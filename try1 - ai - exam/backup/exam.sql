-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: DESKTOP-HOKTFDM.local    Database: exam
-- ------------------------------------------------------
-- Server version	11.4.0-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `developer`
--

DROP TABLE IF EXISTS `developer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `developer` (
  `id` varchar(20) NOT NULL,
  `developer` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `developer`
--

LOCK TABLES `developer` WRITE;
/*!40000 ALTER TABLE `developer` DISABLE KEYS */;
INSERT INTO `developer` VALUES ('AHC','Allen Newell, Herbert A. Simon, and Cliff Shaw','USA'),('CMU','Carnegie Mellon University','USA'),('OAI','Open AI','USA'),('VUM','Victoria University of Manchester','England');
/*!40000 ALTER TABLE `developer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` varchar(50) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `nick` varchar(100) DEFAULT NULL,
  `debate` varchar(200) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  `developer_id` varchar(20) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `image` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `developer_id` (`developer_id`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('DEEPBLU','Deep Blue','Alien opponent','Behind Deep Blue: Building the Computer that Defeated the World Chess Champion',1997,'CMU','https://en.wikipedia.org/wiki/Deep_Blue_(chess_computer)','https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Deep_Blue.jpg/220px-Deep_Blue.jpg'),('LOGTHE','Logic Theorist','The first artificial intelligence program','Logic Theorist proved 38 of the first 52 theorems in chapter two of Whitehead and Bertrand Russell\'s Principia Mathematica, and found new and shorter proofs for some of them.',1956,'AHC','https://en.wikipedia.org/wiki/Logic_Theorist','https://img.youtube.com/vi/HfPXr90HXSY/0.jpg'),('MARK1','Manchester Mark 1','Electronic brain','Can an electronic computer ever be truly creative.',1949,'VUM','https://en.wikipedia.org/wiki/Manchester_Mark_1','https://upload.wikimedia.org/wikipedia/en/d/d8/Manchester_Mark2.jpg'),('NAVLAB1','Navlab 1','Warp supercomputer','The vehicle suffered from software limitations and was not fully functional until the late 80s, when it achieved its top speed of 20 mph (32 km/h).',1986,'CMU','https://en.wikipedia.org/wiki/Navlab','https://www.cs.cmu.edu/afs/cs/project/alv/www/img2/textured_car_after.png'),('NAVLAB5','Navlab 5','From Pittsburgh to San Diego','Our current work involves pedestrian detection, surround sensing, and short range sensing for vehicle control.',1995,'CMU','https://en.wikipedia.org/wiki/Navlab','https://www.cs.cmu.edu/afs/cs/project/alv/www/img2/detection.png');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product2type`
--

DROP TABLE IF EXISTS `product2type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product2type` (
  `product_id` varchar(50) DEFAULT NULL,
  `type_id` varchar(20) DEFAULT NULL,
  KEY `product_id` (`product_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `product2type_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `product2type_ibfk_2` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product2type`
--

LOCK TABLES `product2type` WRITE;
/*!40000 ALTER TABLE `product2type` DISABLE KEYS */;
INSERT INTO `product2type` VALUES ('MARK1','SPC'),('LOGTHE','AUR'),('NAVLAB1','SAV'),('NAVLAB5','SAV'),('DEEPBLU','CES');
/*!40000 ALTER TABLE `product2type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type` (
  `id` varchar(20) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type`
--

LOCK TABLES `type` WRITE;
/*!40000 ALTER TABLE `type` DISABLE KEYS */;
INSERT INTO `type` VALUES ('AUR','Automated reasoning','https://en.wikipedia.org/wiki/Automated_reasoning'),('CES','Chess-playing expert system','https://en.wikipedia.org/wiki/Expert_system'),('GEN','Generative artificial intelligence','https://en.wikipedia.org/wiki/Generative_artificial_intelligence'),('SAV','Autonomous and semi-autonomous vehicle','https://en.wikipedia.org/wiki/Autonomous'),('SPC','Stored-program computer','https://en.wikipedia.org/wiki/Stored-program_computer');
/*!40000 ALTER TABLE `type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'exam'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `DisplayAIProducts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `DisplayAIProducts`()
BEGIN
    
    
    
    SELECT 
        CONCAT(p.name, ' (', p.id, ') - ', p.nick) AS Product,
        CONCAT(t.id, '|', t.name) AS Type,
        p.year AS Year,
        CONCAT(d.id, ' - ', d.developer) AS Developer
    FROM product p
    LEFT JOIN developer d ON p.developer_id = d.id
    LEFT JOIN product2type p2t ON p.id = p2t.product_id
    LEFT JOIN type t ON p2t.type_id = t.id
    UNION
    SELECT
        NULL AS Product,
        CONCAT(t.id, '|', t.name) AS Type,
        NULL AS Year,
        '....................' AS Developer
    FROM type t
    WHERE t.id = 'GEN'
    UNION
    SELECT
        NULL AS Product,
        NULL AS Type,
        NULL AS Year,
        CONCAT(d.id, ' - ', d.developer) AS Developer
    FROM developer d
    WHERE d.id = 'OAI'
    ORDER BY Year DESC, Type, Developer;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_all_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `search_all_products`(search VARCHAR(100))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_all_products`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all_products_without_url` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_all_products_without_url`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_special` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_special`()
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
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-21 18:46:35
