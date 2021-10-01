USE `es_extended`;

ALTER TABLE `users`
  ADD COLUMN `last_garage` VARCHAR(255) NULL
;

CREATE TABLE `users_garages` (
  
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `identifier` varchar(60) DEFAULT NULL,
  `garage` varchar(60) DEFAULT NULL,
  `vehicle` longtext,
  `position` longtext,
  `model` varchar(20) DEFAULT NULL,
  `display` varchar(20) DEFAULT NULL,

  PRIMARY KEY (`id`)
);