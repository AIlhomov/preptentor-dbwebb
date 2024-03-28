
use el;

DROP TABLE IF EXISTS kraftverk2typ;
DROP TABLE IF EXISTS konsument2kraftverk;
DROP TABLE IF EXISTS typ;
DROP TABLE IF EXISTS kraftverk;
DROP TABLE IF EXISTS konsument;



CREATE TABLE konsument(
    id VARCHAR(20) PRIMARY KEY,
    namn VARCHAR(100),
    ort VARCHAR(100),
    arsbehov INT
);

CREATE TABLE kraftverk(
    id VARCHAR(3) PRIMARY KEY,
    namn VARCHAR(100),
    plats VARCHAR(100),
    kalla VARCHAR(20),
    effekt INT,
    nyttjandegrad INT,
    startad INT,
    stangd INT,
    url VARCHAR(200)
);

CREATE TABLE typ(
    id INT PRIMARY KEY,
    namn VARCHAR(100)
);

CREATE TABLE konsument2kraftverk(
    konsument_id VARCHAR(20),
    kraftverk_kalla VARCHAR(100),
    FOREIGN KEY (konsument_id) REFERENCES konsument(id)
);

CREATE TABLE kraftverk2typ(
    kraftverk_id VARCHAR(20),
    typ_id INT,
    FOREIGN KEY (kraftverk_id) REFERENCES kraftverk(id),
    FOREIGN KEY (typ_id) REFERENCES typ(id)
);





DROP PROCEDURE IF EXISTS show_all_kraftverk;
DELIMITER ;;
CREATE PROCEDURE show_all_kraftverk()
BEGIN
    SELECT kraftverk.*,  typ.namn AS typkraftkalla
    FROM kraftverk
    LEFT JOIN kraftverk2typ ON kraftverk.id = kraftverk2typ.kraftverk_id
    LEFT JOIN typ ON kraftverk2typ.typ_id = typ.id
    GROUP BY kraftverk.id, kraftverk.namn, typ.namn
    ORDER BY kraftverk.id;
END;;
DELIMITER ;




DROP PROCEDURE IF EXISTS show_all_konsument;
DELIMITER ;;
CREATE PROCEDURE show_all_konsument()
BEGIN
    SELECT konsument.*, kraftverk.kalla AS energikalla
    FROM konsument
    LEFT JOIN konsument2kraftverk ON konsument.id = konsument2kraftverk.konsument_id
    LEFT JOIN kraftverk ON konsument2kraftverk.kraftverk_kalla = kraftverk.kalla
    GROUP BY konsument.id
    ORDER BY konsument.id;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS search_all_kraftverk;
DELIMITER ;;
CREATE PROCEDURE search_all_kraftverk(search VARCHAR(100))
BEGIN
    SELECT kraftverk.*,  typ.namn AS typkraftkalla
    FROM kraftverk
    LEFT JOIN kraftverk2typ ON kraftverk.id = kraftverk2typ.kraftverk_id
    LEFT JOIN typ ON kraftverk2typ.typ_id = typ.id
    WHERE kraftverk.namn LIKE search OR 
    kraftverk.id LIKE search OR 
    kraftverk.plats LIKE search OR 
    kraftverk.kalla LIKE search
    GROUP BY kraftverk.id, kraftverk.namn, typ.namn
    ORDER BY kraftverk.namn;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS search_all_konsument;
DELIMITER ;;
CREATE PROCEDURE search_all_konsument(search VARCHAR(100))
BEGIN
    SELECT konsument.*, kraftverk.kalla AS energikalla
    FROM konsument
    LEFT JOIN konsument2kraftverk ON konsument.id = konsument2kraftverk.konsument_id
    LEFT JOIN kraftverk ON konsument2kraftverk.kraftverk_kalla = kraftverk.kalla
    WHERE konsument.namn LIKE search OR
    konsument.id LIKE search OR
    konsument.ort LIKE search OR
    kraftverk.kalla LIKE search
    GROUP BY konsument.id
    ORDER BY konsument.namn;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS show_kraftverk_without_url;
DELIMITER ;;
CREATE PROCEDURE show_kraftverk_without_url()
BEGIN
    SELECT kraftverk.id, kraftverk.namn, kraftverk.plats, kraftverk.kalla, kraftverk.effekt, kraftverk.nyttjandegrad, kraftverk.startad, kraftverk.stangd
    FROM kraftverk
    ORDER BY kraftverk.id;
END;;
DELIMITER ;


-- +------------------------------------------+--------------+-------------------+-------------------------------------------------------------------+
-- | Konsument                                | Månadsbehov  | Källa             | Kraftverk med produktion per tidsenhet                            |
-- +------------------------------------------+--------------+-------------------+-------------------------------------------------------------------+
-- | SO: Mega Kraftbolaget (Solberga)         |            8 | olja + kärnkraft  | Karlshamnsverket (1121), Ringhals 1 (23313), Oskarshamn 3 (39603) |
-- | RU: Kooperativa elförbrukarna (Runtuna)  |           17 | vind              | Munkflohöjden (551), Lillgrund vindkraftpark (1138)               |
-- | DÅ: Inges elkonsument (Djupekås)         |            0 | NULL              | NULL                                                              |
-- | JE: Elsas sammanslutning (Jerle)         |           25 | vatten            | Lilla Edet (759), Harsprånget (6220)                              |
-- +------------------------------------------+--------------+-------------------+-------------------------------------------------------------------+


DROP PROCEDURE IF EXISTS show_special;
DELIMITER ;;
CREATE PROCEDURE show_special()
BEGIN
    SELECT DISTINCT CONCAT(konsument.id, ': ', konsument.namn, ' (', konsument.ort, ')') AS Konsument, CAST(konsument.arsbehov / 12 AS INT) AS Månadsbehov, 
    GROUP_CONCAT(DISTINCT kraftverk.kalla ORDER BY kraftverk.kalla DESC SEPARATOR ' + ') AS Källa, GROUP_CONCAT(CONCAT(kraftverk.namn, ' (', CAST(kraftverk.effekt * 365 * kraftverk.nyttjandegrad / 1200 AS INT), ')') ORDER BY kraftverk.effekt ASC SEPARATOR ', ') AS Kraftverk
    FROM konsument
    LEFT JOIN konsument2kraftverk ON konsument.id = konsument2kraftverk.konsument_id
    LEFT JOIN kraftverk ON konsument2kraftverk.kraftverk_kalla = kraftverk.kalla
    GROUP BY konsument.id
    ORDER BY konsument.namn DESC;
END;;
DELIMITER ;

