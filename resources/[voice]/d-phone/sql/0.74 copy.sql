ALTER TABLE `phone_messages` ADD COLUMN `date2` VARCHAR(11)  NOT NULL DEFAULT '28.04.2022';
ALTER TABLE `phone_messages` ADD COLUMN `isService` tinyint(1)  NOT NULL DEFAULT 0;
ALTER TABLE `phone_messages` ADD COLUMN `senderrpname` VARCHAR(11) NULL;
ALTER TABLE `phone_messages` ADD COLUMN `image` VARCHAR(500) NULL;