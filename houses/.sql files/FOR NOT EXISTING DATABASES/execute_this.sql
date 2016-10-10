-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: dbs_housesystem
-- ------------------------------------------------------
-- Server version	5.5.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `houses`
--

DROP TABLE IF EXISTS `houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `houses` (
  `ID` int(6) NOT NULL AUTO_INCREMENT,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `INTERIOR` int(10) DEFAULT NULL,
  `INTX` float DEFAULT NULL,
  `INTY` float DEFAULT NULL,
  `INTZ` float DEFAULT NULL,
  `MONEY` int(20) DEFAULT '0',
  `WEAP1` varchar(45) DEFAULT '0',
  `WEAP2` varchar(45) DEFAULT '0',
  `WEAP3` varchar(45) DEFAULT '0',
  `LOCKED` int(2) DEFAULT '0',
  `PRICE` int(10) DEFAULT '0',
  `OWNER` varchar(32) DEFAULT 'no-one',
  `RENTABLE` int(2) DEFAULT '0',
  `RENTALPRICE` int(10) DEFAULT '0',
  `RENT1` varchar(32) DEFAULT 'no-one',
  `RENT2` varchar(32) DEFAULT 'no-one',
  `RENT3` varchar(32) DEFAULT 'no-one',
  `RENT4` varchar(32) DEFAULT 'no-one',
  `RENT5` varchar(32) DEFAULT 'no-one',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-07-17 17:05:30

CREATE TABLE `houses` (
  `ID` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `INTERIOR` int(10) DEFAULT NULL,
  `INTX` float DEFAULT NULL,
  `INTY` float DEFAULT NULL,
  `INTZ` float DEFAULT NULL,
  `MONEY` int(20) DEFAULT '0',
  `WEAP1` varchar(45) DEFAULT '0',
  `WEAP2` varchar(45) DEFAULT '0',
  `WEAP3` varchar(45) DEFAULT '0',
  `LOCKED` int(2) DEFAULT '0',
  `PRICE` int(10) DEFAULT '0',
  `OWNER` varchar(32) DEFAULT 'no-one',
  `RENTABLE` int(2) DEFAULT '0',
  `RENTALPRICE` int(10) DEFAULT '0',
  `RENT1` varchar(32) DEFAULT 'no-one',
  `RENT2` varchar(32) DEFAULT 'no-one',
  `RENT3` varchar(32) DEFAULT 'no-one',
  `RENT4` varchar(32) DEFAULT 'no-one',
  `RENT5` varchar(32) DEFAULT 'no-one')
