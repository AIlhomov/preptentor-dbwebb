
use formogenhet;

DROP TABLE IF EXISTS portfolj;
DROP TABLE IF EXISTS fastighet;
DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS aktier;

CREATE TABLE aktier(
    aktier_id VARCHAR(20) PRIMARY KEY,
    varde INT
);

CREATE TABLE person(
    person_id VARCHAR(50) PRIMARY KEY,
    fnamn VARCHAR(100),
    enamn VARCHAR(100),
    foretag VARCHAR(100),
    formogenhet INT
);

CREATE TABLE fastighet(
    person_id VARCHAR(50),
    fastighet_id VARCHAR(50) PRIMARY KEY,
    vardering INT,
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

CREATE TABLE portfolj(
    person_id VARCHAR(50),
    aktier_id VARCHAR(20),
    antal INT,
    inkop INT,
    FOREIGN KEY (person_id) REFERENCES person(person_id),
    FOREIGN KEY (aktier_id) REFERENCES aktier(aktier_id)
);

DROP PROCEDURE IF EXISTS show_all;
DELIMITER ;;
CREATE PROCEDURE show_all()
BEGIN
    SELECT person.person_id, person.fnamn, person.enamn, person.foretag, COALESCE(person.formogenhet, 0) AS formogenhet, COALESCE(MAX(fastighet.vardering), 0) AS vardering, COALESCE(SUM(portfolj.antal), 0) AS antal, COALESCE(SUM(portfolj.inkop), 0) AS inkop, COALESCE(SUM(aktier.varde), 0) AS varde
    FROM person
    LEFT JOIN fastighet ON person.person_id = fastighet.person_id
    LEFT JOIN portfolj ON person.person_id = portfolj.person_id
    LEFT JOIN aktier ON portfolj.aktier_id = aktier.aktier_id
    GROUP BY person.person_id, person.fnamn, person.enamn, person.foretag, person.formogenhet;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS search_all;
DELIMITER ;;
CREATE PROCEDURE search_all(search VARCHAR(100))
BEGIN
    SELECT person.person_id, person.fnamn, person.enamn, person.foretag, COALESCE(person.formogenhet, 0) AS formogenhet, COALESCE(MAX(fastighet.vardering), 0) AS vardering, COALESCE(SUM(portfolj.antal), 0) AS antal, COALESCE(SUM(portfolj.inkop), 0) AS inkop, COALESCE(SUM(aktier.varde), 0) AS varde
    FROM person
    LEFT JOIN fastighet ON person.person_id = fastighet.person_id
    LEFT JOIN portfolj ON person.person_id = portfolj.person_id
    LEFT JOIN aktier ON portfolj.aktier_id = aktier.aktier_id
    WHERE CONCAT(person.fnamn, person.enamn, person.foretag, aktier.aktier_id, fastighet.fastighet_id) LIKE CONCAT('%', search, '%')
    GROUP BY person.person_id, person.fnamn, person.enamn, person.foretag, person.formogenhet;
END;;
DELIMITER ;




-- +------------------------+---------------+--------------+-------------+----------+-------------------------+------------+
-- | Person                 | Förmögenhet   | Aktie        | Inköpspris  | Nuvärde  | Fastighet               | Värdering  |
-- +------------------------+---------------+--------------+-------------+----------+-------------------------+------------+
-- | Mikael Roos (BTH)      |             0 | NULL         |        NULL |     NULL | NULL                    | NULL       |
-- | Jeff Bezos (Amazon)    |           177 | AMAZON       |          11 |        3 | STOCKHOLM-C             | 8.0 (10)   |
-- | Bill Gates (Microsoft) |           124 | MICROSOFT    |          14 |        6 | Ö-I-SÖDERHAVET          | 11.2 (14)  |
-- | Mark Zuckerberg (Meta) |            97 | SPACEX,META  |          31 |       12 | STUDENTRUM-A,NEW-YORK-C | 14.4 (18)  |
-- | Elon Musk (Tesla)      |           151 | TESLA,SPACEX |          25 |        9 | EIFFELTORNET            | 9.6 (12)   |
-- +------------------------+---------------+--------------+-------------+----------+-------------------------+------------+


-- DROP PROCEDURE IF EXISTS show_special;
-- DELIMITER ;;
-- CREATE PROCEDURE show_special()
-- BEGIN
--     SELECT CONCAT(person.fnamn, " ", person.enamn, " (", person.foretag, ")") AS Person, 
--     person.formogenhet AS 'Förmögenhet', 
--     aktier.aktier_id AS Aktie, 
--     SUM(portfolj.inkop) AS 'Inköpspris', 
--     SUM(aktier.varde) AS Nuvärde, 
--     fastighet.fastighet_id AS Fastighet, 
--     MAX(fastighet.vardering) AS Värdering
--     FROM person
--     LEFT JOIN fastighet ON person.person_id = fastighet.person_id
--     LEFT JOIN portfolj ON person.person_id = portfolj.person_id
--     LEFT JOIN aktier ON portfolj.aktier_id = aktier.aktier_id
--     LEFT JOIN portfolj ON person.person_id = portfolj.person_id
--     GROUP BY person.person_id, person.fnamn, person.enamn, person.foretag, person.formogenhet
--     ORDER BY aktier.aktier_id ASC;

-- END;;
-- DELIMITER ;











DROP PROCEDURE IF EXISTS show_special2;
DELIMITER ;;
CREATE PROCEDURE show_special2()
BEGIN
    SELECT 
        CONCAT(p.fnamn, ' ', p.enamn, ' (', p.foretag, ')') AS Person,
        COALESCE(p.formogenhet, 0) AS Förmögenhet,
        GROUP_CONCAT(DISTINCT po.aktier_id ORDER BY po.aktier_id DESC SEPARATOR ', ') AS Aktie,
        SUM(DISTINCT po.inkop) AS Inköpspris,
        SUM(DISTINCT a.varde) AS Nuvärde,
        GROUP_CONCAT(DISTINCT f.fastighet_id ORDER BY f.fastighet_id DESC SEPARATOR ', ') AS Fastighet,
        f.vardering AS Värdering
    FROM
        person p
    LEFT JOIN
        portfolj po ON p.person_id = po.person_id
    LEFT JOIN
        aktier a ON po.aktier_id = a.aktier_id
    LEFT JOIN
        fastighet f ON p.person_id = f.person_id
    GROUP BY
        p.person_id
    ORDER BY
        Aktie ASC;
END;;
DELIMITER ;

