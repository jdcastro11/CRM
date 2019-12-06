-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-03-2014 a las 21:44:19
-- Versión del servidor: 5.5.27
-- Versión de PHP: 5.4.7

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `crmdev`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valor_parametros`
--

DROP TABLE IF EXISTS `valor_parametros`;
CREATE TABLE IF NOT EXISTS `valor_parametros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parametro_id` bigint(20) NOT NULL,
  `id_parametro` varchar(10) NOT NULL,
  `id_valor_parametro` varchar(10) NOT NULL,
  `valor` varchar(300) DEFAULT NULL,
  `orden` varchar(5) DEFAULT NULL,
  `estado_valor_parametro` varchar(1) NOT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_parametro` (`parametro_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=192 ;

--
-- Volcado de datos para la tabla `valor_parametros`
--

INSERT INTO `valor_parametros` (`id`, `parametro_id`, `id_parametro`, `id_valor_parametro`, `valor`, `orden`, `estado_valor_parametro`, `eliminado`) VALUES
(1, 1, 'eempresa', 'empactivo', 'Activo(a)', NULL, 'A', 0),
(2, 1, 'eempresa', 'empinactiv', 'Inactivo(a)', NULL, 'A', 0),
(3, 1, 'eempresa', 'empenproce', 'En Proceso', NULL, 'A', 0),
(4, 2, 'tempresa', 'empproveed', 'Proveedor', NULL, 'A', 0),
(5, 2, 'tempresa', 'empcliente', 'Cliente', NULL, 'A', 0),
(6, 3, 'epersona', 'peractivo', 'Activa', '1', 'A', 0),
(7, 3, 'epersona', 'perinactiv', 'Inactiva', '2', 'A', 0),
(8, 4, 'tpersona', 'percontact', 'Contacto', '1', 'A', 0),
(9, 4, 'tpersona', 'peremplead', 'Empleado Admin', '0', 'A', 0),
(10, 4, 'tpersona', 'perconsult', 'Consultor', NULL, 'A', 0),
(11, 4, 'tpersona', 'pervendedo', 'Vendedor', NULL, 'A', 0),
(12, 5, 'tterritori', 'terpais', 'Pais', '1', 'A', 0),
(13, 5, 'tterritori', 'terregion', 'Region', '2', 'A', 0),
(14, 5, 'tterritori', 'terciudad', 'Ciudad', '4', 'A', 0),
(15, 5, 'tterritori', 'terdpto', 'Dpto', '3', 'A', 0),
(16, 5, 'tterritori', 'termunicip', 'Municipio', '5', 'A', 0),
(17, 2, 'tempresa', 'empprospec', 'Prospecto', NULL, 'A', 0),
(18, 2, 'tempresa', 'empsucursa', 'Sucursal Redsis', NULL, 'A', 0),
(19, 2, 'tempresa', 'empbase', 'Base', NULL, 'A', 0),
(20, 6, 'eprospecto', 'proenproce', 'En proceso', NULL, 'A', 0),
(21, 6, 'eprospecto', 'proactivo', 'Activo', NULL, 'A', 0),
(22, 6, 'eprospecto', 'proinactiv', 'Inactivo', NULL, 'A', 0),
(23, 7, 'eposibilid', 'posactivo', 'Asignada', '03', 'A', 0),
(24, 7, 'eposibilid', 'posdescali', 'Descalificada', '04', 'A', 0),
(25, 7, 'eposibilid', 'posenproce', 'Sin Asignar', '01', 'A', 0),
(26, 8, 'gentitulos', 'vt01', 'Lista de Oportunidades Sin Calificar', NULL, 'A', 0),
(27, 8, 'gentitulos', 'vt02', 'Lista de Oportunidades  Sin Calificar Borradas', NULL, 'A', 0),
(28, 9, 'trazon', 'posnoparti', 'redsis No Participa', '1', 'A', 0),
(29, 9, 'trazon', 'posleadnov', 'Lead No valido', '2', 'A', 0),
(30, 9, 'trazon', 'posotraraz', 'Otra Razón', '3', 'A', 0),
(31, 7, 'eposibilid', 'posoportun', 'Calificada', '05', 'A', 0),
(32, 10, 'tposibilid', 'posoportsc', 'Oportunidad SC', NULL, 'A', 0),
(33, 1, 'tposibilid', 'posoportca', 'Oportunidad', NULL, 'A', 0),
(34, 11, 'genimport', 'vimpprospe', '[   sheet:''Hoja1'',starRow:2,   columnMap:[     ''A'':''razonSocial'',     ''B'':''direccion'',     ''C'':''email''     ''D'':''telefonos''     ]   ]', NULL, 'A', 0),
(35, 12, 'tpoactmerc', 'posacmer01', 'Actividad 1', NULL, 'A', 0),
(36, 12, 'tpoactmerc', 'posacmer02', 'Actividad 2', NULL, 'A', 0),
(37, 13, 'tipocondic', 'poscondi01', 'Es Posible', NULL, 'A', 0),
(38, 13, 'tipocondic', 'poscondi02', 'Comprometida', NULL, 'A', 0),
(39, 14, 'etapasvent', 'posventa10', '10%', NULL, 'A', 0),
(40, 14, 'etapasvent', 'posventa25', '25%', NULL, 'A', 0),
(41, 14, 'etapasvent', 'posventa50', '50%', NULL, 'A', 0),
(42, 14, 'etapasvent', 'posventa75', '75%', NULL, 'A', 0),
(43, 15, 'sectores', 'empsecto01', 'Gobierno', NULL, 'A', 0),
(44, 15, 'sectores', 'empsecto02', 'Salud', NULL, 'A', 0),
(45, 15, 'sectores', 'empsecto03', 'Comercial', NULL, 'A', 0),
(46, 16, 'lineas', 'prolinea01', 'Linea 1', NULL, 'A', 0),
(47, 16, 'lineas', 'prolinea02', 'Linea 2', NULL, 'A', 0),
(48, 17, 'sublineas', 'prosubli01', 'Sub Linea 1', NULL, 'A', 0),
(49, 17, 'sublineas', 'prosubli02', 'Sub linea 2', NULL, 'A', 0),
(50, 18, 'consecutiv', 'oportunida', '0', NULL, 'A', 0),
(51, 7, 'eposibilid', 'ganada', 'Ganada', '12', 'A', 0),
(52, 7, 'eposibilid', 'perdida', 'Perdida', '10', 'A', 0),
(53, 19, 'tpoperdida', 'poscompete', 'Por Competencia', NULL, 'A', 0),
(54, 19, 'tpoperdida', 'posnopart', 'Redsis no participa', NULL, 'A', 0),
(56, 19, 'tpoperdida', 'posduplica', 'Oportunidad duplicada', NULL, 'A', 0),
(57, 19, 'tpoperdida', 'posnooport', 'No hay Oportunidad', NULL, 'A', 0),
(58, 14, 'etapasvent', 'posvent100', '100%', NULL, 'A', 0),
(59, 8, 'gentitulos', 'oportunt01', 'Oportunidades Calificadas', NULL, 'A', 0),
(60, 1, 'gentitulos', 'oportunt02', 'Oportunidades Ganadas', NULL, 'A', 0),
(61, 8, 'gentitulos', 'oportunt03', 'Oportunidades Perdidas', NULL, 'A', 0),
(62, 8, 'gentitulos', 'oportunt04', 'Lista de Oportunidades Borradas', NULL, 'A', 0),
(63, 20, 'estadoprod', 'prodactivo', 'Activo', NULL, 'A', 0),
(64, 20, 'estadoprod', 'prodinacti', 'Inactivo', NULL, 'A', 0),
(65, 20, 'estadogene', 'genactivo', 'Activo(a)', NULL, 'A', 0),
(66, 20, 'estadogene', 'geninactiv', 'Inactivo(a)', NULL, 'A', 0),
(67, 22, 'prodmarca', 'prodmarc01', 'IBM', NULL, 'A', 0),
(68, 22, 'prodmarca', 'prodmarc02', 'HP', NULL, 'A', 0),
(69, 23, 'tipoprod', 'prodtipo01', 'Hardware', NULL, 'A', 0),
(70, 23, 'tipoprod', 'prodtipo02', 'Software', NULL, 'A', 0),
(71, 23, 'tipoprod', 'prodtipo03', 'Consultoria', NULL, 'A', 0),
(72, 23, 'tipoprod', 'prodtipo04', 'Soporte', NULL, 'A', 0),
(73, 8, 'gentitulos', 'lineat01', 'Lineas de Producto', NULL, 'A', 0),
(74, 8, 'gentitulos', 'lineat02', 'Líneas de Productos Borradas', NULL, 'A', 0),
(75, 1, 'gentitulos', 'sublinet01', 'Sub Líneas de Productos', NULL, 'A', 0),
(76, 8, 'gentitulos', 'sublinet02', 'Sub Líneas de Productos Borradas', NULL, 'A', 0),
(77, 8, 'gentitulos', 'empresat01', 'Nuevo Prospecto', NULL, 'A', 0),
(78, 8, 'gentitulos', 'empresat02', 'Edición Prospecto', NULL, 'A', 0),
(79, 8, 'gentitulos', 'empresat03', 'Vista Prospecto', NULL, 'A', 0),
(80, 8, 'gentitulos', 'empresat04', 'Lista de Prospectos Borrados', NULL, 'A', 0),
(81, 8, 'gentitulos', 'empresat05', 'Lista de Clientes', NULL, 'A', 0),
(82, 8, 'gentitulos', 'empresat06', 'Nuevo  Cliente', NULL, 'A', 0),
(83, 8, 'gentitulos', 'empresat00', 'Lista de Prospectos', NULL, 'A', 0),
(84, 8, 'gentitulos', 'empresat07', 'Edición Cliente', NULL, 'A', 0),
(85, 8, 'gentitulos', 'empresat08', 'Vista Cliente', NULL, 'A', 0),
(86, 8, 'gentitulos', 'empresat09', 'Lista de Clientes Borrados', NULL, 'A', 0),
(87, 8, 'gentitulos', 'sedest00', 'Lista de  Sedes', NULL, 'A', 0),
(88, 8, 'gentitulos', 'sedest01', 'Nueva Sede', NULL, 'A', 0),
(89, 8, 'gentitulos', 'sedest02', 'Edición de Sede', NULL, 'A', 0),
(90, 8, 'gentitulos', 'sedest03', 'Vista de Sede', NULL, 'A', 0),
(91, 8, 'gentitulos', 'sedest04', 'Sedes Borradas', NULL, 'A', 0),
(92, 24, 'formadpago', 'pedfpago01', 'De Contado', NULL, 'A', 0),
(93, 24, 'formadpago', 'pedfpago02', '30 dias', NULL, 'A', 0),
(94, 24, 'formadpago', 'pedfpago03', '60 dias', NULL, 'A', 0),
(95, 25, 'tipoprecio', 'pedtprec01', 'En Pesos', NULL, 'A', 0),
(96, 25, 'tipoprecio', 'pedtprec02', 'En Dólares', NULL, 'A', 0),
(97, 26, 'tipomoneda', 'pedtmone01', 'Pesos', NULL, 'A', 0),
(98, 26, 'tipomoneda', 'pedtmone02', 'Dólares', NULL, 'A', 0),
(99, 27, 'arquitecto', 'pedarqui01', 'Jose Hugo Torres', NULL, 'A', 0),
(100, 27, 'arquitecto', 'pedarqui02', 'Hernan Pajaro', NULL, 'A', 0),
(101, 27, 'arquitecto', 'pedarqui03', 'Alexander Rosales', NULL, 'A', 0),
(102, 28, 'estapedido', 'pedestad01', 'En Borrador', NULL, 'A', 0),
(103, 28, 'estapedido', 'pedestad02', 'En Elaboración', NULL, 'A', 0),
(104, 28, 'estapedido', 'pedestad03', 'En Revisión', NULL, 'A', 0),
(105, 28, 'estapedido', 'pedestad04', 'Pendiente x Facturar', NULL, 'A', 0),
(106, 28, 'estapedido', 'pedestad05', 'Facturado Parcialmete', NULL, 'A', 0),
(107, 28, 'estapedido', 'pedestad06', 'Facturado', NULL, 'A', 0),
(108, 28, 'estapedido', 'pedestad07', 'Anulado', NULL, 'A', 0),
(109, 29, 'disponiibm', 'peddispo01', 'En Stock', NULL, 'A', 0),
(110, 29, 'disponiibm', 'peddispo02', 'En Planta', NULL, 'A', 0),
(111, 29, 'disponiibm', 'peddispo03', 'Pre Cargado', NULL, 'A', 0),
(112, 30, 'procespara', 'pedprosp01', 'Mayorista', NULL, 'A', 0),
(113, 30, 'procespara', 'pedprosp02', 'Cableado', NULL, 'A', 0),
(114, 31, 'estadetped', 'peddetpd01', 'En Proceso', NULL, 'A', 0),
(115, 31, 'estadetped', 'peddetpd02', 'Procesado', NULL, 'A', 0),
(116, 32, 'tipoanexos', 'anexo01', 'Tabla de Costos', '1', 'A', 0),
(117, 32, 'tipoanexos', 'anexo02', 'Orde de Compra Cliente', '3', 'A', 0),
(118, 32, 'tipoanexos', 'anexo03', 'Propuesta aprobada x Cliente', '5', 'A', 0),
(119, 32, 'tipoanexos', 'anexo04', 'Cotizaciones de producto', '9', 'A', 0),
(120, 32, 'tipoanexos', 'anexo05', 'Aprobación Nexsys', '11', 'A', 0),
(121, 32, 'tipoanexos', 'anexo06', 'Archivos .cfr y .txt', '13', 'A', 0),
(122, 32, 'tipoanexos', 'anexo07', 'Aprobacion BID', '15', 'A', 0),
(123, 32, 'tipoanexos', 'anexo08', 'Propuesta Servicios IBM', '17', 'A', 0),
(124, 32, 'tipoanexos', 'anexo09', 'Inf. Cliente Nuevo', NULL, 'A', 0),
(125, 32, 'tipoanexos', 'anexo10', 'Otros', NULL, 'A', 0),
(126, 33, 'rutasanexo', 'ruta00', '/crm/Archivos/', NULL, 'A', 0),
(127, 18, 'rutasanexo', 'ruta01', '/Archivos/', NULL, 'A', 0),
(128, 15, 'sectores', 'empsecto04', 'Servicio', NULL, 'A', 0),
(129, 15, 'sectores', 'empsecto05', 'Industrial', NULL, 'A', 0),
(130, 15, 'sectores', 'empsecto06', 'Educativo', NULL, 'A', 0),
(131, 15, 'sectores', 'empsecto07', 'Financiero', NULL, 'A', 0),
(132, 15, 'sectores', 'empsecto08', 'Turismo', NULL, 'A', 0),
(133, 13, 'tipocondic', 'poscondi03', 'Solo Payline', NULL, 'A', 0),
(134, 7, 'eposibilid', 'poscotizad', 'Cotizada', '07', 'A', 0),
(135, 7, 'eposibilid', 'posaprover', 'Aprobación Verbal', '09', 'A', 0),
(136, 7, 'eposibilid', 'posordenco', 'Orden de Compra', '11', 'A', 0),
(137, 8, 'gentitulos', 'anexot01', 'Nuevo Anexo', NULL, 'A', 0),
(138, 34, 'filtros', 'oportunid1', '[filtro:[idTipoPsibilidad:'''',eliminado:0,],exepto:[filter.op.idTipoPosibilidad,filter.op.idTipoPosibilidad,filter.idTipoPosibilidad]]', NULL, 'A', 0),
(139, 8, 'gentitulos', 'empresat10', 'Nueva Empresa', NULL, 'A', 0),
(140, 8, 'gentitulos', 'contactt00', 'Lista de Contactos', NULL, 'A', 0),
(141, 8, 'gentitulos', 'contactt01', 'Lista de Contactos Borrados', NULL, 'A', 0),
(142, 8, 'gentitulos', 'prodoprt01', 'Lista de  Productos de la Oportunidad Borrados', NULL, 'A', 0),
(143, 8, 'gentitulos', 'prodoprt00', 'Lista de Productos de la Oportunidad', NULL, 'A', 0),
(144, 8, 'gentitulos', 'anexot00', 'Lista de Anexos', NULL, 'A', 0),
(145, 8, 'gentitulos', 'anexot05', 'Lista de Anexos Borrados', NULL, 'A', 0),
(146, 8, 'gentitulos', 'actividt00', 'Lista de Actividades', NULL, 'A', 0),
(147, 8, 'gentitulos', 'actividt05', 'Lista de Actividades Borradas', NULL, 'A', 0),
(148, 8, 'tipoactivi', 'activida01', 'LLamada', NULL, 'A', 0),
(149, 8, 'tipoactivi', 'activida02', 'Reunion', NULL, 'A', 0),
(150, 8, 'tipoactivi', 'activida03', 'Correo', NULL, 'A', 0),
(151, 8, 'tipoactivi', 'activida04', 'Visita', NULL, 'A', 0),
(152, 8, 'tipoactivi', 'activida05', 'Invitación a Evento', NULL, 'A', 0),
(153, 8, 'prioracti', 'actiprio01', 'Crítica', NULL, 'A', 0),
(154, 8, 'prioracti', 'actiprio02', 'Alta', NULL, 'A', 0),
(155, 8, 'prioracti', 'actiprio03', 'Media', NULL, 'A', 0),
(156, 8, 'prioracti', 'actiprio05', 'Baja', NULL, 'A', 0),
(157, 8, 'actiestado', 'actiesta01', 'Pendiente', NULL, 'A', 0),
(158, 8, 'actiestado', 'actiesta02', 'Realizada', NULL, 'A', 0),
(159, 8, 'actiestado', 'actiesta03', 'Anulada', NULL, 'A', 0),
(160, 8, 'actiestado', 'actiesta04', 'Suspendida', NULL, 'A', 0),
(161, 8, 'gentitulos', 'propuest01', 'Lista de Propuestas', NULL, 'A', 0),
(162, 18, 'gentitulos', 'propuest05', 'Lista de Propuestas Borradas', NULL, 'A', 0),
(163, 8, 'gentitulos', 'facturat01', 'Lista de Facturas', NULL, 'A', 0),
(164, 38, 'actiavance', 'avance00', '00%', '02', 'A', 0),
(165, 1, 'actiavance', 'avance10', '10%', '04', 'A', 0),
(166, 1, 'actiavance', 'avance20', '20%', '06', 'A', 0),
(167, 1, 'actiavance', 'avance30', '30%', '08', 'A', 0),
(168, 38, 'actiavance', 'avance40', '40%', '10', 'A', 0),
(169, 38, 'actiavance', 'avance50', '50%', '12', 'A', 0),
(170, 38, 'actiavance', 'avance60', '60%', '14', 'A', 0),
(171, 38, 'actiavance', 'avance70', '70%', '16', 'A', 0),
(172, 38, 'actiavance', 'avance80', '80%', '18', 'A', 0),
(173, 38, 'actiavance', 'avance90', '90%', '20', 'A', 0),
(174, 38, 'actiavance', 'avance100', '100%', '22', 'A', 0),
(175, 8, 'gentitulos', 'propuest01', 'Lista de Propuestas', NULL, 'A', 0),
(176, 8, 'gentitulos', 'propuest05', 'Lista de Propuestas Borradas', NULL, 'A', 0),
(177, 39, 'mayoristas', 'myrIBM', 'IBM', NULL, 'A', 0),
(178, 39, 'mayoristas', 'myrNex', 'Nex', NULL, 'A', 0),
(179, 40, 'estregop', 'regenproc', 'En Proceso', NULL, 'A', 0),
(180, 40, 'estregop', 'regverif', 'En Verificación', NULL, 'A', 0),
(181, 40, 'estregop', 'regregistr', 'Registrado', NULL, 'A', 0),
(182, 41, 'estadofact', 'pedestacti', 'Activa', NULL, 'A', 0),
(183, 41, 'estadofact', 'pedestaina', 'inactiva', NULL, 'A', 0),
(184, 41, 'estadofact', 'pedestaanu', 'Anulada', NULL, 'A', 0),
(185, 8, 'gentitulos', 'facturat05', 'Lista de Facturas Borradas', NULL, 'A', 0),
(186, 8, 'gentitulos', 'regoport01', 'Lista de  Registros de Oportunidad', NULL, 'A', 0),
(187, 8, 'gentitulos', 'regoport05', 'Lista de Registros  de Oportunidad Borrados', NULL, 'A', 0),
(188, 8, 'gentitulos', 'detPedit01', 'Lista de Productos', NULL, 'A', 0),
(189, 8, 'gentitulos', 'detPedit05', 'Lista de Productos Borrados', NULL, 'A', 0),
(190, 8, 'gentitulos', 'pedidost01', 'Lista de pedidos', NULL, 'A', 0),
(191, 8, 'gentitulos', 'pedidost05', 'Lista de Pedidos Borrados', NULL, 'A', 0);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `valor_parametros`
--
ALTER TABLE `valor_parametros`
  ADD CONSTRAINT `parametro_valorParametro` FOREIGN KEY (`parametro_id`) REFERENCES `parametros` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
