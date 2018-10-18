/*
Navicat MySQL Data Transfer

Source Server         : General
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : odontoplus_bd

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2018-09-25 15:14:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for agendas
-- ----------------------------
DROP TABLE IF EXISTS `agendas`;
CREATE TABLE `agendas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `celular` varchar(100) DEFAULT NULL,
  `desde` varchar(25) NOT NULL,
  `hasta` varchar(25) NOT NULL,
  `idDoctor` int(11) DEFAULT NULL,
  `tratamiento` varchar(200) DEFAULT NULL,
  `hc` int(11) DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for egresos
-- ----------------------------
DROP TABLE IF EXISTS `egresos`;
CREATE TABLE `egresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `concepto` varchar(125) DEFAULT NULL,
  `tipo` varchar(10) DEFAULT NULL,
  `observacion` varchar(125) DEFAULT NULL,
  `precio_unitario` decimal(6,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for empresas
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `ruc` varchar(12) NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for ingresos
-- ----------------------------
DROP TABLE IF EXISTS `ingresos`;
CREATE TABLE `ingresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPaciente` int(11) NOT NULL,
  `idMedico` int(11) NOT NULL,
  `total` decimal(6,2) DEFAULT '0.00',
  `fecha` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=323 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for ingresos_detalle
-- ----------------------------
DROP TABLE IF EXISTS `ingresos_detalle`;
CREATE TABLE `ingresos_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ingresoId` int(11) DEFAULT NULL,
  `precioId` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `monto` decimal(11,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for medicos
-- ----------------------------
DROP TABLE IF EXISTS `medicos`;
CREATE TABLE `medicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(90) NOT NULL,
  `apellidos` varchar(90) NOT NULL,
  `dni` varchar(8) NOT NULL,
  `email` varchar(90) DEFAULT NULL,
  `direccion` varchar(90) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `genero` varchar(25) NOT NULL,
  `estado` varchar(25) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `celular_aux` varchar(50) DEFAULT NULL,
  `margen_ganancia` decimal(10,0) DEFAULT NULL,
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Table structure for pacientes
-- ----------------------------
DROP TABLE IF EXISTS `pacientes`;
CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(90) NOT NULL,
  `apellidos` varchar(90) NOT NULL,
  `dni` varchar(8) DEFAULT NULL,
  `email` varchar(90) DEFAULT NULL,
  `direccion` varchar(90) NOT NULL,
  `fechanacimiento` date NOT NULL,
  `genero` varchar(25) NOT NULL,
  `estado` varchar(25) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `celular_aux` varchar(50) DEFAULT NULL,
  `empresa_id` int(11) NOT NULL,
  `seguro_ind` int(11) NOT NULL,
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL,
  `nombre_apoderado` varchar(150) DEFAULT NULL,
  `celular_apoderado` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for precios
-- ----------------------------
DROP TABLE IF EXISTS `precios`;
CREATE TABLE `precios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) NOT NULL,
  `idTratamiento` int(11) NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=378 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for presupuestos
-- ----------------------------
DROP TABLE IF EXISTS `presupuestos`;
CREATE TABLE `presupuestos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fechahora` datetime NOT NULL,
  `idPaciente` int(11) NOT NULL,
  `idMedico` int(11) NOT NULL,
  `descuento` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for presupuestos_detalle
-- ----------------------------
DROP TABLE IF EXISTS `presupuestos_detalle`;
CREATE TABLE `presupuestos_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPresupuesto` int(11) NOT NULL,
  `pieza` int(11) NOT NULL,
  `seccion` int(11) NOT NULL,
  `secUno` int(11) NOT NULL,
  `secDos` int(11) NOT NULL,
  `opcion` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3607 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for proveedors
-- ----------------------------
DROP TABLE IF EXISTS `proveedors`;
CREATE TABLE `proveedors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(100) NOT NULL,
  `email` varchar(120) DEFAULT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `dni` varchar(8) DEFAULT NULL,
  `telefono` varchar(60) DEFAULT NULL,
  `celular` varchar(60) DEFAULT NULL,
  `empresa` varchar(120) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `ruc` varchar(11) DEFAULT NULL,
  `banco` varchar(60) DEFAULT NULL,
  `nrocuenta` varchar(60) DEFAULT NULL,
  `insumo_id` int(11) NOT NULL,
  `tipo_id` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for proveedors_detalles
-- ----------------------------
DROP TABLE IF EXISTS `proveedors_detalles`;
CREATE TABLE `proveedors_detalles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProveedor` int(11) NOT NULL,
  `detalle` varchar(120) NOT NULL,
  `monto` decimal(5,1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tratamientos
-- ----------------------------
DROP TABLE IF EXISTS `tratamientos`;
CREATE TABLE `tratamientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detalle` varchar(120) NOT NULL,
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rolid` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Procedure structure for agregarCita
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarCita`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarCita`(IN XHC INT, IN XPACIENTE VARCHAR(50), IN XDESDE VARCHAR(25), IN XHASTA VARCHAR(25), IN XCELULAR VARCHAR(100), IN XDOCTOR INT, IN XTRATAMIENTO VARCHAR(200))
BEGIN
	INSERT INTO agendas(hc, title, desde, hasta, celular, idDoctor, tratamiento) VALUES (XHC, XPACIENTE, XDESDE, XHASTA, XCELULAR, XDOCTOR, XTRATAMIENTO);
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for agregarDetalleProveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarDetalleProveedor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarDetalleProveedor`(IN XID_PROVEEDOR INT, IN XDETALLE VARCHAR(120), IN XMONTO DECIMAL(5,1))
BEGIN
		INSERT INTO proveedors_detalles(idProveedor, detalle, monto) VALUES (XID_PROVEEDOR, XDETALLE, XMONTO);
		SELECT ROW_COUNT() AS ESTADO;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for agregarIngreso
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarIngreso`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarIngreso`(IN XID_PACIENTE INT, IN XID_MEDICO INT, IN XFECHA DATE, IN XTOTAL DECIMAL(11,2))
BEGIN
		INSERT INTO ingresos(idPaciente, idMedico, fecha, total, created_at, updated_at)
			VALUES (XID_PACIENTE, XID_MEDICO, XFECHA ,XTOTAL, NOW(), NOW());
		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for agregarIngresoDetalle
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarIngresoDetalle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarIngresoDetalle`(IN XID_INGRESO INT, IN XID_PRECIO INT, IN XCANTIDAD INT, IN XMONTO DECIMAL(11, 2))
BEGIN
		INSERT INTO ingresos_detalle(ingresoId, precioId, cantidad, monto) 
			VALUES (XID_INGRESO, XID_PRECIO, XCANTIDAD, XMONTO);

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for agregarPresupuestoGeneral
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarPresupuestoGeneral`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarPresupuestoGeneral`(IN ID_PRESUPUESTO INT, IN XFECHA_HORA DATETIME, IN XID_PACIENTE INT, IN XID_DOCTOR INT, IN XDESCUENTO INT)
BEGIN
		INSERT INTO presupuestos(id, fechahora, idPaciente, idMedico, descuento)
			VALUES (ID_PRESUPUESTO, XFECHA_HORA, XID_PACIENTE, XID_DOCTOR, XDESCUENTO);

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for agregarPresupuestosDetalles
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarPresupuestosDetalles`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `agregarPresupuestosDetalles`(IN XID_PRESUPUESTO INT, IN XPIEZA INT, 
XSECCION INT, IN XSECUNO INT, IN XSECDOS INT, IN XOPCION INT)
BEGIN
		INSERT INTO presupuestos_detalle (idPresupuesto, pieza, seccion, secUno, secDos, opcion)
		VALUES(XID_PRESUPUESTO, XPIEZA, XSECCION, XSECUNO, XSECDOS, XOPCION);

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for clonarTratamientosPorEmpresas
-- ----------------------------
DROP PROCEDURE IF EXISTS `clonarTratamientosPorEmpresas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `clonarTratamientosPorEmpresas`(IN `XID_EMPRESA` INT, IN `XID_TRATAMIENTO` INT, IN `XMONTO` DECIMAL)
BEGIN
	
    INSERT INTO precios (idEmpresa, idTratamiento, monto) values (XID_EMPRESA, XID_TRATAMIENTO, XMONTO);
    SELECT ROW_COUNT() AS ESTADO;
    
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for deletePrecioByEmpresaId
-- ----------------------------
DROP PROCEDURE IF EXISTS `deletePrecioByEmpresaId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePrecioByEmpresaId`(IN `XID_EMPRESA` INT)
BEGIN
	DELETE FROM Precios WHERE idEmpresa = XID_EMPRESA;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for deletePrecioByTratamientoId
-- ----------------------------
DROP PROCEDURE IF EXISTS `deletePrecioByTratamientoId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePrecioByTratamientoId`(IN `XID_TRATAMIENTO` INT)
BEGIN
	DELETE FROM Precios WHERE idTratamiento = XID_TRATAMIENTO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for deletePresupuestoById
-- ----------------------------
DROP PROCEDURE IF EXISTS `deletePresupuestoById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deletePresupuestoById`(IN XID_PRESUPUESTO INT)
BEGIN

		DELETE FROM presupuestos_detalle WHERE idPresupuesto = XID_PRESUPUESTO;

		DELETE FROM presupuestos WHERE id = XID_PRESUPUESTO;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for editarCitaById
-- ----------------------------
DROP PROCEDURE IF EXISTS `editarCitaById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `editarCitaById`(IN XID_AGENDA INT, IN XHC INT, IN XTITLE VARCHAR(50), IN XCELULAR VARCHAR(100), 
																IN XDESDE VARCHAR(25), IN XHASTA VARCHAR(25), IN XID_DOCTOR INT, IN XTRATAMIENTO VARCHAR(200))
BEGIN

	UPDATE agendas SET hc = XHC, title = XTITLE, celular = XCELULAR, desde = XDESDE, hasta = XHASTA, idDoctor = XID_DOCTOR, tratamiento = XTRATAMIENTO
		WHERE agendas.id = XID_AGENDA;

	SELECT ROW_COUNT() AS ESTADO;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for eliminarDetalleProveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `eliminarDetalleProveedor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminarDetalleProveedor`(IN XID_DPROVEEDOR INT)
BEGIN
		DELETE FROM proveedors_detalles WHERE id = XID_DPROVEEDOR;
		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getAllEgresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getAllEgresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllEgresos`()
BEGIN
	
	SELECT id, fecha, cantidad, tipo, concepto, observacion, precio_unitario FROM egresos;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getAllIngresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getAllIngresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllIngresos`()
BEGIN

		SELECT ingresos.id as id, medicos.id as idDoctor, CONCAT(medicos.nombres, ' ', medicos.apellidos) as doctor, 
					 medicos.apellidos as ap_doctor,
					 pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as pacientes, ingresos.fecha as fecha,					 
					 ingresos.total as allTotal,
					 medicos.margen_ganancia as mg
		FROM `ingresos` 
			INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
			INNER JOIN medicos on medicos.id = ingresos.idMedico
		ORDER BY ingresos.id DESC;

	END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getAllIngresosByPaciente
-- ----------------------------
DROP PROCEDURE IF EXISTS `getAllIngresosByPaciente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getAllIngresosByPaciente`()
BEGIN
	SELECT pacientes.apellidos as nombre, SUM(total) as monto FROM Pacientes
		INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
	GROUP BY ingresos.idPaciente ORDER BY monto DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getDetalleIngreso
-- ----------------------------
DROP PROCEDURE IF EXISTS `getDetalleIngreso`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetalleIngreso`(IN XID_INGRESO INT)
BEGIN 
	SELECT idt.id, trat.id as idTratamiento, trat.detalle as tratamiento, idt.cantidad, idt.monto FROM ingresos
		INNER JOIN ingresos_detalle as idt on ingresos.id = idt.ingresoId
		INNER JOIN precios on precios.id = idt.precioId
		INNER JOIN tratamientos as trat on trat.id = precios.idTratamiento	
	WHERE idt.ingresoId = XID_INGRESO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getDetallePresupuesto
-- ----------------------------
DROP PROCEDURE IF EXISTS `getDetallePresupuesto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetallePresupuesto`(IN XID_PRESUPUESTO INT)
BEGIN
		SELECT pieza, seccion, secUno, secDos, opcion FROM presupuestos
		INNER JOIN presupuestos_detalle on presupuestos_detalle.idPresupuesto = presupuestos.id
		WHERE presupuestos.id = XID_PRESUPUESTO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getDetalleProveedor
-- ----------------------------
DROP PROCEDURE IF EXISTS `getDetalleProveedor`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getDetalleProveedor`(IN XID_PROVEEDOR INT)
BEGIN
	SELECT id, detalle, monto FROM proveedors_detalles WHERE idProveedor = XID_PROVEEDOR;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastNroIngreso
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastNroIngreso`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastNroIngreso`()
BEGIN
	DECLARE NRO_INGRESO INT;
	SELECT IFNULL(id, 0) INTO NRO_INGRESO  FROM ingresos ORDER BY id DESC LIMIT 1;
    SELECT NRO_INGRESO AS 'NroIngreso';
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastNroPresupuesto
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastNroPresupuesto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastNroPresupuesto`()
BEGIN
	DECLARE NRO_PRESUPUESTO INT;
	SELECT IFNULL(id, 0) INTO NRO_PRESUPUESTO FROM presupuestos ORDER BY id DESC LIMIT 1;
    SELECT NRO_PRESUPUESTO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastSixMonthsEgresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastSixMonthsEgresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastSixMonthsEgresos`()
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(egresos.fecha) as mes, SUM(cantidad * precio_unitario) as egresos FROM egresos
		WHERE egresos.fecha < Now() AND egresos.fecha > DATE_ADD(Now(), INTERVAL - 5 MONTH)
	GROUP BY (MONTH(egresos.fecha)) LIMIT 6;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastSixMonthsEgresosByDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastSixMonthsEgresosByDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastSixMonthsEgresosByDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(egresos.fecha) as mes, SUM(cantidad * precio_unitario) as egresos FROM egresos
		WHERE egresos.fecha <= XDATE_FIN AND egresos.fecha >= XDATE_INI
	GROUP BY (MONTH(egresos.fecha)) LIMIT 6;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastSixMonthsIngresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastSixMonthsIngresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastSixMonthsIngresos`()
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(ingresos.fecha) as mes, SUM(idt.cantidad * idt.monto) as ingresos FROM ingresos
			INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
		WHERE ingresos.fecha < Now() AND ingresos.fecha > DATE_ADD(Now(), INTERVAL - 5 MONTH)
	GROUP BY (MONTH(ingresos.fecha));
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastSixMonthsIngresosByDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastSixMonthsIngresosByDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastSixMonthsIngresosByDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(ingresos.fecha) as mes, SUM(idt.cantidad * idt.monto) as ingresos FROM ingresos
			INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
		WHERE ingresos.fecha <= XDATE_FIN AND ingresos.fecha >= XDATE_INI
	GROUP BY (MONTH(ingresos.fecha));
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastSixMonthsIngresosByEmpresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastSixMonthsIngresosByEmpresa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastSixMonthsIngresosByEmpresa`()
BEGIN 
	SELECT empresas.nombre as nombre, SUM(ingresos.total) as ingresos FROM pacientes
		INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
		INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE ingresos.fecha < Now() AND ingresos.fecha > DATE_ADD(Now(), INTERVAL - 5 MONTH)
	GROUP BY pacientes.empresa_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getLastSixMonthsIngresosByEmpresaDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getLastSixMonthsIngresosByEmpresaDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getLastSixMonthsIngresosByEmpresaDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN 
	SELECT empresas.nombre as nombre, SUM(ingresos.total) as ingresos FROM pacientes
		INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
		INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE ingresos.fecha <= XDATE_FIN AND ingresos.fecha >= XDATE_INI
	GROUP BY pacientes.empresa_id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getMaxTratamientosIngresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getMaxTratamientosIngresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMaxTratamientosIngresos`()
BEGIN
	SELECT SUBSTRING(tratamientos.detalle, 1, 25) as tratamiento, count(tratamientos.detalle) as numero FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.ingresoId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	WHERE ingresos.fecha < Now() AND ingresos.fecha > DATE_ADD(Now(), INTERVAL - 5 MONTH)
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getMaxTratamientosIngresosByDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getMaxTratamientosIngresosByDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMaxTratamientosIngresosByDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN
	SELECT SUBSTRING(tratamientos.detalle, 1, 25) as tratamiento, count(tratamientos.detalle) as numero FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.ingresoId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	WHERE ingresos.fecha >= XDATE_INI AND ingresos.fecha <= XDATE_FIN
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getMontoByEmpresaTratamiento
-- ----------------------------
DROP PROCEDURE IF EXISTS `getMontoByEmpresaTratamiento`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMontoByEmpresaTratamiento`(IN `XID_EMPRESA` INT, IN `XID_TRATAMIENTO` INT)
BEGIN
	DECLARE XMONTO DECIMAL;
	SELECT monto INTO XMONTO FROM precios WHERE idEmpresa = XID_EMPRESA and idTratamiento = XID_TRATAMIENTO;
    SELECT XMONTO as MONTO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getMorePaymentByPacientes
-- ----------------------------
DROP PROCEDURE IF EXISTS `getMorePaymentByPacientes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMorePaymentByPacientes`()
BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(total) as monto FROM ingresos 
		INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	WHERE ingresos.fecha < Now() AND ingresos.fecha > DATE_ADD(Now(), INTERVAL - 5 MONTH)
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getMorePaymentByPacientesByDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getMorePaymentByPacientesByDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getMorePaymentByPacientesByDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(total) as monto FROM ingresos 
		INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	WHERE ingresos.fecha <= XDATE_FIN AND ingresos.fecha >= XDATE_INI
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getNumeroDniPaciente
-- ----------------------------
DROP PROCEDURE IF EXISTS `getNumeroDniPaciente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getNumeroDniPaciente`(IN XDNI VARCHAR(8))
BEGIN
	SELECT dni FROM `pacientes` WHERE dni = XDNI;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getPreciosByIdEmpresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `getPreciosByIdEmpresa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPreciosByIdEmpresa`(IN XID_EMPRESA INT)
BEGIN
	SELECT precios.idTratamiento AS id, tratamientos.detalle AS nombre, precios.monto AS monto FROM precios 
    INNER JOIN tratamientos on precios.idTratamiento = tratamientos.id
    WHERE precios.idEmpresa = XID_EMPRESA;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSearchEgresosAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSearchEgresosAll`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSearchEgresosAll`(IN INI_DATE DATE, IN FIN_DATE DATE)
BEGIN

	SELECT id, fecha, cantidad, concepto, tipo, observacion, precio_unitario FROM egresos
		WHERE fecha >= INI_DATE AND fecha <= FIN_DATE;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSearchIngresoAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSearchIngresoAll`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSearchIngresoAll`(IN INI_DATE DATE, IN FIN_DATE DATE)
BEGIN
	
	SELECT ingresos.id as id, medicos.id as idDoctor, CONCAT(medicos.nombres, ' ', medicos.apellidos) as doctor, medicos.apellidos as ap_doctor,
					 pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as pacientes, ingresos.fecha as fecha,					 
					 ingresos.total as allTotal,
					 medicos.margen_ganancia as mg
		FROM `ingresos` 
			INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
			INNER JOIN medicos on medicos.id = ingresos.idMedico
		WHERE 
				date(ingresos.fecha) >= INI_DATE AND date(ingresos.fecha) <= FIN_DATE;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSearchIngresoById
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSearchIngresoById`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSearchIngresoById`(IN INI_DATE DATE, IN FIN_DATE DATE, IN X_IDDOCTOR INT)
BEGIN
	
	SELECT ingresos.id as id, medicos.id as idDoctor, CONCAT(medicos.nombres, ' ', medicos.apellidos) as doctor, medicos.apellidos as ap_doctor,
					 pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as pacientes, ingresos.fecha as fecha,					 
					 ingresos.total as allTotal,
					 medicos.margen_ganancia as mg
		FROM `ingresos`
			INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
			INNER JOIN medicos on medicos.id = ingresos.idMedico
		WHERE 
				date(ingresos.fecha) >= INI_DATE AND date(ingresos.fecha) <= FIN_DATE AND medicos.id = X_IDDOCTOR;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSumMontoEgresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSumMontoEgresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSumMontoEgresos`()
BEGIN
	SELECT SUM(cantidad * precio_unitario) as egresos 
		FROM egresos;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSumMontoEgresosByDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSumMontoEgresosByDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSumMontoEgresosByDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN
		SELECT SUM(cantidad * precio_unitario) as egresos 
				FROM egresos
		WHERE fecha >= XDATE_INI AND fecha <= XDATE_FIN;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSumMontoIngresos
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSumMontoIngresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSumMontoIngresos`()
BEGIN
	SELECT SUM(cantidad * monto) AS ingresos FROM ingresos
			INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for getSumMontoIngresosByDate
-- ----------------------------
DROP PROCEDURE IF EXISTS `getSumMontoIngresosByDate`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSumMontoIngresosByDate`(IN XDATE_INI DATE, IN XDATE_FIN DATE)
BEGIN
		SELECT SUM(cantidad * monto) AS ingresos FROM ingresos
			INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
		WHERE fecha >= XDATE_INI AND fecha <= XDATE_FIN;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for modificarIngreso
-- ----------------------------
DROP PROCEDURE IF EXISTS `modificarIngreso`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarIngreso`(IN XID_PACIENTE INT, IN XID_MEDICO INT, IN XFECHA DATE, IN XTOTAL DECIMAL(11,2), IN XID_INGRESO INT)
BEGIN
		UPDATE ingresos 
			SET idPaciente = XID_PACIENTE, idMedico = XID_MEDICO, fecha = XFECHA, total = XTOTAL, updated_at = NOW()
		WHERE id = XID_INGRESO;
		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for modificarIngresoDetalle
-- ----------------------------
DROP PROCEDURE IF EXISTS `modificarIngresoDetalle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `modificarIngresoDetalle`(IN XID_INGRESO_DETALLE INT, IN XCANTIDAD INT)
BEGIN
	UPDATE ingresos_detalle
		SET cantidad = XCANTIDAD
	WHERE ingresos_detalle.id = XID_INGRESO_DETALLE;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for obtenerCitas
-- ----------------------------
DROP PROCEDURE IF EXISTS `obtenerCitas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerCitas`(IN XID_USER INT)
BEGIN
		SELECT CONCAT('[', hc, '] ', title, ', ', tratamiento, ', ', celular) as title, id, desde as start, hasta as end 
			FROM agendas
		WHERE idDoctor = XID_USER;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for obtenerTodasCitas
-- ----------------------------
DROP PROCEDURE IF EXISTS `obtenerTodasCitas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTodasCitas`()
BEGIN

		SELECT id, hc, title, celular, desde, hasta, idDoctor, tratamiento FROM agendas;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for obtenerTodosMedicos
-- ----------------------------
DROP PROCEDURE IF EXISTS `obtenerTodosMedicos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTodosMedicos`()
BEGIN
	SELECT id, CONCAT(nombres, ' ', apellidos) as name FROM medicos;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for obtenerTratamientosByPacienteId
-- ----------------------------
DROP PROCEDURE IF EXISTS `obtenerTratamientosByPacienteId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerTratamientosByPacienteId`(IN XID_PACIENTE INT)
BEGIN

	DECLARE XID_EMPRESA INT;

	SELECT empresa_id INTO XID_EMPRESA FROM pacientes where pacientes.id = XID_PACIENTE;

	SELECT precios.id, detalle, monto FROM PRECIOS 
		INNER JOIN tratamientos ON precios.idTratamiento = tratamientos.id
	WHERE idEmpresa = XID_EMPRESA ORDER BY (tratamientos.id);

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for obtenerUltimoIdEmpresa
-- ----------------------------
DROP PROCEDURE IF EXISTS `obtenerUltimoIdEmpresa`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerUltimoIdEmpresa`()
BEGIN
	DECLARE ID_EMPRESA INT;
    
	SELECT id INTO ID_EMPRESA FROM empresas ORDER BY id DESC LIMIT 1;
    
    SELECT ID_EMPRESA;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for obtenerUltimoIdTratamiento
-- ----------------------------
DROP PROCEDURE IF EXISTS `obtenerUltimoIdTratamiento`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerUltimoIdTratamiento`()
BEGIN
	DECLARE ID_TRATAMIENTO INT;
    
	SELECT id INTO ID_TRATAMIENTO FROM tratamientos ORDER BY id DESC LIMIT 1;
    
    SELECT ID_TRATAMIENTO;
END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for updatePrecios
-- ----------------------------
DROP PROCEDURE IF EXISTS `updatePrecios`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `updatePrecios`(IN `XIDEMPRESA` INT, IN `XIDTRATAMIENTO` INT, IN `XMONTO` DECIMAL(10,0), IN `XTOKEN` VARCHAR(255) CHARSET utf8)
BEGIN
    UPDATE precios SET precios.monto=XMONTO where precios.idEmpresa = XIDEMPRESA and precios.idTratamiento = XIDTRATAMIENTO;
    SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;
