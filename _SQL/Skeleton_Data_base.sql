
DROP TABLE IF EXISTS `citas`;
CREATE TABLE `citas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(200) DEFAULT NULL,
  `desde` time DEFAULT NULL,
  `hasta` time DEFAULT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idDoctor` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `empresas`
-- ----------------------------
DROP TABLE IF EXISTS `empresas`;
CREATE TABLE `empresas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(120) NOT NULL,
  `ruc` varchar(12) DEFAULT NULL,
  `is_deleted` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of empresas
-- ----------------------------
INSERT INTO `empresas` VALUES ('1', 'Empresa Default', null, '0', '2018-11-27', '2018-11-27');

-- ----------------------------
--  Table structure for `ingresos`
-- ----------------------------
DROP TABLE IF EXISTS `ingresos`;
CREATE TABLE `ingresos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPaciente` int(11) NOT NULL,
  `is_deleted` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
	`sedeId` int not null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
  `nombre_apoderado` varchar(150) DEFAULT NULL,
  `celular_apoderado` varchar(150) DEFAULT NULL,
  `is_deleted` tinyint(4) DEFAULT '0',
  `referencia_id` int(11) DEFAULT '1',
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
	`sede_id` int not null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

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
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `precios`
-- ----------------------------
DROP TABLE IF EXISTS `precios`;
CREATE TABLE `precios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) NOT NULL,
  `idTratamiento` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of precios
-- ----------------------------
INSERT INTO `precios` VALUES ('1', '1', '2', '10.00', '2018-11-27 16:32:35', '2018-11-27 16:32:35');
INSERT INTO `precios` VALUES ('2', '1', '3', '10.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('3', '1', '4', '10.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('4', '1', '5', '10.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('5', '1', '6', '10.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('6', '1', '7', '10.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('7', '1', '8', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('8', '1', '9', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('9', '1', '10', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('10', '1', '11', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('11', '1', '12', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('12', '1', '13', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('13', '1', '14', '12.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('14', '1', '15', '16.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('15', '1', '16', '16.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('16', '1', '17', '16.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('17', '1', '18', '16.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('18', '1', '19', '16.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('19', '1', '20', '25.00', '2018-11-27 16:33:46', '2018-11-27 16:33:46');
INSERT INTO `precios` VALUES ('20', '1', '21', '25.00', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('21', '1', '22', '25.00', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('22', '1', '23', '25.00', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('23', '1', '26', '25.00', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('24', '1', '27', '25.50', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('25', '1', '28', '25.20', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('26', '1', '29', '25.00', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('27', '1', '30', '25.00', '2018-11-27 16:33:47', '2018-11-27 16:33:47');
INSERT INTO `precios` VALUES ('28', '1', '31', '10.00', '2018-11-27 16:33:12', '2018-11-27 16:33:12');
INSERT INTO `precios` VALUES ('29', '1', '31', '27.00', '2018-11-27 16:33:14', '2018-11-27 16:33:14');

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
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Table structure for `referencias`
-- ----------------------------
DROP TABLE IF EXISTS `referencias`;
CREATE TABLE `referencias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of referencias
-- ----------------------------
INSERT INTO `referencias` VALUES ('1', 'Otros');
INSERT INTO `referencias` VALUES ('2', 'Referidos');
INSERT INTO `referencias` VALUES ('3', 'TV');
INSERT INTO `referencias` VALUES ('4', 'Redes Sociales');

-- ----------------------------
--  Table structure for `tratamientos`
-- ----------------------------
DROP TABLE IF EXISTS `tratamientos`;
CREATE TABLE `tratamientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `detalle` varchar(120) NOT NULL,
  `is_active` tinyint(4) DEFAULT '1',
  `is_deleted` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL,
  `updated_at` timestamp NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tratamientos
-- ----------------------------
INSERT INTO `tratamientos` VALUES ('2', 'Resina Simple Vestibular', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('3', 'Resina Simple Mesial', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('4', 'Resina Simple Distal', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('5', 'Resina Simple Palatino', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('6', 'Ionomero', '2018-11-27', '1', '0', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('7', 'Resina Simple Oclusal', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('8', 'Corona Fenestrada', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('9', 'Corona Metal Porcelana', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('10', 'Corona de Acero', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('11', 'Corona Free Metal', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('12', 'Exodoncia Simple', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('13', 'Exodoncia Compleja', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('14', 'Exodoncia 3ra Molar', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('15', 'Endodoncia Incisivo', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('16', 'Endodoncia de Premolar', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('17', 'Endodoncia Molar', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('18', 'Carillas Inyectada', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('19', 'Carilla Estratificada', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('20', 'Pulpotomia', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('21', 'Pulpectomia', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('22', 'Perno de Colado', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('23', 'Perno de Fibra de Vidrio', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('27', 'Incrustacion de Porcelana', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('28', 'Incrustacion Metal', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('29', 'Resina Compuesta', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('30', 'Resina Compleja', '1', '0', '2018-11-27', '2018-11-27');
INSERT INTO `tratamientos` VALUES ('31', 'Sellantes por pieza dental', '2018-11-27', '1', '0', '2018-11-27');
