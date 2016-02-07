-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2016 at 04:18 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

/*This is to refresh the database vsms, so that you do not need to keep deleting whenever you need to import this file onto the admin*/
drop database vsms;
create database vsms;
use vsms;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `vsms`
--

-- --------------------------------------------------------

--
-- Table structure for table `dish`
--

CREATE TABLE IF NOT EXISTS `dish` (
  `dish_id` int NOT NULL,
  `dish_name` varchar(30) NOT NULL,
  `vendor_id` int NOT NULL,
  `dish_description` text NOT NULL,
  PRIMARY KEY (`dish_id`),
  KEY `dish_name` (`dish_name`,`vendor_id`),
  KEY `vendor_id` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dish`
--

INSERT INTO `dish` (`dish_id`, `dish_name`, `vendor_id`, `dish_description`) VALUES
(1, 'Espresso', 1, 'Coffee for your tired self'),
(2, 'Duck Confit', 1, 'Compilations of duck products'),
(3, 'Rib Eye Steak', 1, 'Tender meat to complement your wine'),
(4, 'Burger', 1, 'Juicy and spiceful burger to suit your taste'),
(5, 'Roast Chicken', 1, 'Hot and fresh Roasted Chicken'),
(6, 'Green Chicken', 1, 'Thai Chicken with Green Soup');

-- --------------------------------------------------------

--
-- Table structure for table `dish_order`
--

CREATE TABLE IF NOT EXISTS `dish_order` (
  `dish_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `order_id` int NOT NULL,
  `dish_quantity` int NOT NULL,
  PRIMARY KEY (`dish_id`,`vendor_id`,`order_id`),
  KEY `dish_quantity` (`dish_quantity`),
  KEY `vendor_id` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `favourite_supplier`
--

CREATE TABLE IF NOT EXISTS `favourite_supplier` (
  `vendor_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  PRIMARY KEY (`vendor_id`,`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `favourite_supplier`
--

INSERT INTO `favourite_supplier` (`vendor_id`, `supplier_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `ingredient`
--
CREATE TABLE IF NOT EXISTS `ingredient` (
  `supplier_id` int NOT NULL,
  `ingredient_name` varchar(30) NOT NULL,
  `supply_unit` varchar(15) NOT NULL,
  `category` varchar(15) NOT NULL,
  `ingredient_description` text NOT NULL,
  `offered_price` float NOT NULL,
  PRIMARY KEY (`supplier_id`,`ingredient_name`),
  KEY `ingredient_type` (`category`),
  KEY `unit` (`supply_unit`),
  KEY `ingredient_name` (`ingredient_name`),
  KEY `offered_price` (`offered_price`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingredient`
--

INSERT INTO `ingredient` (`supplier_id`, `ingredient_name`, `supply_unit`, `category`, `ingredient_description`, `offered_price`) VALUES
(1, 'Coffee Beans', 'g', 'Misc', 'Fresh Coffee Beans from the market', 10.3),
(1, 'Lettuce', 'whole', 'Vegetable', 'Green fresh Lettuce for your salad', 12.3),
(1, 'Pink oranges', 'whole', 'Fruit', 'Unique pink oranges', 5.3),
(1, 'Potatoes', 'g', 'Vegetable', 'Sweet and healthy', 4.2),
(1, 'Purple apples', 'whole', 'Fruit', 'Weird but good', 2.3),
(1, 'Rainbow pineapple', 'whole', 'Fruit', 'Taste like rainbow', 10.3),
(1, 'Strawberry', 'g', 'Fruit', 'Red and juicy', 1.3),
(1, 'Tomatoes', 'g', 'Vegetable', 'Red and Red', 4.1),
(1, 'Whole Chickens', 'whole', 'Meat', 'Tender and healthy', 8.3),
(2, 'Chicken feet', 'g', 'Meat', 'Your local delicacy', 4.3),
(2, 'Foreign chicken', 'whole', 'Meat', 'Your foreign delicacy', 12.4),
(2, 'Local chicken', 'whole', 'Meat', 'White and healthy', 10.3),
(2, 'White Sugar', 'Cup', 'Bakery', 'White sugar to fulfill your sweet needs', 2.0),
(3, 'Blue spinach', 'g', 'Vegetable', 'Healthy blue spinach', 3.1),
(3, 'Organic olives', 'g', 'Vegetable', 'Healthy organic olives', 3.8),
(3, 'Rainbow cabbage', 'whole', 'Vegetable', 'Rainbow colored cabbage', 3.1),
(4, 'Ground Beef', 'g', 'Meat', 'Grounded Meat', 2.1),
(4, 'Leg of Duck', 'whole', 'Meat', 'Your duck legs', 2.9),
(4, 'Rib Eye', 'g', 'Meat', 'For your steak and wine dinner', 20.1),
(5, 'Leg of Duck', 'whole', 'Meat', 'Duck legs from heaven', 5.8),
(5, 'Parsley', 'g', 'Spice', 'Nice spice', 1.0),
(5, 'Rosemary', 'g', 'Spice', 'Nice spice', 1.0),
(5, 'Sage', 'g', 'Spice', 'Nice spice', 1.0),
(5, 'Thyme', 'g', 'Spice', 'Nice spice', 1.0);

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_quantity`
--

CREATE TABLE IF NOT EXISTS `ingredient_quantity` (
  `dish_id` int NOT NULL,
  `ingredient_name` varchar(30) NOT NULL,
  `quantity` int(15) NOT NULL,
  `vendor_id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `unit` varchar(15) NOT NULL,
  PRIMARY KEY (`dish_id`,`ingredient_name`,`vendor_id`,`supplier_id`),
  KEY `vendor_id` (`vendor_id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `unit` (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `ingredient_quantity` (`dish_id`, `ingredient_name`, `quantity`, `vendor_id`, `supplier_id`, `unit`) VALUES 
(1, 'Coffee Beans', 50, 1, 1, 'g'),
(1, 'White Sugar', 10, 1, 2, 'g'),
(1, 'Blue spinach', 100,1,3,'g'),
(2, 'Organic olives',40,1,3,'g'),
(2, 'Rainbow cabbage',10,1,3,'whole'),
(3, 'Ground Beef',50000,1,4,'g'),
(3, 'Leg of Duck',40,1,4,'whole'),
(4, 'Rib Eye',50,1,4,'Meat'),
(5, 'Leg of Duck',30,1,5,'whole'),
(5, 'Parsley',1000,1,5,'g'),
(5, 'Rosemary',1000,1,5,'g');


-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `total_final_price` int(15) NOT NULL,
  `dt` datetime NOT NULL,
  `status` varchar(15) NOT NULL,
  PRIMARY KEY (`order_id`,`vendor_id`),
  KEY `total_price` (`total_final_price`),
  KEY `vendor_id` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`order_id`, `vendor_id`, `total_final_price`,`dt`,`status`) VALUES
(10, 1, 132,'2015-11-12 10:00:09','approved'),
(11, 1, 402,'2015-11-12 10:00:09','approved'),
(12, 1, 400,'2015-11-12 10:00:09','rejected'),
(13, 1, 332,'2015-11-12 10:00:09','approved'),
(14, 1, 342,'2015-11-12 10:00:09','rejected'),
(15, 1, 331,'2015-11-14 10:34:09','rejected'),
(16, 1, 502,'2015-11-14 10:34:09','approved'),
(35, 1, 593,'2015-11-14 10:34:09','approved'),
(36, 1, 682,'2015-11-14 10:34:09','rejected'),
(37, 1, 94,'2015-11-30 10:34:09','approved'),
(38, 1, 234,'2015-11-30 10:34:09','rejected'),
(39, 1, 321,'2015-11-30 10:34:09','approved'),
(40, 1, 451,'2015-12-11 12:34:09','approved'),
(41, 1, 521,'2015-12-11 12:34:09','rejected'),
(42, 1, 111,'2015-12-11 12:34:09','approved'),
(43, 1, 311,'2015-12-11 12:34:09','approved'),
(44, 1, 422,'2015-12-11 12:34:09','approved'),
(45, 1, 512,'2015-12-11 12:34:09','approved'),
(46, 1, 392,'2015-12-11 12:34:09','rejected'),
(47, 1, 421,'2015-12-11 12:34:09','approved'),
(48, 1, 51,'2016-01-04 23:34:09','approved'),
(49, 1, 101,'2016-01-04 23:34:09','approved'),
(5, 1, 321,'2016-01-04 23:34:09','rejected'),
(50, 1, 421,'2016-01-13 08:32:09','approved'),
(51, 1, 551,'2016-01-13 08:32:09','approved'),
(52, 1, 598,'2016-01-13 08:32:09','approved'),
(53, 1, 879,'2016-01-13 08:32:09','pending'),
(54, 1, 302,'2016-01-15 06:23:09','pending'),
(6, 1, 333,'2016-01-16 10:34:09','pending'),
(7, 1, 311,'2016-01-16 10:34:09','pending'),
(8, 1, 321,'2016-01-16 10:34:09','pending'),
(9, 1, 421,'2016-01-16 10:34:09','pending'),
(4, 1, 20,'2016-01-18 10:34:09','pending'),
(1, 1, 33,'2016-01-18 10:34:09','pending'),
(3, 1, 33,'2016-01-18 10:34:09','pending'),
(2, 1, 140,'2016-01-18 10:34:09','pending');

-- --------------------------------------------------------

--
-- Table structure for table `orderline`
--

CREATE TABLE IF NOT EXISTS `orderline` (
  `vendor_id` int NOT NULL,
  `order_id` int NOT NULL,
  `supplier_id` varchar(15) NOT NULL,
  `ingredient_name` varchar(15) NOT NULL,
  `price` float NOT NULL,
  `quantity` int NOT NULL,
  `buffer_percentage` int NOT NULL,
  PRIMARY KEY (`vendor_id`,`order_id`,`supplier_id`,`ingredient_name`),
  KEY `price` (`price`,`quantity`),
  KEY `buffer_percentage` (`buffer_percentage`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orderline`
--

INSERT INTO `orderline` (`vendor_id`, `order_id`, `supplier_id`, `ingredient_name`, `price`, `quantity`, `buffer_percentage`) VALUES
(1, 1, 1, 'Potatoes', 50, 15, 0),
(1, 1, 1, 'Rainbow pineapple', 4, 1, 0),
(1, 10, 5, 'Leg of Duck', 52.1, 12, 0),
(1, 10, 5, 'Parsley', 4.2, 120, 0),
(1, 10, 5, 'Rosemary', 4.2, 120, 0),
(1, 10, 5, 'Sage', 4.2, 120, 0),
(1, 10, 5, 'Thyme', 4.2, 120, 0),
(1, 11, 4, 'Ground Beef', 52.3, 2400, 0),
(1, 11, 4, 'Rib Eye', 50, 3000, 0),
(1, 12, 1, 'Coffee Beans', 32, 240, 0),
(1, 12, 1, 'Lettuce', 10, 600, 0),
(1, 12, 1, 'Potatoes', 10, 6000, 0),
(1, 12, 1, 'Tomatoes', 10, 600, 0),
(1, 12, 1, 'Whole Chickens', 103.2, 12, 0),
(1, 13, 5, 'Leg of Duck', 32, 12, 0),
(1, 13, 5, 'Parsley', 4.2, 120, 0),
(1, 13, 5, 'Rosemary', 4.2, 120, 0),
(1, 13, 5, 'Sage', 4.2, 120, 0),
(1, 13, 5, 'Thyme', 4.2, 120, 0),
(1, 14, 4, 'Ground Beef', 32, 2400, 0),
(1, 14, 4, 'Rib Eye', 23, 3000, 0),
(1, 15, 1, 'Coffee Beans', 40, 240, 0),
(1, 15, 1, 'Lettuce', 10, 600, 0),
(1, 15, 1, 'Potatoes', 20.2, 6000, 0),
(1, 15, 1, 'Tomatoes', 30.2, 600, 0),
(1, 15, 1, 'Whole Chickens', 103.2, 12, 0),
(1, 16, 5, 'Leg of Duck', 79, 12, 0),
(1, 16, 5, 'Parsley', 4.2, 120, 0),
(1, 16, 5, 'Rosemary', 4.2, 120, 0),
(1, 16, 5, 'Sage', 4.2, 120, 0),
(1, 16, 5, 'Thyme', 4.2, 120, 0),
(1, 2, 1, 'Chicken feet', 3, 16, 0),
(1, 2, 1, 'Local Chicken', 4, 23, 0),
(1, 3, 3, 'Blue spinach', 2, 15, 0),
(1, 3, 3, 'Organic olives', 1, 3, 0),
(1, 35, 4, 'Ground Beef',42.1, 800, 0),
(1, 35, 4, 'Rib Eye',42.1, 750, 0),
(1, 36, 3, 'Blue spinach',42.1, 15, 0),
(1, 37, 2, 'Foreign chicken',42.1, 3, 0),
(1, 38, 5, 'Leg of Duck',42.1, 1, 0),
(1, 38, 5, 'Parsley',42.1, 10, 0),
(1, 38, 5, 'Rosemary',42.1, 40, 0),
(1, 38, 5, 'Sage',42.1, 10, 0),
(1, 38, 5, 'Thyme',42.1, 40, 0),
(1, 39, 1, 'Coffee Beans',42.1, 3, 0),
(1, 39, 1, 'Lettuce',42.1, 200, 0),
(1, 39, 1, 'Potatoes',42.1, 500, 0),
(1, 39, 1, 'Tomatoes',42.1, 200, 0),
(1, 39, 1, 'Whole Chickens',42.1, 4, 0),
(1, 4, 2, 'Chicken feet', 2, 5, 0),
(1, 4, 2, 'Local Chicken', 1, 10, 0),
(1, 40, 4, 'Ground Beef',42.1, 1200, 0),
(1, 40, 4, 'Rib Eye',42.1, 1500, 0),
(1, 41, 3, 'Blue spinach',42.1, 40, 0),
(1, 42, 2, 'Foreign chicken',42.1, 8, 0),
(1, 43, 5, 'Leg of Duck',42.1, 4, 0),
(1, 43, 5, 'Parsley',42.1, 40, 0),
(1, 43, 5, 'Rosemary',42.1, 80, 0),
(1, 43, 5, 'Sage',42.1, 40, 0),
(1, 43, 5, 'Thyme',42.1, 80, 0),
(1, 44, 1, 'Coffee Beans',42.1, 100, 0),
(1, 44, 1, 'Lettuce',42.1, 300, 0),
(1, 44, 1, 'Potatoes',42.1, 2000, 0),
(1, 44, 1, 'Tomatoes',42.1, 300, 0),
(1, 44, 1, 'Whole Chickens',42.1, 8, 0),
(1, 45, 4, 'Ground Beef',42.1, 2000, 0),
(1, 45, 4, 'Rib Eye',42.1, 3750, 0),
(1, 46, 3, 'Blue spinach',42.1, 70, 0),
(1, 47, 2, 'Foreign chicken',42.1, 14, 0),
(1, 48, 5, 'Leg of Duck',42.1, 13, 0),
(1, 48, 5, 'Parsley',42.1, 130, 0),
(1, 48, 5, 'Rosemary',42.1, 100, 0),
(1, 48, 5, 'Sage',42.1, 130, 0),
(1, 48, 5, 'Thyme',42.1, 100, 0),
(1, 49, 1, 'Coffee Beans',42.1, 280, 0),
(1, 49, 1, 'Lettuce',42.1, 500, 0),
(1, 49, 1, 'Potatoes',42.1, 6500, 0),
(1, 49, 1, 'Tomatoes',42.1, 500, 0),
(1, 49, 1, 'Whole Chickens',42.1, 10, 0),
(1, 5, 4, 'Ground Beef',42.1, 2000, 0),
(1, 5, 4, 'Rib Eye',42.1, 250, 0),
(1, 50, 4, 'Ground Beef',42.1, 800, 0),
(1, 50, 4, 'Rib Eye',42.1, 3500, 0),
(1, 51, 3, 'Blue spinach',42.1, 10, 0),
(1, 52, 2, 'Foreign chicken',42.1, 2, 0),
(1, 53, 5, 'Leg of Duck',42.1, 2, 0),
(1, 53, 5, 'Parsley',42.1, 20, 0),
(1, 53, 5, 'Rosemary',42.1, 50, 0),
(1, 53, 5, 'Sage',42.1, 20, 0),
(1, 53, 5, 'Thyme',42.1, 50, 0),
(1, 54, 1, 'Coffee Beans',42.1, 460, 0),
(1, 54, 1, 'Lettuce',42.1, 200, 0),
(1, 54, 1, 'Potatoes',42.1, 1000, 0),
(1, 54, 1, 'Tomatoes',42.1, 200, 0),
(1, 54, 1, 'Whole Chickens',42.1, 5, 0),
(1, 6, 1, 'Coffee Beans',42.1, 200, 0),
(1, 6, 1, 'Lettuce',42.1, 500, 0),
(1, 6, 1, 'Potatoes',42.1, 2500, 0),
(1, 6, 1, 'Tomatoes',42.1, 500, 0),
(1, 6, 1, 'Whole Chickens',42.1, 10, 0),
(1, 7, 5, 'Leg of Duck',42.1, 5, 0),
(1, 7, 5, 'Parsley',42.1, 50, 0),
(1, 7, 5, 'Rosemary',42.1, 100, 0),
(1, 7, 5, 'Sage',42.1, 50, 0),
(1, 7, 5, 'Thyme',42.1, 100, 0),
(1, 8, 4, 'Ground Beef',42.1, 2400, 0),
(1, 8, 4, 'Rib Eye',42.1, 3000, 0),
(1, 9, 1, 'Coffee Beans',42.1, 240, 0),
(1, 9, 1, 'Lettuce',42.1, 600, 0),
(1, 9, 1, 'Potatoes',42.1, 6000, 0),
(1, 9, 1, 'Tomatoes',42.1, 600, 0),
(1, 9, 1, 'Whole Chickens',42.1, 12, 0);

-- --------------------------------------------------------

--
-- Table structure for table `order_template`
--

CREATE TABLE IF NOT EXISTS `order_template` (
  `order_id` int NOT NULL,
  `vendor_id` int NOT NULL,
  `name` varchar(30) NOT NULL,
  PRIMARY KEY (`order_id`,`vendor_id`),
  KEY `vendor_id` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` int NOT NULL,
  `supplier_name` varchar(30) NOT NULL,
  `supplier_description` text NOT NULL,
  `supplier_type` varchar(15) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `area_code` int NOT NULL,
  `telephone_number` int NOT NULL,
  `address` varchar(100) NOT NULL, 
  PRIMARY KEY (`supplier_id`),
  KEY `supplier_name` (`supplier_name`),
  KEY `supplier_type` (`supplier_type`),
  KEY `password` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplier_id`, `supplier_name`, `supplier_description`, `supplier_type`, `password`,`email`,`area_code`,`telephone_number`,`address`) VALUES
(1, 'FreshFruitz', 'Description: Providing the freshest and cheapest fruits since 1987. Offering a wide range, from tropical to imported exotic fruits. Items Sold: Rainbow pinapples, Purple apples, Pink oranges etc.', 'western', '','vincentt.2013@sis.smu.edu.sg',65,87221272,'Punggol Street 10, Industrial Block #B1-10'),
(2, 'FreshFoodz', 'Description: Providing the freshest and cheapest chicken since 1887. Offering a wide range of fresh chicken parts. Items Sold: Chicken feet, foreign and local chicken.', 'asian','','vincentt.2013@sis.smu.edu.sg',65,87221272,'Lakeside Street 20, Block 401, #11-10'),
(3, 'FreshSaladz', 'Description: Established in 2014, we provide the best technology in growing organic vegetables. We conduct research in additive free, genetically modified vegetables infused with a variety of vitamins and minerals. Items Sold: Rainbow cabbage, Blue spinach, Organic olives.', 'fusion', '','vincentt.2013@sis.smu.edu.sg',65,87221272,'Jurong Avenue 2, Opposite Jurong Bird Park'),
(4, 'Animal Farm', 'Animal Farm! Animal Animal Animals! Description: Where the pigs farm. Offering discounts on horse meat and beef. Items Sold: We have poultry ranging from kampong chicken to flying pigs!!', 'western', '','vincentt.2013@sis.smu.edu.sg',65,87221272,'Lakeside Street 10, Block 101, #3-10'),
(5, 'Only a Matter of Thyme', 'Only a Matter of Thyme! Description: Time waits for no one. Delivery across thyme and space. Items Sold: Time', 'spices', '','vincentt.2013@sis.smu.edu.sg',65,87221272,'Bart Street 3, Block 41, #1-10');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE IF NOT EXISTS `test` (
  `value1` varchar(15) NOT NULL,
  `value2` varchar(15) NOT NULL,
  `value3` varchar(15) NOT NULL,
  PRIMARY KEY (`value1`),
  KEY `value2` (`value2`,`value3`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`value1`, `value2`, `value3`) VALUES
('1', '2', '3'),
('4', '5', '6'),
('7', '8', '9');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--
CREATE TABLE IF NOT EXISTS `vendor` (
  `vendor_id` int NOT NULL,
  `vendor_name` varchar(50) NOT NULL,
  `vendor_description` varchar(100) NOT NULL,
  `password` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `area_code` int NOT NULL,
  `telephone_number` int NOT NULL,
  `address` varchar(100) NOT NULL,
  PRIMARY KEY (`vendor_id`),
  KEY `vendor_name` (`vendor_name`,`vendor_description`),
  KEY `password` (`password`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`vendor_id`, `vendor_name`, `vendor_description`, `password`,`email`,`area_code`,`telephone_number`,`address`) VALUES
(1, 'Bob''s Bakery And Bistro', 'Bob bakery and bistro is a renowned Bistro that was established in 1976', '','vincentt.2013@sis.smu.edu.sg',65,87221272,'1B Braddel Road #05-02');


--
-- Constraints for dumped tables
--

--
-- Constraints for table `dish`
--
ALTER TABLE `dish`
  ADD CONSTRAINT `dish_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `dish_order`
--
ALTER TABLE `dish_order`
  ADD CONSTRAINT `dish_order_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  ADD CONSTRAINT `dish_order_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`dish_id`);

--
-- Constraints for table `ingredient`
--
ALTER TABLE `ingredient`
  ADD CONSTRAINT `ingredient_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`);

--
-- Constraints for table `ingredient_quantity`
--
ALTER TABLE `ingredient_quantity`
  ADD CONSTRAINT `ingredient_quantity_ibfk_1` FOREIGN KEY (`dish_id`) REFERENCES `dish` (`dish_id`),
  ADD CONSTRAINT `ingredient_quantity_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`),
  ADD CONSTRAINT `ingredient_quantity_ibfk_3` FOREIGN KEY (`supplier_id`) REFERENCES `supplier` (`supplier_id`);

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

--
-- Constraints for table `order_template`
--
ALTER TABLE `order_template`
  ADD CONSTRAINT `order_template_ibfk_1` FOREIGN KEY (`vendor_id`) REFERENCES `vendor` (`vendor_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
