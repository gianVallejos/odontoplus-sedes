-- ----------------------------
--  Procedure definition for `OP_Doctors_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_add_all`(IN XNOMBRES VARCHAR(90), IN XAPELLIDOS VARCHAR(90),
																			 IN XDNI VARCHAR(8), IN XEMAIL VARCHAR(90),
																			 IN XDIRECCION VARCHAR(90), IN XFECHA_NACIMIENTO DATE,
																			 IN XGENERO VARCHAR(25), IN XESTADO VARCHAR(25), IN XTELEFONO VARCHAR(50),
																			 IN XCELULAR VARCHAR(50), IN XCELULAR_AUX VARCHAR(50), IN XMARGEN_GANANCIA DECIMAL(10, 0))
BEGIN
INSERT INTO doctors(nombres, apellidos, dni, email, direccion, fechanacimiento, genero, estado, telefono, celular, celular_aux, margen_ganancia, created_at, updated_at)
  VALUES (XNOMBRES, XAPELLIDOS, XDNI, XEMAIL, XDIRECCION, XFECHA_NACIMIENTO, XGENERO, XESTADO, XTELEFONO, XCELULAR, XCELULAR_AUX, XMARGEN_GANANCIA, NOW(), NOW());

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Doctors_delete_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_delete_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_delete_all_Id`(IN XID_DOCTOR INT)
BEGIN
	DELETE FROM doctors WHERE id = XID_DOCTOR;
	ALTER TABLE `doctors` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Doctors_es_borrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_es_borrable_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_es_borrable_Id`(IN XID_DOCTOR INT)
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
--  Procedure definition for `OP_Doctors_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_get_all`()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Doctors_get_all_DESC`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_get_all_DESC`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_get_all_DESC`()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0' ORDER BY d.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Doctors_get_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_get_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_get_all_Id`(IN XID INT)
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia,
         d.genero, d.estado, d.celular_aux, d.fechanacimiento
  FROM doctors d
  WHERE d.id = XID AND d.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Doctors_update_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Doctors_update_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Doctors_update_all_Id`(IN XNOMBRES VARCHAR(90), IN XAPELLIDOS VARCHAR(90),
																			 IN XDNI VARCHAR(8), IN XEMAIL VARCHAR(90),
																			 IN XDIRECCION VARCHAR(90), IN XFECHA_NACIMIENTO DATE,
																			 IN XGENERO VARCHAR(25), IN XESTADO VARCHAR(25), IN XTELEFONO VARCHAR(50),
																			 IN XCELULAR VARCHAR(50), IN XCELULAR_AUX VARCHAR(50),
																			 IN XMARGEN_GANANCIA DECIMAL(10, 0), IN XID INT)
BEGIN
  UPDATE doctors SET nombres = XNOMBRES, apellidos = XAPELLIDOS, dni = XDNI, email = XEMAIL,
                     direccion = XDIRECCION, fechanacimiento = XFECHA_NACIMIENTO, genero = XGENERO,
                     estado = XESTADO, telefono = XTELEFONO, celular = XCELULAR,
                     celular_aux = XCELULAR_AUX, margen_ganancia = XMARGEN_GANANCIA,
                     updated_at = NOW()
	WHERE id = XID;

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_add_all`(IN XFECHA           date, IN XCANTIDAD int, IN XCONCEPTO varchar(125),
	                                    IN XTIPO            varchar(125), IN XOBSERVACION varchar(125),
	                                    IN XPRECIO_UNITARIO decimal(6, 2), IN XSEDEID int)
BEGIN
INSERT INTO egresos(fecha, cantidad, concepto, tipo, observacion, precio_unitario, sedeId, created_at, updated_at)
  VALUES (XFECHA, XCANTIDAD, XCONCEPTO, XTIPO, XOBSERVACION, XPRECIO_UNITARIO, XSEDEID,NOW(), NOW());

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_add_all_doctor`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_add_all_doctor`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_add_all_doctor`(IN XFECHA           date, IN XCANTIDAD int, IN XCONCEPTO varchar(125),
	                                           IN XTIPO            varchar(125), IN XOBSERVACION varchar(125),
	                                           IN XPRECIO_UNITARIO decimal(6, 2), IN XSEDEID int, IN XDOCTOR_ID int)
BEGIN
INSERT INTO egresos(fecha, cantidad, concepto, tipo, observacion, precio_unitario, doctorId, sedeId, created_at, updated_at)
  VALUES (XFECHA, XCANTIDAD, XCONCEPTO, XTIPO, XOBSERVACION, XPRECIO_UNITARIO, XDOCTOR_ID, XSEDEID, NOW(), NOW());

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_delete_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_delete_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_delete_all_Id`(IN XID_EGRESO INT)
BEGIN
	DELETE FROM egresos WHERE id = XID_EGRESO;
	ALTER TABLE `egresos` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_get_all`()
BEGIN
		SELECT egresos.id, fecha, concepto, cantidad, precio_unitario as monto, SUM(cantidad * precio_unitario) as total,
					 tipo, doctors.apellidos as doctor, doctors.id as doctorId, observacion as nota, sedes.nombre as nombre_sede
			FROM egresos
		LEFT JOIN doctors on doctors.id = egresos.doctorId
		INNER JOIN sedes on sedes.id = egresos.sedeId
		WHERE egresos.is_deleted = 0
		GROUP BY egresos.id ORDER BY egresos.fecha DESC, egresos.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_get_all_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_get_all_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_get_all_fechas`(IN XDATE DATE)
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
--  Procedure definition for `OP_Egresos_get_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_get_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_get_all_Id`(IN XID INT)
BEGIN
	SELECT egresos.id, fecha, concepto, cantidad, precio_unitario as monto, SUM(cantidad * precio_unitario) as total, tipo,
				 doctors.apellidos as doctor, doctors.id as doctorId, observacion as nota, egresos.sedeId as sedeId
			FROM egresos
		LEFT JOIN doctors on doctors.id = egresos.doctorId
		WHERE egresos.is_deleted = 0 AND egresos.id = XID
		GROUP BY egresos.id;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_get_egresos_mensuales_anio`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_get_egresos_mensuales_anio`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_get_egresos_mensuales_anio`(IN anio varchar(4), IN sede_id int)
  BEGIN
	SET lc_time_names = 'es_ES';
	SELECT m.MONTH as mes, COALESCE(AMOUNT,0) as monto
	FROM
	( SELECT 1 AS MONTH
		UNION SELECT 2 AS MONTH
		UNION SELECT 3 AS MONTH
		UNION SELECT 4 AS MONTH
		UNION SELECT 5 AS MONTH
		UNION SELECT 6 AS MONTH
		UNION SELECT 7 AS MONTH
		UNION SELECT 8 AS MONTH
		UNION SELECT 9 AS MONTH
		UNION SELECT 10 AS MONTH
		UNION SELECT 11 AS MONTH
		UNION SELECT 12 AS MONTH ) AS m
	LEFT JOIN
	( SELECT MONTH(e.fecha) as MONTH, SUM(e.cantidad * e.precio_unitario) as AMOUNT
		FROM egresos as e
		WHERE YEAR(e.fecha ) = anio
		AND (sede_id IS NULL OR e.sedeId = sede_id)
		GROUP BY (MONTH(e.fecha))) AS e ON m.MONTH = e.MONTH
	ORDER BY m.MONTH;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_update_all_doctor_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_update_all_doctor_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_update_all_doctor_Id`(IN XFECHA           date, IN XCANTIDAD int, IN XCONCEPTO varchar(125),
	                                                 IN XTIPO            varchar(125), IN XOBSERVACION varchar(125),
	                                                 IN XPRECIO_UNITARIO decimal(6, 2), IN XDOCTOR_ID int, IN XSEDEID int, IN XID int)
BEGIN
	UPDATE egresos
		SET fecha = XFECHA, cantidad = XCANTIDAD, concepto = XCONCEPTO,
				tipo = XTIPO, observacion = XOBSERVACION, precio_unitario = XPRECIO_UNITARIO,
				doctorId = XDOCTOR_ID, sedeId=XSEDEID, updated_at = NOW()
		WHERE egresos.id = XID;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Egresos_update_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Egresos_update_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Egresos_update_all_Id`(IN XFECHA           date, IN XCANTIDAD int, IN XCONCEPTO varchar(125),
	                                          IN XTIPO            varchar(125), IN XOBSERVACION varchar(125),
	                                          IN XPRECIO_UNITARIO decimal(6, 2), IN XSEDEID int, IN XID int)
BEGIN
	UPDATE egresos
		SET fecha = XFECHA, cantidad = XCANTIDAD, concepto = XCONCEPTO,
				tipo = XTIPO, observacion = XOBSERVACION, precio_unitario = XPRECIO_UNITARIO,
				doctorId = NULL, sedeId=XSEDEID,updated_at = NOW()
		WHERE egresos.id = XID;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_add_all`(IN XNOMBRE VARCHAR(120), IN XRUC VARCHAR(12))
BEGIN
  INSERT INTO empresas(nombre, ruc, created_at, updated_at)
    VALUES (XNOMBRE, XRUC, NOW(), NOW());

	SELECT ROW_COUNT() AS ESTADO, LAST_INSERT_ID() AS LAST_ID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_delete_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_delete_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_delete_all`(IN XID INT)
BEGIN
	DELETE FROM empresas
		WHERE empresas.id = XID;

	DELETE FROM precios
		WHERE precios.idEmpresa = XID;

	ALTER TABLE empresas AUTO_INCREMENT = 1;
	ALTER TABLE precios AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_es_borrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_es_borrable_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_es_borrable_Id`(IN XID INT)
BEGIN
	DECLARE empresa_status INT;

	SELECT COUNT(*) INTO empresa_status
		FROM pacientes
	WHERE empresa_id = XID;

	IF empresa_status = "0" THEN
		SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
	ELSE
		SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
	END IF;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_get_all`()
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_get_all_desc`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_get_all_desc`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_get_all_desc`()
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.is_deleted = '0' ORDER BY e.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_get_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_get_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_get_all_Id`(IN XID INT)
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.id = XID AND e.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Empresas_update_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Empresas_update_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Empresas_update_all_Id`(IN XNOMBRE VARCHAR(120), IN XRUC VARCHAR(12), IN XID INT)
BEGIN
  UPDATE empresas SET nombre = XNOMBRE, ruc = XRUC, updated_at = NOW()
    WHERE empresas.id = XID;

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_add_all`(IN XPACIENTE_ID INT)
BEGIN
INSERT INTO ingresos(idPaciente, created_at, updated_at)
  VALUES (XPACIENTE_ID, NOW(), NOW());

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_delete_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_delete_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_delete_all_Id`(IN XID_PACIENTE INT)
BEGIN
	DELETE FROM ingresos WHERE idPaciente = XID_PACIENTE;
	ALTER TABLE `ingresos` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_Detalle_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_Detalle_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_Detalle_add_all`(IN XID_INGRESO int, IN XID_PRECIO int, IN XCANTIDAD int,
	                                             IN XMONTO      decimal(11, 2), IN XFECHA date, IN XSEDEID int,
	                                             IN XDOCTOR     int)
	BEGIN
		DECLARE MONTO_TOTAL DECIMAL(11, 2);
		DECLARE XMARGEN DECIMAL(10, 0);

		SELECT margen_ganancia INTO XMARGEN FROM doctors WHERE doctors.id = XDOCTOR;

		INSERT INTO ingresos_detalle(ingresoId, precioId, cantidad, monto, fecha, doctorId, margen_ganancia, sedeId)
			VALUES (XID_INGRESO, XID_PRECIO, XCANTIDAD, XMONTO, XFECHA, XDOCTOR, XMARGEN, XSEDEID);

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_Detalle_delete_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_Detalle_delete_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_Detalle_delete_all`(IN XID INT)
BEGIN
	DELETE FROM ingresos_detalle WHERE ingresos_detalle.id = XID;
	ALTER TABLE ingresos_detalle AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_Detalle_get_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_Detalle_get_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_Detalle_get_all_Id`(IN XID_INGRESO INT)
BEGIN
	SELECT idt.id, trat.id as idTratamiento, trat.detalle as tratamiento,
				 doc.id as idDoctor, CONCAT(doc.nombres, ' ', doc.apellidos) as nombreDoctor, sed.nombre as nombre_sede,
				 idt.cantidad * idt.monto as total,
				 ROUND(IFNULL(SUM(idt.monto * idt.cantidad) * doc.margen_ganancia/100, 0), 2) as mg,
				 ROUND(IFNULL(SUM(idt.monto * idt.cantidad) - (SUM(idt.monto * idt.cantidad) * doc.margen_ganancia/100), 0), 2) as mg_core,
				 idt.cantidad, idt.monto, idt.fecha as fecha, idt.sedeId as sede
		FROM ingresos
		INNER JOIN ingresos_detalle as idt on ingresos.id = idt.ingresoId
		INNER JOIN sedes as sed on sed.id = idt.sedeId
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
--  Procedure definition for `OP_Ingresos_Detalle_get_all_total_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_Detalle_get_all_total_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_Detalle_get_all_total_Id`(IN XID_INGRESO_DETALLE INT)
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
--  Procedure definition for `OP_Ingresos_Detalle_get_ultimo_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_Detalle_get_ultimo_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_Detalle_get_ultimo_Id`(IN XID_INGRESO INT)
BEGIN
	SELECT idt.id as lastIngresoDetalle FROM ingresos_detalle as idt ORDER BY idt.id DESC LIMIT 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_Detalle_update_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_Detalle_update_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_Detalle_update_all`(IN XID_INGRESO INT, IN XID_PRECIO INT, IN XCANTIDAD INT, IN XMONTO DECIMAL(11, 2), IN XID INT, IN XFECHA DATE, IN XDOCTOR INT)
BEGIN
		DECLARE MONTO_TOTAL DECIMAL(11, 2);

		UPDATE ingresos_detalle SET ingresoId = XID_INGRESO, precioId = XID_PRECIO, cantidad = XCANTIDAD, monto = XMONTO, fecha = XFECHA, doctorId = XDOCTOR
		WHERE ingresos_detalle.id = XID;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_es_borrable_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_es_borrable_id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_es_borrable_id`(IN XID_INGRESO INT)
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
--  Procedure definition for `OP_Ingresos_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_all`()
BEGIN
	SELECT ingresos.id as id, pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as nombrePaciente,
			 ingresos.created_at as fecha,
			 IFNULL(SUM(idt.cantidad * idt.monto), 0) as monto_total, prs.id as presupuestoId
		FROM `ingresos`
	INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
  LEFT JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	LEFT JOIN presupuestos as prs on prs.idPaciente = ingresos.idPaciente
		WHERE ingresos.is_deleted = 0
		GROUP BY ingresos.id ORDER BY ingresos.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_all_by_doctor_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_all_by_doctor_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_all_by_doctor_fechas`(IN doctor_id int, IN start_date date, IN end_date date)
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

DROP PROCEDURE IF EXISTS `OP_Ingresos_get_ganancias_sede_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_ganancias_sede_fechas`(IN sede_id int, IN start_date date, IN end_date date)
  BEGIN
    SELECT idt.id, LPAD(ing.idPaciente, 5, '00000') as historia, dr.id as doctorId, dr.nombres,dr.apellidos, tr.detalle as tratamiento,
					 idt.cantidad, idt.monto, (idt.cantidad * idt.monto) as total, sd.nombre as nombre_sede,
           FORMAT((idt.margen_ganancia/100 * idt.cantidad * idt.monto), 2) as doctor, DATE_FORMAT(idt.fecha, "%d-%m-%Y") as fecha
    	 FROM ingresos_detalle idt
    INNER JOIN ingresos ing ON ing.id = idt.ingresoId
    INNER JOIN doctors dr ON dr.id = idt.doctorId
    INNER JOIN precios pr ON pr.id = idt.precioId
    INNER JOIN tratamientos tr ON tr.id = pr.idTratamiento
    INNER JOIN sedes sd ON sd.id = idt.sedeId
			WHERE ( sede_id IS NULL OR idt.sedeId = sede_id )
			AND idt.fecha BETWEEN start_date AND end_date;

END
;;
DELIMITER ;
-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_all_Id`(IN XID INT)
BEGIN
	SELECT LPAD(ingresos.id, 5, '0') as id, LPAD(pacientes.id, 5, '0') as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as nombrePaciente,
				 ingresos.created_at as fecha, pacientes.sede_id as pacienteSedeId,
				 IFNULL(SUM(ingresos_detalle.cantidad * ingresos_detalle.monto), 0) as monto_total, prs.id as presupuestoId
		FROM `ingresos`
	INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	LEFt JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
	LEFT JOIN presupuestos as prs on prs.idPaciente = ingresos.idPaciente
		WHERE ingresos.id = XID AND ingresos.is_deleted = 0
	ORDER BY ingresos.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_ingresos_mensuales_anio`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_ingresos_mensuales_anio`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_ingresos_mensuales_anio`(IN anio varchar(4), IN sede_id int)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT m.MONTH as mes, COALESCE(AMOUNT,0) as monto
	FROM
	( SELECT 1 AS MONTH
		UNION SELECT 2 AS MONTH
		UNION SELECT 3 AS MONTH
		UNION SELECT 4 AS MONTH
		UNION SELECT 5 AS MONTH
		UNION SELECT 6 AS MONTH
		UNION SELECT 7 AS MONTH
		UNION SELECT 8 AS MONTH
		UNION SELECT 9 AS MONTH
		UNION SELECT 10 AS MONTH
		UNION SELECT 11 AS MONTH
		UNION SELECT 12 AS MONTH ) AS m
	LEFT JOIN
	( SELECT MONTH(idt.fecha) as MONTH, SUM(idt.cantidad * idt.monto) as AMOUNT
		FROM ingresos_detalle as idt
		WHERE YEAR(idt.fecha ) = anio
		AND (sede_id IS NULL OR idt.sedeId = sede_id)
		GROUP BY (MONTH(idt.fecha)) ) AS i ON m.MONTH = i.MONTH
	ORDER BY m.MONTH;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_ingresos_por_doctor_doctor_id_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_ingresos_por_doctor_doctor_id_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_ingresos_por_doctor_doctor_id_fechas`(IN doctor_id int, IN start_date date,
                                                                      IN end_date  date)
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
--  Procedure definition for `OP_Ingresos_get_ingresos_por_doctor_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_ingresos_por_doctor_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_ingresos_por_doctor_fechas`(IN start_date date, IN end_date date, IN xsede_id int)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT dr.nombres, dr.apellidos, FORMAT(IFNULL(SUM((1 - dr.margen_ganancia/100) * idt.cantidad * idt.monto), 0),2) as ingreso
	FROM ingresos_detalle idt
	INNER JOIN doctors dr ON dr.id = idt.doctorId
	WHERE idt.fecha BETWEEN start_date AND end_date
	AND (xsede_id IS NULL OR idt.sedeId = xsede_id)
	GROUP BY dr.id
	ORDER By ingreso ASC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_ingresos_por_paciente_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_ingresos_por_paciente_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_ingresos_por_paciente_fechas`(IN XINI date, IN XFIN date, IN XSEDEID int)
  BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(idt.cantidad * idt.monto) as monto
		FROM ingresos INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	WHERE idt.fecha BETWEEN XINI AND XFIN
  AND (XSEDEID IS NULL OR idt.sedeId = XSEDEID)
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_monto_total_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_monto_total_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_monto_total_Id`(IN XID_INGRESO INT)
BEGIN

	SELECT SUM(idt.cantidad * idt.monto) as total FROM ingresos
		INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	WHERE ingresos.id = XID_INGRESO;

END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_presupuestos_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_presupuestos_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_presupuestos_Id`(IN XID_INGRESO INT)
BEGIN
	SELECT presupuestos.id FROM presupuestos
		INNER JOIN pacientes on pacientes.id = presupuestos.idPaciente
		INNER JOIN ingresos on ingresos.idPaciente = presupuestos.idPaciente
	WHERE ingresos.id = XID_INGRESO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Ingresos_get_totales_by_doctor_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_totales_by_doctor_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_totales_by_doctor_fechas`(IN doctor_id int, IN start_date date, IN end_date date)
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
--  Procedure definition for `OP_Ingresos_get_totales_doctor_id_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Ingresos_get_totales_doctor_id_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_get_totales_doctor_id_fechas`(IN doctor_id int, IN start_date date, IN end_date date)
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
--  Procedure definition for `OP_Pacientes_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_add_all`(IN XNOMBRES           varchar(90), IN XAPELLIDOS varchar(90), IN XDNI varchar(8),
	                                      IN XEMAIL             varchar(90), IN XDIRECCION varchar(90),
	                                      IN XFECHA_NACIMIENTO  date, IN XGENERO varchar(25), IN XESTADO varchar(25),
	                                      IN XTELEFONO          varchar(50), IN XFAX varchar(50), IN XCELULAR varchar(50),
	                                      IN XCELULAR_AUX       varchar(50), IN XID_EMPRESA int, IN XID_SEGURO_IND int,
	                                      IN XNOMBRE_APODERADO  varchar(150), IN XCELULAR_APODERADO varchar(150),
	                                      IN XREFERENCIA_ID     int, IN XSEDE_ID int)
BEGIN
	INSERT INTO pacientes(nombres, apellidos, dni, email, direccion, fechanacimiento, genero, estado, telefono, fax,
										celular, celular_aux, empresa_id, seguro_ind, nombre_apoderado, celular_apoderado,
										referencia_id, created_at, updated_at, sede_id)
	VALUES (XNOMBRES, XAPELLIDOS, XDNI, XEMAIL, XDIRECCION, XFECHA_NACIMIENTO, XGENERO, XESTADO, XTELEFONO, XFAX,
					XCELULAR, XCELULAR_AUX, XID_EMPRESA, XID_SEGURO_IND, XNOMBRE_APODERADO, XCELULAR_APODERADO,
					XREFERENCIA_ID, NOW(), NOW(), XSEDE_ID);

	SELECT ROW_COUNT() AS ESTADO, LAST_INSERT_ID() AS LAST_ID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_delete_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_delete_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_delete_all_Id`(IN XID_PACIENTE INT)
BEGIN
	DELETE FROM pacientes WHERE id = XID_PACIENTE;
	ALTER TABLE `pacientes` AUTO_INCREMENT = 1;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_es_borrable_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_es_borrable_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_es_borrable_Id`(IN XID_PACIENTE INT)
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
--  Procedure definition for `OP_Pacientes_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_all`()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero,
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, pc.referencia_id,
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id,
				 emp.nombre as empresa_nombre, pc.sede_id, sed.nombre as sede_nombre, ing.id as ingresoId
		FROM pacientes as pc
	INNER JOIN sedes as sed on sed.id = pc.sede_id
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	INNER JOIN ingresos as ing on ing.idPaciente = pc.id
		ORDER BY pc.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_get_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_all_Id`(IN XID INT)
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero,
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, pc.referencia_id,
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id,
				 pc.sede_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.id = XID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_get_empresa_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_empresa_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_empresa_Id`(IN XID_PACIENTE INT)
BEGIN
	SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_get_for_search`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_for_search`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_for_search`()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero,
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, pc.referencia_id,
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre, ingresos.id as ingresoId,
				 presupuestos.id as presupuestosId
		FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	INNER JOIN ingresos on ingresos.idPaciente = pc.id
	LEFT JOIN presupuestos on presupuestos.idPaciente = pc.id
		ORDER BY pc.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_get_pacientes_creados_por_mes_anio_actual`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_pacientes_creados_por_mes_anio_actual`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_pacientes_creados_por_mes_anio_actual`()
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT m.MONTH as mes, COALESCE(cantidad,0) as cantidad
	FROM
	( SELECT 1 AS MONTH
		UNION SELECT 2 AS MONTH
		UNION SELECT 3 AS MONTH
		UNION SELECT 4 AS MONTH
		UNION SELECT 5 AS MONTH
		UNION SELECT 6 AS MONTH
		UNION SELECT 7 AS MONTH
		UNION SELECT 8 AS MONTH
		UNION SELECT 9 AS MONTH
		UNION SELECT 10 AS MONTH
		UNION SELECT 11 AS MONTH
		UNION SELECT 12 AS MONTH ) AS m
	LEFT JOIN
	( SELECT MONTH(p.created_at) as MONTH, COUNT(p.Id) cantidad
		FROM pacientes as p
		WHERE YEAR(p.created_at ) = YEAR(CURDATE())
		GROUP BY MONTH(p.created_at)) AS p ON m.MONTH = p.MONTH
	ORDER BY m.MONTH;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_get_pacientes_creados_por_mes_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_pacientes_creados_por_mes_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_pacientes_creados_por_mes_fechas`(IN start_date date, IN end_date date,
                                                                   IN xsede_id   int)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(p.created_at) mes, COUNT(p.Id) cantidad
	FROM pacientes p
	WHERE p.created_at BETWEEN start_date AND end_date
  AND (xsede_id IS NULL OR p.sede_id = xsede_id)
	GROUP BY MONTHNAME(p.created_at)
	ORDER BY MONTH(p.created_at);
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_get_pacientes_por_canal_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_get_pacientes_por_canal_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_pacientes_por_canal_fechas`(IN start_date date, IN end_date date, IN xsede_id int)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT r.nombre canal, COUNT(p.Id) cantidad
	FROM pacientes p
	INNER JOIN referencias r ON p.referencia_id = r.id
	WHERE p.created_at BETWEEN start_date AND end_date
  AND (xsede_id IS NULL OR p.sede_id = xsede_id)
	GROUP BY r.id
	ORDER By cantidad DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pacientes_update_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pacientes_update_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_update_all_Id`(IN XNOMBRES          varchar(90), IN XAPELLIDOS varchar(90),
	                                            IN XDNI              varchar(8), IN XEMAIL varchar(90),
	                                            IN XDIRECCION        varchar(90), IN XFECHA_NACIMIENTO date,
	                                            IN XGENERO           varchar(25), IN XESTADO varchar(25),
	                                            IN XTELEFONO         varchar(50), IN XFAX varchar(50),
	                                            IN XCELULAR          varchar(50), IN XCELULAR_AUX varchar(50),
	                                            IN XID_EMPRESA       int, IN XID_SEGURO_IND int,
	                                            IN XNOMBRE_APODERADO varchar(150), IN XCELULAR_APODERADO varchar(150),
	                                            IN XREFERENCIA_ID    int, IN XSEDE_ID int, IN XID int)
BEGIN
	UPDATE pacientes SET nombres = XNOMBRES, apellidos = XAPELLIDOS, dni = XDNI, email = XEMAIL,
											 direccion = XDIRECCION, fechanacimiento = XFECHA_NACIMIENTO, genero = XGENERO,
											 estado = XESTADO, telefono = XTELEFONO, fax = XFAX, celular = XCELULAR,
											 celular_aux = XCELULAR_AUX, empresa_id = XID_EMPRESA, seguro_ind = XID_SEGURO_IND,
											 nombre_apoderado = XNOMBRE_APODERADO, celular_apoderado = XCELULAR_APODERADO,
											 referencia_id = XREFERENCIA_ID, updated_at = NOW(), sede_id = XSEDE_ID
	WHERE pacientes.id = XID;

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pagos_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pagos_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pagos_add_all`(IN XID_DOCTOR INT, IN XFECHA_INICIO DATE, IN XFECHA_FIN DATE)
BEGIN
		INSERT INTO pagos(idDoctor, fecha_inicio, fecha_fin, created_at, updated_at)
			VALUES (XID_DOCTOR, XFECHA_INICIO, XFECHA_FIN, NOW(), NOW());
		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pagos_delete_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pagos_delete_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pagos_delete_all`(IN XID_PAGO INT)
BEGIN
	UPDATE pagos SET is_deleted = 1 WHERE pagos.id = XID_PAGO;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pagos_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pagos_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pagos_get_all`()
BEGIN
  SELECT p.id, p.idDoctor, dr.nombres, dr.apellidos, p.fecha_inicio, p.fecha_fin, p.created_at, p.updated_at
  FROM pagos p
  INNER JOIN doctors dr ON dr.id = p.idDoctor
  WHERE p.is_deleted = '0' ORDER BY p.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pagos_get_pagos_por_doctor_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pagos_get_pagos_por_doctor_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pagos_get_pagos_por_doctor_fechas`(IN start_date date, IN end_date date, IN xsede_id int)
BEGIN
	SET lc_time_names = 'es_ES';
  SELECT dr.nombres, dr.apellidos, FORMAT(IFNULL(SUM(dr.margen_ganancia/100 * idt.cantidad * idt.monto), 0),2) as pago
  FROM ingresos_detalle idt
  INNER JOIN doctors dr ON dr.id = idt.doctorId
	WHERE idt.fecha BETWEEN start_date AND end_date
  AND (xsede_id IS NULL OR idt.sedeId = xsede_id)
  GROUP BY dr.id
	ORDER By pago;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Pagos_get_ultimo`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Pagos_get_ultimo`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pagos_get_ultimo`()
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
--  Procedure definition for `OP_Precios_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Precios_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Precios_add_all`(IN empresaId int, IN tratamientoId int, IN precio decimal)
BEGIN
  INSERT INTO precios (idEmpresa, idTratamiento, monto, created_at, updated_at) values (empresaId, tratamientoId, precio, NOW(), NOW());
  SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Precios_get_all_by_empresa_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Precios_get_all_by_empresa_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Precios_get_all_by_empresa_Id`(IN XID_EMPRESA INT)
BEGIN
	select trat.id, trat.detalle, emprc.monto from precios as emprc
		inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA order by idTratamiento;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Precios_get_all_for_table_by_empresa_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Precios_get_all_for_table_by_empresa_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Precios_get_all_for_table_by_empresa_Id`(IN XID_EMPRESA INT)
BEGIN
	select trat.id, trat.detalle, emprc.monto from precios as emprc
		inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA and trat.id > 7 and trat.id != 29 and trat.id != 30 order by idTratamiento;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Precios_get_all_standard`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Precios_get_all_standard`;
DELIMITER ;;
CREATE PROCEDURE `OP_Precios_get_all_standard`()
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
--  Procedure definition for `OP_Precios_get_by_empresa_tratamiento_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Precios_get_by_empresa_tratamiento_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Precios_get_by_empresa_tratamiento_Id`(IN empresaId INT, IN tratamientoId INT)
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  WHERE precios.idEmpresa = empresaId AND precios.idTratamiento = tratamientoId;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Precios_update_monto_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Precios_update_monto_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Precios_update_monto_Id`(IN XMONTO DECIMAL(10, 2), IN XID INT)
BEGIN
	UPDATE precios SET monto = XMONTO, updated_at = NOW() WHERE precios.id = XID;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuestos_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_add_all`(IN ID_PRESUPUESTO INT, IN XID_PACIENTE INT, IN XID_DOCTOR INT, IN XDESCUENTO INT)
BEGIN
    INSERT INTO presupuestos(id, fechahora, idPaciente, idDoctor, descuento, created_at, updated_at)
      VALUES (ID_PRESUPUESTO, NOW(), XID_PACIENTE, XID_DOCTOR, XDESCUENTO, NOW(), NOW());

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuestos_delete_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_delete_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_delete_all_Id`(IN XID_PRESUPUESTO INT)
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
--  Procedure definition for `OP_Presupuestos_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_get_all`()
BEGIN
	SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento,
				 CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente,
				 CONCAT(dc.nombres, ' ', dc.apellidos) AS nombreDoctor,
				 ingresos.id as ingresosId
	FROM presupuestos as pre
	INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
	INNER JOIN doctors AS dc ON dc.id = pre.idDoctor
	INNER JOIN ingresos ON ingresos.idPaciente = pre.idPaciente
	ORDER BY pre.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuestos_get_by_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_get_by_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_get_by_Id`(IN XID INT)
BEGIN
	SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento,
				 CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente,
				 CONCAT(dc.nombres, ' ', dc.apellidos) AS nombreDoctor,
				 emp.nombre as empresa,
				 ingresos.id as ingresosId
		FROM presupuestos as pre
	INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
	INNER JOIN doctors AS dc ON dc.id = pre.idDoctor
	INNER JOIN empresas as emp ON emp.id = pc.empresa_id
	INNER JOIN ingresos ON ingresos.idPaciente = pre.idPaciente
	WHERE pre.id = XID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuestos_get_doctores`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_get_doctores`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_get_doctores`(IN XID_DOCTOR INT)
BEGIN
	SELECT id as id, nombres as nombres, apellidos as apellidos, margen_ganancia
		FROM doctors WHERE id = XID_DOCTOR;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuestos_get_last_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_get_last_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_get_last_Id`()
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
--  Procedure definition for `OP_Presupuestos_get_pacientes`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuestos_get_pacientes`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuestos_get_pacientes`(IN XID_PACIENTES INT)
BEGIN
	SELECT LPAD(pacientes.id, 5, '0') as id, pacientes.nombres, pacientes.apellidos, empresas.nombre as empresa, pacientes.empresa_id
		FROM pacientes
		INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE pacientes.id = XID_PACIENTES;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuesto_Detalles_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuesto_Detalles_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuesto_Detalles_add_all`(IN XID_PRESUPUESTO INT, IN XPIEZA INT, XSECCION INT, IN XSECUNO INT, IN XSECDOS INT, IN XOPCION INT, IN XMONTO DECIMAL(10, 2))
BEGIN
		INSERT INTO presupuesto_detalles(idPresupuesto, pieza, seccion, secUno, secDos, opcion, monto)
		VALUES(XID_PRESUPUESTO, XPIEZA, XSECCION, XSECUNO, XSECDOS, XOPCION, XMONTO);

		SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Presupuesto_Detalles_by_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Presupuesto_Detalles_by_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Presupuesto_Detalles_by_Id`(IN XID INT)
BEGIN
	SELECT id, pieza, seccion, secUno, secDos, opcion, monto FROM presupuesto_detalles
		WHERE idPresupuesto = XID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Referencias_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Referencias_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Referencias_get_all`()
BEGIN
  SELECT id, nombre FROM referencias;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamientos_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamientos_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamientos_add_all`(IN XDETALLE VARCHAR(120))
BEGIN
  INSERT INTO tratamientos (detalle, created_at, updated_at)
  VALUES (XDETALLE, NOW(), NOW());

	SELECT ROW_COUNT() AS ESTADO, LAST_INSERT_ID() AS LAST_ID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamientos_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamientos_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamientos_get_all`()
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.is_deleted = '0' ORDER BY t.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamientos_get_all_pacienteId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamientos_get_all_pacienteId`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamientos_get_all_pacienteId`(IN XID_PACIENTE INT)
BEGIN
	DECLARE XID_EMPRESA INT;

	SELECT empresa_id INTO XID_EMPRESA FROM pacientes where pacientes.id = XID_PACIENTE;

	SELECT precios.id, detalle, monto FROM precios
		INNER JOIN tratamientos ON precios.idTratamiento = tratamientos.id
	WHERE idEmpresa = XID_EMPRESA ORDER BY (tratamientos.id);
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamientos_get_tratamientos_destacados_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamientos_get_tratamientos_destacados_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamientos_get_tratamientos_destacados_fechas`(IN XINI date, IN XEND date, IN xsede_id int)
  BEGIN
	SELECT CONCAT(SUBSTRING(tratamientos.detalle, 1, 25),"... - S/.", sum(ingresos_detalle.cantidad * ingresos_detalle.monto)) as tratamiento,
				 count(tratamientos.detalle) as numero
	FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.precioId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	WHERE ingresos_detalle.fecha BETWEEN XINI AND XEND
	AND (xsede_id IS NULL OR ingresos_detalle.sedeId = xsede_id)
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamientos_get_tratamientos_por_doctor_fechas`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamientos_get_tratamientos_por_doctor_fechas`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamientos_get_tratamientos_por_doctor_fechas`(IN start_date date, IN end_date date,
                                                                    IN xsede_id   int)
  BEGIN
	SET lc_time_names = 'es_ES';
  SELECT dr.nombres, dr.apellidos, COUNT(idt.id) as nro_tratamientos
  FROM ingresos_detalle idt
  INNER JOIN precios pr ON pr.id = idt.precioId
  INNER JOIN doctors dr ON dr.id = idt.doctorId
  INNER JOIN tratamientos tr ON tr.id = idt.precioId
	WHERE idt.fecha BETWEEN start_date AND end_date
  AND (xsede_id IS NULL OR idt.sedeId = xsede_id)
  GROUP BY dr.id
	ORDER By nro_tratamientos DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamientos_update_all_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamientos_update_all_id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamientos_update_all_id`(IN XID INT(11), IN XDETALLE VARCHAR(120))
BEGIN
  UPDATE tratamientos
	   SET detalle = XDETALLE, updated_at = NOW()
	WHERE id = XID;

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Tratamiento_delete_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamiento_delete_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamiento_delete_Id`(IN XID_TRATAMIENTO int)
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
--  Procedure definition for `OP_Tratamiento_es_borrable_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamiento_es_borrable_id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamiento_es_borrable_id`(IN XID_TRATAMIENTO int)
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
--  Procedure definition for `OP_Tratamiento_get_all_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Tratamiento_get_all_id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Tratamiento_get_all_id`(IN XID int)
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.id = XID AND t.is_deleted = '0';
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Citas_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Citas_add_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Citas_add_all`(IN XTITULO     varchar(200), IN XFECHA date, IN XDESDE time, IN XHASTA time,
                                   	 IN XIDPACIENTE int, IN XIDDOCTOR int, IN XIDSEDE int)
BEGIN
	INSERT INTO citas(titulo, fecha, desde, hasta, idPaciente, idDoctor, idSede)
			VALUES (XTITULO, XFECHA, XDESDE, XHASTA, XIDPACIENTE, XIDDOCTOR, XIDSEDE);
	SELECT ROW_COUNT() AS ESTADO, LAST_INSERT_ID() AS LAST_ID;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Citas_delete_all_Id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Citas_delete_all_Id`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Citas_delete_all_Id`(IN XID INT)
BEGIN
	DELETE FROM citas
		WHERE id = XID;
	ALTER TABLE `citas` AUTO_INCREMENT = 1;
  SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Citas_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Citas_get_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Citas_get_all`()
BEGIN
	SELECT c.id as idEvent, c.titulo as title, c.idPaciente, c.idDoctor, fecha,
				 CONCAT(c.fecha, ' ', c.desde) as start, CONCAT(c.fecha, ' ', c.hasta) as end, sed.nombre as nombre_sede
		FROM citas c
	INNER JOIN  sedes sed ON sed.id = c.idSede;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Citas_get_all_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Citas_get_all_id`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Citas_get_all_id`(IN XID INT)
BEGIN
	SELECT c.id as idEvent, c.titulo as title, c.idDoctor as idDoctor, c.idPaciente as idPaciente, idSede as idSede,
				 c.fecha as fecha, c.desde as start, c.hasta as end
		FROM citas c
	WHERE c.id = XID;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS `OP_Citas_get_all_by_doctor_sede`;
DELIMITER ;;
CREATE PROCEDURE `OP_Citas_get_all_by_doctor_sede`(IN doctorId int, IN sedeId int)
BEGIN
	SELECT c.id as idEvent, c.titulo as title, c.idPaciente, c.idDoctor, c.idSede, fecha,
				 CONCAT(c.fecha, ' ', c.desde) as start, CONCAT(c.fecha, ' ', c.hasta) as end
		FROM citas c
	WHERE ( doctorId IS NULL OR c.idDoctor = doctorId )
		AND ( sedeId IS NULL OR c.idSede = sedeId);
END
;;
DELIMITER ;
-- ----------------------------
--  Procedure definition for `OP_Citas_update_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Citas_update_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Citas_update_all`(IN XID    int, IN XTITULO varchar(200), IN XFECHA date, IN XDESDE time,
                                      	IN XHASTA time, IN XIDPACIENTE int, IN XIDDOCTOR int, IN XIDSEDE int)
BEGIN
	UPDATE citas SET titulo = XTITULO, fecha = XFECHA, desde = XDESDE, hasta = XHASTA, idPaciente = XIDPACIENTE,
									 idDoctor = XIDDOCTOR, idSede = XIDSEDE
		WHERE citas.id = XID;

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Citas_update_fecha_cita`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Citas_update_fecha_cita`;
DELIMITER ;;
CREATE PROCEDURE `OP_Citas_update_fecha_cita`(IN XFECHA DATE, IN XID INT)
BEGIN
	UPDATE citas SET fecha = XFECHA WHERE citas.id = XID;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `OP_Citas_get_all_doctor_id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Citas_get_all_doctor_id`(IN doctorId int)
BEGIN
	SELECT c.id as idEvent, c.titulo as title, c.idPaciente, c.idDoctor, c.idSede, fecha,
				 CONCAT(c.fecha, ' ', c.desde) as start, CONCAT(c.fecha, ' ', c.hasta) as end
		FROM citas c
	WHERE c.idDoctor = doctorId;
END
;;
DELIMITER ;
-- ----------------------------
--  Sedes
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Sedes_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Sedes_get_all`()
BEGIN
	SELECT id, nombre, ciudad, direccion, telefono, celular, celular_aux, email
	FROM sedes;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `OP_Sedes_get_all_id`;
DELIMITER ;;
CREATE PROCEDURE OP_Sedes_get_all_id(IN XID int)
BEGIN
	SELECT se.id, se.nombre, se.ciudad, se.direccion, se.telefono, se.celular, se.celular_aux, se.email
	FROM sedes se
  WHERE se.id = XID;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `OP_Sedes_get_all_by_paciente_id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Sedes_get_all_by_paciente_id`(IN XPACIENTEID int)
BEGIN
	SELECT se.id, se.nombre, se.ciudad, se.direccion, se.telefono, se.celular, se.celular_aux, se.email
		FROM sedes se
		INNER JOIN pacientes pc ON pc.sede_id = se.id
  WHERE pc.id = XPACIENTEID;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `OP_Sedes_add_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Sedes_add_all`(IN XNOMBRE varchar(150),   IN XCIUDAD varchar(150),  IN XDIRECCION varchar(100),
	                                  IN XTELEFONO varchar(200), IN XCELULAR varchar(200), IN XCELAUX varchar(200),
	                                  IN XEMAIL varchar(200))
  BEGIN
  INSERT INTO sedes(nombre, ciudad, direccion, telefono, celular, celular_aux, email)
    VALUES (XNOMBRE, XCIUDAD, XDIRECCION, XTELEFONO, XCELULAR, XCELAUX, XEMAIL);

	SELECT ROW_COUNT() AS ESTADO, LAST_INSERT_ID() AS LAST_ID;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `OP_Sedes_update_all_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Sedes_update_all_Id`(IN XID int, IN XNOMBRE varchar(150),  IN XCIUDAD varchar(150),
                                        IN XDIRECCION varchar(100), IN XTELEFONO varchar(200), IN XCELULAR varchar(200),
                                        IN XCELAUX varchar(200), IN XEMAIL varchar(200))
BEGIN
  UPDATE sedes SET nombre = XNOMBRE,  ciudad = XCIUDAD, direccion = XDIRECCION, telefono = XTELEFONO,
                   celular = XCELULAR, celular_aux = XCELAUX, email = XEMAIL
    WHERE sedes.id = XID;

	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- Revisar otras relaciones
DROP PROCEDURE IF EXISTS `OP_Sedes_es_borrable_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Sedes_es_borrable_Id`(IN XID int)
  BEGIN
	DECLARE sede_status INT;

	SELECT COUNT(*) INTO sede_status
		FROM pacientes
	WHERE sede_id = XID;

	IF sede_status = "0" THEN
		SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
	ELSE
		SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
	END IF;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS `OP_Sedes_delete_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Sedes_delete_all`(IN XID int)
  BEGIN
	DELETE FROM sedes
		WHERE sedes.id = XID;

	ALTER TABLE sedes AUTO_INCREMENT = 1;
END
;;
DELIMITER ;
