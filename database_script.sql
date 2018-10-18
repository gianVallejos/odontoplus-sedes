-- we don't know how to generate schema homestead (class Schema) :(
create table agendas
(
	id int auto_increment
		primary key,
	title varchar(50) not null,
	celular varchar(100) null,
	desde varchar(25) not null,
	hasta varchar(25) not null,
	idDoctor int null,
	tratamiento varchar(200) null,
	hc int default '-1' null
)
;

create table doctors
(
	id int auto_increment
		primary key,
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
	margen_ganancia decimal default '0' null,
	is_deleted tinyint(1) default '0' not null,
	updated_at date not null,
	created_at date not null
)
charset=utf8
;

create table egresos
(
	id int auto_increment
		primary key,
	fecha date null,
	cantidad int null,
	concepto varchar(125) null,
	tipo varchar(125) null,
	observacion varchar(125) null,
	precio_unitario decimal(6,2) null,
	doctorId int null,
	is_deleted tinyint default '0' null,
	created_at timestamp null on update CURRENT_TIMESTAMP,
	updated_at timestamp null on update CURRENT_TIMESTAMP
)
charset=utf8
;

create table empresas
(
	id int auto_increment
		primary key,
	nombre varchar(120) not null,
	ruc varchar(12) null,
	created_at date not null,
	updated_at date not null,
	is_deleted tinyint(1) default '0' null
)
;

create table ingresos
(
	id int auto_increment
		primary key,
	idPaciente int not null,
	idMedico int not null,
	total decimal(6,2) default '0.00' null,
	fecha date not null,
	created_at timestamp null on update CURRENT_TIMESTAMP,
	updated_at timestamp default '0000-00-00 00:00:00' not null on update CURRENT_TIMESTAMP,
	is_deleted tinyint default '0' null
)
charset=utf8
;

create table ingresos_detalle
(
	id int auto_increment
		primary key,
	ingresoId int null,
	precioId int null,
	cantidad int null,
	monto decimal(11,2) null
)
charset=utf8
;

create table migrations
(
	id int unsigned auto_increment
		primary key,
	migration varchar(255) not null,
	batch int not null
)
collate=utf8mb4_unicode_ci
;

create table pacientes
(
	id int auto_increment
		primary key,
	nombres varchar(90) not null,
	apellidos varchar(90) not null,
	dni varchar(8) null,
	email varchar(90) null,
	direccion varchar(90) not null,
	fechanacimiento date null,
	genero varchar(25) null,
	estado varchar(25) null,
	telefono varchar(50) null,
	fax varchar(50) null,
	celular varchar(50) null,
	celular_aux varchar(50) null,
	empresa_id int not null,
	seguro_ind int null,
	updated_at date not null,
	created_at date not null,
	nombre_apoderado varchar(150) null,
	celular_apoderado varchar(150) null,
	is_deleted tinyint default '0' null
)
;

create table precios
(
	id int auto_increment
		primary key,
	idEmpresa int not null,
	idTratamiento int not null,
	monto decimal(10,2) not null
)
;

create table presupuesto_detalles
(
	id int auto_increment
		primary key,
	idPresupuesto int not null,
	pieza int not null,
	seccion int not null,
	secUno int not null,
	secDos int not null,
	opcion int not null
)
;

create table presupuestos
(
	id int auto_increment
		primary key,
	fechahora datetime not null,
	idPaciente int not null,
	idDoctor int not null,
	descuento int not null,
	is_deleted tinyint default '0' null
)
;

create table proveedors
(
	id int auto_increment
		primary key,
	nombres varchar(100) not null,
	email varchar(120) null,
	direccion varchar(100) null,
	dni varchar(8) null,
	telefono varchar(60) null,
	celular varchar(60) null,
	empresa varchar(120) null,
	ciudad varchar(100) null,
	ruc varchar(11) null,
	banco varchar(60) null,
	nrocuenta varchar(60) null,
	insumo_id int not null,
	tipo_id int(1) not null,
	updated_at datetime null,
	created_at datetime null,
	is_deleted tinyint default '0' null
)
;

create table proveedors_detalles
(
	id int auto_increment
		primary key,
	idProveedor int not null,
	detalle varchar(120) not null,
	monto decimal(5,1) not null
)
;

create table roles
(
	id int auto_increment
		primary key,
	nombre varchar(50) null,
	descripcion varchar(100) null
)
charset=utf8
;

create table tratamientos
(
	id int auto_increment
		primary key,
	detalle varchar(120) not null,
	updated_at date not null,
	created_at date not null,
	is_active tinyint(1) default '1' null,
	is_deleted tinyint(1) default '0' null
)
;

create table users
(
	id int unsigned auto_increment
		primary key,
	name varchar(255) not null,
	email varchar(255) not null,
	password varchar(255) not null,
	remember_token varchar(100) null,
	created_at timestamp null,
	updated_at timestamp null,
	rolid int default '2' not null,
	is_active tinyint(1) default '1' null,
	is_deleted tinyint(1) default '0' null
)
collate=utf8mb4_unicode_ci
;

create procedure OP_AgregarPrecios_EmpresaId_TratamientoId (IN empresaId int, IN tratamientoId int, IN precio decimal)
BEGIN
  INSERT INTO precios (idEmpresa, idTratamiento, monto) values (empresaId, tratamientoId, precio);
  SELECT ROW_COUNT() AS ESTADO;
END
;

create procedure OP_ObtenerDoctores ()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0';
END
;

create procedure OP_ObtenerDoctores_DESC ()
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia
  FROM doctors d
  WHERE d.is_deleted = '0' ORDER BY d.id DESC;
END
;

create procedure OP_ObtenerDoctores_Id (IN XID int)
BEGIN
  SELECT d.id, d.nombres, d.apellidos, d.dni, d.email, d.direccion, d.telefono, d.celular, d.margen_ganancia,
         d.genero, d.estado, d.celular_aux, d.fechanacimiento
  FROM doctors d
  WHERE d.id = XID AND d.is_deleted = '0';
END
;

create procedure OP_ObtenerEgresos_Fechas (IN start_date date, IN end_date date)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(e.fecha) as mes, SUM(e.cantidad * e.precio_unitario) as egresos
  FROM egresos e
	WHERE (e.fecha BETWEEN start_date AND end_date)
	GROUP BY (MONTH(e.fecha));
END
;

create procedure OP_ObtenerEmpresas ()
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.is_deleted = '0';
END
;

create procedure OP_ObtenerEmpresas_DESC ()
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.is_deleted = '0' ORDER BY e.id DESC;
END
;

create procedure OP_ObtenerEmpresas_Id (IN XID int)
BEGIN
  SELECT e.id, e.nombre, e.ruc
  FROM empresas e
  WHERE e.id = XID AND e.is_deleted = '0';
END
;

create procedure OP_ObtenerIngresosPorEmpresa_Fechas (IN start_date date, IN end_date date)
BEGIN
	SELECT empresas.nombre as nombre, SUM(ingresos.total) as ingresos
	FROM pacientes
	INNER JOIN ingresos on ingresos.idPaciente = pacientes.id
	INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE ingresos.fecha BETWEEN start_date AND end_date
	GROUP BY pacientes.empresa_id;
END
;

create procedure OP_ObtenerIngresosPorPaciente_Fechas (IN start_date date, IN end_date date)
BEGIN
	SELECT SUBSTRING(CONCAT(pacientes.nombres, " ", pacientes.apellidos), 1, 25) as nombre, SUM(total) as monto
  FROM ingresos INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	WHERE ingresos.fecha BETWEEN start_date AND end_date
	GROUP BY (ingresos.idPaciente) ORDER BY monto DESC LIMIT 10;
END
;

create procedure OP_ObtenerIngresos_Fechas (IN start_date date, IN end_date date)
BEGIN
	SET lc_time_names = 'es_ES';
	SELECT MONTHNAME(i.fecha) as mes, SUM(i.total) as ingresos
  FROM ingresos i
  WHERE (i.fecha BETWEEN start_date AND end_date)
	GROUP BY (MONTH(i.fecha));
END
;

create procedure OP_ObtenerPreciosEstandard ()
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, tratamientos.detalle AS tratamiento,
         precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  INNER JOIN tratamientos on precios.idTratamiento = tratamientos.id
  INNER JOIN empresas on precios.idEmpresa = empresas.id
  WHERE precios.idEmpresa = 1
  ORDER BY tratamientos.id;
END
;

create procedure OP_ObtenerPrecios_EmpresaId_TratamientoId (IN empresaId int, IN tratamientoId int)
BEGIN
	SELECT precios.id, precios.idTratamiento AS id_tratamiento, precios.idEmpresa AS id_empresa, precios.monto AS monto
  FROM precios
  WHERE precios.idEmpresa = empresaId AND precios.idTratamiento = tratamientoId;
END
;

create procedure OP_ObtenerProveedores ()
BEGIN
  SELECT 	e.id, e.nombres, e.email, e.direccion, e.dni, e.telefono, e.celular, e.empresa,	e.ciudad,	e.ruc,
	e.banco,	e.nrocuenta,	e.insumo_id,	e.tipo_id
  FROM proveedors e
  WHERE e.is_deleted = '0';
END
;

create procedure OP_ObtenerProveedores_Id (IN XID int)
BEGIN
  SELECT e.id, e.nombres, e.email, e.direccion, e.dni, e.telefono, e.celular, e.empresa,	e.ciudad,	e.ruc,
	e.banco,	e.nrocuenta,	e.insumo_id,	e.tipo_id
  FROM proveedors e
  WHERE e.id = XID AND e.is_deleted = '0';
END
;

create procedure OP_ObtenerTotalEgresos_Fechas (IN start_date date, IN end_date date)
BEGIN
	SELECT SUM(cantidad * precio_unitario) as egresos
	FROM egresos
	WHERE fecha BETWEEN start_date AND end_date;
END
;

create procedure OP_ObtenerTotalIngresos_Fechas (IN start_date date, IN end_date date)
BEGIN
	SELECT SUM(cantidad * monto) AS ingresos FROM ingresos
	INNER JOIN ingresos_detalle as idt on idt.ingresoId = ingresos.id
	WHERE fecha BETWEEN start_date AND end_date;
END
;

create procedure OP_ObtenerTratamientos ()
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.is_deleted = '0' ORDER BY t.id DESC;
END
;

create procedure OP_ObtenerTratamientosDestacados_Fechas (IN start_date date, IN end_date date)
BEGIN
	SELECT SUBSTRING(tratamientos.detalle, 1, 25) as tratamiento, count(tratamientos.detalle) as numero
	FROM ingresos
		INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
		INNER JOIN precios on precios.id = ingresos_detalle.ingresoId
		INNER JOIN tratamientos on tratamientos.id = precios.idTratamiento
	WHERE ingresos.fecha BETWEEN start_date AND end_date
	GROUP BY (tratamientos.id) ORDER BY count(tratamientos.id) DESC LIMIT 5;
END
;

create procedure OP_ObtenerTratamientos_Id (IN XID int)
BEGIN
  SELECT t.id, t.detalle, t.is_active
  FROM tratamientos t
  WHERE t.id = XID AND t.is_deleted = '0';
END
;

create procedure OP_ObtenerUsuarios ()
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, r.nombre AS rol
  FROM users u
  LEFT JOIN roles r ON u.rolid = r.id
  WHERE u.is_deleted = '0' ORDER BY u.id DESC;
END
;

create procedure OP_ObtenerUsuarios_Id (IN XID int)
BEGIN
  SELECT u.id, u.name, u.email, u.is_active, u.created_at, u.rolid, u.is_active
  FROM users u
  WHERE u.id = XID AND u.is_deleted = '0' ORDER BY u.id DESC;
END
;

create procedure OP_actualizarIngresoDetalle (IN XID_INGRESO int, IN XID_PRECIO int, IN XCANTIDAD int, IN XMONTO decimal(11,2), IN XID int)
BEGIN
	DECLARE MONTO_TOTAL DECIMAL(11, 2);

		UPDATE ingresos_detalle SET ingresoId = XID_INGRESO, precioId = XID_PRECIO, cantidad = XCANTIDAD, monto = XMONTO 
			WHERE ingresos_detalle.id = XID;

		SELECT SUM(cantidad * monto) INTO MONTO_TOTAL FROM `ingresos_detalle` WHERE ingresoId = XID_INGRESO;

		UPDATE ingresos SET total = MONTO_TOTAL WHERE ingresos.id = XID_INGRESO;
END
;

create procedure OP_agregarIngresoDetalle (IN XID_INGRESO int, IN XID_PRECIO int, IN XCANTIDAD int, IN XMONTO decimal(11,2))
BEGIN
		DECLARE MONTO_TOTAL DECIMAL(11, 2);

		INSERT INTO ingresos_detalle(ingresoId, precioId, cantidad, monto) 
			VALUES (XID_INGRESO, XID_PRECIO, XCANTIDAD, XMONTO);

		SELECT SUM(cantidad * monto) INTO MONTO_TOTAL FROM `ingresos_detalle` WHERE ingresoId = XID_INGRESO;

		UPDATE ingresos SET total = MONTO_TOTAL WHERE ingresos.id = XID_INGRESO;
		

END
;

create procedure OP_agregarPresupuestoGeneral (IN ID_PRESUPUESTO int, IN XID_PACIENTE int, IN XID_DOCTOR int, IN XDESCUENTO int)
BEGIN
		INSERT INTO presupuestos(id, fechahora, idPaciente, idDoctor, descuento)
			VALUES (ID_PRESUPUESTO, NOW(), XID_PACIENTE, XID_DOCTOR, XDESCUENTO);

		SELECT ROW_COUNT() AS ESTADO;
END
;

create procedure OP_agregarPresupuestosDetalles (IN XID_PRESUPUESTO int, IN XPIEZA int, IN XSECCION int, IN XSECUNO int, IN XSECDOS int, IN XOPCION int)
BEGIN
		INSERT INTO presupuesto_detalles(idPresupuesto, pieza, seccion, secUno, secDos, opcion)
		VALUES(XID_PRESUPUESTO, XPIEZA, XSECCION, XSECUNO, XSECDOS, XOPCION);

		SELECT ROW_COUNT() AS ESTADO;
END
;

create procedure OP_eliminarDoctor_Id (IN XID_DOCTOR int)
BEGIN
	DELETE FROM doctors WHERE id = XID_DOCTOR;
	ALTER TABLE `doctors` AUTO_INCREMENT = 1;
END
;

create procedure OP_eliminarIngresoDetalle (IN XID int)
BEGIN
	DELETE FROM ingresos_detalle WHERE ingresos_detalle.id = XID;
END
;

create procedure OP_eliminarPaciente_Id (IN XID_PACIENTE int)
BEGIN
	DELETE FROM pacientes WHERE id = XID_PACIENTE;
	ALTER TABLE `pacientes` AUTO_INCREMENT = 1;
END
;

create procedure OP_eliminarPresupuesto_Id (IN XID_PRESUPUESTO int)
BEGIN
	START TRANSACTION;
		DELETE FROM presupuestos WHERE id = XID_PRESUPUESTO;
		DELETE FROM presupuesto_detalles WHERE idPresupuesto = XID_PRESUPUESTO;
	COMMIT;
END
;

create procedure OP_eliminarTratamiento_Id (IN XID_TRATAMIENTO int)
BEGIN
	START TRANSACTION;
		DELETE FROM tratamientos WHERE id = XID_TRATAMIENTO;
		DELETE FROM precios WHERE idTratamiento = XID_TRATAMIENTO;
	COMMIT;
END
;

create procedure OP_esDoctorBorrable_Id (IN XID_DOCTOR int)
BEGIN
DECLARE myvar INT;

SELECT count(id) INTO myvar FROM `presupuestos` WHERE idDoctor = XID_DOCTOR;

IF myvar = "0" THEN
	SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
ELSE
	SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
END IF;

END
;

create procedure OP_esIngresoBorrable_Id (IN XID_INGRESO int)
BEGIN

	DECLARE myvar INT;
	
	SELECT count(id) INTO myvar FROM ingresos_detalle where ingresos_detalle.ingresoId = XID_INGRESO;
	
	IF myvar = "0" THEN
		SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
	ELSE
		SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
	END IF;

END
;

create procedure OP_esPacienteBorrable_Id (IN XID_PACIENTE int)
BEGIN
DECLARE myvar INT;

SELECT count(id) INTO myvar FROM `presupuestos` WHERE idPaciente = XID_PACIENTE;

IF myvar = "0" THEN
	SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
ELSE
	SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
END IF;

END
;

create procedure OP_esTratamientoBorrable_Id (IN XID_TRATAMIENTO int)
BEGIN
DECLARE myvar INT;

SELECT count(id) INTO myvar FROM presupuesto_detalles WHERE pieza = XID_TRATAMIENTO or seccion = XID_TRATAMIENTO or secUno = XID_TRATAMIENTO or SecDos = XID_TRATAMIENTO;

IF myvar = "0" THEN
	SELECT 1 as CAN_DELETE; -- PUEDE BORRARSE --
ELSE
	SELECT 0 as CAN_DELETE; -- NO SE DEBE BORRAR --
END IF;

END
;

create procedure OP_obtenerDoctores_presupuesto (IN XID_DOCTOR int)
BEGIN
	SELECT id as id, nombres as nombres, apellidos as apellidos, margen_ganancia
		FROM doctors WHERE id = XID_DOCTOR;
END
;

create procedure OP_obtenerEgresos ()
BEGIN
		SELECT egresos.id, fecha, concepto, cantidad, precio_unitario as monto, SUM(cantidad * precio_unitario) as total, tipo, doctors.apellidos as doctor, doctors.id as doctorId, observacion as nota
			FROM egresos
		LEFT JOIN doctors on doctors.id = egresos.doctorId
		WHERE egresos.is_deleted = 0
		GROUP BY egresos.id ORDER BY egresos.id DESC;
END
;

create procedure OP_obtenerEgresos_Id (IN XID int)
BEGIN
	SELECT egresos.id, fecha, concepto, cantidad, precio_unitario as monto, SUM(cantidad * precio_unitario) as total, tipo, 
				 doctors.apellidos as doctor, doctors.id as doctorId, observacion as nota
			FROM egresos
		LEFT JOIN doctors on doctors.id = egresos.doctorId
		WHERE egresos.is_deleted = 0 AND egresos.id = XID
		GROUP BY egresos.id;
END
;

create procedure OP_obtenerEmpresaActual_paciente (IN XID_PACIENTE int)
BEGIN
	SELECT empresa_id FROM pacientes WHERE pacientes.id = XID_PACIENTE;
END
;

create procedure OP_obtenerIngresoDetalle_Id (IN XID_INGRESO int)
BEGIN
	SELECT idt.id, trat.id as idTratamiento, trat.detalle as tratamiento, 
				 idt.cantidad, idt.monto, idt.cantidad * idt.monto as total FROM ingresos
		INNER JOIN ingresos_detalle as idt on ingresos.id = idt.ingresoId
		INNER JOIN precios on precios.id = idt.precioId
		INNER JOIN tratamientos as trat on trat.id = precios.idTratamiento	
	WHERE idt.ingresoId = XID_INGRESO AND ingresos.is_deleted = 0
  ORDER BY idt.id DESC;
END
;

create procedure OP_obtenerIngresos ()
BEGIN 
	SELECT ingresos.id as id, doctors.id as idDoctor, CONCAT(doctors.nombres, ' ', doctors.apellidos) as nombreDoctor, 
				 pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as nombrePaciente, 
				 ingresos.fecha as fecha,					 
				 ingresos.total as monto_total,
				 ROUND((ingresos.total * doctors.margen_ganancia/100), 2) as mg,
				 ROUND(ingresos.total - (ingresos.total * doctors.margen_ganancia/100), 2) as mg_core
		FROM `ingresos` 
	INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	INNER JOIN doctors on doctors.id = ingresos.idMedico
	WHERE ingresos.is_deleted = 0
	ORDER BY ingresos.id DESC;
END
;

create procedure OP_obtenerIngresosTotal_Id (IN XID_INGRESO int)
BEGIN
	SELECT ROUND(IFNULL(SUM(ingresos_detalle.monto * ingresos_detalle.cantidad), 0), 2) as total,
				 ROUND(IFNULL(SUM(ingresos_detalle.monto * ingresos_detalle.cantidad) * doctors.margen_ganancia/100, 0), 2) as mg,
				 ROUND(IFNULL(SUM(ingresos_detalle.monto * ingresos_detalle.cantidad) - (SUM(ingresos_detalle.monto * ingresos_detalle.cantidad) * doctors.margen_ganancia/100), 0), 2) as mg_core 
		FROM ingresos_detalle
		INNER JOIN ingresos on ingresos.id = ingresos_detalle.ingresoId
		INNER JOIN doctors on doctors.id = ingresos.idMedico
	WHERE ingresos_detalle.ingresoId = XID_INGRESO AND ingresos.is_deleted = 0;
END
;

create procedure OP_obtenerIngresos_Id (IN XID int)
BEGIN
	SELECT LPAD(ingresos.id, 5, '0') as id, doctors.id as idDoctor, CONCAT(doctors.nombres, ' ', doctors.apellidos) as nombreDoctor, 
				 pacientes.id as hc, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) as nombrePaciente, 
				 ingresos.fecha as fecha,					 
				 IFNULL(SUM(ingresos_detalle.cantidad * ingresos_detalle.monto), 0) as monto_total,
				 ROUND(IFNULL((SUM(ingresos_detalle.cantidad * ingresos_detalle.monto) * doctors.margen_ganancia/100), 0), 2) as mg,
				 ROUND(IFNULL(SUM(ingresos_detalle.cantidad * ingresos_detalle.monto) - (SUM(ingresos_detalle.cantidad * ingresos_detalle.monto) * doctors.margen_ganancia/100), 0), 2) as mg_core
		FROM `ingresos`
	INNER JOIN pacientes on pacientes.id = ingresos.idPaciente
	INNER JOIN doctors on doctors.id = ingresos.idMedico
	INNER JOIN ingresos_detalle on ingresos_detalle.ingresoId = ingresos.id
	WHERE ingresos.id = XID AND ingresos.is_deleted = 0
	ORDER BY ingresos.id DESC;
END
;

create procedure OP_obtenerPacientes ()
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
		FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
		ORDER BY pc.id DESC;
END
;

create procedure OP_obtenerPacientes_Id (IN XID int)
BEGIN
	SELECT pc.id, pc.nombres, pc.apellidos, pc.dni, pc.email, pc.direccion, pc.fechanacimiento, pc.genero, 
				 pc.estado, pc.telefono, pc.fax, pc.celular, pc.celular_aux, pc.seguro_ind, 
				 pc.updated_at, pc.created_at, pc.nombre_apoderado, pc.celular_apoderado, pc.empresa_id, emp.nombre as empresa_nombre
	FROM pacientes as pc
	INNER JOIN empresas as emp on emp.id = pc.empresa_id
	WHERE pc.id = XID;
END
;

create procedure OP_obtenerPacientes_presupuesto (IN XID_PACIENTES int)
BEGIN
	SELECT LPAD(pacientes.id, 5, '0') as id, pacientes.nombres, pacientes.apellidos, empresas.nombre as empresa, pacientes.empresa_id 
		FROM pacientes
		INNER JOIN empresas on empresas.id = pacientes.empresa_id
	WHERE pacientes.id = XID_PACIENTES;
END
;

create procedure OP_obtenerPreciosParaTabla_EmpresaId (IN XID_EMPRESA int)
BEGIN
	select trat.id, trat.detalle, emprc.monto from precios as emprc
		inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA and trat.id > 7 and trat.id != 29 and trat.id != 30 order by idTratamiento;
END
;

create procedure OP_obtenerPrecios_EmpresaId (IN XID_EMPRESA int)
BEGIN
	select trat.id, trat.detalle, emprc.monto from precios as emprc
		inner join empresas as emp on emp.id = emprc.idEmpresa
    inner join tratamientos as trat on trat.id = emprc.idTratamiento
  where emp.id = XID_EMPRESA order by idTratamiento;
END
;

create procedure OP_obtenerPresupuestoDetalle_Id (IN XID int)
BEGIN
	SELECT id, pieza, seccion, secUno, secDos, opcion FROM presupuesto_detalles
		WHERE idPresupuesto = XID;
END
;

create procedure OP_obtenerPresupuesto_Id (IN XID int)
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
;

create procedure OP_obtenerPresupuestos ()
BEGIN
	SELECT LPAD(pre.id, 5, '00000') as id, pre.fechahora as fecha, LPAD(pre.idPaciente, 5, '00000') as idPaciente, pre.idDoctor, pre.descuento, 
				 CONCAT(pc.nombres, ' ', pc.apellidos) AS nombrePaciente, 
				 CONCAT(dc.nombres, ' ', dc.apellidos) AS nombreDoctor
	FROM presupuestos as pre		
	INNER JOIN pacientes AS pc ON pc.id = pre.idPaciente
	INNER JOIN doctors AS dc ON dc.id = pre.idDoctor
	ORDER BY pre.id DESC;	
END
;

create procedure OP_obtenerTratamientos_PacienteId (IN XID_PACIENTE int)
BEGIN
	DECLARE XID_EMPRESA INT;

	SELECT empresa_id INTO XID_EMPRESA FROM pacientes where pacientes.id = XID_PACIENTE;

	SELECT precios.id, detalle, monto FROM PRECIOS 
		INNER JOIN tratamientos ON precios.idTratamiento = tratamientos.id
	WHERE idEmpresa = XID_EMPRESA ORDER BY (tratamientos.id);
END
;

create procedure OP_obtenerUltimoIngresoDetalle_Id (IN XID_INGRESO int)
BEGIN
	SELECT idt.id as lastIngresoDetalle FROM ingresos_detalle as idt ORDER BY idt.id DESC LIMIT 1;
END
;

create procedure OP_obtenerUltimoPresupuesto ()
BEGIN
	DECLARE NRO_PRESUPUESTO INT;
	
	SELECT id INTO NRO_PRESUPUESTO FROM presupuestos LIMIT 1;
	
	IF NRO_PRESUPUESTO IS NULL THEN
			SELECT LPAD(1, 5, '00000') as presupuesto; 
	ELSE
		SELECT LPAD(id+1, 5, '00000') as presupuesto FROM presupuestos ORDER BY id DESC LIMIT 1;
  END IF;

END
;

create procedure OP_obtenerUltimosDiezPacientes ()
SELECT id as hc, CONCAT(nombres, ' ', apellidos) as nombres 
		FROM pacientes 
	WHERE pacientes.is_deleted = 0
ORDER BY created_at DESC LIMIT 10
;

create procedure OP_obtenerUltimosDiezPresupuestos ()
BEGIN
  SELECT presupuestos.id, CONCAT(pacientes.nombres, ' ', pacientes.apellidos) AS pacientes, doctors.nombres as doctores 
		FROM presupuestos
	INNER JOIN pacientes on pacientes.id = presupuestos.idPaciente
	INNER JOIN doctors on doctors.id = presupuestos.idDoctor
		WHERE presupuestos.is_deleted = 0
	ORDER BY fechahora DESC LIMIT 10;
END
;

create procedure OP_obtenerUserByEmail (IN XEMAIL varchar(255))
BEGIN
	SELECT name, email, is_active, is_deleted 
		FROM users WHERE email = XEMAIL;
END
;

