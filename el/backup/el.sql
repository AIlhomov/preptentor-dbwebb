-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: DESKTOP-HOKTFDM.local    Database: el
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
-- Table structure for table `konsument`
--

DROP TABLE IF EXISTS `konsument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `konsument` (
  `id` varchar(20) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `ort` varchar(100) DEFAULT NULL,
  `arsbehov` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `konsument`
--

LOCK TABLES `konsument` WRITE;
/*!40000 ALTER TABLE `konsument` DISABLE KEYS */;
INSERT INTO `konsument` VALUES ('DÅ','Inges elkonsument','Djupekås',0),('JE','Elsas sammanslutning','Jerle',300),('RU','Kooperativa elförbrukarna','Runtuna',200),('SO','Mega Kraftbolaget','Solberga',100);
/*!40000 ALTER TABLE `konsument` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `konsument2kraftverk`
--

DROP TABLE IF EXISTS `konsument2kraftverk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `konsument2kraftverk` (
  `konsument_id` varchar(20) DEFAULT NULL,
  `kraftverk_kalla` varchar(100) DEFAULT NULL,
  KEY `konsument_id` (`konsument_id`),
  CONSTRAINT `konsument2kraftverk_ibfk_1` FOREIGN KEY (`konsument_id`) REFERENCES `konsument` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `konsument2kraftverk`
--

LOCK TABLES `konsument2kraftverk` WRITE;
/*!40000 ALTER TABLE `konsument2kraftverk` DISABLE KEYS */;
INSERT INTO `konsument2kraftverk` VALUES ('JE','vatten'),('RU','vind'),('SO','olja'),('SO','kärnkraft');
/*!40000 ALTER TABLE `konsument2kraftverk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kraftverk`
--

DROP TABLE IF EXISTS `kraftverk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kraftverk` (
  `id` varchar(3) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `plats` varchar(100) DEFAULT NULL,
  `kalla` varchar(20) DEFAULT NULL,
  `effekt` int(11) DEFAULT NULL,
  `nyttjandegrad` int(11) DEFAULT NULL,
  `startad` int(11) DEFAULT NULL,
  `stangd` int(11) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kraftverk`
--

LOCK TABLES `kraftverk` WRITE;
/*!40000 ALTER TABLE `kraftverk` DISABLE KEYS */;
INSERT INTO `kraftverk` VALUES ('HAR','Harsprånget','Luleälven','vatten',818,25,1951,0,'https://sv.wikipedia.org/wiki/Harspr%C3%A5nget'),('KAR','Karlshamnsverket','Karlshamn','olja',335,11,1969,0,'https://sv.wikipedia.org/wiki/Karlshamnsverket'),('LED','Lilla Edet','Göta älv','vatten',39,64,1926,0,'https://sv.wikipedia.org/wiki/Lilla_Edets_kraftverk'),('LIL','Lillgrund vindkraftpark','Öresund','vind',110,34,2007,0,'https://sv.wikipedia.org/wiki/Lillgrunds_vindkraftpark'),('MUN','Munkflohöjden','Jämtland','vind',49,37,2019,0,'https://www.gem.wiki/Munkfloh%C3%B6gen_wind_farm'),('OSK','Oskarshamn 3','Simpevarp','kärnkraft',1400,93,1985,0,'https://sv.wikipedia.org/wiki/Oskarshamns_k%C3%A4rnkraftverk'),('RIN','Ringhals 1','Väröhalvön','kärnkraft',881,87,1976,2020,'https://sv.wikipedia.org/wiki/Ringhals_k%C3%A4rnkraftverk');
/*!40000 ALTER TABLE `kraftverk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kraftverk2typ`
--

DROP TABLE IF EXISTS `kraftverk2typ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kraftverk2typ` (
  `kraftverk_id` varchar(20) DEFAULT NULL,
  `typ_id` int(11) DEFAULT NULL,
  KEY `kraftverk_id` (`kraftverk_id`),
  KEY `typ_id` (`typ_id`),
  CONSTRAINT `kraftverk2typ_ibfk_1` FOREIGN KEY (`kraftverk_id`) REFERENCES `kraftverk` (`id`),
  CONSTRAINT `kraftverk2typ_ibfk_2` FOREIGN KEY (`typ_id`) REFERENCES `typ` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kraftverk2typ`
--

LOCK TABLES `kraftverk2typ` WRITE;
/*!40000 ALTER TABLE `kraftverk2typ` DISABLE KEYS */;
INSERT INTO `kraftverk2typ` VALUES ('HAR',0),('HAR',0),('LED',0),('LED',0),('LIL',0),('LIL',0),('MUN',0),('MUN',0),('RIN',0),('OSK',0);
/*!40000 ALTER TABLE `kraftverk2typ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typ`
--

DROP TABLE IF EXISTS `typ`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `typ` (
  `id` int(11) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typ`
--

LOCK TABLES `typ` WRITE;
/*!40000 ALTER TABLE `typ` DISABLE KEYS */;
INSERT INTO `typ` VALUES (0,'förnybar');
/*!40000 ALTER TABLE `typ` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'el'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_all_konsument` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `search_all_konsument`(search VARCHAR(100))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_all_kraftverk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `search_all_kraftverk`(search VARCHAR(100))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_all`()
BEGIN
    SELECT kraftverk.*,  typ.namn AS typkraftkalla
    FROM kraftverk
    LEFT JOIN kraftverk2typ ON kraftverk.id = kraftverk2typ.kraftverk_id
    LEFT JOIN typ ON kraftverk2typ.typ_id = typ.id
    GROUP BY kraftverk.id, kraftverk.namn, typ.namn 
    ORDER BY kraftverk.namn;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all_konsument` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_all_konsument`()
BEGIN
    SELECT konsument.*, kraftverk.kalla AS energikalla
    FROM konsument
    LEFT JOIN konsument2kraftverk ON konsument.id = konsument2kraftverk.konsument_id
    LEFT JOIN kraftverk ON konsument2kraftverk.kraftverk_kalla = kraftverk.kalla
    GROUP BY konsument.id
    ORDER BY konsument.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_all_kraftverk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_all_kraftverk`()
BEGIN
    SELECT kraftverk.*,  typ.namn AS typkraftkalla
    FROM kraftverk
    LEFT JOIN kraftverk2typ ON kraftverk.id = kraftverk2typ.kraftverk_id
    LEFT JOIN typ ON kraftverk2typ.typ_id = typ.id
    GROUP BY kraftverk.id, kraftverk.namn, typ.namn
    ORDER BY kraftverk.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_kraftverk_without_url` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_kraftverk_without_url`()
BEGIN
    SELECT kraftverk.id, kraftverk.namn, kraftverk.plats, kraftverk.kalla, kraftverk.effekt, kraftverk.nyttjandegrad, kraftverk.startad, kraftverk.stangd
    FROM kraftverk
    ORDER BY kraftverk.id;
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
    SELECT DISTINCT CONCAT(konsument.id, ': ', konsument.namn, ' (', konsument.ort, ')') AS Konsument, CAST(konsument.arsbehov / 12 AS INT) AS Månadsbehov, 
    GROUP_CONCAT(DISTINCT kraftverk.kalla ORDER BY kraftverk.kalla DESC SEPARATOR ' + ') AS Källa, GROUP_CONCAT(CONCAT(kraftverk.namn, ' (', CAST(kraftverk.effekt * 365 * kraftverk.nyttjandegrad / 1200 AS INT), ')') ORDER BY kraftverk.effekt ASC SEPARATOR ', ') AS Kraftverk
    FROM konsument
    LEFT JOIN konsument2kraftverk ON konsument.id = konsument2kraftverk.konsument_id
    LEFT JOIN kraftverk ON konsument2kraftverk.kraftverk_kalla = kraftverk.kalla
    GROUP BY konsument.id
    ORDER BY konsument.namn DESC;
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

-- Dump completed on 2024-03-21  0:25:16
