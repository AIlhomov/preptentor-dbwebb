-- MySQL dump 10.19  Distrib 10.3.38-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: DESKTOP-HOKTFDM.local    Database: formogenhet
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
-- Table structure for table `aktier`
--

DROP TABLE IF EXISTS `aktier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aktier` (
  `aktier_id` varchar(20) NOT NULL,
  `varde` int(11) DEFAULT NULL,
  PRIMARY KEY (`aktier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aktier`
--

LOCK TABLES `aktier` WRITE;
/*!40000 ALTER TABLE `aktier` DISABLE KEYS */;
INSERT INTO `aktier` VALUES ('AMAZON',3),('META',7),('MICROSOFT',6),('SPACEX',5),('TESLA',4);
/*!40000 ALTER TABLE `aktier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fastighet`
--

DROP TABLE IF EXISTS `fastighet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fastighet` (
  `person_id` varchar(50) DEFAULT NULL,
  `fastighet_id` varchar(50) NOT NULL,
  `vardering` int(11) DEFAULT NULL,
  PRIMARY KEY (`fastighet_id`),
  KEY `person_id` (`person_id`),
  CONSTRAINT `fastighet_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fastighet`
--

LOCK TABLES `fastighet` WRITE;
/*!40000 ALTER TABLE `fastighet` DISABLE KEYS */;
INSERT INTO `fastighet` VALUES ('elon','EIFFELTORNET',12),('mark','NEW-YORK-C',16),('bill','Ö-I-SÖDERHAVET',14),('jeff','STOCKHOLM-C',10),('mark','STUDENTRUM-A',18);
/*!40000 ALTER TABLE `fastighet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` varchar(50) NOT NULL,
  `fnamn` varchar(100) DEFAULT NULL,
  `enamn` varchar(100) DEFAULT NULL,
  `foretag` varchar(100) DEFAULT NULL,
  `formogenhet` int(11) DEFAULT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('bill','Bill','Gates','Microsoft',124),('elon','Elon','Musk','Tesla',151),('jeff','Jeff','Bezos','Amazon',177),('mark','Mark','Zuckerberg','Meta',97),('mos','Mikael','Roos','BTH',0);
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portfolj`
--

DROP TABLE IF EXISTS `portfolj`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portfolj` (
  `person_id` varchar(50) DEFAULT NULL,
  `aktier_id` varchar(20) DEFAULT NULL,
  `antal` int(11) DEFAULT NULL,
  `inkop` int(11) DEFAULT NULL,
  KEY `person_id` (`person_id`),
  KEY `aktier_id` (`aktier_id`),
  CONSTRAINT `portfolj_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`person_id`),
  CONSTRAINT `portfolj_ibfk_2` FOREIGN KEY (`aktier_id`) REFERENCES `aktier` (`aktier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portfolj`
--

LOCK TABLES `portfolj` WRITE;
/*!40000 ALTER TABLE `portfolj` DISABLE KEYS */;
INSERT INTO `portfolj` VALUES ('jeff','AMAZON',1,11),('elon','TESLA',1,12),('elon','SPACEX',1,13),('bill','MICROSOFT',1,14),('mark','META',1,15),('mark','SPACEX',1,16);
/*!40000 ALTER TABLE `portfolj` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'formogenhet'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_all` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `search_all`(search VARCHAR(100))
BEGIN
    SELECT person.person_id, person.fnamn, person.enamn, person.foretag, COALESCE(person.formogenhet, 0) AS formogenhet, COALESCE(MAX(fastighet.vardering), 0) AS vardering, COALESCE(SUM(portfolj.antal), 0) AS antal, COALESCE(SUM(portfolj.inkop), 0) AS inkop, COALESCE(SUM(aktier.varde), 0) AS varde
    FROM person
    LEFT JOIN fastighet ON person.person_id = fastighet.person_id
    LEFT JOIN portfolj ON person.person_id = portfolj.person_id
    LEFT JOIN aktier ON portfolj.aktier_id = aktier.aktier_id
    WHERE CONCAT(person.fnamn, person.enamn, person.foretag, aktier.aktier_id, fastighet.fastighet_id) LIKE CONCAT('%', search, '%')
    GROUP BY person.person_id, person.fnamn, person.enamn, person.foretag, person.formogenhet;
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
    SELECT person.person_id, person.fnamn, person.enamn, person.foretag, COALESCE(person.formogenhet, 0) AS formogenhet, COALESCE(MAX(fastighet.vardering), 0) AS vardering, COALESCE(SUM(portfolj.antal), 0) AS antal, COALESCE(SUM(portfolj.inkop), 0) AS inkop, COALESCE(SUM(aktier.varde), 0) AS varde
    FROM person
    LEFT JOIN fastighet ON person.person_id = fastighet.person_id
    LEFT JOIN portfolj ON person.person_id = portfolj.person_id
    LEFT JOIN aktier ON portfolj.aktier_id = aktier.aktier_id
    GROUP BY person.person_id, person.fnamn, person.enamn, person.foretag, person.formogenhet;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_special2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`dbadm`@`%` PROCEDURE `show_special2`()
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

-- Dump completed on 2024-03-21  0:23:19
