-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-07-2014 a las 21:17:30
-- Versión del servidor: 5.5.36
-- Versión de PHP: 5.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
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
-- Estructura de tabla para la tabla `def_log`
--

CREATE TABLE IF NOT EXISTS `def_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `campo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_def_log` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `nom_entidad` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `nombre_campo` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `id_tipo_contenido` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=18 ;

--
-- Volcado de datos para la tabla `def_log`
--

INSERT INTO `def_log` (`id`, `campo`, `eliminado`, `id_estado_def_log`, `nom_entidad`, `nombre_campo`, `id_tipo_contenido`) VALUES
(1, 'empleado', 0, 'genactivo', 'Prospecto', 'Vendedor', 'deflogval'),
(2, 'idEstadoProspecto', 0, 'genactivo', 'Prospecto', 'Estado', 'deflogpar'),
(3, 'idSucursal', 0, 'genactivo', 'Prospecto', 'Sucursal', 'deflogfk'),
(4, 'empleado', 0, 'genactivo', 'Oportunidad', 'Vendedor', 'deflogval'),
(5, 'empresa', 0, 'genactivo', 'Oportunidad', 'Cliente', 'deflogval'),
(6, 'idSucursal', 0, 'genactivo', 'Oportunidad', 'Sucursal', 'deflogfk'),
(7, 'idEtapa', 0, 'genactivo', 'Oportunidad', 'Probabilidad', 'deflogpar'),
(8, 'idEstadoPedido', 0, 'genactivo', 'Pedido', 'Estado', 'deflogpar'),
(9, 'idFacturarA', 0, 'genactivo', 'Pedido', 'Facturar A:', 'deflogval'),
(10, 'idSucursal', 0, 'genactivo', 'Pedido', 'Sucursal', 'deflogfk'),
(11, 'dirEntregaFactura', 0, 'genactivo', 'Pedido', 'Dir. Entrega Factura', 'deflogval'),
(12, 'dirDespacho', 0, 'genactivo', 'Pedido', 'Dir. Despacho', 'deflogval'),
(13, 'empleado', 0, 'genactivo', 'Pedido', 'Vendedor', 'deflogval'),
(14, 'idEstadoDetPedido', 0, 'genactivo', 'DetPedido', 'Estado', 'deflogpar'),
(15, 'cantidadRecibida', 0, 'genactivo', 'DetPedido', 'Cantidad Recibida', 'deflogval'),
(16, 'valor', 0, 'genactivo', 'DetPedido', 'Valor', 'deflogval'),
(17, 'cantidad', 0, 'genactivo', 'DetPedido', 'Cantidad Pedida', 'deflogval');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
