--
-- Fills the database with data
--

DELETE FROM konsument;
DELETE FROM kraftverk;
DELETE FROM typ;
DELETE FROM konsument2kraftverk;
DELETE FROM kraftverk2typ;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'konsument.csv'
INTO TABLE konsument
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'kraftverk.csv'
INTO TABLE kraftverk
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'typ.csv'
INTO TABLE typ
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

LOAD DATA LOCAL INFILE 'konsument2kraftverk.csv'
INTO TABLE konsument2kraftverk
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;


LOAD DATA LOCAL INFILE 'kraftverk2typ.csv'
INTO TABLE kraftverk2typ
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;
