ALTER TABLE `users` ADD `savedweapons` LONGTEXT NOT NULL;
ALTER TABLE `users` ADD `licenses` LONGTEXT NOT NULL;

INSERT INTO `licenses` VALUES ('explosiveslicense', 'Explosives Permit');
INSERT INTO `licenses` VALUES ('heavylicense', 'MG Permit');
INSERT INTO `licenses` VALUES ('pistolslicense', 'Handgun Permit');
INSERT INTO `licenses` VALUES ('rifleslicense', 'Rifle Permit');