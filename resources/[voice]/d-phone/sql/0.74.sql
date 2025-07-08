ALTER TABLE `jobs` ADD COLUMN `motdchange` VARCHAR(155)  NOT NULL;
ALTER TABLE `jobs` ADD COLUMN `motd` VARCHAR(155)  NOT NULL;
ALTER TABLE `jobs` ADD COLUMN `member` VARCHAR(11)  NOT NULL;

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