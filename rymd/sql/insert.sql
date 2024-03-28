--
-- Uses CSV files to insert data into the e_shop database.
--

DELETE FROM satellit;
DELETE FROM fenomen;
DELETE FROM problem;
DELETE FROM satellit2fenomen;
DELETE FROM satellit2problem;


--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'fenomen.csv'
INTO TABLE fenomen
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'problem.csv'
INTO TABLE problem
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'satellit.csv'
INTO TABLE satellit
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'satellit2fenomen.csv'
INTO TABLE satellit2fenomen
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'satellit2problem.csv'
INTO TABLE satellit2problem
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;
