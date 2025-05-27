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
CREATE PROCEDURE SP_AGREGAR_DEPARTAMENTO

@Nombre_Departamento	varchar(20),
@SueldoBase_Diario		money,
@Empresa_ID				int

AS
INSERT INTO Departamento(Nombre_Departamento, SueldoBase_Diario, Empresa_ID)
values(@Nombre_Departamento, @SueldoBase_Diario, @Empresa_ID)
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
CREATE PROCEDURE SP_AGREGAR_CONCEPTO
@Nombre_Concepto		varchar(30) ,
@Tipo					bit ,
@Obligatoria			bit ,
@Mensual				bit ,
@Valor					money
AS

INSERT INTO Concepto(Nombre_Concepto, Tipo, Obligatoria, Mensual, Valor)
values(@Nombre_Concepto, @Tipo, @Obligatoria, @Mensual, @Valor)
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_TEST_AsignarConceptos
@Empleado int,
@Concepto int,
@fecha date

AS

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
create procedure sp_NominaRequisito_Percepciones
@Empleado int

as
select
C.ID_Concepto AS [CLAVE],
C.Nombre_Concepto AS [CONCEPTO],
(case when C.Nombre_Concepto = 'Sueldo Diario' then D.SueldoBase_Diario else 0 end) AS [IMP GRAVADO],
C.Valor AS [IMP EXT]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where E.ID_Empleado = @Empleado AND C.Tipo = 1 AND C.Nombre_Concepto != 'Horas Extra' AND C.Nombre_Concepto != 'Dia Incapacitado'
order by E.Nombre

go
------------------------------------------------------------------------------------------------------------------
create procedure sp_NominaRequisito_Deducciones
@Empleado int

as
select
C.ID_Concepto AS [CLAVE],
C.Nombre_Concepto AS [CONCEPTO],
C.Valor AS [IMPORTE]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where E.ID_Empleado = @Empleado AND C.Tipo = 0 AND C.Nombre_Concepto != 'Horas Extra' AND C.Nombre_Concepto != 'Dia Incapacitado'
order by E.Nombre

go
------------------------------------------------------------------------------------------------------------------
create procedure sp_NominaRequisito_HorasExtra
@Empleado int
as
declare @CantDias int
select @CantDias = dbo.Dias_con_Horas_Extra(@Empleado)


select
(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then COUNT(EC.ID_EmpleadoConceptos) else 0 end) AS [DIAS],
(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then (COUNT(EC.ID_EmpleadoConceptos) * 8) else 0 end) AS [HORAS],
(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then (COUNT(EC.ID_EmpleadoConceptos) * D.SueldoBase_Diario) else 0 end) AS [IMP PAGADO]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where E.ID_Empleado = @Empleado AND C.Nombre_Concepto = 'Horas Extra'
group by D.SueldoBase_Diario

--select
--(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then COUNT(EC.ID_EmpleadoConceptos) else 0 end) AS [DIAS],
--(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then (COUNT(EC.ID_EmpleadoConceptos) * 8) else 0 end) AS [HORAS],
--(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then (COUNT(EC.ID_EmpleadoConceptos) * D.SueldoBase_Diario) else 0 end) AS [IMP PAGADO]
--from Empleado E
--inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
--inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
--inner join Departamento D on E.Departamento_ID = D.ID_Departamento
--where E.ID_Empleado = @Empleado AND C.Nombre_Concepto = 'Horas Extra'
--group by D.SueldoBase_Diario
go


--select
--(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then COUNT(EC.ID_EmpleadoConceptos) else 0 end) AS [DIAS],
--(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then (COUNT(EC.ID_EmpleadoConceptos) * 8) else 0 end) AS [HORAS],
--(case when COUNT(EC.ID_EmpleadoConceptos) > 0 then (COUNT(EC.ID_EmpleadoConceptos) * D.SueldoBase_Diario) else 0 end) AS [IMP PAGADO]
--from Empleado E
--inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
--inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
--inner join Departamento D on E.Departamento_ID = D.ID_Departamento
--where E.ID_Empleado = 2 AND C.Nombre_Concepto = 'Horas Extra'
--group by D.SueldoBase_Diario




exec sp_NominaRequisito_Percepciones 1
exec sp_NominaRequisito_HorasExtra 5


------------------------------------------------------------------------------------------------------------------

truncate table Empresa
select * from Empresa
exec SP_LLENAR_EMPRESA 'BYTEFORCE', 'Oficinas Modelo S.A. de C.V.', 'Enrique Segoviano', '8241230807',
'00000001234', 'PAZO020109MLIOLKA8', '01/08/1999'



truncate table Empleado
select * from Empleado
exec SP_AGREGAR_EMPLEADO 'vdhnr18368', 'Omar', 'Garza', 'Zapata', '03/01/2003',
'GAZO030301HNLRPMA7', 'nss826nss82', 'GAZO030301RP10', 'OmGaZa03@outlook.com', '8241260908', 1, 1, 4,
1, 2

exec SP_AGREGAR_EMPLEADO 'awdtg17350', 'Gisele', 'Cardenas', 'De leon','01/08/2002',
'CALG020108MNLRNSA7', 'nss912nss91', 'CALG0201088F6', 'GiCaDe02@outlook.com', '8241112028', 2, 1, 2,
3, 3 

exec SP_AGREGAR_EMPLEADO 'dgjku17252', 'Pedro', 'Gutierrez', 'De leon', '09/02/2001',
'GULP010902HNLTNDA5', 'nss156nss15', 'GULP010902H66', 'PeGuDe01@outlook.com', '8244719812', 3, 1, 1,
2, 3 

exec SP_AGREGAR_EMPLEADO 'bcfd21825', 'Martin', 'Perez', 'Villareal', '01/01/2005',
'PEVM050101HNLRLRA6', 'nss260nss26', 'PEVM0501015BA', 'MaPeVi05@outlook.com', '8249241383', 4, 1, 3,
1, 5 

exec SP_AGREGAR_EMPLEADO 'avfwt81254', 'Karla', 'Amaro', 'Lopez', '02/09/2005',
'AALK050209MNLMPRA5', 'nss916nss91', 'AALK050209MI9', 'KaAmLo05@outlook.com', '8241690947', 5, 1, 5,
5, 4 

select * from Departamento
truncate table Departamento
exec SP_AGREGAR_DEPARTAMENTO 'Produccion', 37, '1'; 
exec SP_AGREGAR_DEPARTAMENTO 'Contaduria', 52, '1'; 
exec SP_AGREGAR_DEPARTAMENTO 'Recursos Humanos', 35, '1'; 
exec SP_AGREGAR_DEPARTAMENTO 'Comunicaciones', 28, '1'; 
exec SP_AGREGAR_DEPARTAMENTO 'Oficina', 15, '1'; 


select * from Puesto
truncate table Puesto
exec SP_AGREGAR_PUESTO 'Director', 1.0;
exec SP_AGREGAR_PUESTO 'Tecnico', 0.9;
exec SP_AGREGAR_PUESTO 'Gerente', 0.8;
exec SP_AGREGAR_PUESTO 'Secretario', 0.7;
exec SP_AGREGAR_PUESTO 'Conserje', 0.6;


select * from Direccion
truncate table Direccion
Exec SP_AGREGAR_DIRECCION 'Zapata',512,'Cuactemoc','Monterrey','Nuevo leon','2205';
Exec SP_AGREGAR_DIRECCION 'Edgar almiran',515,'Cuactemoc','Monterrey','Nuevo leon','2205';
Exec SP_AGREGAR_DIRECCION 'General',135,'Limoneros','Sabinas Hidalgo','Nuevo leon','1923';
Exec SP_AGREGAR_DIRECCION 'General',271,'Pascuales','Saltillo','Nuevo leon','9012';
Exec SP_AGREGAR_DIRECCION 'Maderos',412,'Hospitalaria','Bustamante','Nuevo leon','5436';


select * from Cuenta_De_Banco
truncate table Cuenta_De_Banco
exec SP_LLENAR_BANCO 'Azteca', '3582513951472691489';
exec SP_LLENAR_BANCO 'Azteca', '2812149062585248579';
exec SP_LLENAR_BANCO 'Guajardo', '9209475024067309572';
exec SP_LLENAR_BANCO 'Benavides', '7693759472951645427';
exec SP_LLENAR_BANCO 'Azteca', '1037569375932058302';

select * from Concepto
truncate table Concepto
exec SP_AGREGAR_CONCEPTO 'Sueldo Diario' ,		1, 1, 1, 0 
exec SP_AGREGAR_CONCEPTO 'Llegada Tardia',		0, 0, 0, 20
exec SP_AGREGAR_CONCEPTO 'Bono',				1, 0, 0, 200
exec SP_AGREGAR_CONCEPTO 'Extra Mensual',		1, 1, 1, 50
exec SP_AGREGAR_CONCEPTO 'Fondo para Retiro',	0, 1, 1, 100
exec SP_AGREGAR_CONCEPTO 'Horas Extra',			1, 0, 0, 0
exec SP_AGREGAR_CONCEPTO 'Dia Incapacitado',	1, 0, 1, 0

--delete from Concepto where Nombre_Concepto = 'Hora Extra'

select * from EmpleadoConceptos
truncate table EmpleadoConceptos

exec SP_TEST_AsignarConceptos 1,1, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,2, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,5, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,8, '03/01/2020'

exec SP_TEST_AsignarConceptos 2,1, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,2, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,5, '03/01/2020'

exec SP_TEST_AsignarConceptos 3,1, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,2, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,5, '03/01/2020'

exec SP_TEST_AsignarConceptos 4,1, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,2, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,5, '03/01/2020'

exec SP_TEST_AsignarConceptos 5,1, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,2, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,5, '03/01/2020'





insert into EmpleadoConceptos
values(4,2,getdate())
insert into EmpleadoConceptos
values(4,3,getdate())
insert into EmpleadoConceptos
values(4,4,getdate())
insert into EmpleadoConceptos
values(4,5,getdate())
insert into EmpleadoConceptos
values(4,5,getdate())

insert into EmpleadoConceptos
values(5,2,getdate())
insert into EmpleadoConceptos
values(5,3,getdate())
insert into EmpleadoConceptos
values(5,4,getdate())
insert into EmpleadoConceptos
values(5,5,getdate())
insert into EmpleadoConceptos
values(5,5,getdate())



truncate table ReciboDeNomina

exec SP_AGREGAR_RECIBO 1;
exec SP_IMPRIMIR_RECIBO

exec SP_AGREGAR_RECIBO_ALT 1,1,2000

select * from EmpleadoConceptos

exec SP_IMPRIMIR_CONCEPTO

------------------------------------------------------------------------------------------


