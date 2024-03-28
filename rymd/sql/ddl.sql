--
-- Creates tables for the rymd database. (Database scheme).
--

use rymd;

DROP TABLE IF EXISTS satellit2problem;
DROP TABLE IF EXISTS satellit2fenomen;
DROP TABLE IF EXISTS problem;
DROP TABLE IF EXISTS fenomen;
DROP TABLE IF EXISTS satellit;


CREATE TABLE satellit(
    satellit_id VARCHAR(50) PRIMARY KEY,
    namn VARCHAR(100),
    massa INT,
    uppskjutning DATETIME,
    plats VARCHAR(100),
    eol DATETIME,
    url VARCHAR(255)
);

CREATE TABLE fenomen(
    fenomen_id VARCHAR(5) PRIMARY KEY,
    namn VARCHAR(100),
    url VARCHAR(255)
);

CREATE TABLE problem(
    problem_id VARCHAR(5) PRIMARY KEY,
    namn VARCHAR(100)
);

CREATE TABLE satellit2fenomen(
    satellit_id VARCHAR(50),
    fenomen_id VARCHAR(5),
    FOREIGN KEY (satellit_id) REFERENCES satellit(satellit_id),
    FOREIGN KEY (fenomen_id) REFERENCES fenomen(fenomen_id)
);

CREATE TABLE satellit2problem(
    satellit_id VARCHAR(50),
    problem_id VARCHAR(5),
    FOREIGN KEY (satellit_id) REFERENCES satellit(satellit_id),
    FOREIGN KEY (problem_id) REFERENCES problem(problem_id)
);





DROP PROCEDURE IF EXISTS show_rymd;
DELIMITER ;;
CREATE PROCEDURE show_rymd()
BEGIN
    SELECT satellit.*, fenomen.namn as fnamn, GROUP_CONCAT(problem.namn) as pnamn
    FROM satellit
    JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
    JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
    JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
    JOIN problem ON satellit2problem.problem_id = problem.problem_id
    GROUP BY satellit.satellit_id
    ORDER BY satellit.satellit_id;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS search_rymd;
DELIMITER ;;
CREATE PROCEDURE search_rymd(search VARCHAR(100))
BEGIN
    SELECT satellit.*, fenomen.namn as fnamn, GROUP_CONCAT(problem.namn) as pnamn
    FROM satellit
    JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
    JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
    JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
    JOIN problem ON satellit2problem.problem_id = problem.problem_id
    WHERE satellit.namn LIKE search
    GROUP BY satellit.satellit_id
    ORDER BY satellit.satellit_id;
END;;
DELIMITER ;

DROP PROCEDURE IF EXISTS show_rymd_without_url;
DELIMITER ;;
CREATE PROCEDURE show_rymd_without_url()
BEGIN
    SELECT satellit.satellit_id, satellit.namn, satellit.massa, satellit.uppskjutning, 
    satellit.plats, satellit.eol, fenomen.namn as fnamn, GROUP_CONCAT(problem.namn) as pnamn
    FROM satellit
    JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
    JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
    JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
    JOIN problem ON satellit2problem.problem_id = problem.problem_id
    GROUP BY satellit.satellit_id
    ORDER BY satellit.satellit_id;
END;;
DELIMITER ;

-- OR satellit.satellit_id LIKE CONCAT('%', search, '%')
-- OR satellit.plats LIKE CONCAT('%', search, '%')
-- OR satellit.massa LIKE CONCAT('%', search, '%')
-- OR satellit.uppskjutning LIKE CONCAT('%', search, '%')
-- OR satellit.eol LIKE CONCAT('%', search, '%')
-- OR satellit.url LIKE CONCAT('%', search, '%')
-- OR fenomen.namn LIKE CONCAT('%', search, '%')
-- OR problem.namn LIKE CONCAT('%', search, '%')






-- +--------------------+--------------------------------------+--------------------------------------------+-------+
-- | Namn               | Fenomen                              | Problem                                    | Dagar |
-- +--------------------+--------------------------------------+--------------------------------------------+-------+
-- | 1998-72B: Astrid 2 | Norrsken (NOR)                       | Lost contact (LOS)                         |   226 |
-- | 1992-64A: Freja    | Norrsken (NOR)                       | Radiation (RAD)                            |  1469 |
-- | 2000-75C: Munin    | Norrsken (NOR)                       | Computer failure (COMP)                    |    83 |
-- | 2001-07A: Odin     | Ozonlagret (OZO), Himlakroppar (HIM) | NULL                                       |  NULL |
-- | 1989-67A: Sirius 1 | NULL                                 | NULL                                       |  4995 |
-- | 1986-19B: Viking   | Norrsken (NOR)                       | No batteri (BAT) + Component failure (COM) |   449 |
-- +--------------------+--------------------------------------+--------------------------------------------+-------+

-- DROP PROCEDURE IF EXISTS show_rymd_with_days;
-- DELIMITER ;;
-- CREATE PROCEDURE show_rymd_with_days()
-- BEGIN
--     SELECT CONCAT(satellit.satellit_id, ": ", satellit.namn) as Namn, 
--     IFNULL(GROUP_CONCAT(DISTINCT CONCAT(fenomen.namn, " (", fenomen.fenomen_id, ")") SEPARATOR ', '), 'NULL') as Fenomen, 
--     IF(COUNT(problem.problem_id) > 1, 
--         IFNULL(GROUP_CONCAT(CONCAT(problem.namn, " (", problem.problem_id, ")") SEPARATOR ' + '), 'NULL'), 
--         IFNULL(GROUP_CONCAT(CONCAT(problem.namn, " (", problem.problem_id, ")") ORDER BY problem.problem_id ASC), 'NULL')
--     ) as Problem, 
--     DATEDIFF(satellit.eol, satellit.uppskjutning) as Dagar
--     FROM satellit
--     LEFT JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
--     LEFT JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
--     LEFT JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
--     LEFT JOIN problem ON satellit2problem.problem_id = problem.problem_id
--     GROUP BY satellit.satellit_id
--     ORDER BY satellit.namn ASC;
-- END;;
-- DELIMITER ;

DROP PROCEDURE IF EXISTS show_rymd_with_days;
DELIMITER ;;
CREATE PROCEDURE show_rymd_with_days()
BEGIN
    SELECT CONCAT(satellit.satellit_id, ": ", satellit.namn) as Namn, 
    IFNULL(GROUP_CONCAT(DISTINCT CONCAT(fenomen.namn, " (", fenomen.fenomen_id, ")") ORDER BY fenomen.fenomen_id DESC SEPARATOR ', '), 'NULL') as Fenomen, 
    IF(COUNT(problem.problem_id) > 1, 
        IFNULL(GROUP_CONCAT(CONCAT(problem.namn, " (", problem.problem_id, ")") ORDER BY problem.problem_id ASC SEPARATOR ' + '), 'NULL'), 
        IFNULL(GROUP_CONCAT(CONCAT(problem.namn, " (", problem.problem_id, ")") SEPARATOR ' + '), 'NULL')
    ) as Problem, 
    DATEDIFF(satellit.eol, satellit.uppskjutning) as Dagar
    FROM satellit
    LEFT JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
    LEFT JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
    LEFT JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
    LEFT JOIN problem ON satellit2problem.problem_id = problem.problem_id
    GROUP BY satellit.satellit_id
    ORDER BY satellit.namn ASC;
END;;
DELIMITER ;
