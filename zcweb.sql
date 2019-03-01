/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.7.17-log : Database - zcweb
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`zcweb` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `zcweb`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Data for the table `admin` */

insert  into `admin`(`id`,`name`,`password`) values (1,'leitao','123');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`id`,`name`) values (93,'智能手环'),(94,'智能家居'),(95,'智能出行'),(96,'智能穿戴'),(97,'智能电视');

/*Table structure for table `order_` */

DROP TABLE IF EXISTS `order_`;

CREATE TABLE `order_` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderCode` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `post` varchar(255) DEFAULT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `userMessage` varchar(255) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  `payDate` datetime DEFAULT NULL,
  `deliveryDate` datetime DEFAULT NULL,
  `confirmDate` datetime DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_user` (`uid`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

/*Data for the table `order_` */

insert  into `order_`(`id`,`orderCode`,`address`,`post`,`receiver`,`mobile`,`userMessage`,`createDate`,`payDate`,`deliveryDate`,`confirmDate`,`uid`,`status`) values (2,'201805041921349807459','桂电花江','210003','雷涛','123456789',NULL,'2018-05-04 19:21:34','2018-05-05 21:14:07','2018-05-06 15:07:50','2018-05-04 20:01:44',11,'delete'),(3,'201805042043543248144','桂电花江10栋','3433','切格拉嘛','1029304',NULL,'2018-05-04 20:43:54','2018-05-04 20:43:56','2018-05-05 09:49:07','2018-05-05 20:51:11',11,'waitReview'),(4,'201805042156575869861','gfafdghafdh','33','3gsfg','3524536453',NULL,'2018-05-04 21:56:57','2018-05-05 21:14:01','2018-05-06 15:08:12','2018-05-05 09:50:09',11,'delete'),(5,'201805051001385201256','桂电花江','210003','政治局常委嘻嘻哈哈','1458328283',NULL,'2018-05-05 10:01:38','2018-05-05 21:13:50','2018-05-06 15:08:09','2018-05-05 10:02:58',11,'delete'),(6,'201805051334578086920','GUET','210003','LEITAO','123121',NULL,'2018-05-05 13:34:57','2018-05-05 21:13:39','2018-05-06 15:08:03','2018-05-05 13:36:47',11,'delete'),(7,'201805051338045574767','WUJIAO','213494','LEITAO','123123',NULL,'2018-05-05 13:38:04','2018-05-06 19:49:58','2018-05-06 19:53:24','2018-05-05 13:39:03',12,'waitConfirm'),(8,'201805052111557565988','桂电花江','210001','雷涛','133332233',NULL,'2018-05-05 21:11:55','2018-05-05 21:11:57','2018-05-06 15:08:23',NULL,11,'delete'),(9,'201805061110117347223','桂林市','210001','雷涛','123344',NULL,'2018-05-06 11:10:11','2018-05-06 11:10:19','2018-05-06 15:08:20',NULL,11,'delete'),(10,'20180506111547709941','花江','2121','士兵76','76',NULL,'2018-05-06 11:15:47','2018-05-06 11:15:50','2018-05-06 15:08:17',NULL,11,'delete'),(11,'201805061120364054560','国王大道','000001','莱因哈特','0009',NULL,'2018-05-06 11:20:36','2018-05-06 11:20:42','2018-05-06 15:07:59','2018-05-06 20:15:04',11,'waitReview'),(12,'201805061124398283602','努巴尼','210001','禅','13456',NULL,'2018-05-06 11:24:39','2018-05-06 11:24:46','2018-05-06 15:07:54','2018-05-06 20:14:57',11,'waitReview'),(13,'20180506112754011904','66号公路','3432','76号','555',NULL,'2018-05-06 11:27:54','2018-05-06 11:27:55','2018-05-06 15:07:43','2018-05-06 20:14:47',11,'waitReview'),(14,'201805061133556779612','花村幼儿园','345','源氏','89088',NULL,'2018-05-06 11:33:55','2018-05-06 11:34:01','2018-05-06 15:07:42','2018-05-06 20:14:40',11,'waitReview'),(15,'201805061228361789411','尼泊尔','3850','宁静致远','0382',NULL,'2018-05-06 12:28:36','2018-05-06 12:28:37','2018-05-06 15:07:40','2018-05-06 19:49:04',12,'finish'),(16,'201805061232507343986','漓江塔','4960','狂鼠','2930',NULL,'2018-05-06 12:32:50','2018-05-06 12:33:02','2018-05-06 15:07:38','2018-05-06 20:14:33',11,'waitReview'),(17,'201805061330222428586','Junk Town','3944','路霸','5864',NULL,'2018-05-06 13:30:22','2018-05-06 13:30:23','2018-05-06 15:07:37','2018-05-06 20:12:10',11,'waitReview'),(18,'20180506202421204276','漓江塔','210002','猎空','12304943',NULL,'2018-05-06 20:24:21','2018-05-06 20:24:23','2018-05-11 14:31:48',NULL,11,'waitConfirm');

/*Table structure for table `orderitem` */

DROP TABLE IF EXISTS `orderitem`;

CREATE TABLE `orderitem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `oid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_orderitem_user` (`uid`),
  KEY `fk_orderitem_project` (`pid`),
  CONSTRAINT `fk_orderitem_project` FOREIGN KEY (`pid`) REFERENCES `project` (`id`),
  CONSTRAINT `fk_orderitem_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;

/*Data for the table `orderitem` */

insert  into `orderitem`(`id`,`pid`,`oid`,`uid`,`number`) values (3,12,2,11,1),(4,12,3,11,3),(11,12,4,11,7),(13,13,5,11,1),(18,12,-1,12,4),(19,13,7,12,2),(20,13,6,11,1),(22,14,8,11,1),(23,14,9,11,2),(24,14,10,11,3),(25,12,11,11,1),(26,13,12,11,1),(27,12,13,11,2),(28,13,14,11,1),(29,13,15,12,1),(30,12,16,11,2),(31,14,17,11,5),(32,20,18,11,250);

/*Table structure for table `project` */

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `projectCode` varchar(255) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  `detail` varchar(255) DEFAULT NULL,
  `reward` varchar(255) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `stock` int(8) DEFAULT NULL,
  `uid` int(8) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `publishDate` datetime DEFAULT NULL,
  `checkDate` datetime DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_project_category` (`cid`),
  KEY `fk_project_user` (`uid`),
  CONSTRAINT `fk_project_category` FOREIGN KEY (`cid`) REFERENCES `category` (`id`),
  CONSTRAINT `fk_project_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

/*Data for the table `project` */

insert  into `project`(`id`,`cid`,`projectCode`,`NAME`,`detail`,`reward`,`price`,`stock`,`uid`,`mobile`,`publishDate`,`checkDate`,`STATUS`) values (12,96,'201805041717241444479','新型智能眼镜','这是一款具有透视功能的眼镜','透视眼镜套装',1299,100,11,'12580','2018-05-04 17:17:24','2018-05-05 19:46:58','Checked'),(13,95,'20180505095452794563','柯南滑板','跑地贼快的滑板','滑板套装',999,100,11,'1501030107','2018-05-05 09:54:52','2018-05-06 15:58:18','Checked'),(14,93,'201805051720274083825','小米手环','能检测你的心率，贼溜','299手环套装',299,100,12,'1330783','2018-05-05 17:20:27','2018-05-05 19:25:53','Checked'),(15,94,'201805061640070766202','厨房空气净化器','清新空气，更亲近你','一台空气净化器',579,300,13,'8090','2018-05-06 16:40:07','2018-05-06 16:45:46','Checked'),(16,94,'201805061643191826552','智能小炉台','小宇青年小炉台，年轻人必备厨房良品！','小炉台+平底锅',299,100,13,'8090','2018-05-06 16:43:19','2018-05-06 16:45:49','Checked'),(17,94,'201805061645075701186','无线吸尘器','高颜值更轻盈 新概念无线吸尘器','无线吸尘器套装（吸尘器和清洁剂）',389,200,13,'8090','2018-05-06 16:45:07','2018-05-06 16:45:53','Checked'),(18,95,'201805061650137032984','智能电动自行车','innowin 智能电动自行车，尽在 “掌控” 中','智能电动自行车',1199,100,14,'8800','2018-05-06 16:50:13','2018-05-06 19:28:50','Checked'),(19,95,'201805061931356887276','潮人平衡车','小智街拍 PLUS 潮人平衡车','小智PLUS街拍平衡车黑（白）1台',2899,500,14,'8800','2018-05-06 19:31:35','2018-05-06 19:32:23','Checked'),(20,96,'20180506193533803267','VR实景眼镜','虚拟与现实的结合 ------VR 实景眼镜','VR眼镜+蓝牙手柄',179,300,15,'7897','2018-05-06 19:35:33','2018-05-06 19:43:56','Checked'),(21,96,'201805061942296619091','多单元定制圈铁','#听见更多细节 #，执着多单元定制圈铁系列','12单元定制圈铁耳机+升级线',1988,100,15,'8990','2018-05-06 19:42:29','2018-05-06 19:43:05','Checked');

/*Table structure for table `projectimage` */

DROP TABLE IF EXISTS `projectimage`;

CREATE TABLE `projectimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productimage_project` (`pid`),
  CONSTRAINT `fk_productimage_project` FOREIGN KEY (`pid`) REFERENCES `project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

/*Data for the table `projectimage` */

insert  into `projectimage`(`id`,`pid`,`type`) values (11,12,'type_single'),(12,12,'type_detail'),(13,12,'type_detail'),(14,13,'type_single'),(20,14,'type_single'),(21,14,'type_single'),(22,14,'type_detail'),(23,14,'type_detail'),(24,14,'type_detail'),(25,14,'type_detail'),(26,14,'type_detail'),(27,14,'type_detail'),(28,13,'type_detail'),(29,13,'type_detail'),(30,13,'type_detail'),(31,13,'type_detail'),(32,15,'type_single'),(33,15,'type_detail'),(34,15,'type_detail'),(35,15,'type_detail'),(36,16,'type_single'),(37,16,'type_single'),(38,16,'type_detail'),(39,16,'type_detail'),(40,16,'type_detail'),(41,17,'type_single'),(42,17,'type_detail'),(43,17,'type_detail'),(44,17,'type_detail'),(45,17,'type_detail'),(46,18,'type_single'),(47,18,'type_detail'),(48,18,'type_detail'),(49,18,'type_detail'),(50,18,'type_detail'),(51,19,'type_single'),(52,19,'type_detail'),(53,19,'type_detail'),(54,19,'type_detail'),(55,19,'type_detail'),(56,19,'type_detail'),(57,20,'type_single'),(58,20,'type_detail'),(59,20,'type_detail'),(60,20,'type_detail'),(61,20,'type_detail'),(62,20,'type_detail'),(63,20,'type_detail'),(64,21,'type_single'),(65,21,'type_detail'),(66,21,'type_detail'),(67,21,'type_detail');

/*Table structure for table `property` */

DROP TABLE IF EXISTS `property`;

CREATE TABLE `property` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_property_category` (`cid`),
  CONSTRAINT `fk_property_category` FOREIGN KEY (`cid`) REFERENCES `category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `property` */

/*Table structure for table `propertyvalue` */

DROP TABLE IF EXISTS `propertyvalue`;

CREATE TABLE `propertyvalue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `ptid` int(11) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_propertyvalue_property` (`ptid`),
  CONSTRAINT `fk_propertyvalue_property` FOREIGN KEY (`ptid`) REFERENCES `property` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `propertyvalue` */

/*Table structure for table `review` */

DROP TABLE IF EXISTS `review`;

CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(4000) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `createDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_review_product` (`pid`),
  KEY `fk_review_user` (`uid`),
  CONSTRAINT `fk_review_project` FOREIGN KEY (`pid`) REFERENCES `project` (`id`),
  CONSTRAINT `fk_review_user` FOREIGN KEY (`uid`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `review` */

insert  into `review`(`id`,`content`,`uid`,`pid`,`createDate`) values (2,'feichanghao',11,12,'2018-05-04 20:24:23'),(3,'不错的购物体验',11,12,'2018-05-05 09:51:17'),(4,'不错，的确贼快',11,13,'2018-05-05 10:03:23'),(5,'很好很好',11,13,'2018-05-05 13:37:30'),(6,'不错不错',12,13,'2018-05-05 13:39:17'),(7,'哎哟，不错哦',12,13,'2018-05-06 19:49:48');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `buynumber` int(11) DEFAULT NULL,
  `buytotal` float DEFAULT NULL,
  `publishnumber` int(11) DEFAULT NULL,
  `publishtotal` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`name`,`password`,`buynumber`,`buytotal`,`publishnumber`,`publishtotal`) values (11,'leitao','123',274,51298,4,4596),(12,'abc','123',18,7441,25,8161),(13,'a1','123',NULL,NULL,NULL,NULL),(14,'b2','123',NULL,NULL,NULL,NULL),(15,'c3','123',NULL,NULL,250,44750);

/*Table structure for table `webreview` */

DROP TABLE IF EXISTS `webreview`;

CREATE TABLE `webreview` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `webreview` */

insert  into `webreview`(`id`,`content`,`name`,`contact`,`username`) values (1,'','','','leitao'),(2,'nihao','nihao','fddfd','leitao'),(3,'nice','someone','82717*****','leitao');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
