-- ---------------------------------------------------------------------------------
-- USERS
-- ---------------------------------------------------------------------------------
-- COLUMNS
ALTER TABLE users
ADD COLUMN is_active BOOLEAN DEFAULT FALSE;

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_ObtenerUsuarios`;

CREATE PROCEDURE `OP_ObtenerUsuarios`()
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, r.nombre AS rol
  FROM users u
  LEFT JOIN roles r ON u.rolid = r.id;
END;

-- ---------------------------------------------------------------------------------
-- PACIENTES
-- ---------------------------------------------------------------------------------
-- COLUMNS

-- PROCEDURES
DROP PROCEDURE IF EXISTS `OP_obtenerPacientes`;
CREATE PROCEDURE OP_obtenerPacientes()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerPresupuestos`()
BEGIN
  SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento, 
         CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente, 
         CONCAT(pc.nombres, ' ', pc.apellidos) AS nombreDoctor
  FROM presupuestos as pre    
  INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
  ORDER BY pre.id DESC; 
END

CREATE DEFINER=`root`@`localhost` PROCEDURE `OP_obtenerUltimoPresupuesto`()
BEGIN
  DECLARE NRO_PRESUPUESTO INT;
  SELECT LPAD(IFNULL(id, 0), 5, '00000') as presupuesto FROM presupuestos ORDER BY id DESC LIMIT 1;
END