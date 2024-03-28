-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: DESKTOP-HOKTFDM.local    Database: fiskodling
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
-- Table structure for table `familj`
--

DROP TABLE IF EXISTS `familj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `familj` (
  `id` int(11) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `latin` varchar(100) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `familj`
--

LOCK TABLES `familj` WRITE;
/*!40000 ALTER TABLE `familj` DISABLE KEYS */;
INSERT INTO `familj` VALUES (1,'laxfiskar','Salmonidae','https://sv.wikipedia.org/wiki/Laxfiskar'),(2,'ciklider','Cichlidae','https://sv.wikipedia.org/wiki/Ciklider'),(3,'clariidae','Clariidae','https://sv.wikipedia.org/wiki/Clariidae'),(4,'störar','Acipenseridae','https://sv.wikipedia.org/wiki/St%C3%B6rar');
/*!40000 ALTER TABLE `familj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fisk`
--

DROP TABLE IF EXISTS `fisk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fisk` (
  `id` int(11) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `latin` varchar(100) DEFAULT NULL,
  `familj_id` int(11) DEFAULT NULL,
  `manader` int(11) DEFAULT NULL,
  `temp_min` int(11) DEFAULT NULL,
  `temp_max` int(11) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `familj_id` (`familj_id`),
  CONSTRAINT `fisk_ibfk_1` FOREIGN KEY (`familj_id`) REFERENCES `familj` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fisk`
--

LOCK TABLES `fisk` WRITE;
/*!40000 ALTER TABLE `fisk` DISABLE KEYS */;
INSERT INTO `fisk` VALUES (1,'Regnbåge','Onchorhynchus mykiss',1,12,10,20,'https://sv.wikipedia.org/wiki/Regnb%C3%A5ge_(fisk)'),(2,'Tilapia','Oreochromis sp',2,6,21,36,'https://sv.wikipedia.org/wiki/Tilapia'),(3,'Niltilapia','Oreochomis niloticus',2,6,21,36,'https://en.wikipedia.org/wiki/Nile_tilapia'),(4,'Clariasmal (afrikansk ålmal)','Clarias gariepinus',3,6,21,34,'https://sv.wikipedia.org/wiki/Afrikansk_vandrarmal'),(5,'Sibirisk stör','Acipenser baeri',4,12,1,26,'https://sv.wikipedia.org/wiki/Sibirisk_st%C3%B6r');
/*!40000 ALTER TABLE `fisk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `odling`
--

DROP TABLE IF EXISTS `odling`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `odling` (
  `id` int(11) NOT NULL,
  `tank_id` varchar(100) DEFAULT NULL,
  `fisk_id` int(11) DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  `kg` int(11) DEFAULT NULL,
  `start` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tank_id` (`tank_id`),
  KEY `fisk_id` (`fisk_id`),
  CONSTRAINT `odling_ibfk_1` FOREIGN KEY (`tank_id`) REFERENCES `tank` (`id`),
  CONSTRAINT `odling_ibfk_2` FOREIGN KEY (`fisk_id`) REFERENCES `fisk` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `odling`
--

LOCK TABLES `odling` WRITE;
/*!40000 ALTER TABLE `odling` DISABLE KEYS */;
INSERT INTO `odling` VALUES (1,'lada101',1,24,5500,'2021-10-01 00:00:00'),(2,'lada102',2,23,11000,'2021-10-01 00:00:00'),(3,'svin201',4,20,24400,'2021-11-15 00:00:00'),(4,'svin202',4,24,16500,'2021-11-15 00:00:00'),(5,'höns303',5,18,2300,'2021-12-01 00:00:00');
/*!40000 ALTER TABLE `odling` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tank`
--

DROP TABLE IF EXISTS `tank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tank` (
  `id` varchar(100) NOT NULL,
  `hus` varchar(100) DEFAULT NULL,
  `rum` varchar(100) DEFAULT NULL,
  `antal` int(11) DEFAULT NULL,
  `m3` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tank`
--

LOCK TABLES `tank` WRITE;
/*!40000 ALTER TABLE `tank` DISABLE KEYS */;
INSERT INTO `tank` VALUES ('höns303','Hönshuset','303',8,12.00),('höns304','Hönshuset','304',4,18.00),('lada101','Ladan','101',8,12.00),('lada102','Ladan','102',8,12.00),('svin201','Svinstian','201',4,18.00),('svin202','Svinstian','202',8,12.00);
/*!40000 ALTER TABLE `tank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'fiskodling'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fisk_rapport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `fisk_rapport`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fisk_rapport_search` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `fisk_rapport_search`(search VARCHAR(100))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fisk_rapport_without_url` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `fisk_rapport_without_url`()
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

-- Dump completed on 2024-03-21  0:24:33
