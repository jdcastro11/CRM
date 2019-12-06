/*
SQLyog Ultimate v9.63 
MySQL - 5.5.27 : Database - crmdev
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`crmdev` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

/*Table structure for table `actividades` */

CREATE TABLE `actividades` (
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `actividades` */

insert  into `actividades`(`id`,`desc_actividad`,`eliminado`,`fecha_final`,`fecha_inicio`,`id_asignador`,`id_avance`,`id_contacto`,`id_entidad`,`id_estado_actividad`,`id_padre`,`id_prioridad`,`id_responsable`,`id_tipo_actividad`,`nombre_entidad`) values (1,'especificacion requisitos',0,'11-03-2014 11:00 am','10-03-2014 09:45 am',43,'avance00',48,3,'actiesta01',NULL,'actiprio03',45,'activida02','oportunidad'),(2,'Explicacion de Alternativa de xxx',1,'19-03-2014 12:00 pm','19-03-2014 08:00 am',43,'avance00',48,3,'actiesta01',NULL,'actiprio03',45,'activida03','oportunidad');

/*Table structure for table `anexos` */

CREATE TABLE `anexos` (
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;

/*Data for the table `anexos` */

insert  into `anexos`(`id`,`comentarios`,`eliminado`,`fecha_creacion`,`id_entidad`,`id_estado_anexo`,`id_tipo_anexo`,`nombre_archivo`,`nombre_entidad`) values (1,NULL,1,'28/01/2014',1,'genactivo','anexo01','PresentacionTechnet2013.pdf','pedido'),(2,'okok',0,'18/02/2014',1,'genactivo','anexo01','logrosPrueba.xlsx','pedido'),(3,NULL,0,'17/02/2014',1,'genactivo','anexo01','BscEjemplo.pdf','pedido'),(4,NULL,0,'18/02/2014',1,'genactivo','anexo01','modcontrato01.rtf','pedido'),(5,'ok',0,'11-03-2014',5,'genactivo','anexo03','CRM_DB_SPRINT1.pdf','propuesta'),(15,NULL,0,NULL,2,'genactivo','anexo01',NULL,'pedido'),(16,NULL,0,NULL,2,'genactivo','anexo02',NULL,'pedido'),(17,NULL,0,NULL,2,'genactivo','anexo03',NULL,'pedido'),(18,NULL,0,NULL,2,'genactivo','anexo04',NULL,'pedido'),(19,NULL,0,NULL,2,'genactivo','anexo05',NULL,'pedido'),(20,NULL,0,NULL,2,'genactivo','anexo06',NULL,'pedido'),(21,NULL,0,NULL,2,'genactivo','anexo07',NULL,'pedido'),(22,NULL,0,NULL,2,'genactivo','anexo08',NULL,'pedido'),(23,NULL,0,NULL,2,'genactivo','anexo09',NULL,'pedido'),(24,NULL,1,'26-03-2014',1,'genactivo','anexo05','CertificacionPesantes.pdf','propuesta'),(25,NULL,0,'26-03-2014',1,'genactivo','anexo10','CertificadoTrabajoHAriza.pdf','propuesta'),(26,'ok',0,'26-03-2014',1,'genactivo','anexo09','CartaLaboralMartha.doc','propuesta');

/*Table structure for table `contactos` */

CREATE TABLE `contactos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `id_estado_contacto` varchar(10) DEFAULT NULL,
  `persona_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE77EAA048C00AE0A` (`persona_id`),
  KEY `FKE77EAA04612F24EA` (`empresa_id`),
  CONSTRAINT `FKE77EAA04612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `FKE77EAA048C00AE0A` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

/*Data for the table `contactos` */

insert  into `contactos`(`id`,`eliminado`,`empresa_id`,`id_estado_contacto`,`persona_id`) values (1,0,12,'genactivo',51),(3,0,12,'genactivo',49),(4,0,11,'genactivo',50),(5,0,11,'genactivo',47),(6,0,23,'genactivo',52),(7,0,21,'genactivo',48),(8,0,23,'genactivo',49),(9,0,14,'genactivo',48),(10,0,11,'genactivo',56),(11,1,11,'genactivo',44),(12,1,11,'genactivo',46),(13,0,11,'genactivo',49),(14,0,11,'genactivo',44),(15,0,8,'genactivo',49),(16,0,8,'genactivo',56),(17,0,8,'genactivo',17),(18,0,10,'genactivo',53),(19,0,10,'genactivo',46),(20,0,20,'genactivo',17),(21,0,20,'genactivo',47),(22,0,23,'genactivo',51),(23,0,8,'genactivo',53),(24,0,8,'genactivo',47),(25,0,8,'genactivo',57),(26,0,10,'genactivo',48),(27,0,24,'genactivo',60);

/*Table structure for table `det_pedidos` */

CREATE TABLE `det_pedidos` (
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
  KEY `FK1CA739A25F949CA` (`pedido_id`),
  CONSTRAINT `FK1CA739A25E4583EA` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`),
  CONSTRAINT `FK1CA739A25F949CA` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `det_pedidos` */

insert  into `det_pedidos`(`id`,`cantidad`,`desc_producto`,`eliminado`,`id_estado_det_pedido`,`id_procesar_para`,`observaciones`,`ref_producto`,`valor`,`pedido_id`,`producto_id`) values (1,'200','Cable blindado',0,'peddetpd01','pedprosp02','ok','1234E5','1300',1,1);

/*Table structure for table `elementos_por_oportunidad` */

CREATE TABLE `elementos_por_oportunidad` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cantidad` varchar(10) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_elemento_por_oportunidad` varchar(10) DEFAULT NULL,
  `id_linea` bigint(20) NOT NULL,
  `id_sublinea` bigint(20) NOT NULL,
  `valor` varchar(20) DEFAULT NULL,
  `id_marca` varchar(10) DEFAULT NULL,
  `id_tipo_producto` varchar(10) DEFAULT NULL,
  `id_oportunidad` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `elementos_por_oportunidad` */

insert  into `elementos_por_oportunidad`(`id`,`cantidad`,`eliminado`,`id_estado_elemento_por_oportunidad`,`id_linea`,`id_sublinea`,`valor`,`id_marca`,`id_tipo_producto`,`id_oportunidad`) values (1,'3',0,'genactivo',2,3,'1,000,000','prodmarc01','prodtipo04',0),(2,'20',0,'genactivo',1,1,'12,600','prodmarc02','prodtipo02',0),(3,'10',0,'genactivo',2,3,'80','prodmarc01','prodtipo03',0),(4,'1',0,'genactivo',1,1,'5,000','prodmarc01','prodtipo02',0),(5,'1',0,'genactivo',1,1,'15,000','prodmarc01','prodtipo01',0),(6,'2',1,'genactivo',1,1,'1,000','prodmarc01','prodtipo01',0),(7,'1',0,'genactivo',1,1,'3,500','prodmarc01','prodtipo02',0),(8,'20',1,'genactivo',2,3,'8','prodmarc01','prodtipo03',0);

/*Table structure for table `empresas` */

CREATE TABLE `empresas` (
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

/*Data for the table `empresas` */

insert  into `empresas`(`id`,`padre_id`,`nit`,`razon_social`,`id_sucursal`,`celular`,`direccion`,`id_sector`,`id_dpto`,`id_pais`,`id_region`,`id_ciudad`,`id_tipo_empresa`,`id_tipo_sede`,`email`,`fax`,`telefonos`,`observaciones`,`id_estado_empresa`,`iniciales`,`eliminado`) values (1,NULL,'802012130','Redsis S.A.S',0,NULL,'Calle 74 # 53-23. Piso 5','empservici',3,1,2,4,'empbase','','info@redsis.com',NULL,' (571) 6351270',NULL,'empactivo','BAQ',0),(5,1,NULL,'Redsis Bogota',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empbase',NULL,NULL,NULL,NULL,NULL,'empactivo','BOG',0),(6,1,NULL,'Redsis  Bucaramanga',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empbase',NULL,NULL,NULL,NULL,NULL,'empactivo','BUC',0),(7,1,NULL,'Redsis  USA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empbase',NULL,NULL,NULL,NULL,NULL,'empactivo',NULL,0),(8,NULL,'802015200','Acme S.A',1,NULL,'Cra 77B # 65-20','empsecto01',NULL,NULL,NULL,NULL,'empprospec',NULL,'info@acme.com',NULL,'3521146',NULL,'empenproce',NULL,0),(9,NULL,'8020132015','Olimpica S.A.',1,NULL,'Calle 14','empsecto03',10,NULL,NULL,14,'empprospec',NULL,'sucursal14@olimpica.com',NULL,'2323',NULL,'empactivo',NULL,0),(10,NULL,NULL,'Caracol Radio',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,'gerencia@caracol.com.co',NULL,NULL,NULL,'empenproce',NULL,0),(11,NULL,'845515347','Monomeros Colombo Venezolano',1,NULL,'via 40 80 20','empsecto01',NULL,NULL,NULL,NULL,'empprospec',NULL,'info@monomeros.com',NULL,'3801015',NULL,'empactivo',NULL,0),(12,NULL,NULL,'Technet Limitada',NULL,NULL,'Cra 26C/ # 76A-75',NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,'gerencia@technet.com.co',NULL,'3521146',NULL,'empenproce',NULL,0),(13,NULL,NULL,'Integra.net',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,'integra@gmail.com',NULL,'3521146',NULL,'empenproce',NULL,0),(14,NULL,'802445776','Litoplas',NULL,NULL,'Aveida circunvalar KM 10','empsecto05',NULL,NULL,NULL,4,'empprospec',NULL,'info@litoplas.com.co',NULL,'2521146',NULL,'empenproce',NULL,0),(15,9,NULL,'Olimpica',NULL,NULL,'Cra 77B # 65-20',NULL,10,NULL,NULL,14,'empcliente',NULL,'gerencia77@olimpica.com',NULL,'3521148',NULL,'empactivo',NULL,0),(18,9,'8020132015','Olimpica',NULL,NULL,'Calle 1ra # 15-45',NULL,12,NULL,NULL,20,'empcliente',NULL,'gerenciario@olimpica.com',NULL,'2251410',NULL,'empactivo',NULL,0),(19,9,'8020132015','Olimpica',NULL,NULL,'La matuna # 20- 30',NULL,10,NULL,NULL,14,'empcliente',NULL,'gerencia@olimpica.com.co',NULL,'3362800',NULL,'empactivo',NULL,0),(20,NULL,'805315840','Tebsa',NULL,NULL,'Calle 17','empsecto01',3,NULL,NULL,4,'empcliente',NULL,NULL,NULL,'3524277',NULL,'empactivo',NULL,0),(21,NULL,NULL,'Transportes Sancarlos',NULL,NULL,'Calle 2 # 43 100',NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,'gerencia@sancarlos.com.',NULL,'3524510',NULL,'empactivo',NULL,0),(23,NULL,NULL,'Fondo Regional de Garantias',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,NULL,NULL,'3362800',NULL,'empactivo',NULL,0),(24,NULL,'805455132','Camara de Comercio de Barranquilla',NULL,NULL,'VIa 40 # 36-15',NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,'camara@camarabaq.org.co',NULL,'3521158',NULL,'empactivo',NULL,0),(25,NULL,NULL,'Oleoflores',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'empprospec',NULL,'info@oleoflores.com.co',NULL,'3455615',NULL,'empactivo',NULL,0);

/*Table structure for table `enc_vencimientos` */

CREATE TABLE `enc_vencimientos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `empresa_id` bigint(20) NOT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_enc_vencimiento` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE8AD5F53612F24EA` (`empresa_id`),
  CONSTRAINT `FKE8AD5F53612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `enc_vencimientos` */

insert  into `enc_vencimientos`(`id`,`eliminado`,`empresa_id`,`id_contacto`,`id_estado_enc_vencimiento`) values (1,1,14,48,'genactivo'),(2,0,14,48,'genactivo'),(3,0,14,48,'genactivo'),(4,1,14,48,'geninactiv'),(5,0,12,51,'genactivo'),(6,0,8,17,'genactivo'),(7,0,23,52,'genactivo'),(8,0,10,53,'genactivo'),(9,0,10,53,'genactivo'),(10,0,23,49,'genactivo');

/*Table structure for table `facturas` */

CREATE TABLE `facturas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `fecha_factura` varchar(10) NOT NULL,
  `id_estado_factura` varchar(10) NOT NULL,
  `num_factura` varchar(20) NOT NULL,
  `pedido_id` bigint(20) NOT NULL,
  `valor_factura` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1E7DA7FB5F949CA` (`pedido_id`),
  CONSTRAINT `FK1E7DA7FB5F949CA` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `facturas` */

insert  into `facturas`(`id`,`eliminado`,`fecha_factura`,`id_estado_factura`,`num_factura`,`pedido_id`,`valor_factura`) values (1,0,'13-02-2014','pedestacti','123',1,'2875000'),(2,1,'28-02-2014','pedestacti','325',1,'5250000');

/*Table structure for table `lineas` */

CREATE TABLE `lineas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_linea` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_linea` varchar(10) NOT NULL,
  `observ_linea` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `lineas` */

insert  into `lineas`(`id`,`desc_linea`,`eliminado`,`id_estado_linea`,`observ_linea`) values (1,'Linea 1',0,'genactivo',NULL),(2,'Linea 2',0,'genactivo',NULL),(3,'Linea 3',1,'genactivo','Desc Linea 3'),(4,'Linea 3',0,'genactivo',NULL),(5,'Linea 4',0,'genactivo','ok');

/*Table structure for table `opciones` */

CREATE TABLE `opciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_opcion` varchar(200) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_opcion` varchar(1) NOT NULL,
  `id_padre` bigint(20) DEFAULT NULL,
  `id_tipo_opcion` varchar(10) DEFAULT NULL,
  `nombre_opcion` varchar(100) NOT NULL,
  `url` varchar(300) DEFAULT NULL,
  `cls` varchar(100) DEFAULT NULL,
  `controlador` varchar(200) DEFAULT NULL,
  `orden` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

/*Data for the table `opciones` */

insert  into `opciones`(`id`,`desc_opcion`,`eliminado`,`estado_opcion`,`id_padre`,`id_tipo_opcion`,`nombre_opcion`,`url`,`cls`,`controlador`,`orden`) values (1,'Inicio',0,'A',NULL,'M','Inicio','/crm','icon-home icon-white','dashboard','01'),(2,NULL,0,'A',NULL,'M','Prospectos','/crm/Prospecto/index','icon-briefcase icon-white','prospecto','02'),(3,NULL,0,'A',NULL,'M','Oportunidades','/crm/Oportunidad/index','icon-eye-open icon-white','oportunidad','03'),(4,NULL,0,'A',NULL,'M','Clientes','/crm/empresa/index/2?layout=main&t=empresat05','icon-star icon-white','empresa','06'),(5,NULL,0,'A',NULL,'M','Contactos','/crm/contacto/index?layout=main','fa-icon-group','contacto','05'),(6,'Pedidos',0,'A',NULL,'M','Pedidos','/crm/pedido/index?sw=1','icon-edit icon-white','pedido','04'),(7,NULL,0,'A',NULL,'M','Productos','/crm/Producto/index','icon-gift icon-white','producto','08'),(8,NULL,0,'A',NULL,'M','Parametrización','/crm/Parametro/index','icon-cog icon-white','parametro','12'),(9,NULL,0,'A',NULL,'M','Lineas','/crm/Linea/index','fa-icon-money icon-white','linea','09'),(10,NULL,0,'A',NULL,'M','Territorios','/crm/Territorio/index','icon-road icon-white','territorio','11'),(11,'Oportunidad SC',0,'A',NULL,'D','Posibilidad','/crm/Posibilidad/index','fa-icon-money icon-white','posibilidad',NULL),(12,NULL,0,'A',NULL,'M','Empleados','/crm/Empleado/Index','icon-user icon-white','empleado','10'),(13,'Valor Parametro',0,'A',NULL,'D','Valor Parametro','/crm/ValorParametro/index',NULL,'valorParametro',NULL),(14,'Items de Oportunidades ',0,'A',NULL,'D','Items de Oportunidad','/crm/ElementoPorOportunidad/index',NULL,'elementoPorOportunidad',NULL),(15,NULL,0,'A',NULL,'D','Actividades','/crm/Actividad/index',NULL,'actividad',NULL),(16,NULL,0,'A',NULL,'D','Propuestas','/crm/Propuesta/index',NULL,'propuesta',NULL),(17,NULL,0,'A',NULL,'D','Registro Oportunidades','/crm/RegistroOportunidad',NULL,'registroOportunidad',NULL),(18,NULL,0,'A',NULL,'D','Listar Sedes','/crm/empresa/listarSedes',NULL,'empresa',NULL),(19,NULL,0,'A',NULL,'D','Listar Contactos','/crm/contacto/listarContactos',NULL,'contacto',NULL),(20,NULL,0,'A',NULL,'D','Sublineas','/crm/sublinea/index',NULL,'sublinea',NULL),(21,NULL,0,'A',NULL,'D','Det Territorios','/crm/territorio/detTerritorio',NULL,'territorio',NULL),(22,NULL,0,'A',NULL,'M','Vencimientos','/crm/EncVencimiento/index','fa-icon-check icon-white','encVencimiento','07'),(23,NULL,0,'A',NULL,'D','Det Pedidos','/crm/detPedido/index/',NULL,'detPedido',NULL),(24,NULL,0,'A',NULL,'D','Anexos','/crm/Anexo/index',NULL,'anexo',NULL),(25,NULL,0,'A',NULL,'D','Factura','/crm/factura/index',NULL,'factura',NULL),(26,NULL,0,'A',NULL,'D','Det Vencimientos','/crm/Vencimiento/index',NULL,'vencimiento',NULL),(27,NULL,0,'A',NULL,'D','Auto Completar Empresa','/crm/Empresa/autoCompletar',NULL,'empresa',NULL),(28,NULL,0,'A',NULL,'I','Auto Completar Contacto','/crm/Contacto/autoCompletar',NULL,'contacto',NULL),(29,NULL,0,'A',NULL,'I','Editar Contacto Modal','/crm/persona/index',NULL,'persona',NULL),(30,NULL,0,'A',NULL,'D','Personas','/crm/persona/index',NULL,'persona',NULL),(31,'Seguridad',0,'A',NULL,'M','Seguridad','/crm/seguridad/index','icon-lock icon-white','seguridad','99');

/*Table structure for table `operaciones` */

CREATE TABLE `operaciones` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `acciones` varchar(1000) NOT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_operacion` varchar(1) NOT NULL,
  `nombre_operacion` varchar(100) NOT NULL,
  `opcion_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKEAB8C1C6B2FBD22A` (`opcion_id`),
  CONSTRAINT `FKEAB8C1C6B2FBD22A` FOREIGN KEY (`opcion_id`) REFERENCES `opciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

/*Data for the table `operaciones` */

insert  into `operaciones`(`id`,`acciones`,`eliminado`,`estado_operacion`,`nombre_operacion`,`opcion_id`) values (1,'index,show,',0,'A','VER',NULL),(2,'create,save,',0,'A','CREAR',NULL),(3,'edit,update,',0,'A','MODIFICAR',NULL),(4,'borrar,listarBorrados,',0,'A','BORRAR',NULL),(5,'delete,',0,'A','DESTRUIR',NULL),(6,'filter,filtro,',0,'A','FILTRAR',NULL),(7,'asignarVendedor,',0,'A','ASIGNAR_VENDEDOR',NULL),(8,'listarSedes,',0,'A','LISTAR_SEDES',18),(9,'listarContactos,',0,'A','LISTAR_CONTACTOS',19),(10,'detTerritorio,',0,'A','DET_TERRITORIO',21),(11,'autoCompletar,',0,'A','AUTO_COMPLETAR',NULL),(12,'mostrarCboContacto,',0,'A','MOSTRAR_CONTACTO',NULL),(13,'datosContacto,',0,'A','DATOS_CONTACTO',NULL),(14,'index,acceso,application,personas,parametros,roles,nuevoRol,editarRol,borrarRoles,opcionesPorRol,opciones,asignarOpciones,quitarOpciones,nuevaOpcion,editarOpcion,borrarOpciones,usuariosPorRol,usuarios,asignarUsuarios,quitarUsuarios,nuevaUsuario,editarUsuario,borrarUsuarios,operacionesPorOpcion,operaciones,asignarOperaciones,quitarOperaciones,nuevaOperacion,editarOperacion,borrarOperaciones,',0,'A','ADMIN_ROLES',NULL),(15,'datosCliente,',0,'A','DATOS_CLIENTE',NULL),(16,'descalificar,',0,'A','DESCALIFICAR',NULL),(17,'convertir,',0,'A','CONVERTIR_OPORTUNIDAD',NULL);

/*Table structure for table `oportunidades` */

CREATE TABLE `oportunidades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_oportunidad` varchar(300) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `empresa_id` bigint(20) NOT NULL,
  `fecha_apertura` varchar(255) DEFAULT NULL,
  `fecha_cierre_estimada` varchar(255) DEFAULT NULL,
  `fecha_cierre_real` varchar(20) DEFAULT NULL,
  `id_actividad_mercadeo` varchar(10) DEFAULT NULL,
  `id_condicion` varchar(10) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_oportunidad` varchar(10) DEFAULT NULL,
  `id_etapa` varchar(10) DEFAULT NULL,
  `id_motivo_perdida` varchar(10) DEFAULT NULL,
  `id_sucursal` bigint(20) NOT NULL,
  `id_vendedor` bigint(20) DEFAULT NULL,
  `nombre_actividad_mercadeo` varchar(100) DEFAULT NULL,
  `nombre_oportunidad` varchar(50) DEFAULT NULL,
  `num_oportunidad` varchar(50) DEFAULT NULL,
  `num_oportunidad_fabricante` varchar(100) DEFAULT NULL,
  `observ_cambio_vendedor` varchar(200) DEFAULT NULL,
  `observ_cierre` varchar(200) DEFAULT NULL,
  `valor_facturado` decimal(19,2) DEFAULT NULL,
  `valor_oportunidad` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3D1AF4F5612F24EA` (`empresa_id`),
  CONSTRAINT `FK3D1AF4F5612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `oportunidades` */

insert  into `oportunidades`(`id`,`desc_oportunidad`,`eliminado`,`empresa_id`,`fecha_apertura`,`fecha_cierre_estimada`,`fecha_cierre_real`,`id_actividad_mercadeo`,`id_condicion`,`id_contacto`,`id_estado_oportunidad`,`id_etapa`,`id_motivo_perdida`,`id_sucursal`,`id_vendedor`,`nombre_actividad_mercadeo`,`nombre_oportunidad`,`num_oportunidad`,`num_oportunidad_fabricante`,`observ_cambio_vendedor`,`observ_cierre`,`valor_facturado`,`valor_oportunidad`) values (1,NULL,0,11,'09/04/2014',NULL,NULL,'posacmer01','poscondi01',50,'posenproce','posventa10',NULL,1,4,NULL,'Servidor  IBM','BAQ-0001-14',NULL,NULL,NULL,NULL,'10500.00'),(2,'Consultoria gestion Documental Basica',0,8,'09/04/2014',NULL,NULL,'posacmer01','poscondi01',49,'posenproce','posventa10',NULL,1,45,NULL,'Consultoría Alfresco','BAQ-0002-14',NULL,NULL,NULL,NULL,'8500.00'),(3,'ok',0,24,'09/04/2014',NULL,NULL,'posacmer01','poscondi01',60,'posenproce','posventa10',NULL,1,45,NULL,'Cableado Estructurado Sucursal Delicias','BAQ-0003-14',NULL,NULL,NULL,NULL,'105000.00');

/*Table structure for table `parametros` */

CREATE TABLE `parametros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_parametro` varchar(10) NOT NULL,
  `atributo` varchar(50) NOT NULL,
  `descripcion` varchar(300) DEFAULT NULL,
  `tipo_parametro` varchar(1) DEFAULT NULL,
  `estado_parametro` varchar(1) NOT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;

/*Data for the table `parametros` */

insert  into `parametros`(`id`,`id_parametro`,`atributo`,`descripcion`,`tipo_parametro`,`estado_parametro`,`eliminado`) values (1,'eempresa','id_estado_empresa','Estado de la Empresa','U','A',0),(2,'tempresa','id_tipo_empresa','Tipo de Empresa','U','A',0),(3,'epersona','id_estado_persona','Estado Persona','U','A',0),(4,'tpersona','id_tipo_persona','Tipo Persona','U','A',0),(5,'tterritori','id_tipo_territorio','Tipo Territorio','S','A',0),(6,'eprospecto','id_estado_empresa','Estado Prospecto','U','A',0),(7,'eposibilid','id_estado_posibilidad','Estado Posibilidad','U','A',1),(8,'gentitulos','generico','Titulos de las ventanas de CRUD','U','A',0),(9,'trazon','id_razon_cancelacion','Razones para Cancelar Oportunidad','U','A',0),(10,'tposibilid','id_tipo_posibilidad','Tipo de Posibilidad','U','A',0),(11,'genimport','general','Definiciones  tipo JSON para Importaciones','U','A',0),(12,'tpoactmerc','idActividadMercadeo','Tipo de Actividades de Mercadeo','U','A',0),(13,'tipocondic','idCondicion','Tipo de Condicion de la Oprtunidad','U','A',0),(14,'etapasvent','idEtapa','Etapas de Venta','U','A',0),(15,'sectores','id_sector','Sectores','U','A',0),(16,'lineas','idLinea','Lineas de productos','U','A',0),(17,'sublineas','id_sub_linea','Sub lineas de productos','U','A',0),(18,'consecutiv','genconsec','Consecuivos','U','A',0),(19,'tpoperdida','id_motivo_perdida','Motivo Perdida de Una Oportunidad','U','A',0),(20,'estadoprod','id_estado_producto','Estado Productos','U','A',0),(21,'estadogene','IdEstadoXX','Estado Generico para Entidades','U','A',0),(22,'prodmarca','IdMarca','Marca','U','A',0),(23,'tipoprod','IdTipoProducto','Tipo de productos','U','A',0),(24,'formadpago','idformaPago','Formas de Pago','U','A',0),(25,'tipoprecio','idTipoPrecio','Tipo de Precios','U','A',0),(26,'tipomoneda','idMonedaFactura','Tipo de Moneda para Factura','U','A',0),(27,'arquitecto','listaArquitectos','Lista de Arquitectos de Soluciones','U','A',0),(28,'estapedido','IdEstadopedido','Estado de los pedidos','U','A',0),(29,'disponiibm','idProductoDisponible','Disponibilidad producto IBM','U','A',0),(30,'procespara','idProcesarPara','Procesar Para','U','A',0),(31,'estadetped','idEstadoDetPedido','Estado del  Items en Detalle de Pedidos','U','A',0),(32,'tipoanexos','idTipoAnexo','Tipos de Anexos','U','A',0),(33,'rutasanexo','rutas','Rutas de Repositorios de documentos','U','A',0),(34,'filtros','n/a','Filtros  especiales','U','A',0),(35,'tipoactivi','idtipoActividad','Tipo de Actividad','U','A',0),(36,'prioracti','idPrioridad','Prioridad Actividad','U','A',0),(37,'actiestado','idEstadoActividad','Estado Actividad','U','A',0),(38,'actiavance','idAvance','Avance de las Actividades','U','A',0),(39,'mayoristas','id_registro_en','Mayoristas Registro Oportunidad','U','A',0),(40,'estregop','idEstadoRegistroOportunidad','Estado Registro Oportunidad','U','A',0),(41,'estadofact','idEstadoFactura','Estado Factura Pedidos','U','A',0),(42,'anexbasped','n/a','Lista de Anexos Basicos Pedidos','U','A',0),(43,'estadovenc','idEstadoVencimiento','Estado Vencimientos','U','A',0),(44,'tipovencim','idTipoVencimiento','Tipo de Vencimiento','U','A',0),(45,'tipocobert','idTipoCobertura','Tipo de Coberturas en Vencimientos','U','A',0),(46,'estadouser','idEstadoUsuario','Estado de los Usuarios','U','A',0);

/*Table structure for table `pedidos` */

CREATE TABLE `pedidos` (
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
  `empresa_id` bigint(20) NOT NULL,
  `id_usuario_autor` bigint(20) DEFAULT NULL,
  `oportunidad_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKD6C5D1CE612F24EA` (`empresa_id`),
  KEY `FKD6C5D1CECF76E42A` (`oportunidad_id`),
  CONSTRAINT `FKD6C5D1CE612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`),
  CONSTRAINT `FKD6C5D1CECF76E42A` FOREIGN KEY (`oportunidad_id`) REFERENCES `oportunidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `pedidos` */

insert  into `pedidos`(`id`,`arquitecto_sol`,`campania_redsis`,`cliente_nuevo`,`compra_ibm`,`desc_campania`,`desc_polizas`,`dir_despacho`,`dir_entrega_factura`,`eliminado`,`facturacion_parcial`,`fecha_entrega`,`fecha_apertura`,`id_bid_nexsys`,`id_contacto`,`id_estado_pedido`,`id_forma_pago`,`id_mondeda_factura`,`id_producto_disponible`,`id_tipo_precio`,`id_vendedor`,`lista_arquitectos`,`num_cliente`,`orden_compra`,`requiere_polizas`,`servicio_ibm`,`num_pedido`,`id_sucursal`,`empresa_id`,`id_usuario_autor`,`oportunidad_id`) values (1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,'25-04-2014','11-04-2014',NULL,49,'pedestad01',NULL,NULL,NULL,NULL,45,NULL,NULL,'1545',NULL,NULL,'BAQ-0001-14',1,8,NULL,NULL);

/*Table structure for table `personas` */

CREATE TABLE `personas` (
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
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=latin1;

/*Data for the table `personas` */

insert  into `personas`(`id`,`identificacion`,`id_tipo_persona`,`primer_nombre`,`segundo_nombre`,`primer_apellido`,`segundo_apellido`,`cargo`,`celular_adicional`,`celular_principal`,`email`,`id_nivel_decision`,`observaciones`,`rep_legal`,`telefono_fijo`,`id_estado_persona`,`eliminado`) values (1,'72135240','percontact','Hernan','Enrique','Pajaro','Torres','Gerente Operaciones',NULL,'3003563643','hpajaro@gmail.com',NULL,NULL,NULL,'3521146','vinactiva',0),(4,'72154789','pervendedo','Pedro',NULL,'Paramo',NULL,NULL,NULL,NULL,NULL,NULL,'ok',NULL,NULL,'peractivo',0),(15,NULL,'percontact','Gariel',NULL,'Garcia','Marquez',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(16,NULL,'percontact','Pablo','Manuel','Marmol',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(17,NULL,'percontact','Pedro',NULL,'Gutierrez','Perez','Gerente de Recursos Humanos',NULL,'3155467896','pguti@gmail.com',NULL,NULL,NULL,'3556244',NULL,0),(43,'1162534','peremplead','Pablo',NULL,'Neruda',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(44,NULL,'percontact','Carlos','Alberto','Valderrama',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(45,'114256872','pervendedo','Carlos',NULL,'Vaca',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'peractivo',0),(46,NULL,'percontact','Pablo',NULL,'Milanez',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(47,NULL,'percontact','Homero',NULL,'Simpson',NULL,NULL,NULL,'3015269877',NULL,NULL,NULL,NULL,NULL,NULL,0),(48,NULL,'percontact','Martha',NULL,'NiÃ±o',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(49,NULL,'percontact','Catalina',NULL,'Pajaro','Torres','Jefe de compras',NULL,'3117896545',NULL,NULL,NULL,NULL,'3445521',NULL,0),(50,NULL,'percontact','Jairo',NULL,'Matino',NULL,NULL,NULL,'300456890',NULL,NULL,NULL,NULL,NULL,NULL,0),(51,NULL,'percontact','Carlos',NULL,'Paez',NULL,NULL,NULL,'300456899','cpaez@contraloria.gov.co',NULL,NULL,NULL,'3154850 Ext 215','genactivo',0),(52,NULL,'percontact','Joisman',NULL,'Jimenez','Perez',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(53,NULL,'percontact','Humberto',NULL,'Maury',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(54,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(55,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0),(56,NULL,'percontact','Johana',NULL,'Combita','Niño','Jefe de Compras',NULL,'300542825',NULL,NULL,NULL,NULL,NULL,NULL,0),(57,NULL,'percontact','Jaime',NULL,'Berdugo',NULL,'Gerente RH',NULL,'3005466987',NULL,NULL,NULL,NULL,NULL,NULL,0),(58,NULL,'percontact','Francisco',NULL,'Romero',NULL,NULL,NULL,'3156525478','fromero1@gmail.com',NULL,NULL,NULL,NULL,NULL,0),(59,NULL,'percontact','Francisco',NULL,'Romero',NULL,NULL,NULL,'3125468978','fromero@gmail.com',NULL,NULL,NULL,NULL,NULL,0),(60,NULL,'percontact','Erick',NULL,'Carpio',NULL,'Jefe de Sistemas',NULL,'3115154879','ecarpio@camarabaq.org',NULL,NULL,NULL,NULL,NULL,0);

/*Table structure for table `productos` */

CREATE TABLE `productos` (
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `productos` */

insert  into `productos`(`id`,`desc_producto`,`eliminado`,`id_linea`,`id_sub_linea`,`id_tipo_producto`,`ref_producto`,`id_estado_producto`,`id_marca`) values (1,'Cable UTP Nivel 7A',0,'1','1',NULL,'123459-R','prodactivo',NULL),(2,'Servicio de fibra',0,NULL,NULL,NULL,'SRV-0125','peddetpd01',NULL);

/*Table structure for table `propuestas` */

CREATE TABLE `propuestas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_propuesta` varchar(10) DEFAULT NULL,
  `id_vendedor` bigint(20) DEFAULT NULL,
  `num_propuesta` varchar(50) DEFAULT NULL,
  `valor` varchar(20) DEFAULT NULL,
  `oportunidad_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKE3639A0633685ACA` (`oportunidad_id`),
  CONSTRAINT `FKE3639A0633685ACA` FOREIGN KEY (`oportunidad_id`) REFERENCES `oportunidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `propuestas` */

/*Table structure for table `prospectos` */

CREATE TABLE `prospectos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_prospecto` varchar(300) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `empresa_id` bigint(20) DEFAULT NULL,
  `fecha_apertura` varchar(255) DEFAULT NULL,
  `fecha_cierre_estimada` varchar(255) DEFAULT NULL,
  `id_contacto` bigint(20) DEFAULT NULL,
  `id_estado_prospecto` varchar(10) DEFAULT NULL,
  `id_razon_cancelacion` varchar(10) DEFAULT NULL,
  `id_sucursal` bigint(20) NOT NULL,
  `id_vendedor` bigint(20) DEFAULT NULL,
  `nombre_prospecto` varchar(50) DEFAULT NULL,
  `otra_razon_cancelacion` varchar(200) DEFAULT NULL,
  `valor_prospecto` decimal(19,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7986CC70612F24EA` (`empresa_id`),
  CONSTRAINT `FK7986CC70612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `prospectos` */

insert  into `prospectos`(`id`,`desc_prospecto`,`eliminado`,`empresa_id`,`fecha_apertura`,`fecha_cierre_estimada`,`id_contacto`,`id_estado_prospecto`,`id_razon_cancelacion`,`id_sucursal`,`id_vendedor`,`nombre_prospecto`,`otra_razon_cancelacion`,`valor_prospecto`) values (1,'Fibra implica obra civil ok ok',0,11,'09-04-2014','29-05-2014',56,'posenproce',NULL,1,4,'Cableado Estructurado  + Fibra 1000 Mts',NULL,'5500.00'),(3,'Tebiso',0,20,'10-04-2014','22-05-2014',17,'posenproce',NULL,1,NULL,'Gestion Documental con Alfresco',NULL,'8000.00');

/*Table structure for table `registro_oportunidades` */

CREATE TABLE `registro_oportunidades` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL,
  `fecha` varchar(10) DEFAULT NULL,
  `id_asignadoa` bigint(20) DEFAULT NULL,
  `id_autor` bigint(20) NOT NULL,
  `id_estado_registro_oportunidad` varchar(10) DEFAULT NULL,
  `num_registro_oportunidad` varchar(50) DEFAULT NULL,
  `id_registro_en` varchar(10) NOT NULL,
  `oportunidad_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKBEE721E933685ACA` (`oportunidad_id`),
  KEY `id_registro_en` (`id_registro_en`),
  CONSTRAINT `FKBEE721E933685ACA` FOREIGN KEY (`oportunidad_id`) REFERENCES `oportunidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `registro_oportunidades` */

/*Table structure for table `rol_opcion_operacion` */

CREATE TABLE `rol_opcion_operacion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `estado_rol_opcion_operacion` varchar(1) NOT NULL,
  `opcion_id` bigint(20) NOT NULL,
  `operacion_id` bigint(20) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FKD4E68CAF67EBF2A` (`rol_id`),
  KEY `FKD4E68CAF3B3E328A` (`operacion_id`),
  KEY `FKD4E68CAFB2FBD22A` (`opcion_id`),
  CONSTRAINT `FKD4E68CAF3B3E328A` FOREIGN KEY (`operacion_id`) REFERENCES `operaciones` (`id`),
  CONSTRAINT `FKD4E68CAF67EBF2A` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FKD4E68CAFB2FBD22A` FOREIGN KEY (`opcion_id`) REFERENCES `opciones` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=167 DEFAULT CHARSET=latin1;

/*Data for the table `rol_opcion_operacion` */

insert  into `rol_opcion_operacion`(`id`,`estado_rol_opcion_operacion`,`opcion_id`,`operacion_id`,`rol_id`,`eliminado`) values (1,'A',2,1,1,0),(2,'A',2,2,1,0),(3,'A',2,3,1,0),(4,'A',1,4,1,0),(7,'A',11,1,1,0),(8,'A',3,1,1,0),(9,'A',3,3,1,0),(10,'A',3,4,1,0),(11,'A',3,5,1,0),(12,'A',3,6,1,0),(13,'A',3,2,1,0),(15,'A',5,1,1,0),(16,'A',3,7,1,0),(17,'A',8,1,1,0),(18,'A',8,6,1,0),(19,'A',8,2,1,0),(20,'A',8,3,1,0),(21,'A',8,4,1,0),(22,'A',8,5,1,0),(24,'A',13,1,1,0),(25,'A',13,2,1,0),(26,'A',13,3,1,0),(27,'A',13,4,1,0),(28,'A',13,5,1,0),(29,'A',13,6,1,0),(30,'A',2,4,1,0),(31,'A',2,5,1,0),(32,'A',2,6,1,0),(33,'A',11,2,1,0),(34,'A',11,3,1,0),(35,'A',11,4,1,0),(36,'A',11,5,1,0),(37,'A',11,6,1,0),(38,'A',14,1,1,0),(39,'A',14,2,1,0),(40,'A',14,3,1,0),(41,'A',14,4,1,0),(42,'A',14,5,1,0),(43,'A',14,6,1,0),(44,'A',15,1,1,0),(45,'A',15,2,1,0),(46,'A',15,3,1,0),(47,'A',15,4,1,0),(48,'A',15,5,1,0),(49,'A',15,6,1,0),(50,'A',16,1,1,0),(51,'A',16,2,1,0),(52,'A',16,3,1,0),(53,'A',16,4,1,0),(54,'A',16,5,1,0),(55,'A',16,6,1,0),(56,'A',17,1,1,0),(57,'A',17,2,1,0),(58,'A',17,3,1,0),(59,'A',17,4,1,0),(60,'A',17,5,1,0),(61,'A',17,6,1,0),(62,'A',4,1,1,0),(63,'A',4,2,1,0),(64,'A',4,3,1,0),(65,'A',4,4,1,0),(66,'A',4,5,1,0),(67,'A',4,6,1,0),(68,'A',18,1,1,0),(69,'A',18,2,1,0),(70,'A',18,3,1,0),(71,'A',18,4,1,0),(72,'A',18,5,1,0),(73,'A',18,6,1,0),(74,'A',4,8,1,0),(75,'A',19,1,1,0),(76,'A',19,2,1,0),(77,'A',19,3,1,0),(78,'A',19,4,1,0),(79,'A',19,5,1,0),(80,'A',19,6,1,0),(81,'A',19,9,1,0),(82,'A',9,1,1,0),(83,'A',9,2,1,0),(84,'A',9,3,1,0),(85,'A',9,4,1,0),(86,'A',9,5,1,0),(87,'A',9,6,1,0),(88,'A',20,1,1,0),(89,'A',20,2,1,0),(90,'A',20,3,1,0),(91,'A',20,4,1,0),(92,'A',20,5,1,0),(93,'A',20,6,1,0),(94,'A',10,1,1,0),(95,'A',10,2,1,0),(96,'A',10,3,1,0),(97,'A',10,4,1,0),(98,'A',10,5,1,0),(99,'A',10,6,1,0),(100,'A',10,10,1,0),(101,'A',27,11,1,0),(102,'A',6,1,1,0),(103,'A',6,2,1,0),(104,'A',6,3,1,0),(105,'A',6,4,1,0),(106,'A',6,5,1,0),(107,'A',6,6,1,0),(108,'A',7,1,1,0),(109,'A',7,2,1,0),(110,'A',7,3,1,0),(111,'A',7,4,1,0),(112,'A',7,5,1,0),(113,'A',7,6,1,0),(114,'A',1,1,1,0),(115,'A',12,1,1,0),(116,'A',12,2,1,0),(117,'A',12,3,1,0),(118,'A',12,4,1,0),(119,'A',12,5,1,0),(120,'A',12,6,1,0),(121,'A',22,1,1,0),(122,'A',22,2,1,0),(123,'A',22,3,1,0),(124,'A',22,4,1,0),(125,'A',22,5,1,0),(126,'A',22,6,1,0),(127,'A',23,1,1,0),(128,'A',23,2,1,0),(129,'A',23,3,1,0),(130,'A',23,4,1,0),(131,'A',23,5,1,0),(132,'A',23,6,1,0),(133,'A',24,1,1,0),(134,'A',24,2,1,0),(135,'A',24,3,1,0),(136,'A',24,4,1,0),(137,'A',24,5,1,0),(138,'A',24,6,1,0),(139,'A',25,1,1,0),(140,'A',25,2,1,0),(141,'A',25,3,1,0),(142,'A',25,4,1,0),(143,'A',25,5,1,0),(144,'A',25,6,1,0),(145,'A',26,1,1,0),(146,'A',26,2,1,0),(147,'A',26,3,1,0),(148,'A',26,4,1,0),(149,'A',26,5,1,0),(150,'A',26,6,1,0),(151,'A',28,11,1,0),(152,'A',5,12,1,0),(153,'A',2,13,1,0),(154,'A',29,3,1,0),(155,'A',30,1,1,0),(156,'A',30,2,1,0),(157,'A',30,3,1,0),(158,'A',30,4,1,0),(159,'A',30,5,1,0),(160,'A',30,6,1,0),(161,'A',31,14,1,0),(162,'A',31,1,1,0),(163,'A',3,15,1,0),(164,'A',30,13,1,0),(165,'A',2,16,1,0),(166,'A',2,17,1,1);

/*Table structure for table `roles` */

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_rol` varchar(200) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_rol` varchar(1) DEFAULT NULL,
  `nombre_rol` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `roles` */

insert  into `roles`(`id`,`desc_rol`,`eliminado`,`estado_rol`,`nombre_rol`) values (1,'Administrador Funcional',0,'A','ADMIN_FUNCIONAL'),(2,'Ejecutivo de Cuentas',0,'A','VENDEDOR'),(3,'Asistente de Ventas',0,'A','ASISTENTE_VENTAS'),(4,'Gerente',0,'A','GERENTE');

/*Table structure for table `roles_usuarios` */

CREATE TABLE `roles_usuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `estado_rol_usuario` varchar(1) NOT NULL,
  `rol_id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC9AC5A4767EBF2A` (`rol_id`),
  KEY `FKC9AC5A471204E6CA` (`usuario_id`),
  CONSTRAINT `FKC9AC5A471204E6CA` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `FKC9AC5A4767EBF2A` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `roles_usuarios` */

insert  into `roles_usuarios`(`id`,`eliminado`,`estado_rol_usuario`,`rol_id`,`usuario_id`) values (1,1,'A',1,1),(2,0,'A',1,1);

/*Table structure for table `sublineas` */

CREATE TABLE `sublineas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desc_sublinea` varchar(200) NOT NULL,
  `eliminado` tinyint(4) NOT NULL,
  `id_estado_sublinea` varchar(10) NOT NULL,
  `linea_id` bigint(20) NOT NULL,
  `observ_sublinea` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK13109D66B8828E6A` (`linea_id`),
  CONSTRAINT `FK13109D66B8828E6A` FOREIGN KEY (`linea_id`) REFERENCES `lineas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `sublineas` */

insert  into `sublineas`(`id`,`desc_sublinea`,`eliminado`,`id_estado_sublinea`,`linea_id`,`observ_sublinea`) values (1,'Prueba 44',0,'genactivo',1,NULL),(2,'Servicio de Soporte',0,'genactivo',1,NULL),(3,'Sublinea 1 Linea 2',0,'genactivo',2,'ok'),(4,'Sublinea 2 Linea 2',0,'genactivo',2,NULL),(5,'Prueba',0,'genactivo',3,NULL),(6,'Prueba 6',0,'genactivo',4,NULL),(7,'Pruba 7',0,'genactivo',4,NULL),(8,'Prueba 87',0,'genactivo',4,NULL),(9,'Prueba 26 Linea 1',0,'genactivo',1,NULL);

/*Table structure for table `territorios` */

CREATE TABLE `territorios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `padre_id` bigint(20) DEFAULT NULL,
  `codigo_territorio` varchar(255) NOT NULL,
  `id_tipo_territorio` varchar(10) NOT NULL,
  `nombre_territorio` varchar(100) NOT NULL,
  `estado_territorio` varchar(1) NOT NULL,
  `eliminado` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_Territorio` (`padre_id`),
  CONSTRAINT `territorio_territorio` FOREIGN KEY (`padre_id`) REFERENCES `territorios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1151 DEFAULT CHARSET=utf8;

/*Data for the table `territorios` */

insert  into `territorios`(`id`,`padre_id`,`codigo_territorio`,`id_tipo_territorio`,`nombre_territorio`,`estado_territorio`,`eliminado`) values (1,NULL,'CO','terpais','Colombia','A',0),(2,1,'N','terregion','Norte','A',0),(3,1,'C','terregion','Centro','A',0),(4,1,'Or','terregion','Oriente','A',0),(5,1,'S','terregion','Sur','A',0),(6,1,'Oc','terregion','Occidente','A',0),(7,NULL,'','terdpto','Amazonas','',0),(8,NULL,'','terdpto','Antioquia','',0),(9,NULL,'','terdpto','Arauca','',0),(10,2,'atl','terdpto','Atlántico','A',0),(11,2,'bol','terdpto','Bolívar','A',0),(12,3,'boy','terdpto','Boyacá','A',0),(13,NULL,'','terdpto','Caldas','',0),(14,NULL,'','terdpto','Caquetá','',0),(15,NULL,'','terdpto','Casanare','',0),(16,NULL,'','terdpto','Cauca','',0),(17,NULL,'','terdpto','Cesar','',0),(18,NULL,'','terdpto','Chocó','',0),(19,NULL,'','terdpto','Córdoba','',0),(20,NULL,'','terdpto','Cundinamarca','',0),(21,NULL,'','terdpto','Guainí­a','',0),(22,NULL,'','terdpto','Guaviare','',0),(23,NULL,'','terdpto','Huila','',0),(24,NULL,'','terdpto','La Guajira','',0),(25,NULL,'','terdpto','Magdalena','',0),(26,NULL,'','terdpto','Meta','',0),(27,NULL,'','terdpto','Nariño','',0),(28,NULL,'','terdpto','Norte de santander','',0),(29,NULL,'','terdpto','Putumayo','',0),(30,NULL,'','terdpto','Quindí­o','',0),(31,NULL,'','terdpto','Risaralda','',0),(32,NULL,'','terdpto','San Andrés y Providencia','',0),(33,NULL,'','terdpto','Santander','',0),(34,NULL,'','terdpto','Sucre','',0),(35,NULL,'','terdpto','Tolima','',0),(36,NULL,'','terdpto','Valle del cauca','',0),(37,NULL,'','terdpto','Vaupés','',0),(38,NULL,'','terdpto','Vichada','',0),(39,7,'','termunicip','El encanto','',0),(40,7,'','termunicip','La chorrera','',0),(41,7,'','termunicip','La pedrera','',0),(42,7,'','termunicip','La victoria','',0),(43,7,'','termunicip','Leticia','',0),(44,7,'','termunicip','Miriti','',0),(45,7,'','termunicip','Puerto Alegria','',0),(46,7,'','termunicip','Puerto Arica','',0),(47,7,'','termunicip','Puerto Nariño','',0),(48,7,'','termunicip','Puerto santander','',0),(49,7,'','termunicip','Turapaca','',0),(50,8,'','termunicip','Abejorral','',0),(51,8,'','termunicip','Abriaqui','',0),(52,8,'','termunicip','Alejandria','',0),(53,8,'','termunicip','Amaga','',0),(54,8,'','termunicip','Amalfi','',0),(55,8,'','termunicip','Andes','',0),(56,8,'','termunicip','Angelopolis','',0),(57,8,'','termunicip','Angostura','',0),(58,8,'','termunicip','Anori','',0),(59,8,'','termunicip','Antioquia','',0),(60,8,'','termunicip','Anza','',0),(61,8,'','termunicip','Apartado','',0),(62,8,'','termunicip','Arboletes','',0),(63,8,'','termunicip','Argelia','',0),(64,8,'','termunicip','Armenia','',0),(65,8,'','termunicip','Barbosa','',0),(66,8,'','termunicip','Bello','',0),(67,8,'','termunicip','Belmira','',0),(68,8,'','termunicip','Betania','',0),(69,8,'','termunicip','Betulia','',0),(70,8,'','termunicip','Bolivar','',0),(71,8,'','termunicip','Briceño','',0),(72,8,'','termunicip','Buritica','',0),(73,8,'','termunicip','Caceres','',0),(74,8,'','termunicip','Caicedo','',0),(75,8,'','termunicip','Caldas','',0),(76,8,'','termunicip','Campamento','',0),(77,8,'','termunicip','Canasgordas','',0),(78,8,'','termunicip','Caracolí','',0),(79,8,'','termunicip','Caramanta','',0),(80,8,'','termunicip','Carepa','',0),(81,8,'','termunicip','Carmen de viboral','',0),(82,8,'','termunicip','Carolina del principe','',0),(83,8,'','termunicip','Caucasia','',0),(84,8,'','termunicip','Chigorodo','',0),(85,8,'','termunicip','Cisneros','',0),(86,8,'','termunicip','Cocorna','',0),(87,8,'','termunicip','Concepcion','',0),(88,8,'','termunicip','Concordia','',0),(89,8,'','termunicip','Copacabana','',0),(90,8,'','termunicip','Dabeiba','',0),(91,8,'','termunicip','Donmatias','',0),(92,8,'','termunicip','Ebejico','',0),(93,8,'','termunicip','El bagre','',0),(94,8,'','termunicip','El penol','',0),(95,8,'','termunicip','El retiro','',0),(96,8,'','termunicip','Entrerrios','',0),(97,8,'','termunicip','Envigado','',0),(98,8,'','termunicip','Fredonia','',0),(99,8,'','termunicip','Frontino','',0),(100,8,'','termunicip','Giraldo','',0),(101,8,'','termunicip','Girardota','',0),(102,8,'','termunicip','Gomez plata','',0),(103,8,'','termunicip','Granada','',0),(104,8,'','termunicip','Guadalupe','',0),(105,8,'','termunicip','Guarne','',0),(106,8,'','termunicip','Guataque','',0),(107,8,'','termunicip','Heliconia','',0),(108,8,'','termunicip','Hispania','',0),(109,8,'','termunicip','Itagui','',0),(110,8,'','termunicip','Ituango','',0),(111,8,'','termunicip','Jardin','',0),(112,8,'','termunicip','Jerico','',0),(113,8,'','termunicip','La ceja','',0),(114,8,'','termunicip','La estrella','',0),(115,8,'','termunicip','La pintada','',0),(116,8,'','termunicip','La union','',0),(117,8,'','termunicip','Liborina','',0),(118,8,'','termunicip','Maceo','',0),(119,8,'','termunicip','Marinilla','',0),(120,8,'','termunicip','Medellin','',0),(121,8,'','termunicip','Montebello','',0),(122,8,'','termunicip','Murindo','',0),(123,8,'','termunicip','Mutata','',0),(124,8,'','termunicip','Narino','',0),(125,8,'','termunicip','Nechi','',0),(126,8,'','termunicip','Necocli','',0),(127,8,'','termunicip','Olaya','',0),(128,8,'','termunicip','Peque','',0),(129,8,'','termunicip','Pueblorrico','',0),(130,8,'','termunicip','Puerto berrio','',0),(131,8,'','termunicip','Puerto nare','',0),(132,8,'','termunicip','Puerto triunfo','',0),(133,8,'','termunicip','Remedios','',0),(134,8,'','termunicip','Rionegro','',0),(135,8,'','termunicip','Sabanalarga','',0),(136,8,'','termunicip','Sabaneta','',0),(137,8,'','termunicip','Salgar','',0),(138,8,'','termunicip','San andres de cuerquia','',0),(139,8,'','termunicip','San carlos','',0),(140,8,'','termunicip','San francisco','',0),(141,8,'','termunicip','San jeronimo','',0),(142,8,'','termunicip','San jose de la montaÃ±a','',0),(143,8,'','termunicip','San juan de uraba','',0),(144,8,'','termunicip','San luis','',0),(145,8,'','termunicip','San pedro de los milagros','',0),(146,8,'','termunicip','San pedro de uraba','',0),(147,8,'','termunicip','San rafael','',0),(148,8,'','termunicip','San roque','',0),(149,8,'','termunicip','San vicente','',0),(150,8,'','termunicip','Santa barbara','',0),(151,8,'','termunicip','Santa rosa de osos','',0),(152,8,'','termunicip','Santo domingo','',0),(153,8,'','termunicip','Santuario','',0),(154,8,'','termunicip','Segovia','',0),(155,8,'','termunicip','Sonson','',0),(156,8,'','termunicip','Sopetran','',0),(157,8,'','termunicip','Tamesis','',0),(158,8,'','termunicip','Taraza','',0),(159,8,'','termunicip','Tarso','',0),(160,8,'','termunicip','Titiribi','',0),(161,8,'','termunicip','Toledo','',0),(162,8,'','termunicip','Turbo','',0),(163,8,'','termunicip','Uramita','',0),(164,8,'','termunicip','Urrao','',0),(165,8,'','termunicip','Valdivia','',0),(166,8,'','termunicip','Valparaiso','',0),(167,8,'','termunicip','Vegachi','',0),(168,8,'','termunicip','Venecia','',0),(169,8,'','termunicip','Vigia del fuerte','',0),(170,8,'','termunicip','Yali','',0),(171,8,'','termunicip','Yarumal','',0),(172,8,'','termunicip','Yolombo','',0),(173,8,'','termunicip','Yondo','',0),(174,8,'','termunicip','Zaragoza','',0),(175,9,'','termunicip','Arauca','',0),(176,9,'','termunicip','Arauquita','',0),(177,9,'','termunicip','Cravo norte','',0),(178,9,'','termunicip','Fortul','',0),(179,9,'','termunicip','Puerto rondon','',0),(180,9,'','termunicip','Saravena','',0),(181,9,'','termunicip','Tame','',0),(182,10,'','termunicip','Baranoa','',0),(183,10,'','termunicip','Barranquilla','',0),(184,10,'','termunicip','Campo de la cruz','',0),(185,10,'','termunicip','Candelaria','',0),(186,10,'','termunicip','Galapa','',0),(187,10,'','termunicip','Juan de acosta','',0),(188,10,'','termunicip','Luruaco','',0),(189,10,'','termunicip','Malambo','',0),(190,10,'','termunicip','Manati','',0),(191,10,'','termunicip','Palmar de varela','',0),(192,10,'','termunicip','Piojo','',0),(193,10,'','termunicip','Polo nuevo','',0),(194,10,'','termunicip','Ponedera','',0),(195,10,'','termunicip','Puerto colombia','',0),(196,10,'','termunicip','Repelon','',0),(197,10,'','termunicip','Sabanagrande','',0),(198,10,'','termunicip','Sabanalarga','',0),(199,10,'','termunicip','Santa lucia','',0),(200,10,'','termunicip','Santo tomas','',0),(201,10,'','termunicip','Soledad','',0),(202,10,'','termunicip','Suan','',0),(203,10,'','termunicip','Tubara','',0),(204,10,'','termunicip','Usiacuri','',0),(205,11,'','termunicip','Achi','',0),(206,11,'','termunicip','Altos del rosario','',0),(207,11,'','termunicip','Arenal','',0),(208,11,'','termunicip','Arjona','',0),(209,11,'','termunicip','Arroyohondo','',0),(210,11,'','termunicip','Barranco de loba','',0),(211,11,'','termunicip','Brazuelo de papayal','',0),(212,11,'','termunicip','Calamar','',0),(213,11,'','termunicip','Cantagallo','',0),(214,11,'','termunicip','Cartagena de indias','',0),(215,11,'','termunicip','Cicuco','',0),(216,11,'','termunicip','Clemencia','',0),(217,11,'','termunicip','Cordoba','',0),(218,11,'','termunicip','El carmen de bolivar','',0),(219,11,'','termunicip','El guamo','',0),(220,11,'','termunicip','El penion','',0),(221,11,'','termunicip','Hatillo de loba','',0),(222,11,'','termunicip','Magangue','',0),(223,11,'','termunicip','Mahates','',0),(224,11,'','termunicip','Margarita','',0),(225,11,'','termunicip','Maria la baja','',0),(226,11,'','termunicip','Montecristo','',0),(227,11,'','termunicip','Morales','',0),(228,11,'','termunicip','Morales','',0),(229,11,'','termunicip','Norosi','',0),(230,11,'','termunicip','Pinillos','',0),(231,11,'','termunicip','Regidor','',0),(232,11,'','termunicip','Rio viejo','',0),(233,11,'','termunicip','San cristobal','',0),(234,11,'','termunicip','San estanislao','',0),(235,11,'','termunicip','San fernando','',0),(236,11,'','termunicip','San jacinto','',0),(237,11,'','termunicip','San jacinto del cauca','',0),(238,11,'','termunicip','San juan de nepomuceno','',0),(239,11,'','termunicip','San martin de loba','',0),(240,11,'','termunicip','San pablo','',0),(241,11,'','termunicip','San pablo norte','',0),(242,11,'','termunicip','Santa catalina','',0),(243,11,'','termunicip','Santa cruz de mompox','',0),(244,11,'','termunicip','Santa rosa','',0),(245,11,'','termunicip','Santa rosa del sur','',0),(246,11,'','termunicip','Simiti','',0),(247,11,'','termunicip','Soplaviento','',0),(248,11,'','termunicip','Talaigua nuevo','',0),(249,11,'','termunicip','Tuquisio','',0),(250,11,'','termunicip','Turbaco','',0),(251,11,'','termunicip','Turbana','',0),(252,11,'','termunicip','Villanueva','',0),(253,11,'','termunicip','Zambrano','',0),(254,12,'','termunicip','Aquitania','',0),(255,12,'','termunicip','Arcabuco','',0),(256,12,'','termunicip','Belén','',0),(257,12,'','termunicip','Berbeo','',0),(258,12,'','termunicip','BetÃ©itiva','',0),(259,12,'','termunicip','Boavita','',0),(260,12,'','termunicip','Boyacá¡','',0),(261,12,'','termunicip','Briceño','',0),(262,12,'','termunicip','Buenavista','',0),(263,12,'','termunicip','Busbanzá','',0),(264,12,'','termunicip','Caldas','',0),(265,12,'','termunicip','Campo hermoso','',0),(266,12,'','termunicip','Cerinza','',0),(267,12,'','termunicip','Chinavita','',0),(268,12,'','termunicip','Chiquinquirá','',0),(269,12,'','termunicip','Chá­quiza','',0),(270,12,'','termunicip','Chiscas','',0),(271,12,'','termunicip','Chita','',0),(272,12,'','termunicip','Chitaraque','',0),(273,12,'','termunicip','Chivatá','',0),(274,12,'','termunicip','Ciénega','',0),(275,12,'','termunicip','Cómbita','',0),(276,12,'','termunicip','Coper','',0),(277,12,'','termunicip','Corrales','',0),(278,12,'','termunicip','CovarachÃ­a','',0),(279,12,'','termunicip','Cubara','',0),(280,12,'','termunicip','Cucaita','',0),(281,12,'','termunicip','Cuitiva','',0),(282,12,'','termunicip','Duitama','',0),(283,12,'','termunicip','El cocuy','',0),(284,12,'','termunicip','El espino','',0),(285,12,'','termunicip','Firavitoba','',0),(286,12,'','termunicip','Floresta','',0),(287,12,'','termunicip','Gachantivá','',0),(288,12,'','termunicip','GÃ¡meza','',0),(289,12,'','termunicip','Garagoa','',0),(290,12,'','termunicip','Guacamayas','',0),(291,12,'','termunicip','GÃ¼icÃ¡n','',0),(292,12,'','termunicip','Iza','',0),(293,12,'','termunicip','Jenesano','',0),(294,12,'','termunicip','Jericó','',0),(295,12,'','termunicip','La uvita','',0),(296,12,'','termunicip','La victoria','',0),(297,12,'','termunicip','Labranza grande','',0),(298,12,'','termunicip','Macanal','',0),(299,12,'','termunicip','MaripÃ­','',0),(300,12,'','termunicip','Miraflores','',0),(301,12,'','termunicip','Mongua','',0),(302,12,'','termunicip','MonguÃ­','',0),(303,12,'','termunicip','MoniquirÃ¡','',0),(304,12,'','termunicip','Motavita','',0),(305,12,'','termunicip','Muzo','',0),(306,12,'','termunicip','Nobsa','',0),(307,12,'','termunicip','Nuevo colÃ³n','',0),(308,12,'','termunicip','OicatÃ¡','',0),(309,12,'','termunicip','Otanche','',0),(310,12,'','termunicip','Pachavita','',0),(311,12,'','termunicip','PÃ¡ez','',0),(312,12,'','termunicip','Paipa','',0),(313,12,'','termunicip','Pajarito','',0),(314,12,'','termunicip','Panqueba','',0),(315,12,'','termunicip','Pauna','',0),(316,12,'','termunicip','Paya','',0),(317,12,'','termunicip','Paz de rÃ­o','',0),(318,12,'','termunicip','Pesca','',0),(319,12,'','termunicip','Pisba','',0),(320,12,'','termunicip','Puerto boyaca','',0),(321,12,'','termunicip','QuÃ­pama','',0),(322,12,'','termunicip','RamiriquÃ­','',0),(323,12,'','termunicip','RÃ¡quira','',0),(324,12,'','termunicip','RondÃ³n','',0),(325,12,'','termunicip','SaboyÃ¡','',0),(326,12,'','termunicip','SÃ¡chica','',0),(327,12,'','termunicip','SamacÃ¡','',0),(328,12,'','termunicip','San eduardo','',0),(329,12,'','termunicip','San josÃ© de pare','',0),(330,12,'','termunicip','San luÃ­s de gaceno','',0),(331,12,'','termunicip','San mateo','',0),(332,12,'','termunicip','San miguel de sema','',0),(333,12,'','termunicip','San pablo de borbur','',0),(334,12,'','termunicip','Santa marÃ­a','',0),(335,12,'','termunicip','Santa rosa de viterbo','',0),(336,12,'','termunicip','Santa sofÃ­a','',0),(337,12,'','termunicip','Santana','',0),(338,12,'','termunicip','Sativanorte','',0),(339,12,'','termunicip','Sativasur','',0),(340,12,'','termunicip','Siachoque','',0),(341,12,'','termunicip','SoatÃ¡','',0),(342,12,'','termunicip','Socha','',0),(343,12,'','termunicip','SocotÃ¡','',0),(344,12,'','termunicip','Sogamoso','',0),(345,12,'','termunicip','Sora','',0),(346,12,'','termunicip','SoracÃ¡','',0),(347,12,'','termunicip','SotaquirÃ¡','',0),(348,12,'','termunicip','SusacÃ³n','',0),(349,12,'','termunicip','SutarmachÃ¡n','',0),(350,12,'','termunicip','Tasco','',0),(351,12,'','termunicip','TibanÃ¡','',0),(352,12,'','termunicip','Tibasosa','',0),(353,12,'','termunicip','TinjacÃ¡','',0),(354,12,'','termunicip','Tipacoque','',0),(355,12,'','termunicip','Toca','',0),(356,12,'','termunicip','TogÃ¼Ã­','',0),(357,12,'','termunicip','TÃ³paga','',0),(358,12,'','termunicip','Tota','',0),(359,12,'','termunicip','Tunja','',0),(360,12,'','termunicip','TununguÃ¡','',0),(361,12,'','termunicip','TurmequÃ©','',0),(362,12,'','termunicip','Tuta','',0),(363,12,'','termunicip','TutazÃ¡','',0),(364,12,'','termunicip','Umbita','',0),(365,12,'','termunicip','Venta quemada','',0),(366,12,'','termunicip','Villa de leyva','',0),(367,12,'','termunicip','ViracachÃ¡','',0),(368,12,'','termunicip','Zetaquira','',0),(369,13,'','termunicip','Aguadas','',0),(370,13,'','termunicip','Anserma','',0),(371,13,'','termunicip','Aranzazu','',0),(372,13,'','termunicip','Belalcazar','',0),(373,13,'','termunicip','ChinchinÃ¡','',0),(374,13,'','termunicip','Filadelfia','',0),(375,13,'','termunicip','La dorada','',0),(376,13,'','termunicip','La merced','',0),(377,13,'','termunicip','Manizales','',0),(378,13,'','termunicip','Manzanares','',0),(379,13,'','termunicip','Marmato','',0),(380,13,'','termunicip','Marquetalia','',0),(381,13,'','termunicip','Marulanda','',0),(382,13,'','termunicip','Neira','',0),(383,13,'','termunicip','Norcasia','',0),(384,13,'','termunicip','Pacora','',0),(385,13,'','termunicip','Palestina','',0),(386,13,'','termunicip','Pensilvania','',0),(387,13,'','termunicip','Riosucio','',0),(388,13,'','termunicip','Risaralda','',0),(389,13,'','termunicip','Salamina','',0),(390,13,'','termunicip','Samana','',0),(391,13,'','termunicip','San jose','',0),(392,13,'','termunicip','SupÃ­a','',0),(393,13,'','termunicip','Victoria','',0),(394,13,'','termunicip','VillamarÃ­a','',0),(395,13,'','termunicip','Viterbo','',0),(396,14,'','termunicip','Albania','',0),(397,14,'','termunicip','BelÃ©n andaquies','',0),(398,14,'','termunicip','Cartagena del chaira','',0),(399,14,'','termunicip','Curillo','',0),(400,14,'','termunicip','El doncello','',0),(401,14,'','termunicip','El paujil','',0),(402,14,'','termunicip','Florencia','',0),(403,14,'','termunicip','La montaÃ±ita','',0),(404,14,'','termunicip','MilÃ¡n','',0),(405,14,'','termunicip','Morelia','',0),(406,14,'','termunicip','Puerto rico','',0),(407,14,'','termunicip','San  vicente del caguan','',0),(408,14,'','termunicip','San josÃ© de fragua','',0),(409,14,'','termunicip','Solano','',0),(410,14,'','termunicip','Solita','',0),(411,14,'','termunicip','ValparaÃ­so','',0),(412,15,'','termunicip','Aguazul','',0),(413,15,'','termunicip','Chameza','',0),(414,15,'','termunicip','Hato corozal','',0),(415,15,'','termunicip','La salina','',0),(416,15,'','termunicip','ManÃ­','',0),(417,15,'','termunicip','Monterrey','',0),(418,15,'','termunicip','Nunchia','',0),(419,15,'','termunicip','Orocue','',0),(420,15,'','termunicip','Paz de ariporo','',0),(421,15,'','termunicip','Pore','',0),(422,15,'','termunicip','Recetor','',0),(423,15,'','termunicip','Sabana larga','',0),(424,15,'','termunicip','Sacama','',0),(425,15,'','termunicip','San luis de palenque','',0),(426,15,'','termunicip','Tamara','',0),(427,15,'','termunicip','Tauramena','',0),(428,15,'','termunicip','Trinidad','',0),(429,15,'','termunicip','Villanueva','',0),(430,15,'','termunicip','Yopal','',0),(431,16,'','termunicip','Almaguer','',0),(432,16,'','termunicip','Argelia','',0),(433,16,'','termunicip','Balboa','',0),(434,16,'','termunicip','BolÃ­var','',0),(435,16,'','termunicip','Buenos aires','',0),(436,16,'','termunicip','Cajibio','',0),(437,16,'','termunicip','Caldono','',0),(438,16,'','termunicip','Caloto','',0),(439,16,'','termunicip','Corinto','',0),(440,16,'','termunicip','El tambo','',0),(441,16,'','termunicip','Florencia','',0),(442,16,'','termunicip','Guapi','',0),(443,16,'','termunicip','Inza','',0),(444,16,'','termunicip','JambalÃ³','',0),(445,16,'','termunicip','La sierra','',0),(446,16,'','termunicip','La vega','',0),(447,16,'','termunicip','LÃ³pez','',0),(448,16,'','termunicip','Mercaderes','',0),(449,16,'','termunicip','Miranda','',0),(450,16,'','termunicip','Morales','',0),(451,16,'','termunicip','Padilla','',0),(452,16,'','termunicip','PÃ¡ez','',0),(453,16,'','termunicip','Patia (el bordo)','',0),(454,16,'','termunicip','Piamonte','',0),(455,16,'','termunicip','Piendamo','',0),(456,16,'','termunicip','PopayÃ¡n','',0),(457,16,'','termunicip','Puerto tejada','',0),(458,16,'','termunicip','Purace','',0),(459,16,'','termunicip','Rosas','',0),(460,16,'','termunicip','San sebastiÃ¡n','',0),(461,16,'','termunicip','Santa rosa','',0),(462,16,'','termunicip','Santander de quilichao','',0),(463,16,'','termunicip','Silvia','',0),(464,16,'','termunicip','Sotara','',0),(465,16,'','termunicip','SuÃ¡rez','',0),(466,16,'','termunicip','Sucre','',0),(467,16,'','termunicip','TimbÃ­o','',0),(468,16,'','termunicip','TimbiquÃ­','',0),(469,16,'','termunicip','Toribio','',0),(470,16,'','termunicip','Totoro','',0),(471,16,'','termunicip','Villa rica','',0),(472,17,'','termunicip','Aguachica','',0),(473,17,'','termunicip','AgustÃ­n codazzi','',0),(474,17,'','termunicip','Astrea','',0),(475,17,'','termunicip','Becerril','',0),(476,17,'','termunicip','Bosconia','',0),(477,17,'','termunicip','Chimichagua','',0),(478,17,'','termunicip','ChiriguanÃ¡','',0),(479,17,'','termunicip','CurumanÃ­','',0),(480,17,'','termunicip','El copey','',0),(481,17,'','termunicip','El paso','',0),(482,17,'','termunicip','Gamarra','',0),(483,17,'','termunicip','GonzÃ¡lez','',0),(484,17,'','termunicip','La gloria','',0),(485,17,'','termunicip','La jagua ibirico','',0),(486,17,'','termunicip','Manaure balcÃ³n del cesar','',0),(487,17,'','termunicip','Pailitas','',0),(488,17,'','termunicip','Pelaya','',0),(489,17,'','termunicip','Pueblo bello','',0),(490,17,'','termunicip','RÃ­o de oro','',0),(491,17,'','termunicip','Robles (la paz)','',0),(492,17,'','termunicip','San alberto','',0),(493,17,'','termunicip','San diego','',0),(494,17,'','termunicip','San martÃ­n','',0),(495,17,'','termunicip','Tamalameque','',0),(496,17,'','termunicip','Valledupar','',0),(497,18,'','termunicip','Acandi','',0),(498,18,'','termunicip','Alto baudo (pie de pato)','',0),(499,18,'','termunicip','Atrato','',0),(500,18,'','termunicip','Bagado','',0),(501,18,'','termunicip','Bahia solano (mutis)','',0),(502,18,'','termunicip','Bajo baudo (pizarro)','',0),(503,18,'','termunicip','Bojaya (bellavista)','',0),(504,18,'','termunicip','Canton de san pablo','',0),(505,18,'','termunicip','Carmen del darien','',0),(506,18,'','termunicip','Certegui','',0),(507,18,'','termunicip','Condoto','',0),(508,18,'','termunicip','El carmen','',0),(509,18,'','termunicip','Istmina','',0),(510,18,'','termunicip','Jurado','',0),(511,18,'','termunicip','Litoral del san juan','',0),(512,18,'','termunicip','Lloro','',0),(513,18,'','termunicip','Medio atrato','',0),(514,18,'','termunicip','Medio baudo (boca de pepe)','',0),(515,18,'','termunicip','Medio san juan','',0),(516,18,'','termunicip','Novita','',0),(517,18,'','termunicip','Nuqui','',0),(518,18,'','termunicip','Quibdo','',0),(519,18,'','termunicip','Rio iro','',0),(520,18,'','termunicip','Rio quito','',0),(521,18,'','termunicip','Riosucio','',0),(522,18,'','termunicip','San jose del palmar','',0),(523,18,'','termunicip','Sipi','',0),(524,18,'','termunicip','Tado','',0),(525,18,'','termunicip','Unguia','',0),(526,18,'','termunicip','UniÃ³n panamericana','',0),(527,19,'','termunicip','Ayapel','',0),(528,19,'','termunicip','Buenavista','',0),(529,19,'','termunicip','Canalete','',0),(530,19,'','termunicip','CeretÃ©','',0),(531,19,'','termunicip','Chima','',0),(532,19,'','termunicip','ChinÃº','',0),(533,19,'','termunicip','Cienaga de oro','',0),(534,19,'','termunicip','Cotorra','',0),(535,19,'','termunicip','La apartada','',0),(536,19,'','termunicip','Lorica','',0),(537,19,'','termunicip','Los cÃ³rdobas','',0),(538,19,'','termunicip','Momil','',0),(539,19,'','termunicip','MontelÃ­bano','',0),(540,19,'','termunicip','MonterÃ­a','',0),(541,19,'','termunicip','MoÃ±itos','',0),(542,19,'','termunicip','Planeta rica','',0),(543,19,'','termunicip','Pueblo nuevo','',0),(544,19,'','termunicip','Puerto escondido','',0),(545,19,'','termunicip','Puerto libertador','',0),(546,19,'','termunicip','PurÃ­sima','',0),(547,19,'','termunicip','SahagÃºn','',0),(548,19,'','termunicip','San andrÃ©s sotavento','',0),(549,19,'','termunicip','San antero','',0),(550,19,'','termunicip','San bernardo viento','',0),(551,19,'','termunicip','San carlos','',0),(552,19,'','termunicip','San pelayo','',0),(553,19,'','termunicip','Tierralta','',0),(554,19,'','termunicip','Valencia','',0),(555,20,'','termunicip','Agua de dios','',0),(556,20,'','termunicip','Alban','',0),(557,20,'','termunicip','Anapoima','',0),(558,20,'','termunicip','Anolaima','',0),(559,20,'','termunicip','Arbelaez','',0),(560,20,'','termunicip','BeltrÃ¡n','',0),(561,20,'','termunicip','Bituima','',0),(562,20,'','termunicip','BogotÃ¡ dc','',0),(563,20,'','termunicip','BojacÃ¡','',0),(564,20,'','termunicip','Cabrera','',0),(565,20,'','termunicip','Cachipay','',0),(566,20,'','termunicip','CajicÃ¡','',0),(567,20,'','termunicip','CaparrapÃ­','',0),(568,20,'','termunicip','Caqueza','',0),(569,20,'','termunicip','Carmen de carupa','',0),(570,20,'','termunicip','ChaguanÃ­','',0),(571,20,'','termunicip','Chia','',0),(572,20,'','termunicip','Chipaque','',0),(573,20,'','termunicip','ChoachÃ­','',0),(574,20,'','termunicip','ChocontÃ¡','',0),(575,20,'','termunicip','Cogua','',0),(576,20,'','termunicip','Cota','',0),(577,20,'','termunicip','CucunubÃ¡','',0),(578,20,'','termunicip','El colegio','',0),(579,20,'','termunicip','El peÃ±Ã³n','',0),(580,20,'','termunicip','El rosal1','',0),(581,20,'','termunicip','Facatativa','',0),(582,20,'','termunicip','FÃ³meque','',0),(583,20,'','termunicip','Fosca','',0),(584,20,'','termunicip','Funza','',0),(585,20,'','termunicip','FÃºquene','',0),(586,20,'','termunicip','Fusagasuga','',0),(587,20,'','termunicip','GachalÃ¡','',0),(588,20,'','termunicip','GachancipÃ¡','',0),(589,20,'','termunicip','Gacheta','',0),(590,20,'','termunicip','Gama','',0),(591,20,'','termunicip','Girardot','',0),(592,20,'','termunicip','Granada2','',0),(593,20,'','termunicip','GuachetÃ¡','',0),(594,20,'','termunicip','Guaduas','',0),(595,20,'','termunicip','Guasca','',0),(596,20,'','termunicip','GuataquÃ­','',0),(597,20,'','termunicip','Guatavita','',0),(598,20,'','termunicip','Guayabal de siquima','',0),(599,20,'','termunicip','Guayabetal','',0),(600,20,'','termunicip','GutiÃ©rrez','',0),(601,20,'','termunicip','JerusalÃ©n','',0),(602,20,'','termunicip','JunÃ­n','',0),(603,20,'','termunicip','La calera','',0),(604,20,'','termunicip','La mesa','',0),(605,20,'','termunicip','La palma','',0),(606,20,'','termunicip','La peÃ±a','',0),(607,20,'','termunicip','La vega','',0),(608,20,'','termunicip','Lenguazaque','',0),(609,20,'','termunicip','MachetÃ¡','',0),(610,20,'','termunicip','Madrid','',0),(611,20,'','termunicip','Manta','',0),(612,20,'','termunicip','Medina','',0),(613,20,'','termunicip','Mosquera','',0),(614,20,'','termunicip','NariÃ±o','',0),(615,20,'','termunicip','NemocÃ³n','',0),(616,20,'','termunicip','Nilo','',0),(617,20,'','termunicip','Nimaima','',0),(618,20,'','termunicip','Nocaima','',0),(619,20,'','termunicip','Ospina pÃ©rez','',0),(620,20,'','termunicip','Pacho','',0),(621,20,'','termunicip','Paime','',0),(622,20,'','termunicip','Pandi','',0),(623,20,'','termunicip','Paratebueno','',0),(624,20,'','termunicip','Pasca','',0),(625,20,'','termunicip','Puerto salgar','',0),(626,20,'','termunicip','PulÃ­','',0),(627,20,'','termunicip','Quebradanegra','',0),(628,20,'','termunicip','Quetame','',0),(629,20,'','termunicip','Quipile','',0),(630,20,'','termunicip','Rafael reyes','',0),(631,20,'','termunicip','Ricaurte','',0),(632,20,'','termunicip','San  antonio del  tequendama','',0),(633,20,'','termunicip','San bernardo','',0),(634,20,'','termunicip','San cayetano','',0),(635,20,'','termunicip','San francisco','',0),(636,20,'','termunicip','San juan de rioseco','',0),(637,20,'','termunicip','Sasaima','',0),(638,20,'','termunicip','SesquilÃ©','',0),(639,20,'','termunicip','SibatÃ©','',0),(640,20,'','termunicip','Silvania','',0),(641,20,'','termunicip','Simijaca','',0),(642,20,'','termunicip','Soacha','',0),(643,20,'','termunicip','Sopo','',0),(644,20,'','termunicip','Subachoque','',0),(645,20,'','termunicip','Suesca','',0),(646,20,'','termunicip','SupatÃ¡','',0),(647,20,'','termunicip','Susa','',0),(648,20,'','termunicip','Sutatausa','',0),(649,20,'','termunicip','Tabio','',0),(650,20,'','termunicip','Tausa','',0),(651,20,'','termunicip','Tena','',0),(652,20,'','termunicip','Tenjo','',0),(653,20,'','termunicip','Tibacuy','',0),(654,20,'','termunicip','Tibirita','',0),(655,20,'','termunicip','Tocaima','',0),(656,20,'','termunicip','TocancipÃ¡','',0),(657,20,'','termunicip','TopaipÃ­','',0),(658,20,'','termunicip','UbalÃ¡','',0),(659,20,'','termunicip','Ubaque','',0),(660,20,'','termunicip','UbatÃ©','',0),(661,20,'','termunicip','Une','',0),(662,20,'','termunicip','Utica','',0),(663,20,'','termunicip','Vergara','',0),(664,20,'','termunicip','Viani','',0),(665,20,'','termunicip','Villa gomez','',0),(666,20,'','termunicip','Villa pinzÃ³n','',0),(667,20,'','termunicip','Villeta','',0),(668,20,'','termunicip','Viota','',0),(669,20,'','termunicip','YacopÃ­','',0),(670,20,'','termunicip','ZipacÃ³n','',0),(671,20,'','termunicip','ZipaquirÃ¡','',0),(672,21,'','termunicip','Barranco minas','',0),(673,21,'','termunicip','Cacahual','',0),(674,21,'','termunicip','InÃ­rida','',0),(675,21,'','termunicip','La guadalupe','',0),(676,21,'','termunicip','Mapiripana','',0),(677,21,'','termunicip','Morichal','',0),(678,21,'','termunicip','Pana pana','',0),(679,21,'','termunicip','Puerto colombia','',0),(680,21,'','termunicip','San felipe','',0),(681,22,'','termunicip','Calamar','',0),(682,22,'','termunicip','El retorno','',0),(683,22,'','termunicip','Miraflorez','',0),(684,22,'','termunicip','San josÃ© del guaviare','',0),(685,23,'','termunicip','Acevedo','',0),(686,23,'','termunicip','Agrado','',0),(687,23,'','termunicip','Aipe','',0),(688,23,'','termunicip','Algeciras','',0),(689,23,'','termunicip','Altamira','',0),(690,23,'','termunicip','Baraya','',0),(691,23,'','termunicip','Campo alegre','',0),(692,23,'','termunicip','Colombia','',0),(693,23,'','termunicip','Elias','',0),(694,23,'','termunicip','GarzÃ³n','',0),(695,23,'','termunicip','Gigante','',0),(696,23,'','termunicip','Guadalupe','',0),(697,23,'','termunicip','Hobo','',0),(698,23,'','termunicip','Iquira','',0),(699,23,'','termunicip','Isnos','',0),(700,23,'','termunicip','La argentina','',0),(701,23,'','termunicip','La plata','',0),(702,23,'','termunicip','Nataga','',0),(703,23,'','termunicip','Neiva','',0),(704,23,'','termunicip','Oporapa','',0),(705,23,'','termunicip','Paicol','',0),(706,23,'','termunicip','Palermo','',0),(707,23,'','termunicip','Palestina','',0),(708,23,'','termunicip','Pital','',0),(709,23,'','termunicip','Pitalito','',0),(710,23,'','termunicip','Rivera','',0),(711,23,'','termunicip','Salado blanco','',0),(712,23,'','termunicip','San agustÃ­n','',0),(713,23,'','termunicip','Santa maria','',0),(714,23,'','termunicip','Suaza','',0),(715,23,'','termunicip','Tarqui','',0),(716,23,'','termunicip','Tello','',0),(717,23,'','termunicip','Teruel','',0),(718,23,'','termunicip','Tesalia','',0),(719,23,'','termunicip','Timana','',0),(720,23,'','termunicip','Villavieja','',0),(721,23,'','termunicip','Yaguara','',0),(722,24,'','termunicip','Albania','',0),(723,24,'','termunicip','Barrancas','',0),(724,24,'','termunicip','Dibulla','',0),(725,24,'','termunicip','DistracciÃ³n','',0),(726,24,'','termunicip','El molino','',0),(727,24,'','termunicip','Fonseca','',0),(728,24,'','termunicip','Hato nuevo','',0),(729,24,'','termunicip','La jagua del pilar','',0),(730,24,'','termunicip','Maicao','',0),(731,24,'','termunicip','Manaure','',0),(732,24,'','termunicip','Riohacha','',0),(733,24,'','termunicip','San juan del cesar','',0),(734,24,'','termunicip','Uribia','',0),(735,24,'','termunicip','Urumita','',0),(736,24,'','termunicip','Villanueva','',0),(737,25,'','termunicip','Algarrobo','',0),(738,25,'','termunicip','Aracataca','',0),(739,25,'','termunicip','Ariguani','',0),(740,25,'','termunicip','Cerro san antonio','',0),(741,25,'','termunicip','Chivolo','',0),(742,25,'','termunicip','Cienaga','',0),(743,25,'','termunicip','Concordia','',0),(744,25,'','termunicip','El banco','',0),(745,25,'','termunicip','El piÃ±on','',0),(746,25,'','termunicip','El reten','',0),(747,25,'','termunicip','Fundacion','',0),(748,25,'','termunicip','Guamal','',0),(749,25,'','termunicip','Nueva granada','',0),(750,25,'','termunicip','Pedraza','',0),(751,25,'','termunicip','PijiÃ±o del carmen','',0),(752,25,'','termunicip','Pivijay','',0),(753,25,'','termunicip','Plato','',0),(754,25,'','termunicip','Pueblo viejo','',0),(755,25,'','termunicip','Remolino','',0),(756,25,'','termunicip','Sabanas de san angel','',0),(757,25,'','termunicip','Salamina','',0),(758,25,'','termunicip','San sebastian de buenavista','',0),(759,25,'','termunicip','San zenon','',0),(760,25,'','termunicip','Santa ana','',0),(761,25,'','termunicip','Santa barbara de pinto','',0),(762,25,'','termunicip','Santa marta','',0),(763,25,'','termunicip','Sitionuevo','',0),(764,25,'','termunicip','Tenerife','',0),(765,25,'','termunicip','Zapayan','',0),(766,25,'','termunicip','Zona bananera','',0),(767,26,'','termunicip','Acacias','',0),(768,26,'','termunicip','Barranca de upia','',0),(769,26,'','termunicip','Cabuyaro','',0),(770,26,'','termunicip','Castilla la nueva','',0),(771,26,'','termunicip','Cubarral','',0),(772,26,'','termunicip','Cumaral','',0),(773,26,'','termunicip','El calvario','',0),(774,26,'','termunicip','El castillo','',0),(775,26,'','termunicip','El dorado','',0),(776,26,'','termunicip','Fuente de oro','',0),(777,26,'','termunicip','Granada','',0),(778,26,'','termunicip','Guamal','',0),(779,26,'','termunicip','La macarena','',0),(780,26,'','termunicip','La uribe','',0),(781,26,'','termunicip','LejanÃ­as','',0),(782,26,'','termunicip','MapiripÃ¡n','',0),(783,26,'','termunicip','Mesetas','',0),(784,26,'','termunicip','Puerto concordia','',0),(785,26,'','termunicip','Puerto gaitÃ¡n','',0),(786,26,'','termunicip','Puerto lleras','',0),(787,26,'','termunicip','Puerto lÃ³pez','',0),(788,26,'','termunicip','Puerto rico','',0),(789,26,'','termunicip','Restrepo','',0),(790,26,'','termunicip','San  juan de arama','',0),(791,26,'','termunicip','San carlos guaroa','',0),(792,26,'','termunicip','San juanito','',0),(793,26,'','termunicip','San martÃ­n','',0),(794,26,'','termunicip','Villavicencio','',0),(795,26,'','termunicip','Vista hermosa','',0),(796,27,'','termunicip','Alban','',0),(797,27,'','termunicip','AldaÃ±a','',0),(798,27,'','termunicip','Ancuya','',0),(799,27,'','termunicip','Arboleda','',0),(800,27,'','termunicip','Barbacoas','',0),(801,27,'','termunicip','Belen','',0),(802,27,'','termunicip','Buesaco','',0),(803,27,'','termunicip','Chachagui','',0),(804,27,'','termunicip','Colon (genova)','',0),(805,27,'','termunicip','Consaca','',0),(806,27,'','termunicip','Contadero','',0),(807,27,'','termunicip','Cordoba','',0),(808,27,'','termunicip','Cuaspud','',0),(809,27,'','termunicip','Cumbal','',0),(810,27,'','termunicip','Cumbitara','',0),(811,27,'','termunicip','El charco','',0),(812,27,'','termunicip','El peÃ±ol','',0),(813,27,'','termunicip','El rosario','',0),(814,27,'','termunicip','El tablÃ³n','',0),(815,27,'','termunicip','El tambo','',0),(816,27,'','termunicip','Funes','',0),(817,27,'','termunicip','Guachucal','',0),(818,27,'','termunicip','Guaitarilla','',0),(819,27,'','termunicip','Gualmatan','',0),(820,27,'','termunicip','Iles','',0),(821,27,'','termunicip','Imues','',0),(822,27,'','termunicip','Ipiales','',0),(823,27,'','termunicip','La cruz','',0),(824,27,'','termunicip','La florida','',0),(825,27,'','termunicip','La llanada','',0),(826,27,'','termunicip','La tola','',0),(827,27,'','termunicip','La union','',0),(828,27,'','termunicip','Leiva','',0),(829,27,'','termunicip','Linares','',0),(830,27,'','termunicip','Los andes','',0),(831,27,'','termunicip','Magui','',0),(832,27,'','termunicip','Mallama','',0),(833,27,'','termunicip','Mosqueza','',0),(834,27,'','termunicip','NariÃ±o','',0),(835,27,'','termunicip','Olaya herrera','',0),(836,27,'','termunicip','Ospina','',0),(837,27,'','termunicip','Pasto','',0),(838,27,'','termunicip','Pizarro','',0),(839,27,'','termunicip','Policarpa','',0),(840,27,'','termunicip','Potosi','',0),(841,27,'','termunicip','Providencia','',0),(842,27,'','termunicip','Puerres','',0),(843,27,'','termunicip','Pupiales','',0),(844,27,'','termunicip','Ricaurte','',0),(845,27,'','termunicip','Roberto payan','',0),(846,27,'','termunicip','Samaniego','',0),(847,27,'','termunicip','San bernardo','',0),(848,27,'','termunicip','San lorenzo','',0),(849,27,'','termunicip','San pablo','',0),(850,27,'','termunicip','San pedro de cartago','',0),(851,27,'','termunicip','Sandona','',0),(852,27,'','termunicip','Santa barbara','',0),(853,27,'','termunicip','Santacruz','',0),(854,27,'','termunicip','Sapuyes','',0),(855,27,'','termunicip','Taminango','',0),(856,27,'','termunicip','Tangua','',0),(857,27,'','termunicip','Tumaco','',0),(858,27,'','termunicip','Tuquerres','',0),(859,27,'','termunicip','Yacuanquer','',0),(860,28,'','termunicip','Abrego','',0),(861,28,'','termunicip','Arboledas','',0),(862,28,'','termunicip','Bochalema','',0),(863,28,'','termunicip','Bucarasica','',0),(864,28,'','termunicip','CÃ¡chira','',0),(865,28,'','termunicip','CÃ¡cota','',0),(866,28,'','termunicip','ChinÃ¡cota','',0),(867,28,'','termunicip','ChitagÃ¡','',0),(868,28,'','termunicip','ConvenciÃ³n','',0),(869,28,'','termunicip','CÃºcuta','',0),(870,28,'','termunicip','Cucutilla','',0),(871,28,'','termunicip','Durania','',0),(872,28,'','termunicip','El carmen','',0),(873,28,'','termunicip','El tarra','',0),(874,28,'','termunicip','El zulia','',0),(875,28,'','termunicip','Gramalote','',0),(876,28,'','termunicip','Hacari','',0),(877,28,'','termunicip','HerrÃ¡n','',0),(878,28,'','termunicip','La esperanza','',0),(879,28,'','termunicip','La playa','',0),(880,28,'','termunicip','Labateca','',0),(881,28,'','termunicip','Los patios','',0),(882,28,'','termunicip','Lourdes','',0),(883,28,'','termunicip','Mutiscua','',0),(884,28,'','termunicip','OcaÃ±a','',0),(885,28,'','termunicip','Pamplona','',0),(886,28,'','termunicip','Pamplonita','',0),(887,28,'','termunicip','Puerto santander','',0),(888,28,'','termunicip','Ragonvalia','',0),(889,28,'','termunicip','Salazar','',0),(890,28,'','termunicip','San calixto','',0),(891,28,'','termunicip','San cayetano','',0),(892,28,'','termunicip','Santiago','',0),(893,28,'','termunicip','Sardinata','',0),(894,28,'','termunicip','Silos','',0),(895,28,'','termunicip','Teorama','',0),(896,28,'','termunicip','TibÃº','',0),(897,28,'','termunicip','Toledo','',0),(898,28,'','termunicip','Villa caro','',0),(899,28,'','termunicip','Villa del rosario','',0),(900,29,'','termunicip','ColÃ³n','',0),(901,29,'','termunicip','Mocoa','',0),(902,29,'','termunicip','Orito','',0),(903,29,'','termunicip','Puerto asÃ­s','',0),(904,29,'','termunicip','Puerto caycedo','',0),(905,29,'','termunicip','Puerto guzmÃ¡n','',0),(906,29,'','termunicip','Puerto leguÃ­zamo','',0),(907,29,'','termunicip','San francisco','',0),(908,29,'','termunicip','San miguel','',0),(909,29,'','termunicip','Santiago','',0),(910,29,'','termunicip','Sibundoy','',0),(911,29,'','termunicip','Valle del guamuez','',0),(912,29,'','termunicip','VillagarzÃ³n','',0),(913,30,'','termunicip','Armenia','',0),(914,30,'','termunicip','Buenavista','',0),(915,30,'','termunicip','CalarcÃ¡','',0),(916,30,'','termunicip','Circasia','',0),(917,30,'','termunicip','CÃ³rdoba','',0),(918,30,'','termunicip','Filandia','',0),(919,30,'','termunicip','GÃ©nova','',0),(920,30,'','termunicip','La tebaida','',0),(921,30,'','termunicip','Montenegro','',0),(922,30,'','termunicip','Pijao','',0),(923,30,'','termunicip','Quimbaya','',0),(924,30,'','termunicip','Salento','',0),(925,31,'','termunicip','Apia','',0),(926,31,'','termunicip','Balboa','',0),(927,31,'','termunicip','BelÃ©n de umbrÃ­a','',0),(928,31,'','termunicip','Dos quebradas','',0),(929,31,'','termunicip','Guatica','',0),(930,31,'','termunicip','La celia','',0),(931,31,'','termunicip','La virginia','',0),(932,31,'','termunicip','Marsella','',0),(933,31,'','termunicip','Mistrato','',0),(934,31,'','termunicip','Pereira','',0),(935,31,'','termunicip','Pueblo rico','',0),(936,31,'','termunicip','QuinchÃ­a','',0),(937,31,'','termunicip','Santa rosa de cabal','',0),(938,31,'','termunicip','Santuario','',0),(939,32,'','termunicip','Providencia','',0),(940,32,'','termunicip','San andres','',0),(941,32,'','termunicip','Santa catalina','',0),(942,33,'','termunicip','Aguada','',0),(943,33,'','termunicip','Albania','',0),(944,33,'','termunicip','Aratoca','',0),(945,33,'','termunicip','Barbosa','',0),(946,33,'','termunicip','Barichara','',0),(947,33,'','termunicip','Barrancabermeja','',0),(948,33,'','termunicip','Betulia','',0),(949,33,'','termunicip','BolÃ­var','',0),(950,33,'','termunicip','Bucaramanga','',0),(951,33,'','termunicip','Cabrera','',0),(952,33,'','termunicip','California','',0),(953,33,'','termunicip','Capitanejo','',0),(954,33,'','termunicip','Carcasi','',0),(955,33,'','termunicip','Cepita','',0),(956,33,'','termunicip','Cerrito','',0),(957,33,'','termunicip','CharalÃ¡','',0),(958,33,'','termunicip','Charta','',0),(959,33,'','termunicip','Chima','',0),(960,33,'','termunicip','ChipatÃ¡','',0),(961,33,'','termunicip','Cimitarra','',0),(962,33,'','termunicip','ConcepciÃ³n','',0),(963,33,'','termunicip','Confines','',0),(964,33,'','termunicip','ContrataciÃ³n','',0),(965,33,'','termunicip','Coromoro','',0),(966,33,'','termunicip','CuritÃ­','',0),(967,33,'','termunicip','El carmen','',0),(968,33,'','termunicip','El guacamayo','',0),(969,33,'','termunicip','El peÃ±Ã³n','',0),(970,33,'','termunicip','El playÃ³n','',0),(971,33,'','termunicip','Encino','',0),(972,33,'','termunicip','Enciso','',0),(973,33,'','termunicip','FloriÃ¡n','',0),(974,33,'','termunicip','Floridablanca','',0),(975,33,'','termunicip','GalÃ¡n','',0),(976,33,'','termunicip','Gambita','',0),(977,33,'','termunicip','GirÃ³n','',0),(978,33,'','termunicip','Guaca','',0),(979,33,'','termunicip','Guadalupe','',0),(980,33,'','termunicip','Guapota','',0),(981,33,'','termunicip','GuavatÃ¡','',0),(982,33,'','termunicip','Guepsa','',0),(983,33,'','termunicip','Hato','',0),(984,33,'','termunicip','JesÃºs maria','',0),(985,33,'','termunicip','JordÃ¡n','',0),(986,33,'','termunicip','La belleza','',0),(987,33,'','termunicip','La paz','',0),(988,33,'','termunicip','Landazuri','',0),(989,33,'','termunicip','Lebrija','',0),(990,33,'','termunicip','Los santos','',0),(991,33,'','termunicip','Macaravita','',0),(992,33,'','termunicip','MÃ¡laga','',0),(993,33,'','termunicip','Matanza','',0),(994,33,'','termunicip','Mogotes','',0),(995,33,'','termunicip','Molagavita','',0),(996,33,'','termunicip','Ocamonte','',0),(997,33,'','termunicip','Oiba','',0),(998,33,'','termunicip','Onzaga','',0),(999,33,'','termunicip','Palmar','',0),(1000,33,'','termunicip','Palmas del socorro','',0),(1001,33,'','termunicip','PÃ¡ramo','',0),(1002,33,'','termunicip','Piedecuesta','',0),(1003,33,'','termunicip','Pinchote','',0),(1004,33,'','termunicip','Puente nacional','',0),(1005,33,'','termunicip','Puerto parra','',0),(1006,33,'','termunicip','Puerto wilches','',0),(1007,33,'','termunicip','Rionegro','',0),(1008,33,'','termunicip','Sabana de torres','',0),(1009,33,'','termunicip','San andrÃ©s','',0),(1010,33,'','termunicip','San benito','',0),(1011,33,'','termunicip','San gil','',0),(1012,33,'','termunicip','San joaquÃ­n','',0),(1013,33,'','termunicip','San josÃ© de miranda','',0),(1014,33,'','termunicip','San miguel','',0),(1015,33,'','termunicip','San vicente de chucurÃ­','',0),(1016,33,'','termunicip','Santa bÃ¡rbara','',0),(1017,33,'','termunicip','Santa helena','',0),(1018,33,'','termunicip','Simacota','',0),(1019,33,'','termunicip','Socorro','',0),(1020,33,'','termunicip','Suaita','',0),(1021,33,'','termunicip','Sucre','',0),(1022,33,'','termunicip','Surata','',0),(1023,33,'','termunicip','Tona','',0),(1024,33,'','termunicip','Valle san josÃ©','',0),(1025,33,'','termunicip','VÃ©lez','',0),(1026,33,'','termunicip','Vetas','',0),(1027,33,'','termunicip','Villanueva','',0),(1028,33,'','termunicip','Zapatoca','',0),(1029,34,'','termunicip','Buenavista','',0),(1030,34,'','termunicip','Caimito','',0),(1031,34,'','termunicip','ChalÃ¡n','',0),(1032,34,'','termunicip','Coloso','',0),(1033,34,'','termunicip','Corozal','',0),(1034,34,'','termunicip','El roble','',0),(1035,34,'','termunicip','Galeras','',0),(1036,34,'','termunicip','Guaranda','',0),(1037,34,'','termunicip','La uniÃ³n','',0),(1038,34,'','termunicip','Los palmitos','',0),(1039,34,'','termunicip','Majagual','',0),(1040,34,'','termunicip','Morroa','',0),(1041,34,'','termunicip','Ovejas','',0),(1042,34,'','termunicip','Palmito','',0),(1043,34,'','termunicip','Sampues','',0),(1044,34,'','termunicip','San benito abad','',0),(1045,34,'','termunicip','San juan de betulia','',0),(1046,34,'','termunicip','San marcos','',0),(1047,34,'','termunicip','San onofre','',0),(1048,34,'','termunicip','San pedro','',0),(1049,34,'','termunicip','SincÃ©','',0),(1050,34,'','termunicip','Sincelejo','',0),(1051,34,'','termunicip','Sucre','',0),(1052,34,'','termunicip','TolÃº','',0),(1053,34,'','termunicip','Toluviejo','',0),(1054,35,'','termunicip','Alpujarra','',0),(1055,35,'','termunicip','Alvarado','',0),(1056,35,'','termunicip','Ambalema','',0),(1057,35,'','termunicip','Anzoategui','',0),(1058,35,'','termunicip','Armero (guayabal)','',0),(1059,35,'','termunicip','Ataco','',0),(1060,35,'','termunicip','Cajamarca','',0),(1061,35,'','termunicip','Carmen de apicalÃ¡','',0),(1062,35,'','termunicip','Casabianca','',0),(1063,35,'','termunicip','Chaparral','',0),(1064,35,'','termunicip','Coello','',0),(1065,35,'','termunicip','Coyaima','',0),(1066,35,'','termunicip','Cunday','',0),(1067,35,'','termunicip','Dolores','',0),(1068,35,'','termunicip','Espinal','',0),(1069,35,'','termunicip','FalÃ¡n','',0),(1070,35,'','termunicip','Flandes','',0),(1071,35,'','termunicip','Fresno','',0),(1072,35,'','termunicip','Guamo','',0),(1073,35,'','termunicip','Herveo','',0),(1074,35,'','termunicip','Honda','',0),(1075,35,'','termunicip','IbaguÃ©','',0),(1076,35,'','termunicip','Icononzo','',0),(1077,35,'','termunicip','LÃ©rida','',0),(1078,35,'','termunicip','LÃ­bano','',0),(1079,35,'','termunicip','Mariquita','',0),(1080,35,'','termunicip','Melgar','',0),(1081,35,'','termunicip','Murillo','',0),(1082,35,'','termunicip','Natagaima','',0),(1083,35,'','termunicip','Ortega','',0),(1084,35,'','termunicip','Palocabildo','',0),(1085,35,'','termunicip','Piedras planadas','',0),(1086,35,'','termunicip','Prado','',0),(1087,35,'','termunicip','PurificaciÃ³n','',0),(1088,35,'','termunicip','Rioblanco','',0),(1089,35,'','termunicip','Roncesvalles','',0),(1090,35,'','termunicip','Rovira','',0),(1091,35,'','termunicip','SaldaÃ±a','',0),(1092,35,'','termunicip','San antonio','',0),(1093,35,'','termunicip','San luis','',0),(1094,35,'','termunicip','Santa isabel','',0),(1095,35,'','termunicip','SuÃ¡rez','',0),(1096,35,'','termunicip','Valle de san juan','',0),(1097,35,'','termunicip','Venadillo','',0),(1098,35,'','termunicip','Villahermosa','',0),(1099,35,'','termunicip','Villarrica','',0),(1100,36,'','termunicip','AlcalÃ¡','',0),(1101,36,'','termunicip','AndalucÃ­a','',0),(1102,36,'','termunicip','Anserma nuevo','',0),(1103,36,'','termunicip','Argelia','',0),(1104,36,'','termunicip','BolÃ­var','',0),(1105,36,'','termunicip','Buenaventura','',0),(1106,36,'','termunicip','Buga','',0),(1107,36,'','termunicip','Bugalagrande','',0),(1108,36,'','termunicip','Caicedonia','',0),(1109,36,'','termunicip','Cali','',0),(1110,36,'','termunicip','Calima (darien)','',0),(1111,36,'','termunicip','Candelaria','',0),(1112,36,'','termunicip','Cartago','',0),(1113,36,'','termunicip','Dagua','',0),(1114,36,'','termunicip','El aguila','',0),(1115,36,'','termunicip','El cairo','',0),(1116,36,'','termunicip','El cerrito','',0),(1117,36,'','termunicip','El dovio','',0),(1118,36,'','termunicip','Florida','',0),(1119,36,'','termunicip','Ginebra guacari','',0),(1120,36,'','termunicip','JamundÃ­','',0),(1121,36,'','termunicip','La cumbre','',0),(1122,36,'','termunicip','La uniÃ³n','',0),(1123,36,'','termunicip','La victoria','',0),(1124,36,'','termunicip','Obando','',0),(1125,36,'','termunicip','Palmira','',0),(1126,36,'','termunicip','Pradera','',0),(1127,36,'','termunicip','Restrepo','',0),(1128,36,'','termunicip','Rio frÃ­o','',0),(1129,36,'','termunicip','Roldanillo','',0),(1130,36,'','termunicip','San pedro','',0),(1131,36,'','termunicip','Sevilla','',0),(1132,36,'','termunicip','Toro','',0),(1133,36,'','termunicip','Trujillo','',0),(1134,36,'','termunicip','TulÃºa','',0),(1135,36,'','termunicip','Ulloa','',0),(1136,36,'','termunicip','Versalles','',0),(1137,36,'','termunicip','Vijes','',0),(1138,36,'','termunicip','Yotoco','',0),(1139,36,'','termunicip','Yumbo','',0),(1140,36,'','termunicip','Zarzal','',0),(1141,37,'','termunicip','CarurÃº','',0),(1142,37,'','termunicip','MitÃº','',0),(1143,37,'','termunicip','Pacoa','',0),(1144,37,'','termunicip','Papunaua','',0),(1145,37,'','termunicip','Taraira','',0),(1146,37,'','termunicip','YavaratÃ©','',0),(1147,38,'','termunicip','Cumaribo','',0),(1148,38,'','termunicip','La primavera','',0),(1149,38,'','termunicip','Puerto carreÃ±o','',0),(1150,38,'','termunicip','Santa rosalia','',0);

/*Table structure for table `usuario_sucursal` */

CREATE TABLE `usuario_sucursal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `empresa_id` bigint(20) NOT NULL,
  `estado_usuario_sucural` varchar(1) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK65A40711204E6CA` (`usuario_id`),
  KEY `FK65A4071612F24EA` (`empresa_id`),
  CONSTRAINT `FK65A40711204E6CA` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `FK65A4071612F24EA` FOREIGN KEY (`empresa_id`) REFERENCES `empresas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usuario_sucursal` */

/*Table structure for table `usuarios` */

CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `contrasena` varchar(100) DEFAULT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  `id_estado_usuario` varchar(10) DEFAULT NULL,
  `persona_id` bigint(20) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKA8973058C00AE0A` (`persona_id`),
  CONSTRAINT `FKA8973058C00AE0A` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `usuarios` */

insert  into `usuarios`(`id`,`contrasena`,`eliminado`,`id_estado_usuario`,`persona_id`,`usuario`) values (1,'202cb962ac59075b964b07152d234b70',0,'useractivo',1,'hpajaro');

/*Table structure for table `valor_parametros` */

CREATE TABLE `valor_parametros` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parametro_id` bigint(20) NOT NULL,
  `id_parametro` varchar(10) NOT NULL,
  `id_valor_parametro` varchar(10) NOT NULL,
  `valor` varchar(300) DEFAULT NULL,
  `orden` varchar(5) DEFAULT NULL,
  `estado_valor_parametro` varchar(1) NOT NULL,
  `eliminado` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_parametro` (`parametro_id`),
  CONSTRAINT `parametro_valorParametro` FOREIGN KEY (`parametro_id`) REFERENCES `parametros` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=latin1;

/*Data for the table `valor_parametros` */

insert  into `valor_parametros`(`id`,`parametro_id`,`id_parametro`,`id_valor_parametro`,`valor`,`orden`,`estado_valor_parametro`,`eliminado`) values (1,1,'eempresa','empactivo','Activo(a)',NULL,'A',0),(2,1,'eempresa','empinactiv','Inactivo(a)',NULL,'A',0),(3,1,'eempresa','empenproce','En Proceso',NULL,'A',0),(4,2,'tempresa','empproveed','Proveedor',NULL,'A',0),(5,2,'tempresa','empcliente','Cliente',NULL,'A',0),(6,3,'epersona','peractivo','Activa','1','A',0),(7,3,'epersona','perinactiv','Inactiva','2','A',0),(8,4,'tpersona','percontact','Contacto','1','A',0),(9,4,'tpersona','peremplead','Administrativo','0','A',0),(10,4,'tpersona','perconsult','Consultor',NULL,'A',0),(11,4,'tpersona','pervendedo','Vendedor',NULL,'A',0),(12,5,'tterritori','terpais','Pais','1','A',0),(13,5,'tterritori','terregion','Region','2','A',0),(14,5,'tterritori','terciudad','Ciudad','4','A',0),(15,5,'tterritori','terdpto','Dpto','3','A',0),(16,5,'tterritori','termunicip','Municipio','5','A',0),(17,2,'tempresa','empprospec','Prospecto',NULL,'A',0),(18,2,'tempresa','empsucursa','Sucursal Redsis',NULL,'A',0),(19,2,'tempresa','empbase','Base',NULL,'A',0),(20,6,'eprospecto','proenproce','En proceso',NULL,'A',0),(21,6,'eprospecto','proactivo','Activo',NULL,'A',0),(22,6,'eprospecto','proinactiv','Inactivo',NULL,'A',0),(23,7,'eposibilid','posactivo','Asignada','03','A',0),(24,7,'eposibilid','posdescali','Descalificada','04','A',0),(25,7,'eposibilid','posenproce','Sin Asignar','01','A',0),(26,8,'gentitulos','vt01','Lista de Prospectos',NULL,'A',0),(27,8,'gentitulos','vt02','Lista de Porspectos Borrados',NULL,'A',0),(28,9,'trazon','posnoparti','redsis No Participa','1','A',0),(29,9,'trazon','posleadnov','Lead No valido','2','A',0),(30,9,'trazon','posotraraz','Otra RazÃ³n','3','A',0),(31,7,'eposibilid','posoportun','Calificada','05','A',0),(32,10,'tposibilid','posoportsc','Oportunidad SC',NULL,'A',0),(33,1,'tposibilid','posoportca','Oportunidad',NULL,'A',0),(34,11,'genimport','vimpprospe','[   sheet:\'Hoja1\',starRow:2,   columnMap:[     \'A\':\'razonSocial\',     \'B\':\'direccion\',     \'C\':\'email\'     \'D\':\'telefonos\'     ]   ]',NULL,'A',0),(35,12,'tpoactmerc','posacmer01','Actividad 1',NULL,'A',0),(36,12,'tpoactmerc','posacmer02','Actividad 2',NULL,'A',0),(37,13,'tipocondic','poscondi01','Es Posible',NULL,'A',0),(38,13,'tipocondic','poscondi02','Comprometida',NULL,'A',0),(39,14,'etapasvent','posventa10','10%',NULL,'A',0),(40,14,'etapasvent','posventa25','25%',NULL,'A',0),(41,14,'etapasvent','posventa50','50%',NULL,'A',0),(42,14,'etapasvent','posventa75','75%',NULL,'A',0),(43,15,'sectores','empsecto01','Gobierno',NULL,'A',0),(44,15,'sectores','empsecto02','Salud',NULL,'A',0),(45,15,'sectores','empsecto03','Comercial',NULL,'A',0),(46,16,'lineas','prolinea01','Linea 1',NULL,'A',0),(47,16,'lineas','prolinea02','Linea 2',NULL,'A',0),(48,17,'sublineas','prosubli01','Sub Linea 1',NULL,'A',0),(49,17,'sublineas','prosubli02','Sub linea 2',NULL,'A',0),(50,18,'consecutiv','oportunida','0',NULL,'A',0),(51,7,'eposibilid','ganada','Ganada','12','A',0),(52,7,'eposibilid','perdida','Perdida','10','A',0),(53,19,'tpoperdida','poscompete','Por Competencia',NULL,'A',0),(54,19,'tpoperdida','posnopart','Redsis no participa',NULL,'A',0),(56,19,'tpoperdida','posduplica','Oportunidad duplicada',NULL,'A',0),(57,19,'tpoperdida','posnooport','No hay Oportunidad',NULL,'A',0),(58,14,'etapasvent','posvent100','100%',NULL,'A',0),(59,8,'gentitulos','oportunt01','Oportunidades',NULL,'A',0),(60,1,'gentitulos','oportunt02','Oportunidades Ganadas',NULL,'A',0),(61,8,'gentitulos','oportunt03','Oportunidades Perdidas',NULL,'A',0),(62,8,'gentitulos','oportunt04','Lista de Oportunidades Borradas',NULL,'A',0),(63,20,'estadoprod','prodactivo','Activo',NULL,'A',0),(64,20,'estadoprod','prodinacti','Inactivo',NULL,'A',0),(65,20,'estadogene','genactivo','Activo(a)',NULL,'A',0),(66,20,'estadogene','geninactiv','Inactivo(a)',NULL,'A',0),(67,22,'prodmarca','prodmarc01','IBM',NULL,'A',0),(68,22,'prodmarca','prodmarc02','HP',NULL,'A',0),(69,23,'tipoprod','prodtipo01','Hardware',NULL,'A',0),(70,23,'tipoprod','prodtipo02','Software',NULL,'A',0),(71,23,'tipoprod','prodtipo03','Consultoria',NULL,'A',0),(72,23,'tipoprod','prodtipo04','Soporte',NULL,'A',0),(73,8,'gentitulos','lineat01','Lineas de Producto',NULL,'A',0),(74,8,'gentitulos','lineat02','LÃ­neas de Productos Borradas',NULL,'A',0),(75,1,'gentitulos','sublinet01','Sub LÃ­neas de Productos',NULL,'A',0),(76,8,'gentitulos','sublinet02','Sub LÃ­neas de Productos Borradas',NULL,'A',0),(77,8,'gentitulos','empresat01','Nuevo Prospecto',NULL,'A',0),(78,8,'gentitulos','empresat02','EdiciÃ³n Prospecto',NULL,'A',0),(79,8,'gentitulos','empresat03','Vista Prospecto',NULL,'A',0),(80,8,'gentitulos','empresat04','Lista de Prospectos Borrados',NULL,'A',0),(81,8,'gentitulos','empresat05','Lista de Clientes',NULL,'A',0),(82,8,'gentitulos','empresat06','Nuevo  Cliente',NULL,'A',0),(83,8,'gentitulos','empresat00','Lista de Prospectos',NULL,'A',0),(84,8,'gentitulos','empresat07','EdiciÃ³n Cliente',NULL,'A',0),(85,8,'gentitulos','empresat08','Vista Cliente',NULL,'A',0),(86,8,'gentitulos','empresat09','Lista de Clientes Borrados',NULL,'A',0),(87,8,'gentitulos','sedest00','Lista de  Sedes',NULL,'A',0),(88,8,'gentitulos','sedest01','Nueva Sede',NULL,'A',0),(89,8,'gentitulos','sedest02','EdiciÃ³n de Sede',NULL,'A',0),(90,8,'gentitulos','sedest03','Vista de Sede',NULL,'A',0),(91,8,'gentitulos','sedest04','Sedes Borradas',NULL,'A',0),(92,24,'formadpago','pedfpago01','De Contado',NULL,'A',0),(93,24,'formadpago','pedfpago02','30 dias',NULL,'A',0),(94,24,'formadpago','pedfpago03','60 dias',NULL,'A',0),(95,25,'tipoprecio','pedtprec01','En Pesos',NULL,'A',0),(96,25,'tipoprecio','pedtprec02','En DÃ³lares',NULL,'A',0),(97,26,'tipomoneda','pedtmone01','Pesos',NULL,'A',0),(98,26,'tipomoneda','pedtmone02','DÃ³lares',NULL,'A',0),(99,27,'arquitecto','pedarqui01','Jose Hugo Torres',NULL,'A',0),(100,27,'arquitecto','pedarqui02','Hernan Pajaro',NULL,'A',0),(101,27,'arquitecto','pedarqui03','Alexander Rosales',NULL,'A',0),(102,28,'estapedido','pedestad01','En Borrador',NULL,'A',0),(103,28,'estapedido','pedestad02','En ElaboraciÃ³n',NULL,'A',0),(104,28,'estapedido','pedestad03','En RevisiÃ³n',NULL,'A',0),(105,28,'estapedido','pedestad04','Pendiente x Facturar',NULL,'A',0),(106,28,'estapedido','pedestad05','Facturado Parcialmete',NULL,'A',0),(107,28,'estapedido','pedestad06','Facturado',NULL,'A',0),(108,28,'estapedido','pedestad07','Anulado',NULL,'A',0),(109,29,'disponiibm','peddispo01','En Stock',NULL,'A',0),(110,29,'disponiibm','peddispo02','En Planta',NULL,'A',0),(111,29,'disponiibm','peddispo03','Pre Cargado',NULL,'A',0),(112,30,'procespara','pedprosp01','Mayorista',NULL,'A',0),(113,30,'procespara','pedprosp02','Cableado',NULL,'A',0),(114,31,'estadetped','peddetpd01','En Proceso',NULL,'A',0),(115,31,'estadetped','peddetpd02','Procesado',NULL,'A',0),(116,32,'tipoanexos','anexo01','Tabla de Costos','1','A',0),(117,32,'tipoanexos','anexo02','Orde de Compra Cliente','3','A',0),(118,32,'tipoanexos','anexo03','Propuesta aprobada x Cliente','5','A',0),(119,32,'tipoanexos','anexo04','Cotizaciones de producto','9','A',0),(120,32,'tipoanexos','anexo05','AprobaciÃ³n Nexsys','11','A',0),(121,32,'tipoanexos','anexo06','Archivos .cfr y .txt','13','A',0),(122,32,'tipoanexos','anexo07','Aprobacion BID','15','A',0),(123,32,'tipoanexos','anexo08','Propuesta Servicios IBM','17','A',0),(124,32,'tipoanexos','anexo09','Inf. Cliente Nuevo',NULL,'A',0),(125,32,'tipoanexos','anexo10','Otros',NULL,'A',0),(126,33,'rutasanexo','ruta00','/crm/Archivos/',NULL,'A',0),(127,18,'rutasanexo','ruta01','/Archivos/',NULL,'A',0),(128,15,'sectores','empsecto04','Servicio',NULL,'A',0),(129,15,'sectores','empsecto05','Industrial',NULL,'A',0),(130,15,'sectores','empsecto06','Educativo',NULL,'A',0),(131,15,'sectores','empsecto07','Financiero',NULL,'A',0),(132,15,'sectores','empsecto08','Turismo',NULL,'A',0),(133,13,'tipocondic','poscondi03','Solo Payline',NULL,'A',0),(134,7,'eposibilid','poscotizad','Cotizada','07','A',0),(135,7,'eposibilid','posaprover','AprobaciÃ³n Verbal','09','A',0),(136,7,'eposibilid','posordenco','Orden de Compra','11','A',0),(137,8,'gentitulos','anexot01','Nuevo Anexo',NULL,'A',0),(138,34,'filtros','oportunid1','[filtro:[idTipoPsibilidad:\'\',eliminado:0,],exepto:[filter.op.idTipoPosibilidad,filter.op.idTipoPosibilidad,filter.idTipoPosibilidad]]',NULL,'A',0),(139,8,'gentitulos','empresat10','Nueva Empresa',NULL,'A',0),(140,8,'gentitulos','contactt00','Lista de Contactos',NULL,'A',0),(141,8,'gentitulos','contactt01','Lista de Contactos Borrados',NULL,'A',0),(142,8,'gentitulos','prodoprt01','Lista de  Items de la Oportunidad Borrados',NULL,'A',0),(143,8,'gentitulos','prodoprt00','Lista de Items de la Oportunidad',NULL,'A',0),(144,8,'gentitulos','anexot00','Lista de Anexos',NULL,'A',0),(145,8,'gentitulos','anexot05','Lista de Anexos Borrados',NULL,'A',0),(146,8,'gentitulos','actividt00','Lista de Actividades',NULL,'A',0),(147,8,'gentitulos','actividt05','Lista de Actividades Borradas',NULL,'A',0),(148,8,'tipoactivi','activida01','LLamada',NULL,'A',0),(149,8,'tipoactivi','activida02','Reunion',NULL,'A',0),(150,8,'tipoactivi','activida03','Correo',NULL,'A',0),(151,8,'tipoactivi','activida04','Visita',NULL,'A',0),(152,8,'tipoactivi','activida05','InvitaciÃ³n a Evento',NULL,'A',0),(153,8,'prioracti','actiprio01','CrÃ­tica',NULL,'A',0),(154,8,'prioracti','actiprio02','Alta',NULL,'A',0),(155,8,'prioracti','actiprio03','Media',NULL,'A',0),(156,8,'prioracti','actiprio05','Baja',NULL,'A',0),(157,8,'actiestado','actiesta01','Pendiente',NULL,'A',0),(158,8,'actiestado','actiesta02','Realizada',NULL,'A',0),(159,8,'actiestado','actiesta03','Anulada',NULL,'A',0),(160,8,'actiestado','actiesta04','Suspendida',NULL,'A',0),(161,8,'gentitulos','propuest01','Lista de Propuestas',NULL,'A',0),(162,18,'gentitulos','propuest05','Lista de Propuestas Borradas',NULL,'A',0),(163,8,'gentitulos','facturat01','Lista de Facturas',NULL,'A',0),(164,38,'actiavance','avance00','00%','02','A',0),(165,1,'actiavance','avance10','10%','04','A',0),(166,1,'actiavance','avance20','20%','06','A',0),(167,1,'actiavance','avance30','30%','08','A',0),(168,38,'actiavance','avance40','40%','10','A',0),(169,38,'actiavance','avance50','50%','12','A',0),(170,38,'actiavance','avance60','60%','14','A',0),(171,38,'actiavance','avance70','70%','16','A',0),(172,38,'actiavance','avance80','80%','18','A',0),(173,38,'actiavance','avance90','90%','20','A',0),(174,38,'actiavance','avance100','100%','22','A',0),(175,8,'gentitulos','propuest01','Lista de Propuestas',NULL,'A',0),(176,8,'gentitulos','propuest05','Lista de Propuestas Borradas',NULL,'A',0),(177,39,'mayoristas','myrIBM','IBM',NULL,'A',0),(178,39,'mayoristas','myrNex','Nex',NULL,'A',0),(179,40,'estregop','regenproc','En Proceso',NULL,'A',0),(180,40,'estregop','regverif','En VerificaciÃ³n',NULL,'A',0),(181,40,'estregop','regregistr','Registrado',NULL,'A',0),(182,41,'estadofact','pedestacti','Activa',NULL,'A',0),(183,41,'estadofact','pedestaina','inactiva',NULL,'A',0),(184,41,'estadofact','pedestaanu','Anulada',NULL,'A',0),(185,8,'gentitulos','facturat05','Lista de Facturas Borradas',NULL,'A',0),(186,8,'gentitulos','regoport01','Lista de  Registros de Oportunidad',NULL,'A',0),(187,8,'gentitulos','regoport05','Lista de Registros  de Oportunidad Borrados',NULL,'A',0),(188,8,'gentitulos','detPedit01','Lista de Productos',NULL,'A',0),(189,8,'gentitulos','detPedit05','Lista de Productos Borrados',NULL,'A',0),(190,8,'gentitulos','pedidost01','Lista de pedidos',NULL,'A',0),(191,8,'gentitulos','pedidost05','Lista de Pedidos Borrados',NULL,'A',0),(192,42,'anexbasped','lisanexbas','anexo01,anexo02,anexo03,anexo04,anexo05,anexo06,anexo07,anexo08,anexo09',NULL,'A',0),(193,8,'gentitulos','vencimit00','Lista Detalle  Vencimientos',NULL,'A',0),(194,8,'gentitulos','vencimit05','Lista Detalle  Vencimientos Borrados',NULL,'A',0),(195,43,'estadovenc','venporvenc','Por vencer','3','A',0),(196,43,'estadovenc','venvencido','Vencido','5','A',0),(197,43,'estadovenc','vencubiert','Cubierto','1','A',0),(198,44,'tipovencim','vensofibm','Software IBM',NULL,'A',0),(199,44,'tipovencim','venpaspadv','Passport Advantage',NULL,'A',0),(200,44,'tipovencim','venotrsoft','Otros Software',NULL,'A',0),(201,44,'tipovencim','ven conven','Convenios y Contratos',NULL,'A',0),(202,44,'tipovencim','venharsoft','Hw y SW',NULL,'A',0),(203,45,'tipocobert','ventipoc01','Cobertura 1',NULL,'A',0),(204,45,'tipocobert','ventipoc02','Cobertura 2',NULL,'A',0),(205,8,'gentitulos','encvenct01','Lista de Vencimientos Activos',NULL,'A',0),(206,8,'gentitulos','encvenct05','Lista de Vencimientos Borrados',NULL,'A',0),(207,8,'gentitulos','prueba 99','prueba 99',NULL,'A',1),(208,8,'gentitulos','valparat00','Lista  Valor Parametroa',NULL,'A',0),(209,8,'gentitulos','valparat05','Lista  Valor Parametros Borrados',NULL,'A',0),(210,8,'gentitulos','empleadt01','Lista de Empleados',NULL,'A',0),(211,8,'gentitulos','empleadt02','Lista de Empleados Borrados',NULL,'A',0),(212,46,'estadouser','useractivo','Activo','1','A',0),(213,46,'estadouser','userinact','Inactivo','2','A',0);

/*Table structure for table `vencimientos` */

CREATE TABLE `vencimientos` (
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
  KEY `FK7274CC0E590C37EA` (`encvencimiento_id`),
  CONSTRAINT `FK7274CC0E590C37EA` FOREIGN KEY (`encvencimiento_id`) REFERENCES `enc_vencimientos` (`id`),
  CONSTRAINT `FK7274CC0E5F949CA` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vencimientos` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
