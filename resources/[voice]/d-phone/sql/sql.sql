CREATE TABLE IF NOT EXISTS `phone_banking` (
  `identifier` varchar(155) NOT NULL,
  `cardnumber` varchar(155) NOT NULL,
  `expiredate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_banking_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cardnumber` varchar(50) NOT NULL,
  `cardname` varchar(50) DEFAULT NULL,
  `targetnumber` varchar(50) NOT NULL,
  `targetname` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `amount` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_business` (
  `job` varchar(50) NOT NULL,
  `motd` varchar(155) NOT NULL,
  `motdchanged` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` varchar(10) NOT NULL,
  `num` varchar(10) NOT NULL,
  `time` varchar(50) NOT NULL,
  `accepts` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(80) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL,
  `favourite` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `wallpaper` varchar(155) NOT NULL DEFAULT 'https://cdn.discordapp.com/attachments/717040110641741894/802176415269257236/bright.png',
  `darkmode` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(50) NOT NULL,
  `receiver` varchar(50) NOT NULL,
  `message` varchar(500) NOT NULL DEFAULT '0',
  `date` varchar(50) NOT NULL DEFAULT 'current_timestamp()',
  `isgps` varchar(500) NOT NULL DEFAULT '0',
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  `isService` varchar(50) NOT NULL DEFAULT '0',
  `isAnonym` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=273 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL DEFAULT '0',
  `userid` varchar(50) NOT NULL DEFAULT '0',
  `avatar` varchar(1555) NOT NULL DEFAULT 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_twitter_likes` (
  `identifier` varchar(60) DEFAULT NULL,
  `liked` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_twitter_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '0',
  `userid` varchar(50) NOT NULL DEFAULT '0',
  `avatar` varchar(1555) NOT NULL DEFAULT '0',
  `date` varchar(50) NOT NULL DEFAULT '0',
  `message` varchar(500) NOT NULL DEFAULT '0',
  `imageurl` varchar(266) NOT NULL DEFAULT '0',
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;






ALTER TABLE `phone_messages` ADD COLUMN `isDeleted` INT(10)  NOT NULL DEFAULT '0';

CREATE TABLE IF NOT EXISTS `phone_advertisement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `number` varchar(50) NOT NULL DEFAULT '0',
  `message` varchar(500) NOT NULL DEFAULT '0',
  `date` varchar(500) NOT NULL DEFAULT '0',
  `time` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4;

-- 0.72
ALTER TABLE `phone_information` ADD COLUMN `flightmode` INT(10)  NOT NULL DEFAULT '0';

-- 0.73
ALTER TABLE `phone_information` ADD COLUMN `model` VARCHAR(155)  NOT NULL;
ALTER TABLE `phone_information` ADD COLUMN `case` VARCHAR(155)  NOT NULL;
ALTER TABLE `phone_information` ADD COLUMN `ringtone` VARCHAR(155)  NOT NULL;

-- 0.74


ALTER TABLE `phone_messages` ADD COLUMN `time` VARCHAR(11)  NOT NULL DEFAULT '12:00';
ALTER TABLE `phone_messages` ADD COLUMN `date2` VARCHAR(11)  NOT NULL DEFAULT '28.04.2022';
ALTER TABLE `phone_messages` ADD COLUMN `isService` tinyint(1)  NOT NULL DEFAULT 0;
ALTER TABLE `phone_messages` ADD COLUMN `senderrpname` VARCHAR(11) NULL;
ALTER TABLE `phone_messages` ADD COLUMN `image` VARCHAR(500) NULL;

DROP TABLE IF EXISTS `phone_teamchat`;
CREATE TABLE `phone_teamchat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(50) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `message` varchar(500) NOT NULL DEFAULT '0',
  `date` varchar(50) NOT NULL DEFAULT 'current_timestamp()',
  `time` varchar(50) NOT NULL DEFAULT ' 12:00',
  `gps` varchar(500) DEFAULT '0',
  `image` varchar(500) DEFAULT NULL,
  `senderrpname` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;




/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
ALTER TABLE `phone_information` ADD COLUMN `battery` int(3)  NOT NULL DEFAULT 100;


DROP TABLE IF EXISTS `phone_groupchat`;
CREATE TABLE `phone_groupchat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(255) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `member` longtext,
  `creator` varchar(155) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `phone_groupchat_messages`;
CREATE TABLE `phone_groupchat_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(50) NOT NULL,
  `sender` varchar(50) NOT NULL,
  `message` varchar(500) NOT NULL DEFAULT '0',
  `date` varchar(50) NOT NULL DEFAULT 'current_timestamp()',
  `time` varchar(50) NOT NULL DEFAULT ' 12:00',
  `gps` varchar(500) DEFAULT '0',
  `image` varchar(500) DEFAULT NULL,
  `info` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=142 DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `d-jump`;
CREATE TABLE `d-jump` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(155) DEFAULT NULL,
  `score` int(15) DEFAULT NULL,
  `username` varchar(155) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- 0.75
ALTER TABLE `jobs` ADD COLUMN `handyservice` VARCHAR(2) NOT NULL DEFAULT '0';
ALTER TABLE `jobs` ADD COLUMN `hasapp` int(2) NOT NULL DEFAULT '0';
ALTER TABLE `jobs` ADD COLUMN `onlyboss` int(2) NOT NULL DEFAULT '0';
ALTER TABLE `jobs` ADD COLUMN `number` VARCHAR(10)  NOT NULL DEFAULT '1';
ALTER TABLE `jobs` ADD COLUMN `motdchange` VARCHAR(155)  NOT NULL;
ALTER TABLE `jobs` ADD COLUMN `motd` VARCHAR(155)  NOT NULL;
ALTER TABLE `jobs` ADD COLUMN `member` VARCHAR(11)  NOT NULL;

INSERT INTO `items` (`name`, `label`, `limit`, `rare`, `can_remove`) VALUES
	('battery', 'Battery', -1, 0, 1),
	('powerbank', 'Powerbank', -1, 0, 1),
	('radio', 'Radio', -1, 0, 1)
;

ALTER TABLE `users` ADD COLUMN `phone_number` VARCHAR(10) NULL;
