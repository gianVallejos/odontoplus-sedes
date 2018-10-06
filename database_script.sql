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