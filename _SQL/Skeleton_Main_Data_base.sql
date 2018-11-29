-- ----------------------------
--  Table structure for `roles`
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', 'Administrador', 'Administrador');
INSERT INTO `roles` VALUES ('2', 'Colaborador', 'Usuario Invitado');


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
  `schema` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_comercial` varchar(255) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `ruc` varchar(12) DEFAULT NULL,
  `ciudad` varchar(200) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(200) DEFAULT NULL,
  `url_logotipo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE PROCEDURE `OP_Usuarios_add_all`(IN XNAME VARCHAR(255), IN XEMAIL VARCHAR(255),
																		 IN XPASSWORD VARCHAR(255), IN XROLID TINYINT, IN XIS_ACTIVE TINYINT, IN XSCHEMA VARCHAR(255), IN XID_CLIENTE INT)
BEGIN
INSERT INTO users (name, email, password, rolid, is_active, users.schema, clienteId, created_at, updated_at)
      VALUES (XNAME, XEMAIL, XPASSWORD, XROLID, XIS_ACTIVE, XSCHEMA, XID_CLIENTE, NOW(), NOW());
SELECT ROW_COUNT() AS ESTADO;
END

CREATE PROCEDURE `OP_Usuarios_get_all`(IN XSCHEMA VARCHAR(255))
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, r.nombre AS rol
		FROM users u
  LEFT JOIN roles r ON u.rolid = r.id
  WHERE u.`schema` = XSCHEMA AND u.is_deleted = '0' AND u.id != 1 ORDER BY u.id DESC;
END

CREATE PROCEDURE `OP_Usuarios_get_all_id`(IN XID INT, IN XSCHEMA VARCHAR(255))
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, u.rolid, u.is_active
		FROM users u
  WHERE u.`schema` = XSCHEMA AND u.id = XID AND u.is_deleted = '0' ORDER BY u.id DESC;
END

CREATE PROCEDURE `OP_Usuarios_update_all`(IN XNAME VARCHAR(255), IN XEMAIL VARCHAR(255),
																				IN XPASSWORD VARCHAR(255), IN XROLID TINYINT,
																				IN XIS_ACTIVE TINYINT, IN XID INT, IN XSCHEMA VARCHAR(255), IN XID_CLIENTE INT)
BEGIN
  UPDATE users SET name = XNAME, email = XEMAIL,
                   password = XPASSWORD, rolid = XROLID,
                   is_active = XIS_ACTIVE,
                   updated_at = NOW()
  WHERE users.id = XID AND users.schema = XSCHEMA AND users.clienteId = XID_CLIENTE;
  SELECT ROW_COUNT() AS ESTADO;
END

CREATE PROCEDURE `OP_Usuarios_update_no_pass`(IN XNAME VARCHAR(255), IN XEMAIL VARCHAR(255),
																						IN XROLID TINYINT,
																						IN XIS_ACTIVE TINYINT, IN XID INT, IN XSCHEMA VARCHAR(255), IN XID_CLIENTE INT)
BEGIN
  UPDATE users SET name = XNAME, email = XEMAIL,
                   rolid = XROLID, is_active = XIS_ACTIVE, updated_at = NOW()
  WHERE users.id = XID AND users.schema = XSCHEMA AND users.clienteId = XID_CLIENTE;
  SELECT ROW_COUNT() AS ESTADO;
END
