/*
MySQL Data Transfer
Source Host: localhost
Source Database: bonuspointsexchange
Target Host: localhost
Target Database: bonuspointsexchange
Date: 2016/10/9 21:57:39
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for order
-- ----------------------------
drop database bonuspointsexchange;
create database bonuspointsexchange;
use bonuspointsexchange;
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `point` int(11) NOT NULL DEFAULT '0',
  `wantedShop` varchar(50) NOT NULL DEFAULT '',
  `wantedPoint` int(11) NOT NULL DEFAULT '0',
  `untilDate` date NOT NULL DEFAULT '0000-00-00',
  `exchangeUserName` varchar(50) DEFAULT NULL,
  `orderDate` date DEFAULT '0000-00-00',
  `orderStatus` int(11) NOT NULL DEFAULT '0',
  `userName` varchar(50) NOT NULL DEFAULT '',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`orderID`),
  KEY `userName` (`userName`),
  KEY `shopName` (`shopName`),
  KEY `wantedShop` (`wantedShop`),
  KEY `exchangeUserName` (`exchangeUserName`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_2` FOREIGN KEY (`shopName`) REFERENCES `shop` (`shopName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_3` FOREIGN KEY (`wantedShop`) REFERENCES `shop` (`shopName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_ibfk_4` FOREIGN KEY (`exchangeUserName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for point
-- ----------------------------
DROP TABLE IF EXISTS `point`;
CREATE TABLE `point` (
  `pointID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL DEFAULT '',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `platformPoint` int(11) NOT NULL DEFAULT '0',
  `bindtime` date NOT NULL,
  PRIMARY KEY (`pointID`),
  KEY `userName` (`userName`),
  KEY `shopName` (`shopName`),
  CONSTRAINT `point_ibfk_1` FOREIGN KEY (`userName`) REFERENCES `user` (`userName`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `point_ibfk_2` FOREIGN KEY (`shopName`) REFERENCES `shop` (`shopName`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `imageURL` varchar(200) DEFAULT NULL,
  `password` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `number` varchar(50) NOT NULL DEFAULT '',
  `shopProperty` varchar(50) NOT NULL DEFAULT '',
  `shopDec` varchar(500) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shopName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for transfer
-- ----------------------------
DROP TABLE IF EXISTS `transfer`;
CREATE TABLE `transfer` (
  `transferID` int(11) NOT NULL AUTO_INCREMENT,
  `pointID` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `point` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`transferID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userName` varchar(50) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `imageURL` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for userpoint
-- ----------------------------
DROP TABLE IF EXISTS `userpoint`;
CREATE TABLE `userpoint` (
  `userName` varchar(50) NOT NULL DEFAULT '',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `userPoint` int(11) DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records 
-- ----------------------------
INSERT INTO `order` VALUES ('1', '1', '国航', '2', '2016-11-05', 'deng', '2016-10-08', '1', 'guo', '东航');
INSERT INTO `order` VALUES ('2', '1', '国航', '4', '2016-11-05', 'deng', '2016-10-08', '1', 'guo', '东航');
INSERT INTO `order` VALUES ('3', '1', '东航', '6', '2016-11-05', 'deng', '2016-10-08', '1', 'guo', '国航');
INSERT INTO `order` VALUES ('4', '0', '国航', '0', '2016-11-05', null, '0000-00-00', '0', 'guo', '555');
INSERT INTO `order` VALUES ('5', '0', '国航', '0', '2016-11-05', null, '0000-00-00', '0', 'guo', '东航');
INSERT INTO `order` VALUES ('7', '1', '国航', '65', '2016-11-05', 'deng', '2016-10-08', '1', 'guo', '东航');
INSERT INTO `order` VALUES ('8', '1', '国航', '344', '2016-11-05', 'deng', '2016-10-08', '1', 'guo', '东航');
INSERT INTO `order` VALUES ('9', '1', '555', '400', '2016-11-05', null, '0000-00-00', '0', 'guo', '东航');
INSERT INTO `order` VALUES ('10', '1', '国航', '77', '2016-11-05', null, '0000-00-00', '0', 'guo', '东航');
INSERT INTO `order` VALUES ('11', '1', '国航', '656', '2016-11-05', null, '0000-00-00', '0', 'guo', '东航');
INSERT INTO `order` VALUES ('12', '1', '国航', '32', '2016-11-06', 'deng', '2016-10-08', '1', 'guo', '东航');
INSERT INTO `order` VALUES ('13', '1', '国航', '222', '2016-11-06', 'guo', '2016-10-08', '1', 'deng', '东航');
INSERT INTO `point` VALUES ('1', 'guo', '东航', '8758', '0000-00-00');
INSERT INTO `point` VALUES ('3', 'guo', '国航', '10224', '0000-00-00');
INSERT INTO `point` VALUES ('4', 'deng', '东航', '20242', '0000-00-00');
INSERT INTO `point` VALUES ('5', 'deng', '国航', '-347', '0000-00-00');
INSERT INTO `shop` VALUES ('555', 'null', 'E3CEB5881A0A1FDAAD01296D7554868D', '1255826318@qq.com', '1111111', 'null', '阿达的', '6657878');
INSERT INTO `shop` VALUES ('东航', 'null', 'E10ADC3949BA59ABBE56E057F20F883E', '1803750454@qq.com', '432423', 'null', 'null', 'null');
INSERT INTO `shop` VALUES ('国航', 'null', '1', '1540473376@qq.com', '432423', 'null', 'null', 'null');
INSERT INTO `transfer` VALUES ('1', '4', '0', '20000');
INSERT INTO `user` VALUES ('admin', 'C4CA4238A0B923820DCC509A6F75849B', '1540473376@qq.com', 'ed', '17801125626', null);
INSERT INTO `user` VALUES ('deng', '1', '1803750454@qq.com', 'deng', '31312', null);
INSERT INTO `user` VALUES ('guo', '12', '1540473376@qq.com', 'd3232', '13260665620', null);
INSERT INTO `userpoint` VALUES ('guo', '国航', '40000', '');
INSERT INTO `userpoint` VALUES ('guo', '东航', '30500', '');
INSERT INTO `userpoint` VALUES ('deng', '东航', '22202222', '');
INSERT INTO `userpoint` VALUES ('deng', '国航', '222222222', '');
