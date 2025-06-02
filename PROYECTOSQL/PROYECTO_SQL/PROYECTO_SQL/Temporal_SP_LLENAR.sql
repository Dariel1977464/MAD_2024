create procedure TruncarRecibos
as
begin

delete from ReciboDeNomina

end




CREATE PROCEDURE SP_LLENAR_EMPRESA
@Nombre						nvarchar(13),
@Razón_Social				nvarchar(50),
@Domicilio_Fiscal			nvarchar(50),
@DatosContacto				nvarchar(10),
@Registro_patronal			nvarchar(11),
@RFC						nvarchar(13),
@Fecha_inicio_operaciones	date
AS
insert into Empresa(Nombre,Razon_Social, Domicilio_Fiscal, Datos_Contacto, Registro_patronal, RFC, Fecha_inicio_operaciones)
values(@Nombre,@Razón_Social,@Domicilio_Fiscal,@DatosContacto,@Registro_patronal,@RFC,@Fecha_inicio_operaciones)
GO

--truncate table Empresa




------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_LLENAR_BANCO
@Banco			varchar(20) ,
@NumeroCuenta	varchar(20)
AS

INSERT INTO Cuenta_De_Banco(Banco, NumeroCuenta)
values(@Banco, @NumeroCuenta)
GO

select * from Cuenta_De_Banco
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_AGREGAR_AGREGADA_EMPLEADO_CONCEPTO
@EmpleadoFK			int,
@ConceptosFK		int
AS

INSERT INTO EmpleadoConceptos(Empleado_ID, Concepto_ID, Fecha)
values(@EmpleadoFK, @ConceptosFK, GETDATE())
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_AGREGAR_DIRECCION
@Calle			varchar(20),
@Numero			int,
@Colonia		varchar(20),
@Municipio		varchar(20),
@Estado			varchar(20),
@Codigo_Postal	varchar(20)
AS

INSERT INTO Direccion(Calle, Numero, Colonia, Municipio, Estado, Codigo_Postal)
values(@Calle, @Numero, @Colonia, @Municipio, @Estado, @Codigo_Postal)
GO
------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------
create PROCEDURE SP_AGREGAR_DEPARTAMENTO

@Nombre_Departamento	varchar(20),
@SueldoBase_Diario		money

AS
INSERT INTO Departamento(Nombre_Departamento, SueldoBase_Diario, Empresa_ID)
values(@Nombre_Departamento, @SueldoBase_Diario, 1)
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_AGREGAR_PUESTO
@Nombre_de_Puesto	varchar(30) ,
@Proporcion			float
AS

INSERT INTO Puesto(Titulo_de_Puesto, Proporcion)
values(@Nombre_de_Puesto, @Proporcion)
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_AGREGAR_EMPLEADO
@Contrasena			varchar(20),
@Nombre				varchar(30),
@ApellidoPat		varchar(30),
@ApellidoMat		varchar(30),
@FechaNacimiento	date,
@CURP				varchar(18),
@NSS				varchar(11),
@RFC				varchar(13),
@Email				varchar(30),
@Telefonos			varchar(10),

@Banco				int,
@Empresa_FK			int,
@PuestoFK			int,
@DepartamentoFK		int,
@DireccionFK		int
AS
INSERT INTO Empleado(
Contraseña, Nombre, ApellidoPat, ApellidoMat, FechaNacimiento,
CURP, NSS, RFC, Email, Teléfonos, Cuenta_BancoID, Empresa_ID, Puesto_ID,
Departamento_ID, Direccion_ID, FechaIngreso)

values(
@Contrasena, @Nombre, @ApellidoPat, @ApellidoMat, @FechaNacimiento,
@CURP, @NSS, @RFC, @Email, @Telefonos, @Banco, @Empresa_FK, @PuestoFK,
@DepartamentoFK, @DireccionFK, getdate())
GO
------------------------------------------------------------------------------------------------------------------
create PROCEDURE SP_AGREGAR_CONCEPTO
@Nombre_Concepto		varchar(30) ,
@Tipo					bit ,
@Obligatoria			bit ,
@Mensual				bit ,
@Valor					money,
@Proporcion				bit
AS

INSERT INTO Concepto(Nombre_Concepto, Tipo, Obligatoria, Mensual, Valor, Proporcion)
values(@Nombre_Concepto, @Tipo, @Obligatoria, @Mensual, @Valor, @Proporcion)
GO
------------------------------------------------------------------------------------------------------------------
create PROCEDURE SP_TEST_AsignarConceptos
@Empleado int,
@Concepto int,
@fecha date

AS

set @fecha = GETDATE();

insert into EmpleadoConceptos(Empleado_ID, Concepto_ID, Fecha)
values(@Empleado, @Concepto, @fecha)
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_AGREGAR_RECIBO
@Empleados_FK			int

AS

declare @Sueldo_Bruto_Temp money
declare @Sueldo_Depos_Temp money
declare @Empresa_FK		   int
declare @Bancos_FK		   int
declare @GUID			   varchar(36)

select @Sueldo_Bruto_Temp = dbo.F_SUELDO_BRUTO(@Empleados_FK)

select @Sueldo_Depos_Temp = dbo.F_SUELDO_NETO(@Sueldo_Bruto_Temp,@Empleados_FK)

select @Empresa_FK = E.Empresa_ID from Empleado E where E.ID_Empleado = @Empleados_FK

select @Bancos_FK = E.Cuenta_BancoID from Empleado E where E.ID_Empleado = @Empleados_FK

--DECLARE @guid_temp uniqueidentifier = NEWID()
select @GUID = NEWID()

--Guid.NewGuid().ToString()

INSERT INTO ReciboDeNomina(Fecha_Recibo, Cantidad_Bruta ,Cantidad_Depositada, GUID,
Empresa_ID, Empleado_ID, Banco_ID)

VALUES(GETDATE(), @Sueldo_Bruto_Temp, @Sueldo_Depos_Temp, @GUID,
@Empresa_FK, @Empleados_FK, @Bancos_FK)
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_AGREGAR_RECIBO_ALT
@Empleados_FK			int,
@Mes					int,
@Año					int

AS

declare @Sueldo_Bruto_Temp money
declare @Sueldo_Depos_Temp money
declare @Empresa_FK		   int
declare @Bancos_FK		   int
declare @GUID			   varchar(36)
declare @CANTIDAD_DIAS	   int
declare @Fecha_Alt		   date
declare @Fecha_nuevo	   date
--declare @Ultimo_Dia		   int

--select @Sueldo_Bruto_Temp = dbo.F_SUELDO_BRUTO(@Empleados_FK)
select @CANTIDAD_DIAS = dbo.DIAS_POR_MES(@Mes)

select @Sueldo_Bruto_Temp = dbo.F_SUELDO_BRUTO_ALT(@Empleados_FK, @CANTIDAD_DIAS)

select @Sueldo_Depos_Temp = dbo.F_SUELDO_NETO(@Sueldo_Bruto_Temp,@Empleados_FK)



SELECT @Fecha_Alt =
CONCAT(
@Año, '/',
@Mes, '/',		
@CANTIDAD_DIAS)




select @Empresa_FK = E.Empresa_ID from Empleado E where E.ID_Empleado = @Empleados_FK

select @Bancos_FK = E.Cuenta_BancoID from Empleado E where E.ID_Empleado = @Empleados_FK


select @GUID = NEWID()



INSERT INTO ReciboDeNomina(Fecha_Recibo, Cantidad_Bruta ,Cantidad_Depositada, GUID,
Empresa_ID, Empleado_ID, Banco_ID)

VALUES(@Fecha_Alt, @Sueldo_Bruto_Temp, @Sueldo_Depos_Temp, @GUID,
@Empresa_FK, @Empleados_FK, @Bancos_FK)
GO
------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------------------



delete from EmpleadoConceptos where Empleado_ID = 5 AND Concepto_ID = 8





insert into EmpleadoConceptos




truncate table ReciboDeNomina

exec SP_AGREGAR_RECIBO 1;
exec SP_IMPRIMIR_RECIBO

exec SP_AGREGAR_RECIBO_ALT 1,1,2000

select * from EmpleadoConceptos

exec SP_IMPRIMIR_CONCEPTO

------------------------------------------------------------------------------------------


