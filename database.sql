/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 10.4.22-MariaDB : Database - contacts
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`contacts` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `contacts`;

/*Table structure for table `categories` */

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `catid` int(11) NOT NULL AUTO_INCREMENT,
  `categoryname` varchar(50) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`catid`),
  UNIQUE KEY `categoryname` (`categoryname`),
  KEY `createdby` (`createdby`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`createdby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Data for the table `categories` */

insert  into `categories`(`catid`,`categoryname`,`dateadded`,`createdby`,`deleted`) values (2,'Family','2022-02-10 19:01:54',1,0),(4,'Best Friends','2022-02-10 19:02:25',1,0),(5,'Colleagues','2022-02-10 19:02:37',1,0),(9,'Classmates','2022-02-10 19:07:38',4,0),(10,'Teachers','2022-02-24 19:32:50',1,0),(11,'Officials','2022-02-24 19:33:13',1,0);

/*Table structure for table `contactcategories` */

DROP TABLE IF EXISTS `contactcategories`;

CREATE TABLE `contactcategories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contactid` int(11) DEFAULT NULL,
  `categoryid` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `contactid` (`contactid`),
  KEY `categoryid` (`categoryid`),
  CONSTRAINT `contactcategories_ibfk_1` FOREIGN KEY (`contactid`) REFERENCES `contacts` (`contactid`),
  CONSTRAINT `contactcategories_ibfk_2` FOREIGN KEY (`categoryid`) REFERENCES `categories` (`catid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `contactcategories` */

/*Table structure for table `contacts` */

DROP TABLE IF EXISTS `contacts`;

CREATE TABLE `contacts` (
  `contactid` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `company` varbinary(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `website` varchar(100) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `addedby` int(11) DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT 0,
  `favorite` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`contactid`),
  KEY `addedby` (`addedby`),
  CONSTRAINT `contacts_ibfk_1` FOREIGN KEY (`addedby`) REFERENCES `users` (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `contacts` */

/*Table structure for table `serialnumbers` */

DROP TABLE IF EXISTS `serialnumbers`;

CREATE TABLE `serialnumbers` (
  `document` varchar(50) DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `currentno` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `serialnumbers` */

insert  into `serialnumbers`(`document`,`prefix`,`currentno`) values ('users','KE/2022',3);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(10) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `middlename` varchar(50) DEFAULT NULL,
  `lastname` varchar(50) DEFAULT NULL,
  `dateadded` datetime DEFAULT NULL,
  `accountactive` tinyint(1) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `salt` varchar(100) DEFAULT NULL,
  `createdby` int(11) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `mobile` (`mobile`),
  UNIQUE KEY `email` (`email`),
  KEY `createdby` (`createdby`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`createdby`) REFERENCES `users` (`userid`),
  CONSTRAINT `c1_gender_chk` CHECK (`gender` in ('Male','Female'))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;

/*Data for the table `users` */

insert  into `users`(`userid`,`username`,`firstname`,`middlename`,`lastname`,`dateadded`,`accountactive`,`password`,`salt`,`createdby`,`gender`,`mobile`,`email`) values (1,NULL,'Robert','Redford','Tyson','2022-02-10 18:54:07',1,'test123','23457654dshgdrftyrfq36',NULL,'Male','0727709772','akellorich@tukenya.ac.ke'),(4,NULL,'Mary','Jane','Watson','2022-02-10 18:59:26',1,'test123','23457654dshgdrftyrfq36',NULL,'Female','0727709773','maryjane@tukenya.ac.ke'),(10,'KE/2022/1','Peter','Parker','Watson','2022-02-10 19:25:03',1,'test123','23457654dshgdrftyrfq36',NULL,'Female','0727709774','peterparker@tukenya.ac.ke'),(11,'KE/2022/2','Green','Goblin','Watson','2022-02-10 19:25:38',1,'test123','23457654dshgdrftyrfq36',NULL,'Female','0727709775','goblin@tukenya.ac.ke');

/* Function  structure for function  `fn_generateusername` */

/*!50003 DROP FUNCTION IF EXISTS `fn_generateusername` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` FUNCTION `fn_generateusername`() RETURNS varchar(50) CHARSET utf8mb4
BEGIN
	declare $username varchar(50);
	set $username=(select concat(`prefix`,'/',`currentno`) from `serialnumbers` where `document`='users');
	
	return $username;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_checkcategory` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_checkcategory` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_checkcategory`($categoryid int,$categoryname varchar(50))
BEGIN
	select * from `categories` where `categoryname`=$categoryname and `catid`<>$categoryid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_getcategories` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_getcategories` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getcategories`()
BEGIN
	select * from `categories`
	where ifnull(`deleted`,0)=0
	order by `categoryname`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_savecategory` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_savecategory` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_savecategory`($catid int, $categoryname varchar(50), $createdby int)
BEGIN
	if $catid=0 then
		insert into `categories`(`categoryname`,`dateadded`,`createdby`)
		values($categoryname,now(),$createdby);
	else
		update `categories` set `categoryname`=$categoryname
		where `catid`=$catid;
	end if;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_saveuser` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_saveuser` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_saveuser`($userid int, $firstname varchar(50),$middlename varchar(50),$lastname varchar(50),
	$accountactive bool, $pass varchar(50),$salt varchar(50),$createdby int, $gender varchar(10), $mobile varchar(50),$email varchar(50))
BEGIN
	declare $username varchar(50);
	if $userid=0 then
		start transaction;
			set $username=`fn_generateusername`();
			update `serialnumbers` set `currentno`=`currentno`+1 where `document`='users';
			insert into `users`(`firstname`,`middlename`,`lastname`,`dateadded`,`accountactive`,`password`,`salt`,`createdby`,`gender`,`mobile`,`email`,`username`)
			values($firstname,$middlename,$lastname,now(),$accountactive,$pass,$salt,$createdby,$gender,$mobile,$email,$username);
		commit;
	else
		update `users` set `firstname`=$firstname, `middlename`=$middlename, `lastname`=$lastname,`accountactive`=$accountactive, 
		`gender`=$gender, `mobile`=$mobile, `email`=$email
		where `userid`=$userid;
	end if;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
