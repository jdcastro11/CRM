
CREATE TABLE IF NOT EXISTS `valor_parametros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parametro_id` bigint(20) NOT NULL,
  `id_valor_parametro` varchar(10) NOT NULL,
  `valor` varchar(300) DEFAULT NULL,
  `orden` varchar(5) DEFAULT NULL,
  `estado_valor_parametro` varchar(1) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_parametro` (`parametro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

ALTER TABLE `valor_parametros`
  ADD CONSTRAINT `parametro_valorParametro` FOREIGN KEY (`parametro_id`) REFERENCES `parametros` (`id`);
