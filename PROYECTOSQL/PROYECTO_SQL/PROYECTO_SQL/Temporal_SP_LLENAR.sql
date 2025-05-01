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

INSERT INTO EmpleadoConceptos(Empleado_ID, Concepto_ID)
values(@EmpleadoFK, @ConceptosFK)
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
@Contraseña		varchar(20) ,
@Nombre			varchar(30) ,
@ApellidoPat		varchar(30) ,
@ApellidoMat		varchar(30) ,
@FechaNacimiento date,
@CURP			varchar(18) ,
@NSS				varchar(11) ,
@RFC				varchar(13) ,
@Banco			int ,
@Email			varchar(30) ,
@Teléfonos		varchar(10) ,

@Empresa_FK		int,
@PuestoFK		int,
@DepartamentoFK	int,
@DireccionFK		int
AS
INSERT INTO Empleado(Contraseña, Nombre, ApellidoPat, ApellidoMat, FechaNacimiento,
CURP, NSS, RFC, Cuenta_BancoID, Email, Teléfonos, Empresa_ID, Puesto_ID,
Departamento_ID, Direccion_ID)

values(@Contraseña, @Nombre, @ApellidoPat, @ApellidoMat, @FechaNacimiento,
@CURP, @NSS, @RFC, @Banco, @Email, @Teléfonos, @Empresa_FK, @PuestoFK,
@DepartamentoFK, @DireccionFK)
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
CREATE PROCEDURE SP_AGREGAR_RECIBO
@Fecha_Recibo			date,
@Cantidad_Depositada	money,

@Empresa_FK				int,
@Empleados_FK			int,
@Bancos_FK				int,
@GUID					varchar(30) 
AS

INSERT INTO ReciboDeNomina(Fecha_Recibo, Cantidad_Depositada,
Empresa_ID, Empleado_ID, GUID)
VALUES(@Fecha_Recibo, @Cantidad_Depositada,
@Empresa_FK, @Empleados_FK, @GUID)
GO
------------------------------------------------------------------------------------------------------------------
select * from Empleado
truncate table Empleado
exec SP_AGREGAR_EMPLEADO 'vdhnr18368', 'Omar', 'Garza', 'Zapata',
'03/01/2003', 'GAZO030301HNLRPMA7', 'nss826nss82', 'GAZO030301RP10', 1, 'OmGaZa03@outlook.com',
'8241260908', 1, 4, 1, 2 

exec SP_AGREGAR_EMPLEADO 'awdtg17350', 'Gisele', 'Cardenas', 'De leon',
'01/08/2002', 'CALG020108MNLRNSA7', 'nss912nss91', 'CALG0201088F6', 2, 'GiCaDe02@outlook.com',
'8241112028', 1, 2, 3, 3 

exec SP_AGREGAR_EMPLEADO 'dgjku17252', 'Pedro', 'Gutierrez', 'De leon',
'09/02/2001', 'GULP010902HNLTNDA5', 'nss156nss15', 'GULP010902H66', 3, 'PeGuDe01@outlook.com',
'8244719812', 1, 1, 2, 3 

exec SP_AGREGAR_EMPLEADO 'bcfd21825', 'Martin', 'Perez', 'Villareal',
'01/01/2005', 'PEVM050101HNLRLRA6', 'nss260nss26', 'PEVM0501015BA', 4, 'MaPeVi05@outlook.com',
'8249241383', 1, 3, 1, 5 

exec SP_AGREGAR_EMPLEADO 'avfwt81254', 'Karla', 'Amaro', 'Lopez',
'02/09/2005', 'AALK050209MNLMPRA5', 'nss916nss91', 'AALK050209MI9', 5, 'KaAmLo05@outlook.com',
'8241690947', 1, 5, 5, 4 


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
exec SP_AGREGAR_CONCEPTO 'Sueldo Diario' ,		1, 1, 1, NULL 
exec SP_AGREGAR_CONCEPTO 'Llegada Tardia',		0, 0, 0, 20
exec SP_AGREGAR_CONCEPTO 'Bono',				1, 0, 0, 200
exec SP_AGREGAR_CONCEPTO 'Extra Mensual',		1, 1, 1, 50
exec SP_AGREGAR_CONCEPTO 'Fondo para Retiro',	0, 1, 1, 100
------------------------------------------------------------------------------------------


