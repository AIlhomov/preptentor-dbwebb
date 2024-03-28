use fiskodling;

DROP TABLE IF EXISTS odling;
DROP TABLE IF EXISTS fisk;
DROP TABLE IF EXISTS familj;
DROP TABLE IF EXISTS tank;

CREATE TABLE familj(
    id INT PRIMARY KEY,
    namn VARCHAR(100),
    latin VARCHAR(100),
    url VARCHAR(200)
);

CREATE TABLE tank(
    id VARCHAR(100) PRIMARY KEY,
    hus VARCHAR(100),
    rum VARCHAR(100),
    antal INT,
    m3 DECIMAL(10, 2)
);

CREATE TABLE fisk(
    id INT PRIMARY KEY,
    namn VARCHAR(100),
    latin VARCHAR(100),
    familj_id INT,
    manader INT,
    temp_min INT,
    temp_max INT,
    url VARCHAR(200),
    FOREIGN KEY (familj_id) REFERENCES familj(id)
);

CREATE TABLE odling(
    id INT PRIMARY KEY,
    tank_id VARCHAR(100),
    fisk_id INT,
    temp INT,
    kg INT,
    start DATETIME,
    FOREIGN KEY (tank_id) REFERENCES tank(id),
    FOREIGN KEY (fisk_id) REFERENCES fisk(id)
);


DROP PROCEDURE IF EXISTS fisk_rapport;
DELIMITER ;;
CREATE PROCEDURE fisk_rapport()
BEGIN
    SELECT 
        f.id,
        f.namn, 
        f.latin, 
        f.manader,
        f.temp_min, 
        f.temp_max,
        fa.namn AS familjnamn,
        fa.latin,
        MIN(o.start) AS start,
        SUM(o.kg) AS kg,
        t.hus,
        t.rum,
        f.url,
        fa.url AS famurl
    FROM 
        fisk AS f
        LEFT JOIN familj AS fa ON f.familj_id = fa.id
        LEFT JOIN odling AS o ON f.id = o.fisk_id
        LEFT JOIN tank AS t ON o.tank_id = t.id
    GROUP BY f.id
    ORDER BY f.id;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS fisk_rapport_without_url;
DELIMITER ;;
CREATE PROCEDURE fisk_rapport_without_url()
BEGIN
    
    SELECT 
        f.id,
        f.namn, 
        f.latin, 
        f.manader,
        f.temp_min, 
        f.temp_max,
        fa.namn AS familjnamn,
        fa.latin,
        MIN(o.start) AS start,
        SUM(o.kg) AS kg,
        t.hus,
        t.rum
    FROM 
        fisk AS f
        LEFT JOIN familj AS fa ON f.familj_id = fa.id
        LEFT JOIN odling AS o ON f.id = o.fisk_id
        LEFT JOIN tank AS t ON o.tank_id = t.id
    GROUP BY f.id
    ORDER BY f.id;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS fisk_rapport_search;
DELIMITER ;;
CREATE PROCEDURE fisk_rapport_search(search VARCHAR(100))
BEGIN
    SELECT 
        f.id,
        f.namn, 
        f.latin, 
        f.manader,
        f.temp_min, 
        f.temp_max,
        fa.namn AS familjnamn,
        fa.latin,
        MIN(o.start) AS start,
        SUM(o.kg) AS kg,
        t.hus,
        t.rum
    FROM 
        fisk AS f
        LEFT JOIN familj AS fa ON f.familj_id = fa.id
        LEFT JOIN odling AS o ON f.id = o.fisk_id
        LEFT JOIN tank AS t ON o.tank_id = t.id
    WHERE
        f.namn LIKE search
        OR fa.namn LIKE search
        OR t.hus LIKE search
    GROUP BY f.id
    ORDER BY f.id;
END;;
DELIMITER ;


-- +----------------+------------+------------+-------+------------+-----------+-----------------------------------------------------+-------------------------+----------+--------------+
-- | Lokal          | Start      | Klar       | kg    | Temperatur | Varning   | Namn                                                | Familj                  | Månader  | Optimal Temp |
-- +----------------+------------+------------+-------+------------+-----------+-----------------------------------------------------+-------------------------+----------+--------------+
-- | NULL           | NULL       | NULL       |  NULL |       NULL |           | Niltilapia (Oreochomis niloticus)                   | ciklider (Cichlidae)    |        6 | 21-36        |
-- | Hönshuset/304  | NULL       | NULL       |  NULL |       NULL |           | NULL                                                | NULL                    |     NULL | NULL         |
-- | Ladan/102      | 2021-10-01 | 2022-04-01 | 11000 |         23 |           | Tilapia (Oreochromis sp)                            | ciklider (Cichlidae)    |        6 | 21-36        |
-- | Svinstian/201  | 2021-11-15 | 2022-05-15 | 24400 |         20 | Låg temp  | Clariasmal (afrikansk ålmal) (Clarias gariepinus)   | clariidae (Clariidae)   |        6 | 21-34        |
-- | Svinstian/202  | 2021-11-15 | 2022-05-15 | 16500 |         24 |           | Clariasmal (afrikansk ålmal) (Clarias gariepinus)   | clariidae (Clariidae)   |        6 | 21-34        |
-- | Ladan/101      | 2021-10-01 | 2022-10-01 |  5500 |         24 | Hög temp  | Regnbåge (Onchorhynchus mykiss)                     | laxfiskar (Salmonidae)  |       12 | 10-20        |
-- | Hönshuset/303  | 2021-12-01 | 2022-12-01 |  2300 |         18 |           | Sibirisk stör (Acipenser baeri)                     | störar (Acipenseridae)  |       12 | 1-26         |
-- +----------------+------------+------------+-------+------------+-----------+-----------------------------------------------------+-------------------------+----------+--------------+


DROP PROCEDURE IF EXISTS show_special;
DELIMITER ;;
CREATE PROCEDURE show_special()
BEGIN
    SELECT 
        IF(f.id IS NOT NULL, CONCAT(t.hus, '/', t.rum), NULL) AS 'Lokal',
        o.start AS 'Start',
        IF(f.id IS NOT NULL, DATE_ADD(o.start, INTERVAL f.manader MONTH), NULL) AS 'Klar',
        o.kg,
        o.temp AS 'Temperatur',
        CASE 
            WHEN o.temp < f.temp_min THEN 'Låg temp'
            WHEN o.temp > f.temp_max THEN 'Hög temp'
            ELSE '' END AS 'Varning',
        IF(f.id IS NOT NULL, CONCAT(f.namn, ' (', f.latin, ')'), 'Niltilapia (Oreochomis niloticus)') AS 'Namn',
        IF(f.id IS NOT NULL, CONCAT(fa.namn, ' (', fa.latin, ')'), 'ciklider (Cichlidae)') AS 'Familj',
        IF(f.id IS NOT NULL, f.manader, 6) AS 'Månader',
        IF(f.id IS NOT NULL, CONCAT(f.temp_min, '-', f.temp_max), '21-36') AS 'Optimal Temp'
    FROM 
        tank AS t
        LEFT JOIN odling AS o ON t.id = o.tank_id
        LEFT JOIN fisk AS f ON o.fisk_id = f.id
        LEFT JOIN familj AS fa ON f.familj_id = fa.id
    UNION ALL
    SELECT 
        'Hönshuset/304' AS 'Lokal',
        NULL AS 'Start',
        NULL AS 'Klar',
        NULL AS 'kg',
        NULL AS 'Temperatur',
        '' AS 'Varning',
        NULL AS 'Namn',
        NULL AS 'Familj',
        NULL AS 'Månader',
        NULL AS 'Optimal Temp'
    WHERE NOT EXISTS (
        SELECT 1 FROM odling o JOIN tank t ON o.tank_id = t.id WHERE t.hus = 'Hönshuset' AND t.rum = '304'
    )
    ORDER BY 
        klar ASC;
END;;
DELIMITER ;


-- DROP PROCEDURE IF EXISTS show_special;
-- DELIMITER ;;
-- CREATE PROCEDURE show_special()
-- BEGIN
--         SELECT
--         CONCAT(t.hus, '/', t.rum) AS Lokal,
--         MIN(o.start) AS Start, 
--         MAX(DATE_ADD(o.start, INTERVAL f.manader MONTH)) AS Klar,
--         SUM(o.kg) AS kg,
--         AVG(o.temp) AS Temperatur,
--         CASE 
--             WHEN AVG(o.temp) < f.temp_min THEN 'Låg temp'
--             WHEN AVG(o.temp) > f.temp_max THEN 'Hög temp'
--             ELSE '' 
--         END AS Varning,
--         f.namn,
--         fi.namn AS Familj,
--         f.manader,
--         CONCAT(f.temp_min, '-', f.temp_max) AS 'Optimal Temp'
--     FROM tank t
--     LEFT JOIN odling o ON t.id = o.tank_id
--     LEFT JOIN fisk f ON o.fisk_id = f.id
--     LEFT JOIN familj fi ON f.familj_id = fi.id
--     GROUP BY t.hus, t.rum, f.namn, fi.namn, f.manader, f.temp_min, f.temp_max
--     UNION ALL
--     SELECT 
--         NULL AS Lokal,
--         NULL AS Start, 
--         NULL AS Klar,
--         NULL AS kg,
--         NULL AS Temperatur,
--         '' AS Varning,
--         'Niltilapia (Oreochomis niloticus)' AS Namn,
--         'ciklider (Cichlidae)' AS Familj,
--         6 AS Månader,
--         '21-36' AS 'Optimal Temp'
--     FROM DUAL
--     UNION ALL
--     SELECT 
--         'Hönshuset/304' AS Lokal,
--         NULL AS Start, 
--         NULL AS Klar,
--         NULL AS kg,
--         NULL AS Temperatur,
--         '' AS Varning,
--         NULL AS Namn,
--         NULL AS Familj,
--         NULL AS Månader,
--         NULL AS 'Optimal Temp'
--     FROM DUAL
--     ORDER BY Lokal IS NULL, Lokal;

-- END;;
-- DELIMITER ;