CREATE DATABASE  IF NOT EXISTS `SANITAT` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `SANITAT`;
-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: SANITAT
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `DOCTOR`
--

DROP TABLE IF EXISTS `DOCTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DOCTOR` (
  `HOSPITAL_COD` tinyint(2) NOT NULL,
  `DOCTOR_NO` smallint(3) NOT NULL,
  `COGNOM` varchar(13) DEFAULT NULL,
  `ESPECIALITAT` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`HOSPITAL_COD`,`DOCTOR_NO`),
  CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`HOSPITAL_COD`) REFERENCES `HOSPITAL` (`HOSPITAL_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DOCTOR`
--

LOCK TABLES `DOCTOR` WRITE;
/*!40000 ALTER TABLE `DOCTOR` DISABLE KEYS */;
INSERT INTO `DOCTOR` VALUES (13,435,'López A.','Cardiologia'),(18,585,'Miller G.','Ginecologia'),(18,982,'Cajal R.','Cardiologia'),(22,386,'Cabeza D.','Psiquiatria'),(22,398,'Best K.','Urologia'),(22,453,'Galo D.','Pediatria'),(45,522,'Adams C.','Neurologia'),(45,607,'Nico P.','Pediatria');
/*!40000 ALTER TABLE `DOCTOR` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HOSPITAL`
--

DROP TABLE IF EXISTS `HOSPITAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HOSPITAL` (
  `HOSPITAL_COD` tinyint(2) NOT NULL,
  `NOM` varchar(10) DEFAULT NULL,
  `ADRECA` varchar(20) DEFAULT NULL,
  `TELEFON` varchar(8) DEFAULT NULL,
  `QTAT_LLITS` smallint(3) DEFAULT NULL,
  PRIMARY KEY (`HOSPITAL_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HOSPITAL`
--

LOCK TABLES `HOSPITAL` WRITE;
/*!40000 ALTER TABLE `HOSPITAL` DISABLE KEYS */;
INSERT INTO `HOSPITAL` VALUES (13,'Provincial','O Donell 50','964-4264',0),(18,'General','Atocha s/n','595-3111',0),(22,'La Paz','Castellana 1000','923-5411',0),(45,'San Carlos','Ciudad Universitaria','597-1500',0);
/*!40000 ALTER TABLE `HOSPITAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `INGRESSOS`
--

DROP TABLE IF EXISTS `INGRESSOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `INGRESSOS` (
  `INSCRIPCIO` int(5) NOT NULL,
  `HOSPITAL_COD` tinyint(2) DEFAULT NULL,
  `SALA_COD` tinyint(2) DEFAULT NULL,
  `LLIT` smallint(4) DEFAULT NULL,
  PRIMARY KEY (`INSCRIPCIO`),
  KEY `HOSPITAL_COD` (`HOSPITAL_COD`,`SALA_COD`),
  CONSTRAINT `ingressos_ibfk_1` FOREIGN KEY (`HOSPITAL_COD`, `SALA_COD`) REFERENCES `SALA` (`HOSPITAL_COD`, `SALA_COD`),
  CONSTRAINT `ingressos_ibfk_2` FOREIGN KEY (`INSCRIPCIO`) REFERENCES `MALALT` (`INSCRIPCIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `INGRESSOS`
--

LOCK TABLES `INGRESSOS` WRITE;
/*!40000 ALTER TABLE `INGRESSOS` DISABLE KEYS */;
INSERT INTO `INGRESSOS` VALUES (10995,13,3,1),(14024,13,3,3),(18004,13,3,2),(36658,18,4,1),(38702,18,4,2),(39217,22,6,1),(59076,22,6,2),(63827,22,6,3),(64823,22,2,1);
/*!40000 ALTER TABLE `INGRESSOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MALALT`
--

DROP TABLE IF EXISTS `MALALT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MALALT` (
  `INSCRIPCIO` int(5) NOT NULL,
  `COGNOM` varchar(15) DEFAULT NULL,
  `ADRECA` varchar(20) DEFAULT NULL,
  `DATA_NAIX` date DEFAULT NULL,
  `SEXE` char(1) DEFAULT NULL,
  `NSS` char(9) DEFAULT NULL,
  PRIMARY KEY (`INSCRIPCIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MALALT`
--

LOCK TABLES `MALALT` WRITE;
/*!40000 ALTER TABLE `MALALT` DISABLE KEYS */;
INSERT INTO `MALALT` VALUES (10995,'Laguía M.','Goya 20','1956-05-16','H','280862482'),(14024,'Fernàndez M.','Recoletos 50','1967-06-23','D','321790059'),(18004,'Serrano V.','Alcala 12','1960-05-21','D','284991452'),(36658,'Domin S.','Mayor 71','1942-01-01','H','160657471'),(38702,'Neal R.','Orense 11','1940-06-18','D','380010217'),(39217,'Cervantes M.','Peron 38','1952-02-29','H','440294390'),(59076,'Miller G.','Lopez de Hoyos 2','1945-09-16','D','311969044'),(63827,'Ruíz P.','Esquerdo 103','1980-12-26','H','100973253'),(64823,'Fraser A.','Soto 3','1980-07-10','D','285201776'),(74835,'Benítez E.','Argentina 5','1957-10-05','H','154811767');
/*!40000 ALTER TABLE `MALALT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLANTILLA`
--

DROP TABLE IF EXISTS `PLANTILLA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PLANTILLA` (
  `HOSPITAL_COD` tinyint(2) NOT NULL,
  `SALA_COD` tinyint(2) NOT NULL,
  `EMPLEAT_NO` smallint(4) NOT NULL,
  `COGNOM` varchar(15) DEFAULT NULL,
  `FUNCIO` varchar(10) DEFAULT NULL,
  `TORN` varchar(1) DEFAULT NULL,
  `SALARI` int(10) DEFAULT NULL,
  PRIMARY KEY (`HOSPITAL_COD`,`SALA_COD`,`EMPLEAT_NO`),
  CONSTRAINT `plantilla_ibfk_1` FOREIGN KEY (`HOSPITAL_COD`, `SALA_COD`) REFERENCES `SALA` (`HOSPITAL_COD`, `SALA_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLANTILLA`
--

LOCK TABLES `PLANTILLA` WRITE;
/*!40000 ALTER TABLE `PLANTILLA` DISABLE KEYS */;
INSERT INTO `PLANTILLA` VALUES (13,6,3106,'Hernàndez J.','Infermer','T',2755000),(13,6,3754,'Díaz B.','Infermera','T',2262000),(18,4,6357,'Karplus W.','Intern','T',3379000),(22,1,6065,'Rivera G.','Infermera','N',1626000),(22,1,7379,'Carlos R.','Infermera','T',2119000),(22,2,9901,'Adams C.','Intern','M',2210000),(22,6,1009,'Higueras D.','Infermera','T',2005000),(22,6,8422,'Bocina G.','Infermer','M',1638000),(45,1,8526,'Frank H.','Infermera','T',2522000),(45,4,1280,'Amigó R.','Intern','N',2210000);
/*!40000 ALTER TABLE `PLANTILLA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SALA`
--

DROP TABLE IF EXISTS `SALA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SALA` (
  `HOSPITAL_COD` tinyint(2) NOT NULL,
  `SALA_COD` tinyint(2) NOT NULL,
  `NOM` varchar(20) DEFAULT NULL,
  `QTAT_LLITS` smallint(3) DEFAULT NULL,
  PRIMARY KEY (`HOSPITAL_COD`,`SALA_COD`),
  CONSTRAINT `sala_ibfk_1` FOREIGN KEY (`HOSPITAL_COD`) REFERENCES `HOSPITAL` (`HOSPITAL_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SALA`
--

LOCK TABLES `SALA` WRITE;
/*!40000 ALTER TABLE `SALA` DISABLE KEYS */;
INSERT INTO `SALA` VALUES (13,3,'Cures Intensives',21),(13,6,'Psiquiàtric',67),(18,3,'Cures Intensives',10),(18,4,'Cardiologia',53),(22,1,'Recuperació',10),(22,2,'Maternitat',34),(22,6,'Psiquiàtric',118),(45,1,'Recuperació',13),(45,2,'Maternitat',24),(45,4,'Cardiologia',55);
/*!40000 ALTER TABLE `SALA` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-04 16:02:27
CREATE DATABASE  IF NOT EXISTS `EMPRESA` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `EMPRESA`;
-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: EMPRESA
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `CLIENT`
--

DROP TABLE IF EXISTS `CLIENT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENT` (
  `CLIENT_COD` int(6) NOT NULL,
  `NOM` varchar(45) DEFAULT NULL,
  `ADRECA` varchar(30) DEFAULT NULL,
  `CIUTAT` varchar(50) DEFAULT NULL,
  `ESTAT` varchar(2) DEFAULT NULL,
  `CODI_POSTAL` varchar(9) DEFAULT NULL,
  `AREA` smallint(3) DEFAULT NULL,
  `TELEFON` varchar(9) DEFAULT NULL,
  `REPR_COD` smallint(4) DEFAULT NULL,
  `LIMIT_CREDIT` decimal(9,2) DEFAULT NULL,
  `OBSERVACIONS` text,
  PRIMARY KEY (`CLIENT_COD`),
  KEY `REPR_COD` (`REPR_COD`),
  CONSTRAINT `client_ibfk_1` FOREIGN KEY (`REPR_COD`) REFERENCES `EMP` (`EMP_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENT`
--

LOCK TABLES `CLIENT` WRITE;
/*!40000 ALTER TABLE `CLIENT` DISABLE KEYS */;
INSERT INTO `CLIENT` VALUES (100,'JOCKSPORTS','345 VIEWRIDGE','BELMONT','CA','96711',415,'598-6609',7844,5000.00,'Very friendly people to work with -- sales rep likes to be called Mike.'),(101,'TKB SPORT SHOP','490 BOLI RD.','REDWOOD CIUTAT','CA','94061',415,'368-1223',7521,10000.00,'Rep called 5/8 about change in order - contact shipping.'),(102,'VOLLYRITE','9722 HAMILTON','BURLINGAME','CA','95133',415,'644-3341',7654,7000.00,'Company doing heavy promotion beginning 10/89. Prepare for large orders during winter.'),(103,'JUST TENNIS','HILLVIEW MALL','BURLINGAME','CA','97544',415,'677-9312',7521,3000.00,'Contact rep about new line of tennis rackets.'),(104,'EVERY MOUNTAIN','574 SURRY RD.','CUPERTINO','CA','93301',408,'996-2323',7499,10000.00,'CLIENT with high market share (23%) due to aggressive advertising.'),(105,'K + T SPORTS','3476 EL PASEO','SANTA CLARA','CA','91003',408,'376-9966',7844,5000.00,'Tends to order large amounts of merchandise at once. Accounting is considering raising their credit limit. Usually pays on time.'),(106,'SHAPE UP','908 SEQUOIA','PALO ALTO','CA','94301',415,'364-9777',7521,6000.00,'Support intensive. Orders small amounts (< 800) of merchandise at a time.'),(107,'WOMEN SPORTS','VALCO VILLAGE','SUNNYVALE','CA','93301',408,'967-4398',7499,10000.00,'First sporting goods store geared exclusively towards women. Unusual promotion al style and very willing to take chances towards new PRODUCTEs!'),(108,'NORTH WOODS HEALTH AND FITNESS SUPPLY CENTER','98 LONE PINE WAY','HIBBING','MN','55649',612,'566-9123',7844,8000.00,''),(109,'SPRINGFIELD NUCLEAR POWER PLANT','13 PERCEBE STR.','SPRINGFIELD','NT','0000',636,'999-6666',NULL,10000.00,'');
/*!40000 ALTER TABLE `CLIENT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COMANDA`
--

DROP TABLE IF EXISTS `COMANDA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COMANDA` (
  `COM_NUM` smallint(4) NOT NULL,
  `COM_DATA` date DEFAULT NULL,
  `COM_TIPUS` char(1) DEFAULT NULL,
  `CLIENT_COD` int(6) DEFAULT NULL,
  `DATA_TRAMESA` date DEFAULT NULL,
  `TOTAL` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`COM_NUM`),
  KEY `CLIENT_COD` (`CLIENT_COD`),
  CONSTRAINT `comanda_ibfk_1` FOREIGN KEY (`CLIENT_COD`) REFERENCES `CLIENT` (`CLIENT_COD`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COMANDA`
--

LOCK TABLES `COMANDA` WRITE;
/*!40000 ALTER TABLE `COMANDA` DISABLE KEYS */;
INSERT INTO `COMANDA` VALUES (601,'1986-05-01','A',106,'1986-05-30',2.40),(602,'1986-06-05','B',102,'1986-06-20',56.00),(603,'1986-06-05',NULL,102,'1986-06-05',224.00),(604,'1986-06-15','A',106,'1986-06-30',698.00),(605,'1986-07-14','A',106,'1986-07-30',8324.00),(606,'1986-07-14','A',100,'1986-07-30',3.40),(607,'1986-07-18','C',104,'1986-07-18',5.60),(608,'1986-07-25','C',104,'1986-07-25',35.20),(609,'1986-08-01','B',100,'1986-08-15',97.50),(610,'1987-01-07','A',101,'1987-01-08',101.40),(611,'1987-01-11','B',102,'1987-01-11',45.00),(612,'1987-01-15','C',104,'1987-01-20',5860.00),(613,'1987-02-01',NULL,108,'1987-02-01',6400.00),(614,'1987-02-01',NULL,102,'1987-02-05',23940.00),(615,'1987-02-01',NULL,107,'1987-02-06',710.00),(616,'1987-02-03',NULL,103,'1987-02-10',764.00),(617,'1987-02-05',NULL,104,'1987-03-03',46370.00),(618,'1987-02-15','A',102,'1987-03-06',3510.50),(619,'1987-02-22',NULL,104,'1987-02-04',1260.00),(620,'1987-03-12',NULL,100,'1987-03-12',4450.00),(621,'1987-03-15','A',100,'1987-01-01',730.00);
/*!40000 ALTER TABLE `COMANDA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DEPT`
--

DROP TABLE IF EXISTS `DEPT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DEPT` (
  `DEPT_NO` tinyint(2) NOT NULL,
  `DNOM` varchar(14) DEFAULT NULL,
  `LOC` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`DEPT_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DEPT`
--

LOCK TABLES `DEPT` WRITE;
/*!40000 ALTER TABLE `DEPT` DISABLE KEYS */;
INSERT INTO `DEPT` VALUES (10,'COMPTABILITAT','SEVILLA'),(20,'INVESTIGACIÓ','MADRID'),(30,'VENDES','BARCELONA'),(40,'PRODUCCIÓ','BILBAO');
/*!40000 ALTER TABLE `DEPT` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DETALL`
--

DROP TABLE IF EXISTS `DETALL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DETALL` (
  `COM_NUM` smallint(4) NOT NULL,
  `DETALL_NUM` smallint(4) NOT NULL,
  `PROD_NUM` int(6) DEFAULT NULL,
  `PREU_VENDA` decimal(8,2) DEFAULT NULL,
  `QUANTITAT` int(8) DEFAULT NULL,
  `IMPORT` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`COM_NUM`,`DETALL_NUM`),
  KEY `PROD_NUM` (`PROD_NUM`),
  CONSTRAINT `detall_ibfk_1` FOREIGN KEY (`COM_NUM`) REFERENCES `COMANDA` (`COM_NUM`),
  CONSTRAINT `detall_ibfk_2` FOREIGN KEY (`PROD_NUM`) REFERENCES `PRODUCTE` (`PROD_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DETALL`
--

LOCK TABLES `DETALL` WRITE;
/*!40000 ALTER TABLE `DETALL` DISABLE KEYS */;
INSERT INTO `DETALL` VALUES (601,1,200376,2.40,1,2.40),(602,1,100870,2.80,20,56.00),(603,2,100860,56.00,4,224.00),(604,1,100890,58.00,3,174.00),(604,2,100861,42.00,2,84.00),(604,3,100860,44.00,10,440.00),(605,1,100861,45.00,100,4500.00),(605,2,100870,2.80,500,1400.00),(605,3,100890,58.00,5,290.00),(605,4,101860,24.00,50,1200.00),(605,5,101863,9.00,100,900.00),(605,6,102130,3.40,10,34.00),(606,1,102130,3.40,1,3.40),(607,1,100871,5.60,1,5.60),(608,1,101860,24.00,1,24.00),(608,2,100871,5.60,2,11.20),(609,1,100861,35.00,1,35.00),(609,2,100870,2.50,5,12.50),(609,3,100890,50.00,1,50.00),(610,1,100860,35.00,1,35.00),(610,2,100870,2.80,3,8.40),(610,3,100890,58.00,1,58.00),(611,1,100861,45.00,1,45.00),(612,1,100860,30.00,100,3000.00),(612,2,100861,40.50,20,810.00),(612,3,101863,10.00,150,1500.00),(612,4,100871,5.50,100,550.00),(613,1,100871,5.60,100,560.00),(613,2,101860,24.00,200,4800.00),(613,3,200380,4.00,150,600.00),(613,4,200376,2.20,200,440.00),(614,1,100860,35.00,444,15540.00),(614,2,100870,2.80,1000,2800.00),(614,3,100871,5.60,1000,5600.00),(615,1,100861,45.00,4,180.00),(615,2,100870,2.80,100,280.00),(615,3,100871,5.00,50,250.00),(616,1,100861,45.00,10,450.00),(616,2,100870,2.80,50,140.00),(616,3,100890,58.00,2,116.00),(616,4,102130,3.40,10,34.00),(616,5,200376,2.40,10,24.00),(617,1,100860,35.00,50,1750.00),(617,2,100861,45.00,100,4500.00),(617,3,100870,2.80,500,1400.00),(617,4,100871,5.60,500,2800.00),(617,5,100890,58.00,500,29000.00),(617,6,101860,24.00,100,2400.00),(617,7,101863,12.50,200,2500.00),(617,8,102130,3.40,100,340.00),(617,9,200376,2.40,200,480.00),(617,10,200380,4.00,300,1200.00),(618,1,100860,35.00,23,805.00),(618,2,100861,45.11,50,2255.50),(618,3,100870,45.00,10,450.00),(619,1,200380,4.00,100,400.00),(619,2,200376,2.40,100,240.00),(619,3,102130,3.40,100,340.00),(619,4,100871,5.60,50,280.00),(620,1,100860,35.00,10,350.00),(620,2,200376,2.40,1000,2400.00),(620,3,102130,3.40,500,1700.00),(621,1,100861,45.00,10,450.00),(621,2,100870,2.80,100,280.00);
/*!40000 ALTER TABLE `DETALL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMP`
--

DROP TABLE IF EXISTS `EMP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EMP` (
  `EMP_NO` smallint(4) NOT NULL,
  `COGNOM` varchar(10) DEFAULT NULL,
  `OFICI` varchar(10) DEFAULT NULL,
  `CAP` smallint(4) DEFAULT NULL,
  `DATA_ALTA` date DEFAULT NULL,
  `SALARI` int(11) DEFAULT NULL,
  `COMISSIO` int(11) DEFAULT NULL,
  `DEPT_NO` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`EMP_NO`),
  KEY `DEPT_NO` (`DEPT_NO`),
  KEY `CAP` (`CAP`),
  CONSTRAINT `emp_ibfk_1` FOREIGN KEY (`DEPT_NO`) REFERENCES `DEPT` (`DEPT_NO`),
  CONSTRAINT `emp_ibfk_2` FOREIGN KEY (`CAP`) REFERENCES `EMP` (`EMP_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMP`
--

LOCK TABLES `EMP` WRITE;
/*!40000 ALTER TABLE `EMP` DISABLE KEYS */;
INSERT INTO `EMP` VALUES (7369,'SÀNCHEZ','EMPLEAT',7902,'1980-12-17',104000,NULL,20),(7499,'ARROYO','VENEDOR',7698,'1980-02-20',208000,39000,30),(7521,'SALA','VENEDOR',7698,'1981-02-22',162500,65000,30),(7566,'JIMÉNEZ','DIRECTOR',7839,'1981-04-02',386750,NULL,20),(7654,'MARTÍN','VENEDOR',7698,'1981-09-29',162500,182000,30),(7698,'NEGRO','DIRECTOR',7839,'1981-05-01',370500,NULL,30),(7782,'CEREZO','DIRECTOR',7839,'1981-06-09',318500,NULL,10),(7788,'GIL','ANALISTA',7566,'1981-11-09',390000,NULL,20),(7839,'REY','PRESIDENT',NULL,'1981-11-17',650000,NULL,10),(7844,'TOVAR','VENEDOR',7698,'1981-09-08',195000,0,30),(7876,'ALONSO','EMPLEAT',7788,'1981-09-23',143000,NULL,20),(7900,'JIMENO','EMPLEAT',7698,'1981-12-03',123500,NULL,30),(7902,'FERNÁNDEZ','ANALISTA',7566,'1981-12-03',390000,NULL,20),(7934,'MUÑOZ','EMPLEAT',7782,'1982-01-23',169000,NULL,10);
/*!40000 ALTER TABLE `EMP` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODUCTE`
--

DROP TABLE IF EXISTS `PRODUCTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRODUCTE` (
  `PROD_NUM` int(6) NOT NULL,
  `DESCRIPCIO` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`PROD_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODUCTE`
--

LOCK TABLES `PRODUCTE` WRITE;
/*!40000 ALTER TABLE `PRODUCTE` DISABLE KEYS */;
INSERT INTO `PRODUCTE` VALUES (100860,'ACE TENNIS RACKET I'),(100861,'ACE TENNIS RACKET II'),(100870,'ACE TENNIS BALLS-3 PACK'),(100871,'ACE TENNIS BALLS-6 PACK'),(100890,'ACE TENNIS NET'),(101860,'SP TENNIS RACKET'),(101863,'SP JUNIOR RACKET'),(102130,'RH: \"GUIDE TO TENNIS\"'),(200376,'SB ENERGY BAR-6 PACK'),(200380,'SB VITA SNACK-6 PACK');
/*!40000 ALTER TABLE `PRODUCTE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-04 16:02:27
