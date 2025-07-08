CREATE TABLE IF NOT EXISTS `bit_driverschool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userIdentifier` varchar(50) NOT NULL,
  `licenseType` varchar(10) NOT NULL,
  `theorical` int(11) NOT NULL DEFAULT 0,
  `practice` int(11) NOT NULL DEFAULT 0,
  KEY `id` (`id`)
);
