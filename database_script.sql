-- ---------------------------------------------------------------------------------
-- USERS
-- ---------------------------------------------------------------------------------
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
------------------------------------------------------------------------------------