CREATE DATABASE  IF NOT EXISTS `marketplace`;
USE `marketplace`;
-- MySQL dump 10.13  Distrib 8.0.21, for Win64 (x86_64)
--
-- Host: localhost    Database: marketplace
-- ------------------------------------------------------
-- Server version	8.0.21

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info` (
  `userEmail` varchar(45) NOT NULL,
  `userPhone` int NOT NULL,
  `userPassword` varchar(100) NOT NULL,
  `userFirstName` varchar(45) NOT NULL,
  `userLastName` varchar(45) NOT NULL,
  `userAddress` varchar(100) NOT NULL,
  `userPostalCode` int NOT NULL,
  `dateJoined` DATETIME NOT NULL,
  `lastLogin` DATETIME NOT NULL,
  `isAdmin` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`userEmail`)
) ENGINE=InnoDB;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `categoryID` int NOT NULL AUTO_INCREMENT,
  `categoryMain` VARCHAR(45) NOT NULL,
  `categorySub` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`categoryID`))
ENGINE = InnoDB ;

--
-- Table structure for table `order_info`
--
DROP TABLE IF EXISTS `order_info`;
CREATE TABLE `order_info` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `orderedCustomer` VARCHAR(45) NOT NULL,
  `orderedDate` DATETIME NOT NULL,
  `recipientName` VARCHAR(100) NOT NULL,
  `recipientAddress` VARCHAR(100) NOT NULL,
  `recipientPostalCode` int NOT NULL,
  `recipientPhone` int NOT NULL,
  `orderStatus` VARCHAR(20) NOT NULL,
  `totalItemPrice` FLOAT NOT NULL DEFAULT '0',
  `deliveryDate` DATETIME NOT NULL,
  `remark` VARCHAR(255) NULL DEFAULT NULL,
  `totalItemQuantity` int NOT NULL,
  `cardHolder` VARCHAR(100) DEFAULT 'EMPTY',
  `cardNumber` INT DEFAULT '0',
  `paymentMethod` INT NOT NULL DEFAULT '1',
  `cardExpiryDate` DATE DEFAULT NULL,
  PRIMARY KEY (`orderID`),
  CONSTRAINT `order_info_ref_user_info`
    FOREIGN KEY (`orderedCustomer`)
    REFERENCES `user_info` (`userEmail`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

--
-- Table structure for table `product_info`
--
DROP TABLE IF EXISTS `product_info`;
CREATE TABLE `product_info` (
  `productID` int NOT NULL AUTO_INCREMENT,
  `categoryID` int NOT NULL,
  `productName` varchar(100) NOT NULL,
  `productDescription` varchar(255) DEFAULT NULL,
  `availableQuantity` int NOT NULL DEFAULT '0',
  `lastUpdated` datetime DEFAULT NULL,
  `price` float NOT NULL DEFAULT '0',
  `soldQuantity` INT NOT NULL DEFAULT '0',
  `imagePath` varchar(255) DEFAULT NULL,
  `isShow` bit(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`productID`),
  CONSTRAINT `product_info_ref_category` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`)
) ENGINE=InnoDB;

--
-- Table structure for table `user_comment`
--

DROP TABLE IF EXISTS `user_comment`;
CREATE TABLE `user_comment` (
  `commentID` int NOT NULL AUTO_INCREMENT,
  `commentorEmail` varchar(45) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `commentDate` datetime DEFAULT NULL,
  `productID` int NOT NULL,
  `adminReply` VARCHAR(100) NOT NULL DEFAULT 'No Reply Yet',
  PRIMARY KEY (`commentID`),
  CONSTRAINT `user_comment_ref_user_info` FOREIGN KEY (`commentorEmail`) REFERENCES `user_info` (`userEmail`),
  CONSTRAINT `user_comment_ref_product_info` FOREIGN KEY (`productID`) REFERENCES `product_info` (`productID`)
) ENGINE=InnoDB;

-- Table structure for table `order_detail`
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail` (
  `productID` int NOT NULL,
  `orderID` int NOT NULL,
  `quantity` int NOT NULL,
  `subTotal` FLOAT NOT NULL,
  CONSTRAINT `order_detail_ref_product_info` FOREIGN KEY (`productID`) REFERENCES `product_info` (`productID`),
  CONSTRAINT `order_detail_ref_order_info` FOREIGN KEY (`orderID`) REFERENCES `order_info` (`orderID`)
) ENGINE=InnoDB;


--
-- Table structure for table `bookmark`
--
DROP TABLE IF EXISTS `bookmark`;
CREATE TABLE `bookmark` (
  `bookMarkID` int NOT NULL AUTO_INCREMENT,
  `productID` int NOT NULL,
  `userEmail` varchar(45) NOT NULL,
  `isMarked`  bit(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`bookMarkID`),
  CONSTRAINT `bookmark_ref_productInfo` FOREIGN KEY (`productID`) REFERENCES `product_info` (`productID`),
  CONSTRAINT `bookmark_ref_userInfo` FOREIGN KEY (`userEmail`) REFERENCES `user_info` (`userEmail`)
  ON DELETE CASCADE
  ON UPDATE CASCADE)
) ENGINE=InnoDB;
