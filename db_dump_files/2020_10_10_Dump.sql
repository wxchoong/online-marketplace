CREATE DATABASE  IF NOT EXISTS `marketplace` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `marketplace`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: marketplace
-- ------------------------------------------------------
-- Server version	8.0.21

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `audit_log`
--

DROP TABLE IF EXISTS `audit_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_log` (
  `auditID` int NOT NULL AUTO_INCREMENT,
  `userID` int NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `editor` varchar(100) NOT NULL,
  `updates` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`auditID`),
  KEY `userID` (`userID`),
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `user_info` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_log`
--

LOCK TABLES `audit_log` WRITE;
/*!40000 ALTER TABLE `audit_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `detail` varchar(45) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Living Room','Sofa'),(2,'Living Room','Carpets & Rugs'),(3,'Living Room','Coffee Table'),(4,'Living Room','TV Consoles'),(5,'Living Room','Arm Chairs'),(6,'Bedroom','Bedsets'),(7,'Bedroom','Night Stands'),(8,'Bedroom','Bed Frames'),(9,'Bedroom','Mattresses'),(10,'Bathroom','Bath Towels'),(11,'Bathroom','Rugs'),(12,'Bathroom','Accessories'),(13,'Dining Room','Dining Table'),(14,'Dining Room','Chairs'),(15,'Dining Room','Plates'),(16,'Dining Room','Wine Glasses'),(17,'Dining Room','Candles'),(18,'Dining Room','Cutlery'),(19,'Home Decor','Blinds & Curtains'),(20,'Home Decor','Lights & Lamps'),(21,'Home Decor','Wall Arts'),(22,'Home Decor','Mirrors'),(23,'Home Decor','Cushions & Throws'),(24,'Home Decor','Scent Products');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_info`
--

DROP TABLE IF EXISTS `order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_info` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `createdDate` datetime NOT NULL,
  `recipientName` varchar(128) NOT NULL,
  `custEmail` varchar(100) NOT NULL,
  `custPhone` int NOT NULL,
  `custAddress` varchar(255) NOT NULL,
  `custPostcode` int NOT NULL,
  `orderStatus` varchar(20) NOT NULL,
  `totalPrice` float NOT NULL DEFAULT '0',
  `deliveryDate` datetime NOT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  UNIQUE KEY `custPostcode_UNIQUE` (`custPostcode`),
  KEY `customerEmail` (`custEmail`),
  KEY `customerPhone` (`custPhone`),
  CONSTRAINT `customerEmail` FOREIGN KEY (`custEmail`) REFERENCES `user_info` (`email`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customerPhone` FOREIGN KEY (`custPhone`) REFERENCES `user_info` (`phone`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_info`
--

LOCK TABLES `order_info` WRITE;
/*!40000 ALTER TABLE `order_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_info`
--

DROP TABLE IF EXISTS `product_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_info` (
  `productID` int NOT NULL,
  `category` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `availableQuantity` int NOT NULL DEFAULT '0',
  `lastUpdated` datetime DEFAULT NULL,
  `price` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`productID`),
  KEY `categoryId` (`category`),
  CONSTRAINT `categoryId` FOREIGN KEY (`category`) REFERENCES `category` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_info`
--

LOCK TABLES `product_info` WRITE;
/*!40000 ALTER TABLE `product_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabsales_order`
--

DROP TABLE IF EXISTS `tabsales_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tabsales_order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `creation_datetime` datetime(6) NOT NULL,
  `customer_name` varchar(140) DEFAULT NULL,
  `customer_address` varchar(140) DEFAULT NULL,
  `customer_phone_no` varchar(140) DEFAULT NULL,
  `shipper_name` varchar(140) DEFAULT NULL,
  `shipper_address` varchar(140) DEFAULT NULL,
  `shipper_phone_no` varchar(140) DEFAULT NULL,
  `personalised_msg` varchar(140) DEFAULT NULL,
  `attrib_01` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabsales_order`
--

LOCK TABLES `tabsales_order` WRITE;
/*!40000 ALTER TABLE `tabsales_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `tabsales_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tabsales_order_item`
--

DROP TABLE IF EXISTS `tabsales_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tabsales_order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `creation_datetime` datetime(6) NOT NULL,
  `parent_id` int NOT NULL,
  `item_code` varchar(140) NOT NULL,
  `quantity` int NOT NULL,
  `mfr` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`),
  CONSTRAINT `tabsales_order_item_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `tabsales_order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tabsales_order_item`
--

LOCK TABLES `tabsales_order_item` WRITE;
/*!40000 ALTER TABLE `tabsales_order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `tabsales_order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_comment`
--

DROP TABLE IF EXISTS `user_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_comment` (
  `commentID` int NOT NULL AUTO_INCREMENT,
  `commentorID` bigint NOT NULL,
  `comment` varchar(100) NOT NULL,
  `date` datetime DEFAULT NULL,
  `rate` int NOT NULL,
  PRIMARY KEY (`commentID`),
  KEY `commentor_fk_userID` (`commentorID`),
  CONSTRAINT `commentor_fk_userID` FOREIGN KEY (`commentorID`) REFERENCES `user_info` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_comment`
--

LOCK TABLES `user_comment` WRITE;
/*!40000 ALTER TABLE `user_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info` (
  `userID` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(45) NOT NULL,
  `phone` int NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `firstName` varchar(64) NOT NULL,
  `lastName` varchar(64) NOT NULL,
  `address` varchar(100) NOT NULL,
  `postCode` int NOT NULL,
  `dateJoined` datetime DEFAULT NULL,
  `lastLogin` datetime DEFAULT NULL,
  `isActive` bit(1) NOT NULL,
  `preferPayment` varchar(10) NOT NULL,
  `adminStatus` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`userID`),
  UNIQUE KEY `Phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,'lingang1994@gmail.com',97984038,'1111','Lin','Gang','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 01:03:02','2020-09-27 01:03:02',_binary '','CARD',_binary '\0'),(2,'caden2019@gmail.com',90034738,'11111','Caden','Lin','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 01:03:36','2020-09-27 01:03:36',_binary '','CARD',_binary '\0'),(3,'Jaden2019@gmail.com',90034731,'11111','Jaden','Chen','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 01:05:19','2020-09-27 01:05:19',_binary '','CARD',_binary '\0'),(4,'qwewqwqe9@gmail.com',90034733,'1123','qewq','qwewqeqw','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 01:05:53','2020-09-27 01:05:53',_binary '','CARD',_binary '\0'),(5,'asdsadsadase9@gmail.com',90034734,'1123','sadasdasd','asdsadasd','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 01:06:33','2020-09-27 01:06:33',_binary '','CARD',_binary '\0'),(6,'stanley-lg@hotmail.com',91234567,'123','John','Doe','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 02:15:13','2020-09-27 02:15:13',_binary '','CARD',_binary '\0'),(7,'asdasdsadasg1994@gmail.com',91111111,'1111','aadasdas','asdasdasdsadsa','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 02:31:09','2020-09-27 02:31:09',_binary '','CARD',_binary '\0'),(8,'asdasdsadas94@gmail.com',92222222,'12345','asfdsfdsfds','dsfdsfdsfsd','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 02:33:40','2020-09-27 02:33:40',_binary '','CARD',_binary '\0'),(9,'ASAsaSA4@gmail.com',93333333,'12345','asdsadffd','fdfdfdfd','Blk 684C Edgedale Plains #17-653',823684,'2020-09-27 02:48:38','2020-09-27 02:48:38',_binary '','CARD',_binary '\0');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'marketplace'
--

--
-- Dumping routines for database 'marketplace'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_item_by_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_item_by_category`(categoryTitle varchar(45))
BEGIN
	Select * from product_info where category = (Select ID from category where title = categoryTitle);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_new_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_new_order`(createDate DATETIME, Cname VARCHAR(140), addr VARCHAR(140), ph VARCHAR(140), shipName VARCHAR(140), shipAddr VARCHAR(140), shipPh VARCHAR(140), msg VARCHAR(140), cust_mail VARCHAR(140))
BEGIN
INSERT INTO tabSales_Order(creation_datetime, customer_name,
	customer_address, customer_phone_no, shipper_name, shipper_address, shipper_phone_no, 
	personalised_msg, customer_email) VALUES (createDate, Cname, addr, ph, shipName, shipAddr, shipPh, msg, cust_mail);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_registration` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_registration`(email VARCHAR(45), fName VARCHAR(64), lName VARCHAR(64), contact INT, pwd VARCHAR(100), addr VARCHAR(100), postal INT)
BEGIN
	insert into user_info VALUES (NULL, email, contact, pwd, fName, lName, addr, postal, now(), now(), 1, "CARD", 0);
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

-- Dump completed on 2020-10-10  0:45:52
