# ************************************************************
# Sequel Ace SQL dump
# Version 20051
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# Host: 127.0.0.1 (MySQL 8.0.31)
# Database: posSystem
# Generation Time: 2024-01-02 09:19:54 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table adminCategories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `adminCategories`;

CREATE TABLE `adminCategories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `src` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `adminCategories` WRITE;
/*!40000 ALTER TABLE `adminCategories` DISABLE KEYS */;

INSERT INTO `adminCategories` (`id`, `name`, `src`)
VALUES
	(1,'New Order','https://i.ibb.co/SxdKpfN/menu.png\"'),
	(2,'Dashboard','https://i.ibb.co/6rR5Rqs/menu.png'),
	(3,'Online Order','https://i.ibb.co/gjjpRm7/settings.png'),
	(4,'Settings','https://i.ibb.co/gjjpRm7/settings.png'),
	(5,'Logout','https://i.ibb.co/M9511rJ/menu.png');

/*!40000 ALTER TABLE `adminCategories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `src` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;

INSERT INTO `categories` (`id`, `name`, `src`)
VALUES
	(1,'Meals','https://i.ibb.co/rGbs5bV/categories.png'),
	(2,'Burgers','https://i.ibb.co/rGbs5bV/categories.png'),
	(3,'Sides','https://i.ibb.co/Js2Ndtg/categories3.png'),
	(4,'Drink','https://i.ibb.co/mFDqZXb/categories4.png'),
	(5,'Kids','https://i.ibb.co/rGbs5bV/categories.png');

/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table foods
# ------------------------------------------------------------

DROP TABLE IF EXISTS `foods`;

CREATE TABLE `foods` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `price` varchar(10) NOT NULL,
  `src` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `foods` WRITE;
/*!40000 ALTER TABLE `foods` DISABLE KEYS */;

INSERT INTO `foods` (`id`, `name`, `price`, `src`)
VALUES
	(1,'Quater Pounder With Cheese','3.99','https://i.ibb.co/7S9p77f/burger.png'),
	(2,'Double Quater Pounder With Cheese','4.79','https://i.ibb.co/rmMQWbg/image.png'),
	(3,'Quater Pounder With Cheese Deluxe','4.29','https://i.ibb.co/7S9p77f/burger.png'),
	(4,'Bic Mac','3.99','https://i.ibb.co/rmMQWbg/image.png'),
	(5,'McDouble','1.99','https://i.ibb.co/yF65V4C/image.png'),
	(6,'Quater Pounder With Cheese Bacon','4.99','https://i.ibb.co/7S9p77f/burger.png'),
	(7,'Classic Angus','4.99','https://i.ibb.co/rmMQWbg/image.png'),
	(8,'Bacon Barbeque Angus','5.99','https://i.ibb.co/7S9p77f/burger.png'),
	(9,'Spicy Chicken','5.99','https://i.ibb.co/yF65V4C/image.png');

/*!40000 ALTER TABLE `foods` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table order
# ------------------------------------------------------------

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `orderTime` datetime NOT NULL,
  `totalPrice` double(8,2) NOT NULL,
  `payment` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `totalQty` int DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;

INSERT INTO `order` (`id`, `orderTime`, `totalPrice`, `payment`, `totalQty`, `status`)
VALUES
	(56,'2023-11-14 07:54:18',9.28,'Credit Card',2,'Completed'),
	(57,'2023-11-14 07:54:30',18.36,'Credit Card',4,NULL),
	(58,'2023-11-14 10:21:29',31.74,'Credit Card',6,NULL),
	(59,'2023-11-14 10:21:38',26.05,'Credit Card',5,'Completed'),
	(60,'2023-11-14 10:21:46',20.34,'Credit Card',6,NULL),
	(61,'2023-11-14 10:21:52',34.32,'Credit Card',8,NULL),
	(62,'2023-11-14 10:21:59',23.94,'Credit Card',6,NULL),
	(63,'2023-11-14 10:22:06',11.94,'Credit Card',6,NULL),
	(64,'2023-11-14 10:22:26',21.93,'Credit Card',7,NULL),
	(65,'2023-11-14 10:22:34',40.92,'Credit Card',8,NULL),
	(66,'2023-11-14 10:22:40',34.94,'Credit Card',6,NULL),
	(67,'2023-11-14 10:26:17',11.77,'Credit Card',3,NULL),
	(68,'2023-11-14 10:26:23',29.93,'Credit Card',7,NULL),
	(69,'2023-11-14 10:26:29',44.92,'Credit Card',8,NULL),
	(70,'2023-11-14 10:26:35',39.92,'Credit Card',8,'Completed'),
	(71,'2023-11-24 12:10:59',9.28,'Credit Card',2,'Completed'),
	(72,'2023-12-19 12:28:23',4.29,'Credit Card',1,'Completed');

/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table orderItems
# ------------------------------------------------------------

DROP TABLE IF EXISTS `orderItems`;

CREATE TABLE `orderItems` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `orderNumber` int NOT NULL,
  `item` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `qty` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `orderItems` WRITE;
/*!40000 ALTER TABLE `orderItems` DISABLE KEYS */;

INSERT INTO `orderItems` (`id`, `orderNumber`, `item`, `qty`)
VALUES
	(25,55,'Quater Pounder With Cheese Deluxe',1),
	(26,55,'Quater Pounder With Cheese Bacon',1),
	(27,56,'Quater Pounder With Cheese Deluxe',1),
	(28,56,'Quater Pounder With Cheese Bacon',1),
	(29,57,'Quater Pounder With Cheese Deluxe',2),
	(30,57,'Quater Pounder With Cheese Bacon',1),
	(31,57,'Double Quater Pounder With Cheese',1),
	(32,58,'Quater Pounder With Cheese',1),
	(33,58,'Double Quater Pounder With Cheese',1),
	(34,58,'Spicy Chicken',2),
	(35,58,'Bacon Barbeque Angus',1),
	(36,58,'Classic Angus',1),
	(37,59,'Quater Pounder With Cheese Deluxe',1),
	(38,59,'Double Quater Pounder With Cheese',1),
	(39,59,'Quater Pounder With Cheese Bacon',1),
	(40,59,'Spicy Chicken',2),
	(41,60,'Double Quater Pounder With Cheese',3),
	(42,60,'McDouble',3),
	(43,61,'Quater Pounder With Cheese Deluxe',8),
	(44,62,'Bic Mac',6),
	(45,63,'McDouble',6),
	(46,64,'Quater Pounder With Cheese',4),
	(47,64,'McDouble',3),
	(48,65,'Quater Pounder With Cheese Bacon',7),
	(49,65,'Spicy Chicken',1),
	(50,66,'Bacon Barbeque Angus',5),
	(51,66,'Classic Angus',1),
	(52,67,'Double Quater Pounder With Cheese',1),
	(53,67,'McDouble',1),
	(54,67,'Quater Pounder With Cheese Bacon',1),
	(55,68,'Quater Pounder With Cheese',4),
	(56,68,'Bic Mac',1),
	(57,68,'Quater Pounder With Cheese Bacon',2),
	(58,69,'Bacon Barbeque Angus',5),
	(59,69,'Classic Angus',3),
	(60,70,'Classic Angus',8),
	(61,71,'Quater Pounder With Cheese Deluxe',1),
	(62,71,'Quater Pounder With Cheese Bacon',1),
	(63,72,'Quater Pounder With Cheese Deluxe',1);

/*!40000 ALTER TABLE `orderItems` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
