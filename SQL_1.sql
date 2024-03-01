-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: SQL_1
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Class` (
  `ClassName` varchar(10) NOT NULL,
  `Time` datetime DEFAULT NULL,
  `Room` char(5) DEFAULT NULL,
  `Fid` int DEFAULT NULL,
  PRIMARY KEY (`ClassName`),
  KEY `Fid` (`Fid`),
  CONSTRAINT `Class_ibfk_1` FOREIGN KEY (`Fid`) REFERENCES `Faculty` (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Class`
--

LOCK TABLES `Class` WRITE;
/*!40000 ALTER TABLE `Class` DISABLE KEYS */;
INSERT INTO `Class` VALUES ('CS101','2024-03-01 09:00:00','R128',1),('CS201','2024-04-04 15:00:00','B-101',1),('ENG201','2024-03-02 10:30:00','B-202',2),('Math92','2024-03-02 10:30:00','B-203',4),('PHY301','2024-03-03 13:00:00','R128',3);
/*!40000 ALTER TABLE `Class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Enrolled`
--

DROP TABLE IF EXISTS `Enrolled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Enrolled` (
  `Snum` int NOT NULL,
  `ClassName` varchar(10) NOT NULL,
  PRIMARY KEY (`Snum`,`ClassName`),
  KEY `ClassName` (`ClassName`),
  CONSTRAINT `Enrolled_ibfk_1` FOREIGN KEY (`Snum`) REFERENCES `Students` (`Snum`),
  CONSTRAINT `Enrolled_ibfk_2` FOREIGN KEY (`ClassName`) REFERENCES `Class` (`ClassName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Enrolled`
--

LOCK TABLES `Enrolled` WRITE;
/*!40000 ALTER TABLE `Enrolled` DISABLE KEYS */;
INSERT INTO `Enrolled` VALUES (1,'CS101'),(4,'CS201'),(2,'ENG201'),(2,'Math92'),(4,'Math92'),(5,'Math92'),(6,'Math92'),(7,'Math92'),(3,'PHY301');
/*!40000 ALTER TABLE `Enrolled` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Faculty` (
  `Fid` int NOT NULL,
  `Name` varchar(10) DEFAULT NULL,
  `Dept` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faculty`
--

LOCK TABLES `Faculty` WRITE;
/*!40000 ALTER TABLE `Faculty` DISABLE KEYS */;
INSERT INTO `Faculty` VALUES (1,'H.Merlin','CS'),(2,'Johnson','Eng'),(3,'Lee','Physics'),(4,'Thieu','SAMI');
/*!40000 ALTER TABLE `Faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Students`
--

DROP TABLE IF EXISTS `Students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Students` (
  `Snum` int NOT NULL,
  `Name` varchar(30) DEFAULT NULL,
  `Major` varchar(10) DEFAULT NULL,
  `Level` char(3) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  PRIMARY KEY (`Snum`),
  CONSTRAINT `Students_chk_1` CHECK ((`Level` in (_utf8mb4'UN',_utf8mb4'MA',_utf8mb4'PhD'))),
  CONSTRAINT `Students_chk_2` CHECK (((`Age` >= 18) and (`Age` <= 45)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Students`
--

LOCK TABLES `Students` WRITE;
/*!40000 ALTER TABLE `Students` DISABLE KEYS */;
INSERT INTO `Students` VALUES (1,'John','CS','UN',20),(2,'Jane','Eng','MA',25),(3,'Michael','Physics','PhD',26),(4,'Khanh','CS','UN',22),(5,'Hai','CS','UN',26),(6,'Khanh','CS','UN',20),(7,'Hai','CS','UN',27),(8,'Nghia','Physics','UN',18),(9,'Trang','Eng','UN',19);
/*!40000 ALTER TABLE `Students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-01 19:29:15
