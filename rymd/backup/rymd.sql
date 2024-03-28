-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: DESKTOP-HOKTFDM.local    Database: rymd
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
-- Table structure for table `fenomen`
--

DROP TABLE IF EXISTS `fenomen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fenomen` (
  `fenomen_id` varchar(5) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`fenomen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fenomen`
--

LOCK TABLES `fenomen` WRITE;
/*!40000 ALTER TABLE `fenomen` DISABLE KEYS */;
INSERT INTO `fenomen` VALUES ('HIM','Himlakroppar','https://sv.wikipedia.org/wiki/Himlakropp'),('NOR','Norrsken','https://sv.wikipedia.org/wiki/Polarsken'),('OZO','Ozonlagret','https://sv.wikipedia.org/wiki/Ozonlagret');
/*!40000 ALTER TABLE `fenomen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem`
--

DROP TABLE IF EXISTS `problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem` (
  `problem_id` varchar(5) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem`
--

LOCK TABLES `problem` WRITE;
/*!40000 ALTER TABLE `problem` DISABLE KEYS */;
INSERT INTO `problem` VALUES ('BAT','No batteri'),('COM','Component failure'),('COMP','Computer failure'),('LOS','Lost contact'),('RAD','Radiation');
/*!40000 ALTER TABLE `problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satellit`
--

DROP TABLE IF EXISTS `satellit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `satellit` (
  `satellit_id` varchar(50) NOT NULL,
  `namn` varchar(100) DEFAULT NULL,
  `massa` int(11) DEFAULT NULL,
  `uppskjutning` datetime DEFAULT NULL,
  `plats` varchar(100) DEFAULT NULL,
  `eol` datetime DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`satellit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satellit`
--

LOCK TABLES `satellit` WRITE;
/*!40000 ALTER TABLE `satellit` DISABLE KEYS */;
INSERT INTO `satellit` VALUES ('1986-19B','Viking',286,'1986-02-22 00:00:00','French Guyana','1987-05-17 00:00:00','https://sv.wikipedia.org/wiki/Viking_(satellit)'),('1989-67A','Sirius 1',660,'1989-08-27 00:00:00','USA','2003-05-01 00:00:00','https://sv.wikipedia.org/wiki/SES_Sirius'),('1992-64A','Freja',256,'1992-10-06 00:00:00','China','1996-10-14 00:00:00','https://sv.wikipedia.org/wiki/Freja_(satellit)'),('1998-72B','Astrid 2',30,'1998-12-10 00:00:00','Russia','1999-07-24 00:00:00','https://sv.wikipedia.org/wiki/Astrid_(satellit)'),('2000-75C','Munin',6,'2000-11-21 00:00:00','USA','2001-02-12 00:00:00','https://sv.wikipedia.org/wiki/Munin_(satellit)'),('2001-07A','Odin',250,'2001-02-20 00:00:00','Russia','0000-00-00 00:00:00','https://sv.wikipedia.org/wiki/Odin_(satellit)');
/*!40000 ALTER TABLE `satellit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satellit2fenomen`
--

DROP TABLE IF EXISTS `satellit2fenomen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `satellit2fenomen` (
  `satellit_id` varchar(50) DEFAULT NULL,
  `fenomen_id` varchar(5) DEFAULT NULL,
  KEY `satellit_id` (`satellit_id`),
  KEY `fenomen_id` (`fenomen_id`),
  CONSTRAINT `satellit2fenomen_ibfk_1` FOREIGN KEY (`satellit_id`) REFERENCES `satellit` (`satellit_id`),
  CONSTRAINT `satellit2fenomen_ibfk_2` FOREIGN KEY (`fenomen_id`) REFERENCES `fenomen` (`fenomen_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satellit2fenomen`
--

LOCK TABLES `satellit2fenomen` WRITE;
/*!40000 ALTER TABLE `satellit2fenomen` DISABLE KEYS */;
INSERT INTO `satellit2fenomen` VALUES ('1986-19B','NOR'),('1992-64A','NOR'),('1998-72B','NOR'),('2000-75C','NOR'),('2001-07A','HIM'),('2001-07A','OZO');
/*!40000 ALTER TABLE `satellit2fenomen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `satellit2problem`
--

DROP TABLE IF EXISTS `satellit2problem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `satellit2problem` (
  `satellit_id` varchar(50) DEFAULT NULL,
  `problem_id` varchar(5) DEFAULT NULL,
  KEY `satellit_id` (`satellit_id`),
  KEY `problem_id` (`problem_id`),
  CONSTRAINT `satellit2problem_ibfk_1` FOREIGN KEY (`satellit_id`) REFERENCES `satellit` (`satellit_id`),
  CONSTRAINT `satellit2problem_ibfk_2` FOREIGN KEY (`problem_id`) REFERENCES `problem` (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `satellit2problem`
--

LOCK TABLES `satellit2problem` WRITE;
/*!40000 ALTER TABLE `satellit2problem` DISABLE KEYS */;
INSERT INTO `satellit2problem` VALUES ('1986-19B','COM'),('1986-19B','BAT'),('1992-64A','RAD'),('1998-72B','LOS'),('2000-75C','COMP');
/*!40000 ALTER TABLE `satellit2problem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'rymd'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_rymd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `search_rymd`(search VARCHAR(100))
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_rymd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_rymd`()
BEGIN
    SELECT satellit.*, fenomen.namn as fnamn, GROUP_CONCAT(problem.namn) as pnamn
    FROM satellit
    JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
    JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
    JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
    JOIN problem ON satellit2problem.problem_id = problem.problem_id
    GROUP BY satellit.satellit_id
    ORDER BY satellit.satellit_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_rymd_without_url` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_rymd_without_url`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_rymd_with_days` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_rymd_with_days`()
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_satellit` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_satellit`()
BEGIN
    SELECT * FROM satellit
    JOIN satellit2fenomen ON satellit.satellit_id = satellit2fenomen.satellit_id
    JOIN fenomen ON satellit2fenomen.fenomen_id = fenomen.fenomen_id
    JOIN satellit2problem ON satellit.satellit_id = satellit2problem.satellit_id
    JOIN problem ON satellit2problem.problem_id = problem.problem_id;
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

-- Dump completed on 2024-03-14 22:43:53
