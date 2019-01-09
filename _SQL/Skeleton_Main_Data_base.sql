/*
MySQL Backup
Source Server Version: 5.5.5
Source Database: op_main_bd_v3
Date: 29/11/2018 18:45:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
--  Table structure for `clientes`
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_comercial` varchar(255) DEFAULT NULL,
  `razon_social` varchar(255) DEFAULT NULL,
  `ruc` varchar(12) DEFAULT NULL,
  `ciudad` varchar(200) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `telefono` varchar(200) DEFAULT NULL,
  `celular` varchar(200) DEFAULT NULL,
  `celular_aux` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

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
  `schema` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `clienteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `password_resets`;
create table `password_resets`
(
	id int auto_increment primary key,
	email varchar(255) not null,
	token varchar(255) null,
	created_at timestamp default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP
)
;

-- ----------------------------
--  Procedure definition for `OP_Clientes_get_all_byUserId`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Clientes_get_all_byUserId`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Clientes_get_all_byUserId`(IN XID_USER INT)
BEGIN
	SELECT nombre_comercial as nombre, direccion, ciudad, email, telefono, celular, celular_aux FROM clientes WHERE clientes.id = XID_USER;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Usuarios_add_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Usuarios_add_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Usuarios_add_all`(IN XNAME VARCHAR(255), IN XEMAIL VARCHAR(255),
																		    IN XPASSWORD VARCHAR(255), IN XROLID TINYINT, IN XIS_ACTIVE TINYINT, IN XSCHEMA VARCHAR(255), IN XID_CLIENTE INT, IN XID_SEDE INT)
BEGIN
INSERT INTO users (name, email, password, rolid, is_active, users.schema, clienteId, created_at, updated_at, sede_id)
      VALUES (XNAME, XEMAIL, XPASSWORD, XROLID, XIS_ACTIVE, XSCHEMA, XID_CLIENTE, NOW(), NOW(), XID_SEDE);
SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Usuarios_delete_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Usuarios_delete_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Usuarios_delete_all`(IN XID INT, IN XSCHEMA VARCHAR(255), IN XIS_ACTIVE TINYINT)
BEGIN
	UPDATE users SET is_active = XIS_ACTIVE
		WHERE users.id = XID AND users.schema = XSCHEMA;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Usuarios_get_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Usuarios_get_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Usuarios_get_all`(IN XSCHEMA VARCHAR(255))
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, r.nombre AS rol, u.sede_id
		FROM users u
  LEFT JOIN roles r ON u.rolid = r.id
  WHERE u.`schema` = XSCHEMA AND u.is_deleted = '0' AND u.id != 1 ORDER BY u.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Usuarios_get_all_id`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Usuarios_get_all_id`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Usuarios_get_all_id`(IN XID INT, IN XSCHEMA VARCHAR(255))
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, u.rolid, u.sede_id
		FROM users u
  WHERE u.`schema` = XSCHEMA AND u.id = XID AND u.is_deleted = '0' ORDER BY u.id DESC;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Usuarios_update_all`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Usuarios_update_all`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Usuarios_update_all`(IN XNAME VARCHAR(255), IN XEMAIL VARCHAR(255),
																				IN XPASSWORD VARCHAR(255), IN XROLID TINYINT,
																				IN XIS_ACTIVE TINYINT, IN XID INT, IN XSCHEMA VARCHAR(255),
                                        IN XID_CLIENTE INT, IN XID_SEDE INT)
BEGIN
	UPDATE users SET name = XNAME, email = XEMAIL,
									 password = XPASSWORD, rolid = XROLID,
									 is_active = XIS_ACTIVE,
                   sede_id = XID_SEDE,
									 updated_at = NOW()
	WHERE users.id = XID AND users.schema = XSCHEMA AND users.clienteId = XID_CLIENTE;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Procedure definition for `OP_Usuarios_update_no_pass`
-- ----------------------------
DROP PROCEDURE IF EXISTS `OP_Usuarios_update_no_pass`;
DELIMITER ;;
CREATE  PROCEDURE `OP_Usuarios_update_no_pass`(IN XNAME VARCHAR(255), IN XEMAIL VARCHAR(255),
																						IN XROLID TINYINT,
																						IN XIS_ACTIVE TINYINT, IN XID INT, IN XSCHEMA VARCHAR(255), IN XID_CLIENTE INT, IN XID_SEDE INT)
BEGIN
	UPDATE users SET name = XNAME, email = XEMAIL,
									 rolid = XROLID, is_active = XIS_ACTIVE, updated_at = NOW(), sede_id = XID_SEDE
	WHERE users.id = XID AND users.schema = XSCHEMA AND users.clienteId = XID_CLIENTE;
	SELECT ROW_COUNT() AS ESTADO;
END
;;
DELIMITER ;

-- ----------------------------
--  Records
-- ----------------------------
INSERT INTO `clientes` VALUES ('1','Odontoplus',NULL,NULL,'Cajamarca','Av. Miguel Grau 656',NULL,'943 598585','982 780954','contacto@odontoplus.com');
INSERT INTO `roles` VALUES ('1','Administrador','Administrador'), ('2','Colaborador','Usuario Invitado');
INSERT INTO `users` VALUES ('1','Admin','admin@odontoplus.pe','$2y$10$U74ylBqdic.7idkr.hWgP.bZMU77dZz4s0ksFsvPkPjxH4I9npCkm','RegYwGNCwnau0fRlk0L3VFbtaT62QMj2Ym3hJfnPPpAfW7YsNuHnUHJcyV2T','2018-11-27 15:51:31','2018-11-27 15:51:31','1','1','0','1_ODONTOPLUS_CAJ','1');
