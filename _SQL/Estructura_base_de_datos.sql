SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `doctors`
-- ----------------------------
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE `doctors` (
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
  `margen_ganancia` decimal(10,0) DEFAULT '0',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `egresos`
-- ----------------------------
DROP TABLE IF EXISTS `egresos`;
CREATE TABLE `egresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `concepto` varchar(125) DEFAULT NULL,
  `tipo` varchar(125) DEFAULT NULL,
  `observacion` varchar(125) DEFAULT NULL,
  `precio_unitario` decimal(6,2) DEFAULT NULL,
  `doctorId` int(11) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `empresas`
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `ruc` varchar(12) DEFAULT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `ingresos`
-- ----------------------------
DROP TABLE IF EXISTS `ingresos`;
CREATE TABLE `ingresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPaciente` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `ingresos_detalle`
-- ----------------------------
DROP TABLE IF EXISTS `ingresos_detalle`;
CREATE TABLE `ingresos_detalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ingresoId` int(11) DEFAULT NULL,
  `precioId` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `monto` decimal(11,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `doctorId` int(11) DEFAULT NULL,
  `margen_ganancia` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=543 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `migrations`
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Table structure for `pacientes`
-- ----------------------------
DROP TABLE IF EXISTS `pacientes`;
CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombres` varchar(90) NOT NULL,
  `apellidos` varchar(90) NOT NULL,
  `dni` varchar(8) DEFAULT NULL,
  `email` varchar(90) DEFAULT NULL,
  `direccion` varchar(90) NOT NULL,
  `fechanacimiento` date DEFAULT NULL,
  `genero` varchar(25) DEFAULT NULL,
  `estado` varchar(25) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `celular_aux` varchar(50) DEFAULT NULL,
  `empresa_id` int(11) NOT NULL,
  `seguro_ind` int(11) DEFAULT NULL,
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL,
  `nombre_apoderado` varchar(150) DEFAULT NULL,
  `celular_apoderado` varchar(150) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT '0',
  `referencia_id` int(11) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=233 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `pagos`
-- ----------------------------
DROP TABLE IF EXISTS `pagos`;
CREATE TABLE `pagos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idDoctor` int(11) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `is_deleted` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `precios`
-- ----------------------------
DROP TABLE IF EXISTS `precios`;
CREATE TABLE `precios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) NOT NULL,
  `idTratamiento` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=518 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `presupuestos`
-- ----------------------------
DROP TABLE IF EXISTS `presupuestos`;
CREATE TABLE `presupuestos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fechahora` datetime NOT NULL,
  `idPaciente` int(11) NOT NULL,
  `idDoctor` int(11) NOT NULL,
  `descuento` int(11) NOT NULL,
  `is_deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `presupuesto_detalles`
-- ----------------------------
DROP TABLE IF EXISTS `presupuesto_detalles`;
CREATE TABLE `presupuesto_detalles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPresupuesto` int(11) NOT NULL,
  `pieza` int(11) NOT NULL,
  `seccion` int(11) NOT NULL,
  `secUno` int(11) NOT NULL,
  `secDos` int(11) NOT NULL,
  `opcion` int(11) NOT NULL,
  `monto` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3926 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `proveedors`
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
  `is_deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `proveedors_detalles`
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
--  Table structure for `referencias`
-- ----------------------------
DROP TABLE IF EXISTS `referencias`;
CREATE TABLE `referencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `roles`
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `tratamientos`
-- ----------------------------
DROP TABLE IF EXISTS `tratamientos`;
CREATE TABLE `tratamientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detalle` varchar(120) NOT NULL,
  `updated_at` date NOT NULL,
  `created_at` date NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `is_deleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `users`
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
  `is_active` tinyint(1) DEFAULT '1',
  `is_deleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
--  Procedure definition for `OP_actualizarIngresoDetalle`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_actualizarIngresoDetalle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_actualizarIngresoDetalle`(IN XID_INGRESO INT, IN XID_PRECIO INT, IN XCANTIDAD INT, IN XMONTO DECIMAL(11, 2), IN XID INT, IN XFECHA DATE, IN XDOCTOR INT)
BEGIN
		DECLARE MONTO_TOTAL DECIMAL(11, 2);

		UPDATE ingresos_detalle SET ingresoId = XID_INGRESO, precioId = XID_PRECIO, cantidad = XCANTIDAD, monto = XMONTO, fecha = XFECHA, doctorId = XDOCTOR
		WHERE ingresos_detalle.id = XID;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_agregarIngresoDetalle`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_agregarIngresoDetalle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarIngresoDetalle`(IN XID_INGRESO INT, IN XID_PRECIO INT, IN XCANTIDAD INT, IN XMONTO DECIMAL(11, 2), IN XFECHA DATE, IN XDOCTOR INT)
BEGIN
		DECLARE MONTO_TOTAL DECIMAL(11, 2);
		DECLARE XMARGEN DECIMAL(10, 0);

		SELECT margen_ganancia INTO XMARGEN FROM doctors WHERE doctors.id = XDOCTOR;

		INSERT INTO ingresos_detalle(ingresoId, precioId, cantidad, monto, fecha, doctorId, margen_ganancia)
			VALUES (XID_INGRESO, XID_PRECIO, XCANTIDAD, XMONTO, XFECHA, XDOCTOR, XMARGEN);

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_AgregarPrecios_EmpresaId_TratamientoId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_AgregarPrecios_EmpresaId_TratamientoId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_AgregarPrecios_EmpresaId_TratamientoId`(IN empresaId int, IN tratamientoId int, IN precio decimal)
BEGIN
  INSERT INTO precios (idEmpresa, idTratamiento, monto) values (empresaId, tratamientoId, precio);
  SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_agregarPresupuestoGeneral`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_agregarPresupuestoGeneral`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarPresupuestoGeneral`(IN ID_PRESUPUESTO INT, IN XID_PACIENTE INT, IN XID_DOCTOR INT, IN XDESCUENTO INT)
BEGIN
		INSERT INTO presupuestos(id, fechahora, idPaciente, idDoctor, descuento)
			VALUES (ID_PRESUPUESTO, NOW(), XID_PACIENTE, XID_DOCTOR, XDESCUENTO);

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_agregarPresupuestosDetalles`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_agregarPresupuestosDetalles`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarPresupuestosDetalles`(IN XID_PRESUPUESTO INT, IN XPIEZA INT, XSECCION INT, IN XSECUNO INT, IN XSECDOS INT, IN XOPCION INT, IN XMONTO DECIMAL(10, 2))
BEGIN
		INSERT INTO presupuesto_detalles(idPresupuesto, pieza, seccion, secUno, secDos, opcion, monto)
		VALUES(XID_PRESUPUESTO, XPIEZA, XSECCION, XSECUNO, XSECDOS, XOPCION, XMONTO);

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_eliminarDoctor_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_eliminarDoctor_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_eliminarDoctor_Id`(IN XID_DOCTOR INT)
BEGIN
	DELETE FROM doctors WHERE id = XID_DOCTOR;
	ALTER TABLE `doctors` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_eliminarIngresoDetalle`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_eliminarIngresoDetalle`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_eliminarIngresoDetalle`(IN XID INT)
BEGIN
	DELETE FROM ingresos_detalle WHERE ingresos_detalle.id = XID;
	ALTER TABLE ingresos_detalle AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_eliminarIngreso_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_eliminarIngreso_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_eliminarIngreso_Id`(IN XID_PACIENTE INT)
BEGIN
	DELETE FROM ingresos WHERE idPaciente = XID_PACIENTE;
	ALTER TABLE `ingresos` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_eliminarPaciente_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_eliminarPaciente_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_eliminarPaciente_Id`(IN XID_PACIENTE INT)
BEGIN
	DELETE FROM pacientes WHERE id = XID_PACIENTE;
	ALTER TABLE `pacientes` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_eliminarPresupuesto_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_eliminarPresupuesto_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_eliminarPresupuesto_Id`(IN XID_PRESUPUESTO INT)
BEGIN
	START TRANSACTION;
		DELETE FROM presupuestos WHERE id = XID_PRESUPUESTO;
		DELETE FROM presupuesto_detalles WHERE idPresupuesto = XID_PRESUPUESTO;
		ALTER TABLE presupuestos AUTO_INCREMENT = 1;
		ALTER TABLE presupuesto_detalles AUTO_INCREMENT = 252;
	COMMIT;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_eliminarTratamiento_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_eliminarTratamiento_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_eliminarTratamiento_Id`(IN XID_TRATAMIENTO INT)
BEGIN
	START TRANSACTION;
		DELETE FROM tratamientos WHERE id = XID_TRATAMIENTO;
		DELETE FROM precios WHERE idTratamiento = XID_TRATAMIENTO;

		ALTER TABLE tratamientos AUTO_INCREMENT = 2;
	COMMIT;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_esDoctorBorrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_esDoctorBorrable_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_esDoctorBorrable_Id`(IN XID_DOCTOR INT)
BEGIN
DECLARE myvar INT;

SELECT count(id) INTO myvar FROM `presupuestos` WHERE idDoctor = XID_DOCTOR;

IF myvar = "0" THEN
	SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
ELSE
	SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_esIngresoBorrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_esIngresoBorrable_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_esIngresoBorrable_Id`(IN XID_INGRESO INT)
BEGIN

	DECLARE myvar INT;

	SELECT count(id) INTO myvar FROM ingresos_detalle where ingresos_detalle.ingresoId = XID_INGRESO;

	IF myvar = "0" THEN
		SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
	ELSE
		SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
	END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_esPacienteBorrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_esPacienteBorrable_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_esPacienteBorrable_Id`(IN XID_PACIENTE INT)
BEGIN
DECLARE myvar INT;
DECLARE ingreso_status INT;

SELECT count(id) INTO myvar FROM `presupuestos` WHERE idPaciente = XID_PACIENTE;

SELECT count(idt.id)INTO ingreso_status FROM ingresos
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
WHERE ingresos.idPaciente = XID_PACIENTE;

IF myvar = "0" AND ingreso_status = "0" THEN
	SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
ELSE
	SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_esTratamientoBorrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_esTratamientoBorrable_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_esTratamientoBorrable_Id`(IN XID_TRATAMIENTO INT)
BEGIN
DECLARE myvar INT;

SELECT count(id) INTO myvar FROM presupuesto_detalles WHERE pieza = XID_TRATAMIENTO or seccion = XID_TRATAMIENTO or secUno = XID_TRATAMIENTO or SecDos = XID_TRATAMIENTO;

IF myvar = "0" THEN
	SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
ELSE
	SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerAllTotalIngreso_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerAllTotalIngreso_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerAllTotalIngreso_Id`(IN XID_INGRESO INT)
BEGIN

	SELECT SUM(idt.cantidad * idt.monto) as total FROM ingresos
		INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	WHERE ingresos.id = XID_INGRESO;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerDoctores`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerDoctores`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerDoctores`()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerDoctores_DESC`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerDoctores_DESC`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerDoctores_DESC`()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0' ORDER BY d.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerDoctores_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerDoctores_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerDoctores_Id`(IN XID INT)
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia,
         d.genero, d.estado, d.celular_aux, d.fechanacimiento
  FROM doctors d
  WHERE d.id = XID AND d.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerDoctores_presupuesto`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerDoctores_presupuesto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores_presupuesto`(IN XID_DOCTOR INT)
BEGIN
	SELECT id as id, nombres as nombres, apellidos as apellidos, margen_ganancia
		FROM doctors WHERE id = XID_DOCTOR;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerEgresos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerEgresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEgresos`()
BEGIN
		SELECT egresos.id, fecha, concepto, cantidad, precio_unitario as monto, SUM(cantidad * precio_unitario) as total,
					 tipo, doctors.apellidos as doctor, doctors.id as doctorId, observacion as nota
			FROM egresos
		LEFT JOIN doctors on doctors.id = egresos.doctorId
		WHERE egresos.is_deleted = 0
		GROUP BY egresos.id ORDER BY egresos.fecha DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerEgresos_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerEgresos_Fechas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerEgresos_Fechas`(IN XDATE DATE)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(e.fecha) as mes, SUM(e.cantidad * e.precio_unitario) as egresos
		FROM egresos as e
	WHERE e.fecha BETWEEN XDATE - INTERVAL 5 MONTH AND XDATE
		GROUP BY (MONTH(e.fecha));
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerEgresos_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerEgresos_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEgresos_Id`(IN XID INT)
BEGIN
	SELECT egresos.id, fecha, concepto, cantidad, precio_unitario as monto, SUM(cantidad * precio_unitario) as total, tipo,
				 doctors.apellidos as doctor, doctors.id as doctorId, observacion as nota
			FROM egresos
		LEFT JOIN doctors on doctors.id = egresos.doctorId
		WHERE egresos.is_deleted = 0 AND egresos.id = XID
		GROUP BY egresos.id;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerEmpresaActual_paciente`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerEmpresaActual_paciente`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresaActual_paciente`(IN XID_PACIENTE INT)
BEGIN
	SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerEmpresas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerEmpresas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerEmpresas`()
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerEmpresas_DESC`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerEmpresas_DESC`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerEmpresas_DESC`()
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.is_deleted = '0' ORDER BY e.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerEmpresas_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerEmpresas_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerEmpresas_Id`(IN XID INT)
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.id = XID AND e.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerGanancias`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerGanancias`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerGanancias`()
BEGIN
    SELECT idt.id, dr.nombres,dr.apellidos, tr.detalle as tratamiento, idt.cantidad, idt.monto, (idt.cantidad * idt.monto) as total,
           FORMAT((dr.margen_ganancia/100 * idt.cantidad * idt.monto),2) as doctor
    FROM ingresos_detalle idt
    INNER JOIN doctors dr ON dr.id = idt.doctorId
    INNER JOIN precios pr ON pr.id = idt.precioId
    INNER JOIN tratamientos tr ON tr.id = pr.idTratamiento;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerIngresoDetalle_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerIngresoDetalle_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerIngresoDetalle_Id`(IN XID_INGRESO INT)
BEGIN
	SELECT idt.id, trat.id as idTratamiento, trat.detalle as tratamiento,
				 doc.id as idDoctor, CONCAT(doc.nombres, ' ', doc.apellidos) as nombreDoctor,
				 idt.cantidad * idt.monto as total,
				 ROUND(IFNULL(SUM(idt.monto * idt.cantidad) * doc.margen_ganancia/100, 0), 2) as mg,
				 ROUND(IFNULL(SUM(idt.monto * idt.cantidad) - (SUM(idt.monto * idt.cantidad) * doc.margen_ganancia/100), 0), 2) as mg_core,
				 idt.cantidad, idt.monto, idt.fecha as fecha
		FROM ingresos
		INNER JOIN ingresos_detalle as idt on ingresos.id = idt.ingresoId
		INNER JOIN precios on precios.id = idt.precioId
		INNER JOIN tratamientos as trat on trat.id = precios.idTratamiento
		LEFT JOIN doctors as doc on doc.id = idt.doctorId
	WHERE idt.ingresoId = XID_INGRESO AND ingresos.is_deleted = 0
	GROUP BY idt.id
	ORDER BY idt.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerIngresos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerIngresos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerIngresos`()
BEGIN
	SELECT ingresos.id as id, pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as nombrePaciente,
			 ingresos.created_at as fecha,
			 IFNULL(SUM(idt.cantidad * idt.monto), 0) as monto_total
		FROM `ingresos`
	INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
  LEFT JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
		WHERE ingresos.is_deleted = 0
		GROUP BY ingresos.id ORDER BY ingresos.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosPorDoctor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorDoctor`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerIngresosPorDoctor`()
SELECT dr.nombres, dr.apellidos, FORMAT(IFNULL(SUM(idt.margen_ganancia/100 * idt.cantidad * idt.monto), 0),2) as total_doctor
		FROM ingresos_detalle idt
	INNER JOIN doctors dr ON dr.id = idt.doctorId
  GROUP BY dr.id
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosPorDoctor_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorDoctor_Fechas`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerIngresosPorDoctor_Fechas`(IN start_date date, IN end_date date)
SELECT dr.nombres, dr.apellidos, FORMAT(IFNULL(SUM(idt.margen_ganancia/100 * idt.cantidad * idt.monto), 0),2) as total_doctor
  FROM ingresos_detalle idt
  INNER JOIN doctors dr ON dr.id = idt.doctorId
  WHERE idt.fecha BETWEEN start_date AND end_date
  GROUP BY dr.id
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosPorEmpresa_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorEmpresa_Fechas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerIngresosPorEmpresa_Fechas`(IN start_date DATE, IN end_date date)
BEGIN
	SELECT empresas.nombre as nombre, SUM(idt.cantidad * idt.monto) as ingresos
		FROM pacientes
	INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
	INNER JOIN empresas on empresas.id = pacientes.empresa_id
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
		WHERE idt.fecha BETWEEN start_date AND end_date
	GROUP BY pacientes.empresa_id;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosPorEmpresa_Reportes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorEmpresa_Reportes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerIngresosPorEmpresa_Reportes`()
BEGIN
	SELECT empresas.nombre as nombre, SUM(idt.cantidad * idt.monto) as ingresos
		FROM pacientes
	INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
	INNER JOIN empresas on empresas.id = pacientes.empresa_id
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
		GROUP BY pacientes.empresa_id;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosPorPaciente_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorPaciente_Fechas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerIngresosPorPaciente_Fechas`(IN XINI DATE, IN XFIN DATE)
BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(idt.cantidad * idt.monto) as monto
		FROM ingresos INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	WHERE idt.fecha BETWEEN XINI AND XFIN
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosPorPaciente_Reportes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorPaciente_Reportes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerIngresosPorPaciente_Reportes`()
BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(idt.cantidad * idt.monto) as monto
		FROM ingresos INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresosTotales_DoctorId_RangoFechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosTotales_DoctorId_RangoFechas`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerIngresosTotales_DoctorId_RangoFechas`(IN doctor_id int, IN start_date date, IN end_date date)
BEGIN
	IF doctor_id = 0 THEN

    SELECT FORMAT(IFNULL(SUM(idt.cantidad * idt.monto), 0),2) as total,
           FORMAT(IFNULL(SUM(idt.margen_ganancia/100 * idt.cantidad * idt.monto), 0),2) as total_doctor,
           FORMAT(IFNULL(SUM((100-idt.margen_ganancia)/100 * idt.cantidad * idt.monto), 0),2) as total_ganancia
    FROM ingresos_detalle idt
    INNER JOIN doctors dr ON dr.id = idt.doctorId
    WHERE idt.fecha BETWEEN start_date AND end_date;

	ELSE

    SELECT FORMAT(IFNULL(SUM(idt.cantidad * idt.monto), 0),2) as total,
           FORMAT(IFNULL(SUM(idt.margen_ganancia/100 * idt.cantidad * idt.monto), 0),2) as total_doctor,
           FORMAT(IFNULL(SUM((100-idt.margen_ganancia)/100 * idt.cantidad * idt.monto), 0),2) as total_ganancia
    FROM ingresos_detalle idt
    INNER JOIN doctors dr ON dr.id = idt.doctorId
    WHERE dr.id = doctor_id AND idt.fecha BETWEEN start_date AND end_date;

  END IF;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerIngresosTotal_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerIngresosTotal_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerIngresosTotal_Id`(IN XID_INGRESO_DETALLE INT)
BEGIN
	SELECT ROUND(IFNULL(SUM(ingresos_detalle.monto * ingresos_detalle.cantidad), 0), 2) as total,
			   ROUND(IFNULL(SUM(ingresos_detalle.monto * ingresos_detalle.cantidad) * doctors.margen_ganancia/100, 0), 2) as mg,
			   ROUND(IFNULL(SUM(ingresos_detalle.monto * ingresos_detalle.cantidad) - (SUM(ingresos_detalle.monto * ingresos_detalle.cantidad) * doctors.margen_ganancia/100), 0), 2) as mg_core
		FROM ingresos_detalle
		INNER JOIN ingresos on ingresos.id = ingresos_detalle.ingresoId
		INNER JOIN doctors on doctors.id = ingresos_detalle.doctorId
	WHERE ingresos_detalle.id = XID_INGRESO_DETALLE AND ingresos.is_deleted = 0;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresos_DoctorId_RangoFechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresos_DoctorId_RangoFechas`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerIngresos_DoctorId_RangoFechas`(IN doctor_id int, IN start_date date, IN end_date date)
BEGIN
	IF doctor_id = 0 THEN

    SELECT idt.id, LPAD(ing.idPaciente, 5, '00000') as historia, dr.id as doctorId, dr.nombres,dr.apellidos, tr.detalle as tratamiento,
					 idt.cantidad, idt.monto, (idt.cantidad * idt.monto) as total,
           FORMAT((idt.margen_ganancia/100 * idt.cantidad * idt.monto), 2) as doctor, DATE_FORMAT(idt.fecha, "%d-%m-%Y") as fecha
    FROM ingresos_detalle idt
    INNER JOIN ingresos ing ON ing.id = idt.ingresoId
    INNER JOIN doctors dr ON dr.id = idt.doctorId
    INNER JOIN precios pr ON pr.id = idt.precioId
    INNER JOIN tratamientos tr ON tr.id = pr.idTratamiento
    WHERE idt.fecha BETWEEN start_date AND end_date;

	ELSE

    SELECT idt.id, LPAD(ing.idPaciente, 5, '00000') as historia, dr.id as doctorId, dr.nombres,dr.apellidos, tr.detalle as tratamiento, idt.cantidad, idt.monto, (idt.cantidad * idt.monto) as total,
           FORMAT((idt.margen_ganancia/100 * idt.cantidad * idt.monto),2) as doctor, DATE_FORMAT(idt.fecha, "%d-%m-%Y") as fecha
    FROM ingresos_detalle idt
    INNER JOIN ingresos ing ON ing.id = idt.ingresoId
    INNER JOIN doctors dr ON dr.id = idt.doctorId
    INNER JOIN precios pr ON pr.id = idt.precioId
    INNER JOIN tratamientos tr ON tr.id = pr.idTratamiento
    WHERE dr.id = doctor_id AND idt.fecha BETWEEN start_date AND end_date;

  END IF;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerIngresos_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresos_Fechas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerIngresos_Fechas`(IN XDATE DATE)
BEGIN
	SET lc_time_names = 'es_ES';

	SELECT MONTHNAME(idt.fecha) as mes, SUM(idt.cantidad * idt.monto) as ingresos
		FROM ingresos_detalle as idt
	WHERE idt.fecha BETWEEN XDATE - INTERVAL 5 MONTH AND XDATE
		GROUP BY (MONTH(idt.fecha));
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerIngresos_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerIngresos_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerIngresos_Id`(IN XID INT)
BEGIN
	SELECT LPAD(ingresos.id, 5, '0') as id, LPAD(pacientes.id, 5, '0') as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as nombrePaciente,
				 ingresos.created_at as fecha,
				 IFNULL(SUM(ingresos_detalle.cantidad * ingresos_detalle.monto), 0) as monto_total
		FROM `ingresos`
	INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	LEFt JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
	WHERE ingresos.id = XID AND ingresos.is_deleted = 0
	ORDER BY ingresos.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPacientes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPacientes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes`()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero,
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, pc.referencia_id,
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
		FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
		ORDER BY pc.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPacientes_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPacientes_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes_Id`(IN XID INT)
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero,
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, pc.referencia_id,
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.id = XID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPacientes_presupuesto`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPacientes_presupuesto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes_presupuesto`(IN XID_PACIENTES INT)
BEGIN
	SELECT LPAD(pacientes.id, 5, '0') as id, pacientes.nombres, pacientes.apellidos, empresas.nombre as empresa, pacientes.empresa_id
		FROM pacientes
		INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE pacientes.id = XID_PACIENTES;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerPagos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerPagos`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerPagos`()
BEGIN
  SELECT p.id, p.idDoctor, dr.nombres, dr.apellidos, p.fecha_inicio, p.fecha_fin, p.created_at, p.updated_at
  FROM pagos p
  INNER JOIN doctors dr ON dr.id = p.idDoctor
  WHERE p.is_deleted = '0' ORDER BY p.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerPreciosEstandard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerPreciosEstandard`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerPreciosEstandard`()
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, tratamientos.detalle AS tratamiento,
         precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  INNER JOIN tratamientos on precios.idTratamiento = tratamientos.id
  INNER JOIN empresas on precios.idEmpresa = empresas.id
  WHERE precios.idEmpresa = 1
  ORDER BY tratamientos.id;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPreciosParaTabla_EmpresaId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPreciosParaTabla_EmpresaId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPreciosParaTabla_EmpresaId`(IN XID_EMPRESA INT)
BEGIN
	select trat.id, trat.detalle, emprc.monto from precios as emprc
		inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA and trat.id > 7 and trat.id != 29 and trat.id != 30 order by idTratamiento;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPrecios_EmpresaId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPrecios_EmpresaId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPrecios_EmpresaId`(IN XID_EMPRESA INT)
BEGIN
	select trat.id, trat.detalle, emprc.monto from precios as emprc
		inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA order by idTratamiento;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerPrecios_EmpresaId_TratamientoId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerPrecios_EmpresaId_TratamientoId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerPrecios_EmpresaId_TratamientoId`(IN empresaId INT, IN tratamientoId INT)
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  WHERE precios.idEmpresa = empresaId AND precios.idTratamiento = tratamientoId;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPresupuestoDetalle_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPresupuestoDetalle_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuestoDetalle_Id`(IN XID INT)
BEGIN
	SELECT id, pieza, seccion, secUno, secDos, opcion, monto FROM presupuesto_detalles
		WHERE idPresupuesto = XID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPresupuestos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPresupuestos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuestos`()
BEGIN
	SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento,
				 CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente,
				 CONCAT(dc.nombres, ' ', dc.apellidos) AS nombreDoctor
	FROM presupuestos as pre
	INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
	INNER JOIN doctors AS dc ON dc.id = pre.idDoctor
	ORDER BY pre.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerPresupuesto_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerPresupuesto_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuesto_Id`(IN XID INT)
BEGIN
	SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento,
				 CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente,
				 CONCAT(dc.nombres, ' ', dc.apellidos) AS nombreDoctor,
				 emp.nombre as empresa
		FROM presupuestos as pre
	INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
	INNER JOIN doctors AS dc ON dc.id = pre.idDoctor
	INNER JOIN empresas as emp ON emp.id = pc.empresa_id
	WHERE pre.id = XID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerProveedores`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerProveedores`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerProveedores`()
BEGIN
  SELECT 	e.id, e.nombres, e.email, e.direccion, e.dni, e.telefono, e.celular, e.empresa,	e.ciudad,	e.ruc,
	e.banco,	e.nrocuenta,	e.insumo_id,	e.tipo_id
  FROM proveedors e
  WHERE e.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerProveedores_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerProveedores_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerProveedores_Id`(IN XID INT)
BEGIN
  SELECT e.id, e.nombres, e.email, e.direccion, e.dni, e.telefono, e.celular, e.empresa,	e.ciudad,	e.ruc,
	e.banco,	e.nrocuenta,	e.insumo_id,	e.tipo_id
  FROM proveedors e
  WHERE e.id = XID AND e.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerReferencias`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerReferencias`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerReferencias`()
BEGIN
  SELECT id, nombre FROM referencias;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTotalEgresos_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTotalEgresos_Fechas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTotalEgresos_Fechas`(IN XINI DATE, IN XFIN DATE)
BEGIN
	SELECT SUM(cantidad * precio_unitario) as egresos
		FROM egresos
	WHERE fecha BETWEEN XINI AND XFIN;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTotalEgresos_Reportes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTotalEgresos_Reportes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTotalEgresos_Reportes`()
BEGIN
	SELECT SUM(cantidad * precio_unitario) as egresos
		FROM egresos;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTotalIngresos_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTotalIngresos_Fechas`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTotalIngresos_Fechas`(IN XINI DATE, IN XFIN DATE)
BEGIN
	SELECT SUM(cantidad * monto) AS ingresos
		FROM ingresos_detalle
	WHERE fecha BETWEEN XINI AND XFIN;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTotalIngresos_Reportes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTotalIngresos_Reportes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTotalIngresos_Reportes`()
BEGIN
	SELECT SUM(cantidad * monto) AS ingresos
		FROM ingresos_detalle;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTratamientos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTratamientos`()
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.is_deleted = '0' ORDER BY t.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTratamientosDestacados_Fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientosDestacados_Fechas`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_ObtenerTratamientosDestacados_Fechas`(IN XINI DATE, IN XEND DATE)
BEGIN
	SELECT CONCAT(SUBSTRING(tratamientos.detalle, 1, 25),"... - S/.", sum(ingresos_detalle.cantidad * ingresos_detalle.monto)) as tratamiento,
				 count(tratamientos.detalle) as numero
	FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.precioId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	WHERE ingresos_detalle.fecha BETWEEN XINI AND XEND
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTratamientosDestacados_Reportes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientosDestacados_Reportes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTratamientosDestacados_Reportes`()
BEGIN
	SELECT CONCAT(SUBSTRING(tratamientos.detalle, 1, 25)," - S/.", sum(ingresos_detalle.cantidad * ingresos_detalle.monto)) as tratamiento,
				 count(tratamientos.detalle) as numero
	FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.precioId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerTratamientos_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientos_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerTratamientos_Id`(IN XID INT)
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.id = XID AND t.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerTratamientos_PacienteId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerTratamientos_PacienteId`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerTratamientos_PacienteId`(IN XID_PACIENTE INT)
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
--  Procedure definition for `OP_obtenerUltimoIngresoDetalle_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerUltimoIngresoDetalle_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoIngresoDetalle_Id`(IN XID_INGRESO INT)
BEGIN
	SELECT idt.id as lastIngresoDetalle FROM ingresos_detalle as idt ORDER BY idt.id DESC LIMIT 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerUltimoPago`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerUltimoPago`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoPago`()
BEGIN
	DECLARE NRO_PAGO INT;

	SELECT id INTO NRO_PAGO FROM pagos LIMIT 1;

	IF NRO_PAGO IS NULL THEN
			SELECT LPAD(1, 5, '00000') as pagos;
	ELSE
		SELECT LPAD(id+1, 5, '00000') as pagos FROM pagos ORDER BY id DESC LIMIT 1;
  END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerUltimoPresupuesto`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerUltimoPresupuesto`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoPresupuesto`()
BEGIN
	DECLARE NRO_PRESUPUESTO INT;

	SELECT id INTO NRO_PRESUPUESTO FROM presupuestos LIMIT 1;

	IF NRO_PRESUPUESTO IS NULL THEN
			SELECT LPAD(1, 5, '00000') as presupuesto;
	ELSE
		SELECT LPAD(id+1, 5, '00000') as presupuesto FROM presupuestos ORDER BY id DESC LIMIT 1;
  END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerUltimosDiezPacientes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerUltimosDiezPacientes`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimosDiezPacientes`()
SELECT id as hc, CONCAT(nombres, ' ', apellidos) as nombres
		FROM pacientes
	WHERE pacientes.is_deleted = 0
ORDER BY created_at DESC LIMIT 10
;
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerUltimosDiezPresupuestos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerUltimosDiezPresupuestos`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimosDiezPresupuestos`()
BEGIN
  SELECT presupuestos.id, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) AS pacientes, doctors.nombres as doctores
		FROM presupuestos
	INNER JOIN pacientes on pacientes.id = presupuestos.idPaciente
	INNER JOIN doctors on doctors.id = presupuestos.idDoctor
		WHERE presupuestos.is_deleted = 0
	ORDER BY fechahora DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_obtenerUserByEmail`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_obtenerUserByEmail`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUserByEmail`(IN XEMAIL VARCHAR(255))
BEGIN
	SELECT name, email, is_active, is_deleted
		FROM users WHERE email = XEMAIL;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerUsuarios`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerUsuarios`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerUsuarios`()
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, r.nombre AS rol
  FROM users u
  LEFT JOIN roles r ON u.rolid = r.id
  WHERE u.is_deleted = '0' ORDER BY u.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_ObtenerUsuarios_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerUsuarios_Id`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_ObtenerUsuarios_Id`(IN XID INT)
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, u.rolid, u.is_active
  FROM users u
  WHERE u.id = XID AND u.is_deleted = '0' ORDER BY u.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_pagos`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_pagos`;
DELIMITER ;;
CREATE DEFINER=`odontoguess`@`%` PROCEDURE `OP_pagos`()
BEGIN
  SELECT p.id, p.idDoctor, dr.nombres, dr.apellidos, p.fecha_inicio, p.fecha_fin, p.created_at, p.updated_at
  FROM pagos p
  INNER JOIN doctors dr ON dr.id = p.idDoctor
  WHERE p.is_deleted = '0';
END
;;
DELIMITER ;


-- ----------------------------
--  Records
-- ----------------------------
INSERT INTO `empresas` VALUES ('1','Empresa Default',NULL,'0','2018-11-01 08:58:15','2018-11-01 08:58:20');
INSERT INTO `migrations` VALUES ('17','2014_10_12_000000_create_users_table','1'), ('18','2014_10_12_100000_create_password_resets_table','1'), ('19','2018_09_25_213055_create_pacientes_table','1'), ('20','2018_09_28_160502_create_presupuestos_table','1'), ('21','2018_09_28_161330_create_presupuesto_detalles_table','1'), ('22','2018_10_06_151442_create_ingresos_table','1'), ('23','2018_10_11_101026_create_egresos_table','1'), ('24','2018_11_01_193909_create_doctors_table','1'), ('25','2018_11_01_193956_create_ingresos_detalle_table','1'), ('26','2018_11_01_194018_create_pagos_table','1'), ('27','2018_11_01_194044_create_proveedors_table','1'), ('28','2018_11_01_194103_create_proveedors_detalles_table','1'), ('29','2018_11_01_194304_create_empresas_table','1'), ('30','2018_11_01_194319_create_precios_table','1'), ('31','2018_11_01_194333_create_roles_table','1'), ('32','2018_11_01_194346_create_tratamientos_table','1');
INSERT INTO `precios` VALUES ('1','1','2','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('2','1','3','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('3','1','4','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('4','1','5','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('5','1','6','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('6','1','7','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('7','1','8','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('8','1','9','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('9','1','10','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('10','1','11','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('11','1','12','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('12','1','13','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('13','1','14','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('14','1','15','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('15','1','16','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('16','1','17','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('17','1','18','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('18','1','19','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('19','1','20','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('20','1','21','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('21','1','22','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('22','1','23','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('23','1','26','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('24','1','27','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('25','1','28','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('26','1','29','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('27','1','30','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('28','1','31','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24'), ('29','1','31','0.00','2018-11-01 23:35:24','2018-11-01 23:35:24');
INSERT INTO `roles` VALUES ('1','Administrador','Administrador','2018-11-01 22:20:26','2018-11-01 22:20:30'), ('2','Colaborador','Usuario Invitado','2018-11-01 22:20:32','2018-11-01 22:20:35');
INSERT INTO `tratamientos` VALUES ('2','Resina Simple Vestibular','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('3','Resina Simple Mesial','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('4','Resina Simple Distal','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('5','Resina Simple Palatino','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('6','Ionomero','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('7','Resina Simple Oclusal','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('8','Corona Fenestrada','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('9','Corona Metal Porcelana','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('10','Corona de Acero','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('11','Corona Free Metal','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('12','Exodoncia Simple','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('13','Exodoncia Compleja','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('14','Exodoncia 3ra Molar','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('15','Endodoncia Incisivo','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('16','Endodoncia de Premolar','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('17','Endodoncia Molar','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('18','Carillas Inyectada','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('19','Carilla Estratificada','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('20','Pulpotomia','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('21','Pulpectomia','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('22','Perno de Colado','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('23','Perno de Fibra de Vidrio','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('26','Incrustacion de Resina','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('27','Incrustacion de Porcelana','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('28','Incrustacion Metal','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('29','Resina Compuesta','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('30','Resina Compleja','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00'), ('31','Sellantes por pieza dental','1','0','0000-00-00 00:00:00','0000-00-00 00:00:00');
INSERT INTO `users` VALUES ('1','Admin','admin@gmail.com','$2y$10$IOjFvqRbX12o1ebCjRrMquyHQvK0HCinpEC1y1e70EK.JeiTi/r5q','1','1','0','IGNNHs4alZKWeZMr7ilIkMvVovTsQRbkIoIRdVSVlOWswR9G0W82yoWQPkUo','2018-11-01 22:25:08','2018-11-02 08:59:33');
