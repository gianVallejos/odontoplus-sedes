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
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
ALTER TABLE tratamientos
ADD COLUMN is_deleted BOOLEAN DEFAULT FALSE;

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerTratamientos`;

CREATE PROCEDURE `OP_ObtenerTratamientos`()
BEGIN
  SELECT t.id, t.detalle, t.is_active
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
-- PACIENTES
-- ---------------------------------------------------------------------------------
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=latin1;

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_obtenerPacientes`;
CREATE PROCEDURE `OP_obtenerPacientes`()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id;
END;

DROP PROCEDURE IF EXISTS `OP_obtenerPacientes_Id`;
CREATE PROCEDURE `OP_obtenerPacientes_Id`(IN XID INT)
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.id = XID;
END;

-- ---------------------------------------------------------------------------------
-- EMPRESAS
-- ---------------------------------------------------------------------------------
-- COLUMNS

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_obtenerEmpresasJson`;
CREATE PROCEDURE `OP_obtenerEmpresasJson`()
BEGIN
	SELECT id as value, nombre as text FROM empresas;
END;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresasJson`()
BEGIN
	SELECT id as value, nombre as text FROM empresas;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes`()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.isDeleted = false;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes_Id`(IN XID INT)
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.isDeleted = false AND pc.id = XID;
END

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores`()
BEGIN
  SELECT * FROM doctores;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresasJson`()
BEGIN
  SELECT id as value, nombre as text FROM empresas;
END

-- PROCEDURES PRESUPUESTO LAST UPDATE 05-10-2018 17:23:00pm --

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


CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoPresupuesto`()
BEGIN
  DECLARE NRO_PRESUPUESTO INT;
  SELECT LPAD(IFNULL(id, 0), 5, '00000') as presupuesto FROM presupuestos ORDER BY id DESC LIMIT 1;
END


CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores`()
BEGIN
  SELECT * FROM doctors;
END

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerDoctores_presupuesto`(IN XID_DOCTOR INT)
BEGIN
  SELECT id as id, nombres as nombres, apellidos as apellidos, margen_ganancia
    FROM doctors WHERE id = XID_DOCTOR;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPacientes_presupuesto`(IN XID_PACIENTES INT)
BEGIN
  SELECT LPAD(pacientes.id, 5, '0') as id, pacientes.nombres, pacientes.apellidos, empresas.nombre as empresa, pacientes.empresa_id 
    FROM pacientes
    INNER JOIN empresas on empresas.id = pacientes.empresa_id
  WHERE pacientes.id = XID_PACIENTES;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresaActual_paciente`(IN XID_PACIENTE INT)
BEGIN
  SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPrecios_EmpresaId`(IN XID_EMPRESA INT)
BEGIN
  select trat.id, trat.detalle, emprc.monto from precios as emprc
    inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA order by idTratamiento;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPreciosParaTabla_EmpresaId`(IN XID_EMPRESA INT)
BEGIN
  select trat.id, trat.detalle, emprc.monto from precios as emprc
    inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA and trat.id > 7 and trat.id != 29 and trat.id != 30 order by idTratamiento;
END

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuestoDetalle_Id`(IN XID INT)
BEGIN
  SELECT id, pieza, seccion, secUno, secDos, opcion FROM presupuesto_detalles
    WHERE idPresupuesto = XID;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerEmpresaActual_paciente`(IN XID_PACIENTE INT)
BEGIN
  SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarPresupuestoGeneral`(IN ID_PRESUPUESTO INT, IN XID_PACIENTE INT, IN XID_DOCTOR INT, IN XDESCUENTO INT)
BEGIN
    INSERT INTO presupuestos(id, fechahora, idPaciente, idDoctor, descuento)
      VALUES (ID_PRESUPUESTO, NOW(), XID_PACIENTE, XID_DOCTOR, XDESCUENTO);

    SELECT ROW_COUNT() AS ESTADO;
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_agregarPresupuestosDetalles`(IN XID_PRESUPUESTO INT, IN XPIEZA INT, XSECCION INT, IN XSECUNO INT, IN XSECDOS INT, IN XOPCION INT)
BEGIN
    INSERT INTO presupuesto_detalles(idPresupuesto, pieza, seccion, secUno, secDos, opcion)
    VALUES(XID_PRESUPUESTO, XPIEZA, XSECCION, XSECUNO, XSECDOS, XOPCION);

    SELECT ROW_COUNT() AS ESTADO;
END