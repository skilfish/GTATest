-- Fügt last_position zur characters-Tabelle hinzu, falls nicht vorhanden
ALTER TABLE `characters`
ADD COLUMN `last_position` TEXT DEFAULT NULL;
