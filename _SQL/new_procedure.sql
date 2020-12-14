-- Version 13/12/2020 --
DROP PROCEDURE IF EXISTS `OP_Pacientes_delete_by_update_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_delete_by_update_Id`(IN XID_PACIENTE int)
BEGIN
  UPDATE `pacientes` SET `is_deleted` = '1' WHERE (`id` = XID_PACIENTE);
  SELECT ROW_COUNT() AS ESTADO;
END
;;

DROP PROCEDURE IF EXISTS `OP_Ingresos_delete_by_update_Id`;
DELIMITER ;;
CREATE PROCEDURE `OP_Ingresos_delete_by_update_Id`(IN XID_INGRESOS int)
BEGIN
  UPDATE `ingresos` SET `is_deleted` = '1' WHERE (`id` = XID_INGRESOS);
  SELECT ROW_COUNT() AS ESTADO;
END
;;

DROP PROCEDURE IF EXISTS `OP_Pacientes_get_all`;
DELIMITER ;;
CREATE PROCEDURE `OP_Pacientes_get_all`()
BEGIN
	SELECT pc.id, pc.codigo, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero,
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, pc.referencia_id,
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id,
				 emp.nombre as empresa_nombre, pc.sede_id, sed.nombre as sede_nombre, ingresos.id as ingresoId
		FROM pacientes as pc
	INNER JOIN sedes as sed on sed.id = pc.sede_id
	INNER JOIN ingresos on ingresos.id = pc.id
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	  WHERE pc.is_deleted = 0
		ORDER BY pc.id DESC;
END
;;