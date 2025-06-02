
select * from Empleado

--create table Empresa
--(
--ID_Empresa					int IDENTITY(1, 1) primary key,
--Nombre						varchar(10),
--Razon_Social					varchar(50),
--Domicilio_Fiscal				varchar(50),
--Datos_Contacto				varchar(10),
--Registro_patronal				varchar(11),
--RFC							varchar(13),
--Fecha_inicio_operaciones		date
--);
---------------------------------------------------------------------------------------------

SELECT IC.COLUMN_NAME, IC.Data_TYPE, EP.[Value] as [MS_Description], IKU.CONSTRAINT_NAME,
ITC.CONSTRAINT_TYPE, IC.IS_NULLABLE, IC.TABLE_NAME 
FROM INFORMATION_SCHEMA.COLUMNS IC
INNER JOIN sys.columns sc ON OBJECT_ID(QUOTENAME(IC.TABLE_SCHEMA) + '.' +
QUOTENAME(IC.TABLE_NAME)) = sc.[object_id] AND IC.COLUMN_NAME = sc.name
LEFT OUTER JOIN sys.extended_properties EP ON sc.[object_id] = EP.major_id AND
sc.[column_id] = EP.minor_id AND EP.name = 'MS_Description' AND EP.class = 1
LEFT OUTER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE IKU ON IKU.COLUMN_NAME =
IC.COLUMN_NAME and IKU.TABLE_NAME = IC.TABLE_NAME and IKU.TABLE_CATALOG = IC.TABLE_CATALOG
LEFT OUTER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS ITC ON ITC.TABLE_NAME =
IKU.TABLE_NAME and ITC.CONSTRAINT_NAME = IKU.CONSTRAINT_NAME
WHERE IC.TABLE_CATALOG = 'ReciboDeNomina'
and IC.TABLE_SCHEMA = 'dbo'
and IC.TABLE_NAME = 'Concepto'
order by IC.ORDINAL_POSITION

-------------------------------------------------------------------------------------------

SELECT schemas.name AS SchemaName
,all_objects.name AS TableName ,syscolumns.id AS ColumnId
,syscolumns.name AS ColumnName ,systypes.name AS DataType
,syscolumns.length AS CharacterMaximumLength
,sysproperties.[value] AS ColumnDescription
,syscomments.TEXT AS ColumnDefault ,syscolumns.isnullable AS IsNullable
FROM syscolumns INNER JOIN sys.systypes ON syscolumns.xtype = systypes.xtype
LEFT JOIN sys.all_objects ON syscolumns.id = all_objects.[object_id]
LEFT OUTER JOIN sys.extended_properties AS sysproperties ON (sysproperties.minor_id =
syscolumns.colid AND sysproperties.major_id = syscolumns.id)
LEFT OUTER JOIN sys.syscomments ON syscolumns.cdefault = syscomments.id
LEFT OUTER JOIN sys.schemas ON schemas.[schema_id] = all_objects.[schema_id]
WHERE syscolumns.id IN (SELECT id
FROM sysobjects
WHERE xtype = 'U') AND (systypes.name <> 'sysname')
ORDER BY TableName

--------------------------------------------------------------------------------------------
EXEC sp_addextendedproperty
@name = N'MS_Description', @value = 'Clave de 3 chars de cada Pais',
@level0type = N'Schema', @level0name = 'dbo',
@level1type = N'Table', @level1name = 'Pais',
@level2type = N'Column', @level2name = 'CvePais';
GO

EXEC sp_dropextendedproperty
@name = N'MS_Description',
@level0type = N'Schema',@level0name = 'dbo',
@level1type = N'Table', @level1name = 'Empresa',
@level2type = N'Column', @level2name = 'ID_Empresa';
GO



  BEGIN TRY

BEGIN TRANSACTION [Tran1]



      	---------------------------------------------------------------------------------------------------------
	--EMPRESA

	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'ID_Empresa';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Nombre de la Empresa',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'Nombre';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Razón social de la empresa',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'Razon_Social';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Residencia de la empresa',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'Domicilio_Fiscal';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Número de Teléfono para contactar a la Empresa',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'Datos_Contacto';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Número único asignado por el IMSS',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'Registro_patronal';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Registro Federal de Contribuyentes de la Empresa',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'RFC';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Fecha en que la Empresa empezó a funcionar',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empresa',
	@level2type = N'Column', @level2name = 'Fecha_inicio_operaciones';
	GO
	---------------------------------------------------------------------------------------------------------
	--PUESTO

	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Puesto',
	@level2type = N'Column', @level2name = 'ID_Puesto';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Nombre que identifica al Puesto',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Puesto',
	@level2type = N'Column', @level2name = 'Titulo_de_Puesto';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Número decimal que representa el porcentaje por el que se multiplica el sueldo de cada empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Puesto',
	@level2type = N'Column', @level2name = 'Proporcion';
	GO

	---------------------------------------------------------------------------------------------------------
	--DIRECCION
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'ID_Direccion';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Calle donde reside el Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'Calle';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Número de la casa donde reside el Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'Numero';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Colonia donde reside el Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'Colonia';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Municipio donde reside el Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'Municipio';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Estado donde reside el Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'Estado';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Codigo Postal de la residencia',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Direccion',
	@level2type = N'Column', @level2name = 'Codigo_Postal';
	GO
	---------------------------------------------------------------------------------------------------------
	--CONCEPTO

	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Concepto',
	@level2type = N'Column', @level2name = 'ID_Concepto';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Nombre que identifica al Concepto',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Concepto',
	@level2type = N'Column', @level2name = 'Nombre_Concepto';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Dato que clarifica si el Concepto es una Deducción (0) o una Percepción (1)',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Concepto',
	@level2type = N'Column', @level2name = 'Tipo';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Dato que clarifica si el Concepto es Obligatorio de tener en el recibo (1) o si No es Obligatorio y depende del contexto del Empleado si se usa o aplica o no (0)',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Concepto',
	@level2type = N'Column', @level2name = 'Obligatoria';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Dato que clarifica si el Concepto se aplica de manera Mensual (1) o si se aplica de otra manera (0)',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Concepto',
	@level2type = N'Column', @level2name = 'Mensual';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Cantidad de Dinero que se Añade o se Resta según el tipo de Concepto',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Concepto',
	@level2type = N'Column', @level2name = 'Valor';
	GO
	---------------------------------------------------------------------------------------------------------
	--CUENTA DE BANCO

	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Cuenta_De_Banco',
	@level2type = N'Column', @level2name = 'ID_Banco';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Nombre que identifica al Banco',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Cuenta_De_Banco',
	@level2type = N'Column', @level2name = 'Banco';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Numero de la Cuenta que le pertenece al Empleado asignado cuando se hace el Recibo de Nomina',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Cuenta_De_Banco',
	@level2type = N'Column', @level2name = 'NumeroCuenta';
	GO
	---------------------------------------------------------------------------------------------------------
	--DEPARTAMENTO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Departamento',
	@level2type = N'Column', @level2name = 'ID_Departamento';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Nombre que identifica al Departamento',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Departamento',
	@level2type = N'Column', @level2name = 'Nombre_Departamento';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Numero que representa el pago que se le dará a los Empleados pertenecientes a este Departamento por cada día que trabajen',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Departamento',
	@level2type = N'Column', @level2name = 'SueldoBase_Diario';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a cuál Empresa pertenece este Departamento, debe contener la ID de alguna Empresa existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Departamento',
	@level2type = N'Column', @level2name = 'Empresa_ID';
	GO
	---------------------------------------------------------------------------------------------------------
	--EMPLEADO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'ID_Empleado';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Contraseña del usuario que requiere para ingresar al sistema',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Contraseña';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Primer nombre del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Nombre';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Apellido Patero del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'ApellidoPat';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Apellido Materno del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'ApellidoMat';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Fecha de Nacimiento del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'FechaNacimiento';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Clave Única de Registro de Población del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'CURP';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Número de Seguridad Social del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'NSS';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Registro Federal de Contribuyentes del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'RFC';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Email del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Email';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Teléfonos de contacto del Empleado',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Teléfonos';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Fecha en que el Empleado fue registrado en la Empresa',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'FechaIngreso';
	GO

	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a cuál Numero de Cuenta de Banco pertenece el Empleado, debe contener la ID de algún Número de Cuenta de Banco existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Cuenta_BancoID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a cuál Empresa pertenece el Empleado, debe contener la ID de alguna Empresa existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Empresa_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a cuál Puesto pertenece el Empleado, debe contener la ID de algún Puesto existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Puesto_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a cuál Departamento pertenece el Empleado, debe contener la ID de algún Departamento existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Departamento_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a cuál Dirección pertenece el Empleado, debe contener la ID de alguna Dirección existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'Empleado',
	@level2type = N'Column', @level2name = 'Direccion_ID';
	GO
	---------------------------------------------------------------------------------------------------------
	--EMPLEADo-CONCEPTOS
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'EmpleadoConceptos',
	@level2type = N'Column', @level2name = 'ID_EmpleadoConceptos';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de que Empleado se le asignó un concepto, debe contener la ID de algún Empleado existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'EmpleadoConceptos',
	@level2type = N'Column', @level2name = 'Empleado_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de que Concepto se le asignó a un Empleado, debe contener la ID de algún Concepto existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'EmpleadoConceptos',
	@level2type = N'Column', @level2name = 'Concepto_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Fecha en que se asigno el Concepto',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'EmpleadoConceptos',
	@level2type = N'Column', @level2name = 'Fecha';
	GO
	---------------------------------------------------------------------------------------------------------
	--RECIBO DE NOMINA
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador del índice de la tabla',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'ID_Recibo';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Fecha en que se imprimió el Recibo',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'Fecha_Recibo';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Cantidad en efectivo que se le pagará al Empleado tomando en cuenta su Sueldo Base Diario, su Puesto y Departamento, así como días trabajados',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'Cantidad_Bruta';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Cantidad en efectivo que se le pagará al Empleado tomando en cuenta su Sueldo Base Diario, su Puesto y Departamento, así como días trabajados, y los Conceptos a su nombre',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'Cantidad_Depositada';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador único global usado para garantizar la unidad de los recibos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'GUID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a qué Empresa hace referencia el Recibo, debe contener la ID de alguna Empresa existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'Empresa_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a qué Empleado hace referencia el Recibo, debe contener la ID de algún Empleado existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'Empleado_ID';
	GO
	EXEC sp_addextendedproperty
	@name = N'MS_Description', @value = 'Identificador de a qué Banco hace referencia el Recibo, debe contener la ID de alguna cuenta de Banco existente en la Base de Datos',
	@level0type = N'Schema', @level0name = 'dbo',
	@level1type = N'Table', @level1name = 'ReciboDeNomina',
	@level2type = N'Column', @level2name = 'Banco_ID';
	GO

      COMMIT TRANSACTION [Tran1]
	  ROLLBACK TRANSACTION [Tran1]

  END TRY

  BEGIN CATCH

      ROLLBACK TRANSACTION [Tran1]

  END CATCH 



