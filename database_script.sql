-- ---------------------------------------------------------------------------------
-- USERS
-- ---------------------------------------------------------------------------------
-- COLUMNS
ALTER TABLE users
ADD COLUMN is_active BOOLEAN DEFAULT FALSE;
ALTER TABLE users
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerUsuarios`;

CREATE PROCEDURE `OP_ObtenerUsuarios`()
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, r.nombre AS rol
  FROM users u
  LEFT JOIN roles r ON u.rolid = r.id
  WHERE u.is_deleted = '0';
END;

DROP PROCEDURE IF EXISTS `OP_ObtenerUsuarios_Id`;

CREATE PROCEDURE `OP_ObtenerUsuarios_Id`(IN XID INT)
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, u.rolid, u.is_active
  FROM users u
  WHERE u.id = XID AND u.is_deleted = '0';
END;


-- ---------------------------------------------------------------------------------
-- DOCTORS
-- ---------------------------------------------------------------------------------
-- COLUMNS
DROP TABLE IF EXISTS `medicos`;
DROP TABLE IF EXISTS `doctors`;
CREATE TABLE doctors(
	id int auto_increment primary key,
	nombres varchar(90) not null,
	apellidos varchar(90) not null,
	dni varchar(8) not null,
	email varchar(90) null,
	direccion varchar(90) not null,
	fechanacimiento date not null,
	genero varchar(25) not null,
	estado varchar(25) not null,
	telefono varchar(50) null,
	celular varchar(50) null,
	celular_aux varchar(50) null,
	margen_ganancia decimal null,
  is_deleted boolean not null default false,
	updated_at date not null,
	created_at date not null
);

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerDoctores`;

CREATE PROCEDURE `OP_ObtenerDoctores`()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0';
END;

DROP PROCEDURE IF EXISTS `OP_ObtenerDoctores_Id`;

CREATE PROCEDURE `OP_ObtenerDoctores_Id`(IN XID INT)
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia,
         d.genero, d.estado, d.celular_aux, d.fechanacimiento
  FROM doctors d
  WHERE d.id = XID AND d.is_deleted = '0';
END;

-- ---------------------------------------------------------------------------------
-- TRATAMIENTOS
-- ---------------------------------------------------------------------------------
-- COLUMNS
ALTER TABLE tratamientos
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;
-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientos`;
create procedure OP_ObtenerTratamientos()
  BEGIN
  SELECT t.id, t.detalle
  FROM tratamientos t
  WHERE t.is_deleted = '0';
END;

DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientos_Id`;
CREATE PROCEDURE `OP_ObtenerTratamientos_Id`(IN XID INT)
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.id = XID AND t.is_deleted = '0';
END;

-- ---------------------------------------------------------------------------------
-- EMPRESAS
-- ---------------------------------------------------------------------------------
-- COLUMNS
ALTER TABLE empresas
ADD COLUMN sucursal varchar(120) null ;
ALTER TABLE empresas
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerEmpresas`;

CREATE PROCEDURE `OP_ObtenerEmpresas`()
BEGIN
  SELECT e.id, e.nombre, e.ruc, e.sucursal
  FROM empresas e
  WHERE e.is_deleted = '0';
END;

DROP PROCEDURE IF EXISTS `OP_ObtenerEmpresas_Id`;

CREATE PROCEDURE `OP_ObtenerEmpresas_Id`(IN XID INT)
BEGIN
  SELECT e.id, e.nombre, e.ruc, e.sucursal
  FROM empresas e
  WHERE e.id = XID AND e.is_deleted = '0';
END;

-- ---------------------------------------------------------------------------------
-- PROVEEDORES
-- ---------------------------------------------------------------------------------
-- COLUMNS
ALTER TABLE proveedors
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;
-- --------------------------------------------------------------------

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerProveedores`;

CREATE PROCEDURE `OP_ObtenerProveedores`()
BEGIN
  SELECT 	e.id, e.nombres, e.email, e.direccion, e.dni, e.telefono, e.celular, e.empresa,	e.ciudad,	e.ruc,
	e.banco,	e.nrocuenta,	e.insumo_id,	e.tipo_id
  FROM proveedors e
  WHERE e.is_deleted = '0';
END;

DROP PROCEDURE IF EXISTS `OP_ObtenerProveedores_Id`;

CREATE PROCEDURE `OP_ObtenerProveedores_Id`(IN XID INT)
BEGIN
  SELECT e.id, e.nombres, e.email, e.direccion, e.dni, e.telefono, e.celular, e.empresa,	e.ciudad,	e.ruc,
	e.banco,	e.nrocuenta,	e.insumo_id,	e.tipo_id
  FROM proveedors e
  WHERE e.id = XID AND e.is_deleted = '0';
END;

-- ---------------------------------------------------------------------------------
-- PROVEEDORS_DETALLE
-- ---------------------------------------------------------------------------------
-- COLUMNS

-- --------------------------------------------------------------------

-- PROCEDURES

DROP PROCEDURE IF EXISTS `OP_ObtenerProveedoresDetalles_Id`;

CREATE PROCEDURE `OP_ObtenerProveedoresDetalles_Id`(IN XID INT)
BEGIN
  SELECT p.id, p.idProveedor, p.detalle, p.monto
  FROM proveedors_detalles p
  WHERE p.idProveedor = XID;
END;
-- PRECIOS------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS `OP_ObtenerPreciosEstandard`;
create procedure OP_ObtenerPreciosEstandard()
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, tratamientos.detalle AS tratamiento,
         precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  INNER JOIN tratamientos on precios.idTratamiento = tratamientos.id
  INNER JOIN empresas on precios.idEmpresa = empresas.id
  WHERE precios.idEmpresa = 1
  ORDER BY  tratamientos.detalle;
END;

DROP PROCEDURE IF EXISTS `OP_ObtenerPrecios_EmpresaId_TratamientoId`;
create procedure OP_ObtenerPrecios_EmpresaId_TratamientoId(IN empresaId INT, IN tratamientoId INT)
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  WHERE precios.idEmpresa = empresaId AND precios.idTratamiento = tratamientoId;
END;

DROP PROCEDURE IF EXISTS `OP_AgregarPrecios_EmpresaId_TratamientoId`;
create procedure OP_AgregarPrecios_EmpresaId_TratamientoId(IN empresaId int, IN tratamientoId int, IN precio decimal)
BEGIN
  INSERT INTO precios (idEmpresa, idTratamiento, monto) values (empresaId, tratamientoId, precio);
  SELECT ROW_COUNT() AS ESTADO;
END;
-- ---------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------
-- EMPRESAS
-- ---------------------------------------------------------------------------------
-- COLUMNS

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_obtenerEmpresasJson`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresasJson`()
BEGIN
	SELECT id as value, nombre as text FROM empresas;
END;
-- ------------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------
-- PACIENTES
-- ---------------------------------------------------------------------------------
-- COLUMNS

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
  `isDeleted` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=220 DEFAULT CHARSET=latin1;

-- PROCEDURES

DROP PROCEDURE IF EXISTS `OP_obtenerPacientes`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes`()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.isDeleted = false;
END;

DROP PROCEDURE IF EXISTS `OP_obtenerPacientes_Id`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes_Id`(IN XID INT)
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.isDeleted = false AND pc.id = XID;
END;
-- -------------------------------------------------------------------------------------------------

-- --------------------------------------------------------------------

-- REPORTES

-- Ingresos entre fechas
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresos_Fechas`;
CREATE PROCEDURE `OP_ObtenerIngresos_Fechas`(IN start_date DATE, IN end_date DATE)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(i.fecha) as mes, SUM(i.total) as ingresos
  FROM ingresos i
  WHERE (i.fecha BETWEEN start_date AND end_date)
	GROUP BY (MONTH(i.fecha));
END;

-- Egresos entre fechas
DROP PROCEDURE IF EXISTS `OP_ObtenerEgresos_Fechas`;
create procedure OP_ObtenerEgresos_Fechas(IN start_date date, IN end_date date)
  BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(e.fecha) as mes, SUM(e.cantidad * e.precio_unitario) as egresos
  FROM egresos e
	WHERE (e.fecha BETWEEN start_date AND end_date)
	GROUP BY (MONTH(e.fecha));
END;

-- Ingresos por paciente
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorPaciente_Fechas`;
create procedure OP_ObtenerIngresosPorPaciente_Fechas(IN start_date DATE, IN end_date date)
BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(total) as monto
  FROM ingresos INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	WHERE ingresos.fecha BETWEEN start_date AND end_date
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END;


-- Ingresos por empresa
DROP PROCEDURE IF EXISTS `OP_ObtenerIngresosPorEmpresa_Fechas`;
create procedure OP_ObtenerIngresosPorEmpresa_Fechas(IN start_date DATE, IN end_date date)
BEGIN
	SELECT empresas.nombre as nombre, SUM(ingresos.total) as ingresos
	FROM pacientes
	INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
	INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE ingresos.fecha BETWEEN start_date AND end_date
	GROUP BY pacientes.empresa_id;
END;

-- Tratamientos destacados
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientosDestacados_Fechas`;
create procedure OP_ObtenerTratamientosDestacados_Fechas(IN start_date DATE, IN end_date date)
BEGIN
	SELECT SUBSTRING(tratamientos.detalle, 1, 25) as tratamiento, count(tratamientos.detalle) as numero
	FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.ingresoId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	WHERE ingresos.fecha BETWEEN start_date AND end_date
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END;

-- Total Egresos por Fecha
DROP PROCEDURE IF EXISTS `OP_ObtenerTotalEgresos_Fechas`;
create procedure OP_ObtenerTotalEgresos_Fechas(IN start_date DATE, IN end_date date)
BEGIN
	SELECT SUM(cantidad * precio_unitario) as egresos
	FROM egresos
	WHERE fecha BETWEEN start_date AND end_date;
END;
-- Total Ingresos por fecha
DROP PROCEDURE IF EXISTS `OP_ObtenerTotalIngresos_Fechas`;
create procedure OP_ObtenerTotalIngresos_Fechas(IN start_date DATE, IN end_date date)
BEGIN
	SELECT SUM(cantidad * monto) AS ingresos FROM ingresos
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	WHERE fecha BETWEEN start_date AND end_date;
END;

-- --------------------------------------------------------------------

DROP PROCEDURE IF EXISTS `OP_obtenerDoctores`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores`()
BEGIN
  SELECT * FROM doctores;
END;


-- PROCEDURES PRESUPUESTO LAST UPDATE 05-10-2018 17:23:00pm --


DROP PROCEDURE IF EXISTS `OP_obtenerPresupuestos`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuestos`()
BEGIN
  SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento, 
         CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente, 
         CONCAT(dc.nombres, ' ', dc.apellidos) AS nombreDoctor
  FROM presupuestos as pre    
  INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
  INNER JOIN doctors AS dc ON dc.id = pre.idDoctor
  ORDER BY pre.id DESC; 
END;


DROP PROCEDURE IF EXISTS `OP_obtenerUltimoPresupuesto`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoPresupuesto`()
BEGIN
  DECLARE NRO_PRESUPUESTO INT;
  SELECT LPAD(IFNULL(id, 0), 5, '00000') as presupuesto FROM presupuestos ORDER BY id DESC LIMIT 1;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerDoctores`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores`()
BEGIN
  SELECT * FROM doctors;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerUltimoPresupuesto`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoPresupuesto`()
BEGIN
  DECLARE NRO_PRESUPUESTO INT;
  
  SELECT id INTO NRO_PRESUPUESTO FROM presupuestos LIMIT 1;
  
  IF NRO_PRESUPUESTO IS NULL THEN
      SELECT LPAD(1, 5, '00000') as presupuesto; 
  ELSE
    SELECT LPAD(id+1, 5, '00000') as presupuesto FROM presupuestos ORDER BY id DESC LIMIT 1;
  END IF;

END;


DROP PROCEDURE IF EXISTS `OP_obtenerDoctores_presupuesto`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores_presupuesto`(IN XID_DOCTOR INT)
BEGIN
  SELECT id as id, nombres as nombres, apellidos as apellidos, margen_ganancia
    FROM doctors WHERE id = XID_DOCTOR;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerPacientes_presupuesto`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes_presupuesto`(IN XID_PACIENTES INT)
BEGIN
  SELECT LPAD(pacientes.id, 5, '0') as id, pacientes.nombres, pacientes.apellidos, empresas.nombre as empresa, pacientes.empresa_id 
    FROM pacientes
    INNER JOIN empresas on empresas.id = pacientes.empresa_id
  WHERE pacientes.id = XID_PACIENTES;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerEmpresaActual_paciente`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresaActual_paciente`(IN XID_PACIENTE INT)
BEGIN
  SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerPrecios_EmpresaId`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPrecios_EmpresaId`(IN XID_EMPRESA INT)
BEGIN
  select trat.id, trat.detalle, emprc.monto from precios as emprc
    inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA order by idTratamiento;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerPreciosParaTabla_EmpresaId`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPreciosParaTabla_EmpresaId`(IN XID_EMPRESA INT)
BEGIN
  select trat.id, trat.detalle, emprc.monto from precios as emprc
    inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA and trat.id > 7 and trat.id != 29 and trat.id != 30 order by idTratamiento;
END;

DROP PROCEDURE IF EXISTS `OP_obtenerPresupuesto_Id`;
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
END;

DROP PROCEDURE IF EXISTS `OP_obtenerPresupuestoDetalle_Id`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuestoDetalle_Id`(IN XID INT)
BEGIN
  SELECT id, pieza, seccion, secUno, secDos, opcion FROM presupuesto_detalles
    WHERE idPresupuesto = XID;
END;


DROP PROCEDURE IF EXISTS `OP_obtenerEmpresaActual_paciente`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresaActual_paciente`(IN XID_PACIENTE INT)
BEGIN
  SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END;


DROP PROCEDURE IF EXISTS `OP_agregarPresupuestoGeneral`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarPresupuestoGeneral`(IN ID_PRESUPUESTO INT, IN XID_PACIENTE INT, IN XID_DOCTOR INT, IN XDESCUENTO INT)
BEGIN
    INSERT INTO presupuestos(id, fechahora, idPaciente, idDoctor, descuento)
      VALUES (ID_PRESUPUESTO, NOW(), XID_PACIENTE, XID_DOCTOR, XDESCUENTO);

    SELECT ROW_COUNT() AS ESTADO;
END;


DROP PROCEDURE IF EXISTS `OP_agregarPresupuestosDetalles`;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarPresupuestosDetalles`(IN XID_PRESUPUESTO INT, IN XPIEZA INT, XSECCION INT, IN XSECUNO INT, IN XSECDOS INT, IN XOPCION INT)
BEGIN
    INSERT INTO presupuesto_detalles(idPresupuesto, pieza, seccion, secUno, secDos, opcion)
    VALUES(XID_PRESUPUESTO, XPIEZA, XSECCION, XSECUNO, XSECDOS, XOPCION);

    SELECT ROW_COUNT() AS ESTADO;
END;

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimosDiezPacientes`()
SELECT id as hc, CONCAT(nombres, ' ', apellidos) as nombres 
    FROM pacientes 
  WHERE pacientes.is_deleted = 0
ORDER BY created_at DESC LIMIT 10

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimosDiezPresupuestos`()
BEGIN
  SELECT presupuestos.id, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) AS pacientes, doctors.nombres as doctores 
    FROM presupuestos
  INNER JOIN pacientes on pacientes.id = presupuestos.idPaciente
  INNER JOIN doctors on doctors.id = presupuestos.idDoctor
    WHERE presupuestos.is_deleted = 0
  ORDER BY fechahora DESC;
END