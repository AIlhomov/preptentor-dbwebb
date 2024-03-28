use exam;

DROP TABLE IF EXISTS product2type;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS developer;
DROP TABLE IF EXISTS type;

CREATE TABLE type(
    id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    url VARCHAR(200)
);

CREATE TABLE developer(
    id VARCHAR(20) PRIMARY KEY,
    developer VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE product(
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    nick VARCHAR(100),
    debate VARCHAR(200),
    year INT,
    developer_id VARCHAR(20),
    url VARCHAR(200),
    image VARCHAR(200),
    FOREIGN KEY (developer_id) REFERENCES developer(id)
);

CREATE TABLE product2type(
    product_id VARCHAR(50),
    type_id VARCHAR(20),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (type_id) REFERENCES type(id)
);



DROP PROCEDURE IF EXISTS show_all_products;
DELIMITER ;;
CREATE PROCEDURE show_all_products()
BEGIN
    SELECT 
        p.id,
        p.name AS pname,
        p.nick,
        p.debate,
        p.year,
        p.developer_id,
        t.id,
        t.name,
        pt.product_id,
        pt.type_id,
        p.url AS purl,
        t.url
    FROM product p
    LEFT JOIN product2type pt ON p.id = pt.product_id
    LEFT JOIN type t ON pt.type_id = t.id
    ORDER BY p.id;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS show_all_products_without_url;
DELIMITER ;;
CREATE PROCEDURE show_all_products_without_url()
BEGIN
    SELECT 
        p.id,
        p.name AS pname,
        p.nick,
        LEFT(p.debate, 20) AS debate,
        p.year,
        p.developer_id,
        t.id,
        t.name,
        pt.product_id,
        pt.type_id
    FROM product p
    LEFT JOIN product2type pt ON p.id = pt.product_id
    LEFT JOIN type t ON pt.type_id = t.id
    ORDER BY p.id;
END;;
DELIMITER ;


DROP PROCEDURE IF EXISTS search_all_products;
DELIMITER ;;
CREATE PROCEDURE search_all_products(search VARCHAR(100))
BEGIN
    SELECT 
        p.id,
        p.name AS pname,
        p.nick,
        p.debate,
        p.year,
        p.developer_id,
        t.id,
        t.name,
        pt.product_id,
        pt.type_id,
        p.url AS purl,
        t.url
    FROM product p
    LEFT JOIN product2type pt ON p.id = pt.product_id
    LEFT JOIN type t ON pt.type_id = t.id
    WHERE CONCAT(p.id, p.name, p.nick, p.debate, p.year, p.developer_id, t.id,
    t.name, pt.product_id, pt.type_id) LIKE search
    ORDER BY p.id;
END;;
DELIMITER ;










-- +----------------------------------------------------------------------------+--------------------------------------------+------+----------------------+
-- | Product                                                                    | Type                                       | Year | Developer            |
-- +----------------------------------------------------------------------------+--------------------------------------------+------+----------------------+
-- | Navlab 1 (NAVLAB1)............ - Warp supercomputer                        | SAV|Autonomous and semi-autonomous vehicle | 1986 | CMU - Carnegie Mello |
-- | Logic Theorist (LOGTHE)....... - The first artificial intelligence program | AUR|Automated reasoning                    | 1956 | AHC - Allen Newell,  |
-- | Navlab 5 (NAVLAB5)............ - From Pittsburgh to San Diego              | SAV|Autonomous and semi-autonomous vehicle | 1995 | CMU - Carnegie Mello |
-- | Manchester Mark 1 (MARK1)..... - Electronic brain                          | SPC|Stored-program computer                | 1949 | VUM - Victoria Unive |
-- | Deep Blue (DEEPBLU)........... - Alien opponent                            | CES|Chess-playing expert system            | 1997 | CMU - Carnegie Mello |
-- | NULL                                                                       | GEN|Generative artificial intelligence     | NULL | .................... |
-- | NULL                                                                       |                                            | NULL | OAI - Open AI....... |
-- +----------------------------------------------------------------------------+--------------------------------------------+------+----------------------+




DROP PROCEDURE IF EXISTS show_special;
DELIMITER ;;

CREATE PROCEDURE show_special()
BEGIN
    DECLARE max_product_name_length INT;
    DECLARE default_dot_count INT DEFAULT 12;
    
    SELECT MAX(CHAR_LENGTH(name)) INTO max_product_name_length FROM product;
    
    SELECT 
        CONCAT(p.name, ' (', p.id, ')',
               REPEAT('.', GREATEST(1, default_dot_count - (CHAR_LENGTH(p.name) + CHAR_LENGTH(p.id) - max_product_name_length))), 
               ' - ', p.nick) AS Product,
        CONCAT(t.id, '|', t.name) AS Type,
        p.year AS Year,
        CONCAT(d.id, ' - ', LEFT(d.developer, 14)) AS Developer
    FROM product p
    LEFT JOIN developer d ON p.developer_id = d.id
    LEFT JOIN product2type p2t ON p.id = p2t.product_id
    LEFT JOIN type t ON p2t.type_id = t.id
    UNION ALL
    
    SELECT
        NULL AS Product,
        CONCAT(t.id, '|', t.name) AS Type,
        NULL AS Year,
        '....................' AS Developer
    FROM type t
    WHERE t.id = 'GEN'
    
    UNION ALL
    
    SELECT
        NULL AS Product,
        '' AS Type,
        NULL AS Year,
        CONCAT(d.id, ' - ', LEFT(d.developer, 14), '.......') AS Developer
    FROM developer d
    WHERE d.id = 'OAI'
    
    ORDER BY Year DESC;
    
END;;

DELIMITER ;





