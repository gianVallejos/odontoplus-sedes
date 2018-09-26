-- ---------------------------------------------------------------------------------
-- USERS
-- ---------------------------------------------------------------------------------
ALTER TABLE users
ADD COLUMN is_active BOOLEAN DEFAULT FALSE;

-- PROCEDURES
CREATE PROCEDURE `OP_ObtenerUsuarios`()
BEGIN

	SELECT precios.id, detalle, monto FROM PRECIOS
		INNER JOIN tratamientos ON precios.idTratamiento = tratamientos.id
	WHERE idEmpresa = XID_EMPRESA ORDER BY (tratamientos.id);

END
------------------------------------------------------------------------------------