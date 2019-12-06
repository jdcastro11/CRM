-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-03-2014 a las 21:18:25
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
-- Estructura de tabla para la tabla `actividades`
--

CREATE TABLE IF NOT EXISTS `actividades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_actividad` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `fecha_final` varchar(20) DEFAULT NULL,
  `fecha_inicio` varchar(20) DEFAULT NULL,
  `id_asignador` bigint(20) NOT NULL,
  `id_avance` varchar(10) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_entidad` bigint(20) NOT NULL,
  `id_estado_actividad` varchar(10) DEFAULT NULL,
  `id_padre` bigint(20) DEFAULT NULL,
  `id_prioridad` varchar(10) DEFAULT NULL,
  `id_responsable` bigint(20) NOT NULL,
  `id_tipo_actividad` varchar(10) DEFAULT NULL,
  `nombre_entidad` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `actividades`
--

INSERT INTO `actividades` (`id`, `desc_actividad`, `eliminado`, `fecha_final`, `fecha_inicio`, `id_asignador`, `id_avance`, `id_contacto`, `id_entidad`, `id_estado_actividad`, `id_padre`, `id_prioridad`, `id_responsable`, `id_tipo_actividad`, `nombre_entidad`) VALUES
(1, 'especificacion requisitos', 0, '11-03-2014 11:00 am', '10-03-2014 09:45 am', 43, 'avance00', 48, 3, 'actiesta01', NULL, 'actiprio03', 45, 'activida02', 'oportunidad'),
(2, 'Explicacion de Alternativa de xxx', 1, '19-03-2014 12:00 pm', '19-03-2014 08:00 am', 43, 'avance00', 48, 3, 'actiesta01', NULL, 'actiprio03', 45, 'activida03', 'oportunidad');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anexos`
--

CREATE TABLE IF NOT EXISTS `anexos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comentarios` varchar(200) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `fecha_creacion` varchar(10) DEFAULT NULL,
  `id_entidad` bigint(20) NOT NULL,
  `id_estado_anexo` varchar(10) DEFAULT NULL,
  `id_tipo_anexo` varchar(10) NOT NULL,
  `nombre_archivo` varchar(200) DEFAULT NULL,
  `nombre_entidad` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=27 ;

--
-- Volcado de datos para la tabla `anexos`
--

INSERT INTO `anexos` (`id`, `comentarios`, `eliminado`, `fecha_creacion`, `id_entidad`, `id_estado_anexo`, `id_tipo_anexo`, `nombre_archivo`, `nombre_entidad`) VALUES
(1, NULL, 1, '28/01/2014', 1, 'genactivo', 'anexo01', 'PresentacionTechnet2013.pdf', 'pedido'),
(2, 'okok', 0, '18/02/2014', 1, 'genactivo', 'anexo01', 'logrosPrueba.xlsx', 'pedido'),
(3, NULL, 0, '17/02/2014', 1, 'genactivo', 'anexo01', 'BscEjemplo.pdf', 'pedido'),
(4, NULL, 0, '18/02/2014', 1, 'genactivo', 'anexo01', 'modcontrato01.rtf', 'pedido'),
(5, 'ok', 0, '11-03-2014', 5, 'genactivo', 'anexo03', 'CRM_DB_SPRINT1.pdf', 'propuesta'),
(15, NULL, 0, NULL, 2, 'genactivo', 'anexo01', NULL, 'pedido'),
(16, NULL, 0, NULL, 2, 'genactivo', 'anexo02', NULL, 'pedido'),
(17, NULL, 0, NULL, 2, 'genactivo', 'anexo03', NULL, 'pedido'),
(18, NULL, 0, NULL, 2, 'genactivo', 'anexo04', NULL, 'pedido'),
(19, NULL, 0, NULL, 2, 'genactivo', 'anexo05', NULL, 'pedido'),
(20, NULL, 0, NULL, 2, 'genactivo', 'anexo06', NULL, 'pedido'),
(21, NULL, 0, NULL, 2, 'genactivo', 'anexo07', NULL, 'pedido'),
(22, NULL, 0, NULL, 2, 'genactivo', 'anexo08', NULL, 'pedido'),
(23, NULL, 0, NULL, 2, 'genactivo', 'anexo09', NULL, 'pedido'),
(24, NULL, 1, '26-03-2014', 1, 'genactivo', 'anexo05', 'CertificacionPesantes.pdf', 'propuesta'),
(25, NULL, 0, '26-03-2014', 1, 'genactivo', 'anexo10', 'CertificadoTrabajoHAriza.pdf', 'propuesta'),
(26, 'ok', 0, '26-03-2014', 1, 'genactivo', 'anexo09', 'CartaLaboralMartha.doc', 'propuesta');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contactos`
--

CREATE TABLE IF NOT EXISTS `contactos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `id_estado_contacto` varchar(10) DEFAULT NULL,
  `persona_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE77EAA048C00AE0A` (`persona_id`),
  KEY `FKE77EAA04612F24EA` (`empresa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `contactos`
--

INSERT INTO `contactos` (`id`, `eliminado`, `empresa_id`, `id_estado_contacto`, `persona_id`) VALUES
(1, 0, 12, 'genactivo', 51),
(3, 0, 12, 'genactivo', 49),
(4, 0, 11, 'genactivo', 50),
(5, 0, 11, 'genactivo', 47),
(6, 0, 23, 'genactivo', 52),
(7, 0, 21, 'genactivo', 48),
(8, 0, 23, 'genactivo', 49),
(9, 0, 14, 'genactivo', 48),
(10, 0, 11, 'genactivo', 56),
(11, 1, 11, 'genactivo', 44),
(12, 1, 11, 'genactivo', 46),
(13, 0, 11, 'genactivo', 49),
(14, 0, 11, 'genactivo', 44),
(15, 0, 8, 'genactivo', 49),
(16, 0, 8, 'genactivo', 56),
(17, 0, 8, 'genactivo', 17),
(18, 0, 10, 'genactivo', 53),
(19, 0, 10, 'genactivo', 46),
(20, 0, 20, 'genactivo', 17),
(21, 0, 20, 'genactivo', 47);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `det_pedidos`
--

CREATE TABLE IF NOT EXISTS `det_pedidos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` varchar(10) NOT NULL,
  `desc_producto` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_det_pedido` varchar(10) DEFAULT NULL,
  `id_procesar_para` varchar(10) NOT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `ref_producto` varchar(50) NOT NULL,
  `valor` varchar(20) NOT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1CA739A25E4583EA` (`producto_id`),
  KEY `FK1CA739A25F949CA` (`pedido_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `det_pedidos`
--

INSERT INTO `det_pedidos` (`id`, `cantidad`, `desc_producto`, `eliminado`, `id_estado_det_pedido`, `id_procesar_para`, `observaciones`, `ref_producto`, `valor`, `pedido_id`, `producto_id`) VALUES
(1, '200', 'Cable blindado', 0, 'peddetpd01', 'pedprosp02', 'ok', '1234E5', '1300', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `elementos_por_oportunidad`
--

CREATE TABLE IF NOT EXISTS `elementos_por_oportunidad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` varchar(10) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_elemento_por_oportunidad` varchar(10) DEFAULT NULL,
  `id_linea` bigint(20) NOT NULL,
  `id_posibilidad` bigint(20) NOT NULL,
  `id_sublinea` bigint(20) NOT NULL,
  `valor` varchar(20) DEFAULT NULL,
  `id_marca` varchar(10) DEFAULT NULL,
  `id_tipo_producto` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `elementos_por_oportunidad`
--

INSERT INTO `elementos_por_oportunidad` (`id`, `cantidad`, `eliminado`, `id_estado_elemento_por_oportunidad`, `id_linea`, `id_posibilidad`, `id_sublinea`, `valor`, `id_marca`, `id_tipo_producto`) VALUES
(1, '3', 0, 'genactivo', 2, 17, 3, '1,000,000', 'prodmarc01', 'prodtipo04'),
(2, '20', 0, 'genactivo', 1, 17, 1, '12,600', 'prodmarc02', 'prodtipo02'),
(3, '10', 0, 'genactivo', 2, 17, 3, '80', 'prodmarc01', 'prodtipo03'),
(4, '1', 0, 'genactivo', 1, 13, 1, '5,000', 'prodmarc01', 'prodtipo02'),
(5, '1', 0, 'genactivo', 1, 3, 1, '15,000', 'prodmarc01', 'prodtipo01'),
(6, '2', 1, 'genactivo', 1, 1, 1, '1,000', 'prodmarc01', 'prodtipo01'),
(7, '1', 0, 'genactivo', 1, 1, 1, '3,500', 'prodmarc01', 'prodtipo02'),
(8, '20', 1, 'genactivo', 2, 1, 3, '8', 'prodmarc01', 'prodtipo03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE IF NOT EXISTS `empresas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `padre_id` bigint(20) DEFAULT NULL,
  `nit` varchar(15) DEFAULT NULL,
  `razon_social` varchar(100) NOT NULL,
  `id_sucursal` bigint(20) DEFAULT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `id_sector` varchar(10) DEFAULT NULL,
  `id_dpto` bigint(20) DEFAULT NULL,
  `id_pais` bigint(20) DEFAULT NULL,
  `id_region` bigint(20) DEFAULT NULL,
  `id_ciudad` bigint(20) DEFAULT NULL,
  `id_tipo_empresa` varchar(20) DEFAULT NULL,
  `id_tipo_sede` varchar(10) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fax` varchar(15) DEFAULT NULL,
  `telefonos` varchar(20) DEFAULT NULL,
  `observaciones` varchar(300) DEFAULT NULL,
  `id_estado_empresa` varchar(10) DEFAULT NULL,
  `iniciales` varchar(3) DEFAULT NULL,
  `eliminado` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=24 ;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id`, `padre_id`, `nit`, `razon_social`, `id_sucursal`, `celular`, `direccion`, `id_sector`, `id_dpto`, `id_pais`, `id_region`, `id_ciudad`, `id_tipo_empresa`, `id_tipo_sede`, `email`, `fax`, `telefonos`, `observaciones`, `id_estado_empresa`, `iniciales`, `eliminado`) VALUES
(1, NULL, '802012130', 'Redsis S.A.S', 0, NULL, 'Calle 74 # 53-23. Piso 5', 'empservici', 3, 1, 2, 4, 'empbase', '', 'info@redsis.com', NULL, ' (571) 6351270', NULL, 'empactivo', 'BAQ', 0),
(5, 1, NULL, 'Redsis Bogota', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'empbase', NULL, NULL, NULL, NULL, NULL, 'empactivo', 'BOG', 0),
(6, 1, NULL, 'Redsis  Bucaramanga', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'empbase', NULL, NULL, NULL, NULL, NULL, 'empactivo', 'BUC', 0),
(7, 1, NULL, 'Redsis  USA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'empbase', NULL, NULL, NULL, NULL, NULL, 'empactivo', NULL, 0),
(8, NULL, '802015200', 'Acme S.A', 1, NULL, 'Cra 77B # 65-20', 'empsecto01', NULL, NULL, NULL, NULL, 'empprospec', NULL, 'info@acme.com', NULL, '3521146', NULL, 'empenproce', NULL, 0),
(9, NULL, '8020132015', 'Olimpica', 1, NULL, 'Calle 14', 'empsecto03', 10, NULL, NULL, 14, 'empcliente', NULL, 'sucursal14@olimpica.com', NULL, '2323', NULL, 'empactivo', NULL, 0),
(10, NULL, NULL, 'Caracol Radio', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'empprospec', NULL, 'gerencia@caracol.com.co', NULL, NULL, NULL, 'empenproce', NULL, 0),
(11, NULL, '845515347', 'Monomeros Colombo Venezolano', 1, NULL, 'via 40 80 20', 'empsecto01', NULL, NULL, NULL, NULL, 'empprospec', NULL, 'info@monomeros.com', NULL, '3801015', NULL, 'empactivo', NULL, 0),
(12, NULL, NULL, 'Technet Limitada', NULL, NULL, 'Cra 26C/ # 76A-75', NULL, NULL, NULL, NULL, NULL, 'empprospec', NULL, 'gerencia@technet.com.co', NULL, '3521146', NULL, 'empenproce', NULL, 0),
(13, NULL, NULL, 'Integra.net', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'empprospec', NULL, 'integra@gmail.com', NULL, '3521146', NULL, 'empenproce', NULL, 0),
(14, NULL, '802445776', 'Litoplas', NULL, NULL, 'Aveida circunvalar KM 10', 'empsecto05', NULL, NULL, NULL, 4, 'empprospec', NULL, 'info@litoplas.com.co', NULL, '2521146', NULL, 'empenproce', NULL, 0),
(15, 9, NULL, 'Olimpica', NULL, NULL, 'Cra 77B # 65-20', NULL, 10, NULL, NULL, 14, 'empcliente', NULL, 'gerencia77@olimpica.com', NULL, '3521148', NULL, 'empactivo', NULL, 0),
(18, 9, '8020132015', 'Olimpica', NULL, NULL, 'Calle 1ra # 15-45', NULL, 12, NULL, NULL, 20, 'empcliente', NULL, 'gerenciario@olimpica.com', NULL, '2251410', NULL, 'empactivo', NULL, 0),
(19, 9, '8020132015', 'Olimpica', NULL, NULL, 'La matuna # 20- 30', NULL, 10, NULL, NULL, 14, 'empcliente', NULL, 'gerencia@olimpica.com.co', NULL, '3362800', NULL, 'empactivo', NULL, 0),
(20, NULL, '805315840', 'Tebsa', NULL, NULL, 'Calle 17', 'empsecto01', 3, NULL, NULL, 4, 'empcliente', NULL, NULL, NULL, '3524277', NULL, 'empactivo', NULL, 0),
(21, NULL, NULL, 'Transportes Sancarlos', NULL, NULL, 'Calle 2 # 43 100', NULL, NULL, NULL, NULL, NULL, 'empprospec', NULL, 'gerencia@sancarlos.com.', NULL, '3524510', NULL, 'empactivo', NULL, 0),
(23, NULL, NULL, 'Fondo Regional de Garantias', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'empprospec', NULL, NULL, NULL, '3362800', NULL, 'empactivo', NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enc_vencimientos`
--

CREATE TABLE IF NOT EXISTS `enc_vencimientos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `empresa_id` bigint(20) NOT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_enc_vencimiento` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE8AD5F53612F24EA` (`empresa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `enc_vencimientos`
--

INSERT INTO `enc_vencimientos` (`id`, `eliminado`, `empresa_id`, `id_contacto`, `id_estado_enc_vencimiento`) VALUES
(1, 1, 14, 48, 'genactivo'),
(2, 0, 14, 48, 'genactivo'),
(3, 0, 14, 48, 'genactivo'),
(4, 1, 14, 48, 'geninactiv'),
(5, 0, 12, 51, 'genactivo'),
(6, 0, 8, 17, 'genactivo'),
(7, 0, 23, 52, 'genactivo'),
(8, 0, 10, 53, 'genactivo'),
(9, 0, 10, 53, 'genactivo'),
(10, 0, 23, 49, 'genactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE IF NOT EXISTS `facturas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `fecha_factura` varchar(10) NOT NULL,
  `id_estado_factura` varchar(10) NOT NULL,
  `num_factura` varchar(20) NOT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `valor_factura` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E7DA7FB5F949CA` (`pedido_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`id`, `eliminado`, `fecha_factura`, `id_estado_factura`, `num_factura`, `pedido_id`, `valor_factura`) VALUES
(1, 0, '13-02-2014', 'pedestacti', '123', 1, '2875000'),
(2, 1, '28-02-2014', 'pedestacti', '325', 1, '5250000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lineas`
--

CREATE TABLE IF NOT EXISTS `lineas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_linea` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_linea` varchar(10) NOT NULL,
  `observ_linea` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `lineas`
--

INSERT INTO `lineas` (`id`, `desc_linea`, `eliminado`, `id_estado_linea`, `observ_linea`) VALUES
(1, 'Linea 1', 0, 'genactivo', NULL),
(2, 'Linea 2', 0, 'genactivo', NULL),
(3, 'Linea 3', 1, 'genactivo', 'Desc Linea 3'),
(4, 'Linea 3', 0, 'genactivo', NULL),
(5, 'Linea 4', 0, 'genactivo', 'ok');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones`
--

CREATE TABLE IF NOT EXISTS `opciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_opcion` varchar(200) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_opcion` varchar(1) DEFAULT NULL,
  `id_padre` bigint(20) DEFAULT NULL,
  `id_tipo_opcion` varchar(10) DEFAULT NULL,
  `nombre_opcion` varchar(100) NOT NULL,
  `url` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `operaciones`
--

CREATE TABLE IF NOT EXISTS `operaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_operacion` varchar(1) DEFAULT NULL,
  `nombre_operacion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `parametros`
--

CREATE TABLE IF NOT EXISTS `parametros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_parametro` varchar(10) NOT NULL,
  `atributo` varchar(50) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `tipo_parametro` varchar(1) DEFAULT NULL,
  `estado_parametro` varchar(1) NOT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=46 ;

--
-- Volcado de datos para la tabla `parametros`
--

INSERT INTO `parametros` (`id`, `id_parametro`, `atributo`, `descripcion`, `tipo_parametro`, `estado_parametro`, `eliminado`) VALUES
(1, 'eempresa', 'id_estado_empresa', 'Estado de la Empresa', 'U', 'A', 0),
(2, 'tempresa', 'id_tipo_empresa', 'Tipo de Empresa', 'U', 'A', 0),
(3, 'epersona', 'id_estado_persona', 'Estado Persona', 'U', 'A', 0),
(4, 'tpersona', 'id_tipo_persona', 'Tipo Persona', 'U', 'A', 0),
(5, 'tterritori', 'id_tipo_territorio', 'Tipo Territorio', 'S', 'A', 0),
(6, 'eprospecto', 'id_estado_empresa', 'Estado Prospecto', 'U', 'A', 0),
(7, 'eposibilid', 'id_estado_posibilidad', 'Estado Posibilidad', 'U', 'A', 0),
(8, 'gentitulos', 'generico', 'Titulos de las ventanas de CRUD', 'U', 'A', 0),
(9, 'trazon', 'id_razon_cancelacion', 'Razones para Cancelar Oportunidad', 'U', 'A', 0),
(10, 'tposibilid', 'id_tipo_posibilidad', 'Tipo de Posibilidad', 'U', 'A', 0),
(11, 'genimport', 'general', 'Definiciones  tipo JSON para Importaciones', 'U', 'A', 0),
(12, 'tpoactmerc', 'idActividadMercadeo', 'Tipo de Actividades de Mercadeo', 'U', 'A', 0),
(13, 'tipocondic', 'idCondicion', 'Tipo de Condicion de la Oprtunidad', 'U', 'A', 0),
(14, 'etapasvent', 'idEtapa', 'Etapas de Venta', 'U', 'A', 0),
(15, 'sectores', 'id_sector', 'Sectores', 'U', 'A', 0),
(16, 'lineas', 'idLinea', 'Lineas de productos', 'U', 'A', 0),
(17, 'sublineas', 'id_sub_linea', 'Sub lineas de productos', 'U', 'A', 0),
(18, 'consecutiv', 'genconsec', 'Consecuivos', 'U', 'A', 0),
(19, 'tpoperdida', 'id_motivo_perdida', 'Motivo Perdida de Una Oportunidad', 'U', 'A', 0),
(20, 'estadoprod', 'id_estado_producto', 'Estado Productos', 'U', 'A', 0),
(21, 'estadogene', 'IdEstadoXX', 'Estado Generico para Entidades', 'U', 'A', 0),
(22, 'prodmarca', 'IdMarca', 'Marca', 'U', 'A', 0),
(23, 'tipoprod', 'IdTipoProducto', 'Tipo de productos', 'U', 'A', 0),
(24, 'formadpago', 'idformaPago', 'Formas de Pago', 'U', 'A', 0),
(25, 'tipoprecio', 'idTipoPrecio', 'Tipo de Precios', 'U', 'A', 0),
(26, 'tipomoneda', 'idMonedaFactura', 'Tipo de Moneda para Factura', 'U', 'A', 0),
(27, 'arquitecto', 'listaArquitectos', 'Lista de Arquitectos de Soluciones', 'U', 'A', 0),
(28, 'estapedido', 'IdEstadopedido', 'Estado de los pedidos', 'U', 'A', 0),
(29, 'disponiibm', 'idProductoDisponible', 'Disponibilidad producto IBM', 'U', 'A', 0),
(30, 'procespara', 'idProcesarPara', 'Procesar Para', 'U', 'A', 0),
(31, 'estadetped', 'idEstadoDetPedido', 'Estado del  Items en Detalle de Pedidos', 'U', 'A', 0),
(32, 'tipoanexos', 'idTipoAnexo', 'Tipos de Anexos', 'U', 'A', 0),
(33, 'rutasanexo', 'rutas', 'Rutas de Repositorios de documentos', 'U', 'A', 0),
(34, 'filtros', 'n/a', 'Filtros  especiales', 'U', 'A', 0),
(35, 'tipoactivi', 'idtipoActividad', 'Tipo de Actividad', 'U', 'A', 0),
(36, 'prioracti', 'idPrioridad', 'Prioridad Actividad', 'U', 'A', 0),
(37, 'actiestado', 'idEstadoActividad', 'Estado Actividad', 'U', 'A', 0),
(38, 'actiavance', 'idAvance', 'Avance de las Actividades', 'U', 'A', 0),
(39, 'mayoristas', 'id_registro_en', 'Mayoristas Registro Oportunidad', 'U', 'A', 0),
(40, 'estregop', 'idEstadoRegistroOportunidad', 'Estado Registro Oportunidad', 'U', 'A', 0),
(41, 'estadofact', 'idEstadoFactura', 'Estado Factura Pedidos', 'U', 'A', 0),
(42, 'anexbasped', 'n/a', 'Lista de Anexos Basicos Pedidos', 'U', 'A', 0),
(43, 'estadovenc', 'idEstadoVencimiento', 'Estado Vencimientos', 'U', 'A', 0),
(44, 'tipovencim', 'idTipoVencimiento', 'Tipo de Vencimiento', 'U', 'A', 0),
(45, 'tipocobert', 'idTipoCobertura', 'Tipo de Coberturas en Vencimientos', 'U', 'A', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE IF NOT EXISTS `pedidos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `arquitecto_sol` varchar(1) DEFAULT NULL,
  `campania_redsis` varchar(1) DEFAULT NULL,
  `cliente_nuevo` varchar(1) DEFAULT NULL,
  `compra_ibm` varchar(10) DEFAULT NULL,
  `desc_campania` varchar(200) DEFAULT NULL,
  `desc_polizas` varchar(300) DEFAULT NULL,
  `dir_despacho` varchar(200) DEFAULT NULL,
  `dir_entrega_factura` varchar(200) DEFAULT NULL,
  `eliminado` tinyint(4) DEFAULT NULL,
  `facturacion_parcial` varchar(1) DEFAULT NULL,
  `fecha_entrega` varchar(10) DEFAULT NULL,
  `fecha_apertura` varchar(10) DEFAULT NULL,
  `id_bid_nexsys` varchar(10) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_pedido` varchar(10) DEFAULT NULL,
  `id_forma_pago` varchar(10) DEFAULT NULL,
  `id_mondeda_factura` varchar(10) DEFAULT NULL,
  `id_producto_disponible` varchar(10) DEFAULT NULL,
  `id_tipo_precio` varchar(10) DEFAULT NULL,
  `id_vendedor` bigint(20) DEFAULT NULL,
  `lista_arquitectos` varchar(200) DEFAULT NULL,
  `num_cliente` varchar(20) DEFAULT NULL,
  `orden_compra` varchar(50) DEFAULT NULL,
  `requiere_polizas` varchar(1) DEFAULT NULL,
  `servicio_ibm` varchar(10) DEFAULT NULL,
  `num_pedido` varchar(50) DEFAULT NULL,
  `id_sucursal` bigint(20) NOT NULL,
  `posibilidad_id` bigint(20) DEFAULT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `id_usuario_autor` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD6C5D1CE612F24EA` (`empresa_id`),
  KEY `FKD6C5D1CE33685ACA` (`posibilidad_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `arquitecto_sol`, `campania_redsis`, `cliente_nuevo`, `compra_ibm`, `desc_campania`, `desc_polizas`, `dir_despacho`, `dir_entrega_factura`, `eliminado`, `facturacion_parcial`, `fecha_entrega`, `fecha_apertura`, `id_bid_nexsys`, `id_contacto`, `id_estado_pedido`, `id_forma_pago`, `id_mondeda_factura`, `id_producto_disponible`, `id_tipo_precio`, `id_vendedor`, `lista_arquitectos`, `num_cliente`, `orden_compra`, `requiere_polizas`, `servicio_ibm`, `num_pedido`, `id_sucursal`, `posibilidad_id`, `empresa_id`, `id_usuario_autor`) VALUES
(1, 'N', 'N', 'N', 'N', NULL, NULL, 'xx', 'yy', 0, 'N', '11/02/2014', '27-01-2014', 'N', 47, 'pedestad01', 'pedfpago01', 'pedtmone01', NULL, 'pedtprec01', 4, ',pedarqui01,pedarqui02', NULL, 'OC-1520', 'N', 'N', 'BAQ-0001-14', 1, 5, 20, NULL),
(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '15-02-2014', NULL, 50, 'pedestad01', NULL, NULL, NULL, NULL, 4, NULL, NULL, '1545', NULL, NULL, 'BAQ-0002-14', 1, NULL, 11, NULL),
(3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, '16-03-2014', NULL, 48, 'pedestad01', NULL, NULL, NULL, NULL, 4, NULL, NULL, '1545', NULL, NULL, 'BAQ-0003-14', 1, 3, 14, NULL),
(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '19-03-2014', '21-03-2014', NULL, 53, 'pedestad01', NULL, NULL, NULL, NULL, 45, NULL, NULL, '1354', NULL, NULL, 'BOG-0001-14', 5, NULL, 10, NULL),
(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '20-03-2014', '31-03-2014', NULL, 17, 'pedestad01', NULL, NULL, NULL, NULL, 45, NULL, NULL, '1568', NULL, NULL, 'BOG-0002-14', 5, NULL, 8, NULL),
(6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, '20-03-2014', '31-03-2014', NULL, 52, 'pedestad01', NULL, NULL, NULL, NULL, 45, NULL, NULL, '15645', NULL, NULL, 'BAQ-0004-14', 1, NULL, 23, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE IF NOT EXISTS `personas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `identificacion` varchar(15) DEFAULT NULL,
  `id_tipo_persona` varchar(10) DEFAULT NULL,
  `primer_nombre` varchar(30) DEFAULT NULL,
  `segundo_nombre` varchar(50) DEFAULT NULL,
  `primer_apellido` varchar(30) DEFAULT NULL,
  `segundo_apellido` varchar(30) DEFAULT NULL,
  `cargo` varchar(50) DEFAULT NULL,
  `celular_adicional` varchar(15) DEFAULT NULL,
  `celular_principal` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `id_nivel_decision` varchar(10) DEFAULT NULL,
  `observaciones` varchar(200) DEFAULT NULL,
  `rep_legal` char(1) DEFAULT NULL,
  `telefono_fijo` varchar(50) DEFAULT NULL,
  `id_estado_persona` varchar(10) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=57 ;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`id`, `identificacion`, `id_tipo_persona`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `cargo`, `celular_adicional`, `celular_principal`, `email`, `id_nivel_decision`, `observaciones`, `rep_legal`, `telefono_fijo`, `id_estado_persona`, `eliminado`) VALUES
(1, '72135240', 'percontact', 'Hernan', 'x', 'Pajaro', 'Torres', 'Gerente Operaciones', NULL, '3003563643', 'hpajaro@gmail.com', NULL, NULL, NULL, '3521146', 'vinactiva', 0),
(4, '72154789', 'pervendedo', 'Pedro', NULL, 'Paramo', NULL, NULL, NULL, NULL, NULL, NULL, 'ok', NULL, NULL, 'peractivo', 0),
(15, NULL, 'percontact', 'Gariel', NULL, 'Garcia', 'Marquez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(16, NULL, 'percontact', 'Pablo', 'Manuel', 'Marmol', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
(17, NULL, 'percontact', 'Pedro', NULL, 'Gutierrez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(43, '1162534', 'peremplead', 'Pablo', NULL, 'Neruda', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(44, NULL, 'percontact', 'Carlos', 'Alberto', 'Valderrama', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(45, '114256872', 'pervendedo', 'Carlos', NULL, 'Vaca', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'peractivo', 0),
(46, NULL, 'percontact', 'Pablo', NULL, 'Milanez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(47, NULL, 'percontact', 'Homero', NULL, 'Simpson', NULL, NULL, NULL, '3015269877', NULL, NULL, NULL, NULL, NULL, NULL, 0),
(48, NULL, 'percontact', 'Martha', NULL, 'Niño', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(49, NULL, 'percontact', 'Catalina', NULL, 'Pajaro', 'Aja', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(50, NULL, 'percontact', 'Jairo', NULL, 'Marino', NULL, NULL, NULL, '300456890', NULL, NULL, NULL, NULL, NULL, NULL, 0),
(51, NULL, 'percontact', 'Carlos', NULL, 'Paez', NULL, NULL, NULL, '300456899', 'cpaez@contraloria.gov.co', NULL, NULL, NULL, '3154850 Ext 215', 'genactivo', 0),
(52, NULL, 'percontact', 'Joisman', NULL, 'Jimenez', 'Perez', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(53, NULL, 'percontact', 'Humberto', NULL, 'Maury', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(54, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(55, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(56, NULL, 'percontact', 'Johana', NULL, 'Combita', 'Niño', NULL, NULL, '300542825', NULL, NULL, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `posibilidades`
--

CREATE TABLE IF NOT EXISTS `posibilidades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_tipo_posibilidad` varchar(10) DEFAULT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `id_sucursal` bigint(20) NOT NULL,
  `id_etapa` varchar(10) DEFAULT NULL,
  `nombre_posibilidad` varchar(50) DEFAULT NULL,
  `desc_posibilidad` varchar(300) DEFAULT NULL,
  `fecha_apertura` varchar(20) DEFAULT NULL,
  `fecha_cierre_estimada` varchar(20) DEFAULT NULL,
  `fecha_cierre_real` varchar(20) DEFAULT NULL,
  `id_estado_posibilidad` varchar(10) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `valor_posibilidad` decimal(19,2) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_vendedor` bigint(20) DEFAULT NULL,
  `id_razon_cancelacion` varchar(10) DEFAULT NULL,
  `otra_razon_cancelacion` varchar(200) DEFAULT NULL,
  `id_actividad_mercadeo` varchar(10) DEFAULT NULL,
  `id_condicion` varchar(10) DEFAULT NULL,
  `nombre_actividad_mercadeo` varchar(100) DEFAULT NULL,
  `num_oportunidad_fabricante` varchar(100) DEFAULT NULL,
  `valor_facturado` decimal(19,2) DEFAULT NULL,
  `num_oportunidad` varchar(50) DEFAULT NULL,
  `observ_cambio_vendedor` varchar(200) DEFAULT NULL,
  `observ_cierre` varchar(200) DEFAULT NULL,
  `id_motivo_perdida` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_posib_Empresa` (`empresa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `posibilidades`
--

INSERT INTO `posibilidades` (`id`, `id_tipo_posibilidad`, `empresa_id`, `id_sucursal`, `id_etapa`, `nombre_posibilidad`, `desc_posibilidad`, `fecha_apertura`, `fecha_cierre_estimada`, `fecha_cierre_real`, `id_estado_posibilidad`, `eliminado`, `valor_posibilidad`, `id_contacto`, `id_vendedor`, `id_razon_cancelacion`, `otra_razon_cancelacion`, `id_actividad_mercadeo`, `id_condicion`, `nombre_actividad_mercadeo`, `num_oportunidad_fabricante`, `valor_facturado`, `num_oportunidad`, `observ_cambio_vendedor`, `observ_cierre`, `id_motivo_perdida`) VALUES
(1, 'posoportca', 11, 1, 'posventa10', 'Servidor IBM', 'ok', '20/02/2014', '20/03/2014', NULL, 'posenproce', 0, 15000.00, 50, 4, NULL, NULL, NULL, 'poscondi01', NULL, NULL, NULL, 'BAQ-0002-14', NULL, NULL, NULL),
(2, 'posportunc', 11, 1, NULL, 'Cableado con fibra', 'ok', '20/02/2014', '20/03/2014', NULL, 'posoportun', 0, 8000.00, 47, 45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'posoportca', 14, 1, 'posventa10', 'Servidor AIX', 'Detalle del servidor xx', '16/02/2014', '28/03/2014', NULL, 'posenproce', 0, 15000.00, 48, 4, NULL, NULL, 'posacmer01', 'poscondi01', NULL, '91535;450220', NULL, 'BAQ-0001-14', NULL, NULL, NULL),
(4, 'posoportsc', 23, 1, NULL, 'Router para telefonia ip E1', 'ok', '25/02/2014', NULL, NULL, 'posactivo', 0, 3500.00, 52, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'posoportca', 20, 1, NULL, 'Plataforma Alfresco', NULL, '25/02/2014', '26/03/2014', NULL, 'posenproce', 0, 10000.00, 50, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BAQ-0004-14', NULL, NULL, NULL),
(6, 'posoportca', 11, 1, NULL, 'Cableado  Bodega X', NULL, NULL, NULL, NULL, 'posenproce', 0, 5000.00, 50, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'BAQ-0003-14', NULL, NULL, NULL),
(7, 'posoportsc', 11, 1, NULL, '15 Puintos de Ventas', 'okok', NULL, NULL, NULL, 'posenproce', 0, 30000.00, 47, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'posoportsc', 21, 5, NULL, 'Horas de Capacitación Softmachine', NULL, '13-03-2014', '30-03-2014', NULL, 'posenproce', 0, 7500.00, 48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'posoportsc', 8, 0, NULL, 'Implementacion Alfresco', 'Gestion Doc. Basica', '14-03-2014', '30-03-2014', NULL, 'posenproce', 0, 5000.00, 49, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'posoportsc', 11, 0, NULL, 'Instalacion Processmaker', 'ok', '15-03-2014', '29-03-2014', NULL, 'posenproce', 1, 4500.00, 46, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE IF NOT EXISTS `productos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_producto` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_linea` varchar(10) DEFAULT NULL,
  `id_sub_linea` varchar(10) DEFAULT NULL,
  `id_tipo_producto` varchar(10) DEFAULT NULL,
  `ref_producto` varchar(50) DEFAULT NULL,
  `id_estado_producto` varchar(10) DEFAULT NULL,
  `id_marca` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `desc_producto`, `eliminado`, `id_linea`, `id_sub_linea`, `id_tipo_producto`, `ref_producto`, `id_estado_producto`, `id_marca`) VALUES
(1, 'Cable UTP Nivel 7A', 0, '1', '1', NULL, '123459-R', 'prodactivo', NULL),
(2, 'Servicio de fibra', 0, NULL, NULL, NULL, 'SRV-0125', 'peddetpd01', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `propuestas`
--

CREATE TABLE IF NOT EXISTS `propuestas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_propuesta` varchar(10) DEFAULT NULL,
  `id_vendedor` bigint(20) DEFAULT NULL,
  `num_propuesta` varchar(50) DEFAULT NULL,
  `posibilidad_id` bigint(20) NOT NULL,
  `valor` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE3639A0633685ACA` (`posibilidad_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `propuestas`
--

INSERT INTO `propuestas` (`id`, `eliminado`, `fecha`, `id_contacto`, `id_estado_propuesta`, `id_vendedor`, `num_propuesta`, `posibilidad_id`, `valor`) VALUES
(1, 0, '25/02/2014', 44, 'genactivo', 45, 'BAQ-0002-14', 1, '50000'),
(3, 0, '22-03-2014', 48, 'genactivo', 4, 'BAQ-0001-14', 3, '11500'),
(5, 0, '27-03-2014', 48, 'genactivo', 4, 'BAQ-0002-14', 3, '8500');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prospectos`
--

CREATE TABLE IF NOT EXISTS `prospectos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `empresa_id` bigint(20) NOT NULL,
  `id_estado_prospecto` varchar(10) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `fecha_creacion` varchar(10) DEFAULT NULL,
  `id_sucursal` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7986CC70612F24EA` (`empresa_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `prospectos`
--

INSERT INTO `prospectos` (`id`, `empresa_id`, `id_estado_prospecto`, `eliminado`, `fecha_creacion`, `id_sucursal`) VALUES
(1, 11, 'proactivo', 0, NULL, 5),
(2, 8, 'proactivo', 0, NULL, 5),
(3, 21, 'proactivo', 0, NULL, 6),
(4, 23, 'proactivo', 0, NULL, 5),
(5, 20, 'proactivo', 0, NULL, 1),
(6, 10, 'proactivo', 1, NULL, 5),
(7, 21, 'proactivo', 0, NULL, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_oportunidades`
--

CREATE TABLE IF NOT EXISTS `registro_oportunidades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `id_asignadoa` bigint(20) DEFAULT NULL,
  `id_autor` bigint(20) NOT NULL,
  `id_estado_registro_oportunidad` varchar(10) DEFAULT NULL,
  `num_registro_oportunidad` varchar(50) DEFAULT NULL,
  `posibilidad_id` bigint(20) NOT NULL,
  `id_registro_en` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKBEE721E933685ACA` (`posibilidad_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `registro_oportunidades`
--

INSERT INTO `registro_oportunidades` (`id`, `eliminado`, `fecha`, `id_asignadoa`, `id_autor`, `id_estado_registro_oportunidad`, `num_registro_oportunidad`, `posibilidad_id`, `id_registro_en`) VALUES
(1, 0, '11-03-2014', 45, 43, 'regenproc', NULL, 3, 'myrIBM');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_rol` varchar(200) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_rol` varchar(1) DEFAULT NULL,
  `nombre_rol` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol_opcion_operacion`
--

CREATE TABLE IF NOT EXISTS `rol_opcion_operacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `estado_rol_opcion_operacion` varchar(1) DEFAULT NULL,
  `opcion_id` bigint(20) NOT NULL,
  `operacion_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD4E68CAF67EBF2A` (`rol_id`),
  KEY `FKD4E68CAF3B3E328A` (`operacion_id`),
  KEY `FKD4E68CAFB2FBD22A` (`opcion_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sublineas`
--

CREATE TABLE IF NOT EXISTS `sublineas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_sublinea` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_sublinea` varchar(10) NOT NULL,
  `linea_id` bigint(20) NOT NULL,
  `observ_sublinea` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK13109D66B8828E6A` (`linea_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Volcado de datos para la tabla `sublineas`
--

INSERT INTO `sublineas` (`id`, `desc_sublinea`, `eliminado`, `id_estado_sublinea`, `linea_id`, `observ_sublinea`) VALUES
(1, 'Prueba 44', 0, 'genactivo', 1, NULL),
(2, 'Servicio de Soporte', 0, 'genactivo', 1, NULL),
(3, 'Sublinea 1 Linea 2', 0, 'genactivo', 2, 'ok'),
(4, 'Sublinea 2 Linea 2', 0, 'genactivo', 2, NULL),
(5, 'Prueba', 0, 'genactivo', 3, NULL),
(6, 'Prueba 6', 0, 'genactivo', 4, NULL),
(7, 'Pruba 7', 0, 'genactivo', 4, NULL),
(8, 'Prueba 87', 0, 'genactivo', 4, NULL),
(9, 'Prueba 26 Linea 1', 0, 'genactivo', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `territorios`
--

CREATE TABLE IF NOT EXISTS `territorios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `padre_id` bigint(20) DEFAULT NULL,
  `codigo_territorio` varchar(255) NOT NULL,
  `id_tipo_territorio` varchar(10) NOT NULL,
  `nombre_territorio` varchar(100) NOT NULL,
  `estado_territorio` varchar(1) NOT NULL,
  `eliminado` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_Territorio` (`padre_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `territorios`
--

INSERT INTO `territorios` (`id`, `padre_id`, `codigo_territorio`, `id_tipo_territorio`, `nombre_territorio`, `estado_territorio`, `eliminado`) VALUES
(1, NULL, 'co', 'vpais', 'Colombia', 'A', 0),
(2, 1, 'nor', 'vregion', 'Norte', 'A', 0),
(3, 2, 'atl', 'vdpto', 'Atlantico', 'A', 0),
(4, 3, 'baq', 'vciudad', 'Barranquilla', 'A', 0),
(5, 3, 'sol', 'vciudad', 'Soledad', 'A', 0),
(6, 1, 'ori', 'vregion', 'oriente', 'A', 0),
(7, 1, 'cen', 'vregion', 'Centro', 'A', 0),
(8, 1, 'occ', 'vregion', 'Occidente', 'A', 0),
(9, 1, 'sur', 'vregion', 'Sur', '', 0),
(10, 2, 'bol', 'vdpto', 'Bolivar', 'A', 0),
(11, 2, 'mag', 'vdpto', 'Magdalena', 'A', 0),
(12, 2, 'gua', 'vdpto', 'Guajira', 'A', 0),
(13, 7, 'cun', 'vdpto', 'Cundinamarca', 'A', 0),
(14, 10, 'car', 'vciudad', 'Cartagena', 'A', 0),
(15, NULL, 'buc', 'vciudad', 'Bucaramanga', 'A', 0),
(16, NULL, 'bog', 'vciudad', 'Bogotá', 'A', 0),
(17, NULL, 'cal', 'vciudad', 'Cali', 'A', 0),
(18, NULL, 'med', 'vciudad', 'Medellin', 'A', 0),
(19, NULL, 'vall', 'vciudad', 'Valledupar', '', 0),
(20, NULL, 'rio', 'vciudad', 'Rioacha', 'A', 0),
(21, NULL, 'mon', 'vciudad', 'Monteria', 'A', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contrasena` varchar(100) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `id_estado_usuario` varchar(10) DEFAULT NULL,
  `persona_id` bigint(20) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA8973058C00AE0A` (`persona_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario_sucursal`
--

CREATE TABLE IF NOT EXISTS `usuario_sucursal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `empresa_id` bigint(20) NOT NULL,
  `estado_usuario_sucural` varchar(1) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65A40711204E6CA` (`usuario_id`),
  KEY `FK65A4071612F24EA` (`empresa_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `valor_parametros`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=212 ;

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
(9, 4, 'tpersona', 'peremplead', 'Administrativo', '0', 'A', 0),
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
(142, 8, 'gentitulos', 'prodoprt01', 'Lista de  Items de la Oportunidad Borrados', NULL, 'A', 0),
(143, 8, 'gentitulos', 'prodoprt00', 'Lista de Items de la Oportunidad', NULL, 'A', 0),
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
(191, 8, 'gentitulos', 'pedidost05', 'Lista de Pedidos Borrados', NULL, 'A', 0),
(192, 42, 'anexbasped', 'lisanexbas', 'anexo01,anexo02,anexo03,anexo04,anexo05,anexo06,anexo07,anexo08,anexo09', NULL, 'A', 0),
(193, 8, 'gentitulos', 'vencimit00', 'Lista Detalle  Vencimientos', NULL, 'A', 0),
(194, 8, 'gentitulos', 'vencimit05', 'Lista Detalle  Vencimientos Borrados', NULL, 'A', 0),
(195, 43, 'estadovenc', 'venporvenc', 'Por vencer', '3', 'A', 0),
(196, 43, 'estadovenc', 'venvencido', 'Vencido', '5', 'A', 0),
(197, 43, 'estadovenc', 'vencubiert', 'Cubierto', '1', 'A', 0),
(198, 44, 'tipovencim', 'vensofibm', 'Software IBM', NULL, 'A', 0),
(199, 44, 'tipovencim', 'venpaspadv', 'Passport Advantage', NULL, 'A', 0),
(200, 44, 'tipovencim', 'venotrsoft', 'Otros Software', NULL, 'A', 0),
(201, 44, 'tipovencim', 'ven conven', 'Convenios y Contratos', NULL, 'A', 0),
(202, 44, 'tipovencim', 'venharsoft', 'Hw y SW', NULL, 'A', 0),
(203, 45, 'tipocobert', 'ventipoc01', 'Cobertura 1', NULL, 'A', 0),
(204, 45, 'tipocobert', 'ventipoc02', 'Cobertura 2', NULL, 'A', 0),
(205, 8, 'gentitulos', 'encvenct01', 'Lista de Vencimientos Activos', NULL, 'A', 0),
(206, 8, 'gentitulos', 'encvenct05', 'Lista de Vencimientos Borrados', NULL, 'A', 0),
(207, 8, 'gentitulos', 'prueba 99', 'prueba 99', NULL, 'A', 1),
(208, 8, 'gentitulos', 'valparat00', 'Lista  Valor Parametroa', NULL, 'A', 0),
(209, 8, 'gentitulos', 'valparat05', 'Lista  Valor Parametros Borrados', NULL, 'A', 0),
(210, 8, 'gentitulos', 'empleadt01', 'Lista de Empleados', NULL, 'A', 0),
(211, 8, 'gentitulos', 'empleadt02', 'Lista de Empleados Borrados', NULL, 'A', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vencimientos`
--

CREATE TABLE IF NOT EXISTS `vencimientos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `decripcion` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `fecha_inicio` varchar(10) DEFAULT NULL,
  `fecha_vencimiento` varchar(10) DEFAULT NULL,
  `id_estado_vencimiento` varchar(10) NOT NULL,
  `id_tipo_cobertura` varchar(10) NOT NULL,
  `id_tipo_vencimiento` varchar(10) NOT NULL,
  `observaciones` varchar(100) DEFAULT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `serial` varchar(50) DEFAULT NULL,
  `encvencimiento_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7274CC0E5F949CA` (`pedido_id`),
  KEY `FK7274CC0E590C37EA` (`encvencimiento_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `vencimientos`
--

INSERT INTO `vencimientos` (`id`, `decripcion`, `eliminado`, `fecha_inicio`, `fecha_vencimiento`, `id_estado_vencimiento`, `id_tipo_cobertura`, `id_tipo_vencimiento`, `observaciones`, `pedido_id`, `serial`, `encvencimiento_id`) VALUES
(2, 'ok', 1, '25-03-2014', '26-06-2014', 'vencubiert', 'ventipoc01', 'vensofibm', NULL, 3, NULL, 1);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `contactos`
--
ALTER TABLE `contactos`
  ADD CONSTRAINT `FKE77EAA04612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  ADD CONSTRAINT `FKE77EAA048C00AE0A` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `det_pedidos`
--
ALTER TABLE `det_pedidos`
  ADD CONSTRAINT `FK1CA739A25E4583EA` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `FK1CA739A25F949CA` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`);

--
-- Filtros para la tabla `enc_vencimientos`
--
ALTER TABLE `enc_vencimientos`
  ADD CONSTRAINT `FKE8AD5F53612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD CONSTRAINT `FK1E7DA7FB5F949CA` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`);

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`posibilidad_id`) REFERENCES `posibilidades` (`id`),
  ADD CONSTRAINT `FKD6C5D1CE612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `posibilidades`
--
ALTER TABLE `posibilidades`
  ADD CONSTRAINT `fk_posib_empresas` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `propuestas`
--
ALTER TABLE `propuestas`
  ADD CONSTRAINT `FKE3639A0633685ACA` FOREIGN KEY (`posibilidad_id`) REFERENCES `posibilidades` (`id`);

--
-- Filtros para la tabla `prospectos`
--
ALTER TABLE `prospectos`
  ADD CONSTRAINT `FK7986CC70612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `registro_oportunidades`
--
ALTER TABLE `registro_oportunidades`
  ADD CONSTRAINT `FKBEE721E933685ACA` FOREIGN KEY (`posibilidad_id`) REFERENCES `posibilidades` (`id`);

--
-- Filtros para la tabla `rol_opcion_operacion`
--
ALTER TABLE `rol_opcion_operacion`
  ADD CONSTRAINT `FKD4E68CAF3B3E328A` FOREIGN KEY (`operacion_id`) REFERENCES `operaciones` (`id`),
  ADD CONSTRAINT `FKD4E68CAF67EBF2A` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `FKD4E68CAFB2FBD22A` FOREIGN KEY (`opcion_id`) REFERENCES `opciones` (`id`);

--
-- Filtros para la tabla `sublineas`
--
ALTER TABLE `sublineas`
  ADD CONSTRAINT `FK13109D66B8828E6A` FOREIGN KEY (`linea_id`) REFERENCES `lineas` (`id`);

--
-- Filtros para la tabla `territorios`
--
ALTER TABLE `territorios`
  ADD CONSTRAINT `territorio_territorio` FOREIGN KEY (`padre_id`) REFERENCES `territorios` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `FKA8973058C00AE0A` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`);

--
-- Filtros para la tabla `usuario_sucursal`
--
ALTER TABLE `usuario_sucursal`
  ADD CONSTRAINT `FK65A40711204E6CA` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  ADD CONSTRAINT `FK65A4071612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`);

--
-- Filtros para la tabla `valor_parametros`
--
ALTER TABLE `valor_parametros`
  ADD CONSTRAINT `parametro_valorParametro` FOREIGN KEY (`parametro_id`) REFERENCES `parametros` (`id`);

--
-- Filtros para la tabla `vencimientos`
--
ALTER TABLE `vencimientos`
  ADD CONSTRAINT `FK7274CC0E590C37EA` FOREIGN KEY (`encvencimiento_id`) REFERENCES `enc_vencimientos` (`id`),
  ADD CONSTRAINT `FK7274CC0E5F949CA` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
