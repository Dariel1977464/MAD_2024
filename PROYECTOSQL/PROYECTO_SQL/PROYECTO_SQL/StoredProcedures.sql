CREATE PROCEDURE DBsp_EmpresaLLnear
@Razón_Social				nvarchar(50),
@Domicilio_Fiscal			nvarchar(50),
@DatosContacto				nvarchar(10),
@Registro_patronal			nvarchar(11),
@RFC						nvarchar(13),
@Fecha_inicio_operaciones	date

AS

insert into Empresa(Razon_Social,Domicilio_Fiscal, Datos_Contacto, Registro_patronal, RFC, Fecha_inicio_operaciones)
values(@Razón_Social,@Domicilio_Fiscal,@DatosContacto,@Registro_patronal,@RFC,@Fecha_inicio_operaciones)

GO


Exec DBsp_EmpresaLLnear 'Razon social', 'Enrique Segobiano', '8241260908', 'Registro pat', '1234567890123', '01/03/2021';

CREATE PROCEDURE DBsp_PuestoLenar
@Nombre_de_Puesto	varchar(30) ,
@Proporcion			float
AS

INSERT INTO Puesto(Titulo_de_Puesto, Proporcion)
values(@Nombre_de_Puesto, @Proporcion)

GO

exec DBsp_PuestoLenar 'Puesto1', 0.5;


CREATE PROCEDURE DBsp_DepartamentoLLenar

@Nombre_Departamento	varchar(20),
@SueldoBase_Diario		money,
@Empresa_ID				int

AS
INSERT INTO Departamento(Nombre_Departamento, SueldoBase_Diario, Empresa_ID)
values(@Nombre_Departamento, @SueldoBase_Diario, @Empresa_ID)
GO

exec DBsp_DepartamentoLLenar 'Compras', 25, '1'; 



CREATE PROCEDURE DBsp_DireccionLLenar
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



CREATE PROCEDURE DBsp_EmpleadoLLenar
@Contraseña		varchar(20) ,
@Nombre			varchar(30) ,
@ApellidoPat		varchar(30) ,
@ApellidoMat		varchar(30) ,
@FechaNacimiento date,
@CURP			varchar(18) ,
@NSS				varchar(11) ,
@RFC				varchar(13) ,
@Banco			int ,
@NumeroCuenta	int ,
@Email			varchar(30) ,
@Teléfonos		varchar(10) ,

@Empresa_FK		int,
@PuestoFK		int,
@DepartamentoFK	int,
@DireccionFK		int
AS
INSERT INTO Empleado(Contraseña, Nombre, ApellidoPat, ApellidoMat, FechaNacimiento,
CURP, NSS, RFC, Banco, NumeroCuenta, Email, Teléfonos, Empresa_ID, Puesto_ID,
Departamento_ID, Direccion_ID)

values(@Contraseña, @Nombre, @ApellidoPat, @ApellidoMat, @FechaNacimiento,
@CURP, @NSS, @RFC, @Banco, @NumeroCuenta, @Email, @Teléfonos, @Empresa_FK, @PuestoFK,
@DepartamentoFK, @DireccionFK)

GO

drop procedure DBsp_EmpleadoLLenar

exec DBsp_EmpleadoLLenar '12345', 'Dariel', 'Perez', 'Chavez',
'03/01/2003', 'curp12334', 'nss123', 'rfc123', 1, 213, 'outlook.com',
'8241260908', 1, 1, 2, null 

select * from Puesto


CREATE PROCEDURE DBsp_ConceptosDeNominaLLenar
@Nombre_Concepto		varchar(30) ,
@Tipo				int ,
@Obligatoria			bit ,
@Mensual				bit 
AS

INSERT INTO ConceptosDeNomina(Nombre_Concepto, Tipo, Obligatoria, Mensual)
values(@Nombre_Concepto, @Tipo, @Obligatoria, @Mensual)

GO

exec DBsp_ConceptosDeNominaLLenar 'Aguinaldo', 0, 0, 0 


CREATE PROCEDURE DBsp_BancoLLenar
@Banco			varchar(20) ,
@NumeroCuenta	varchar(20)
AS

INSERT INTO Banco(Banco, NumeroCuenta)
values(@Banco, @NumeroCuenta)

GO


CREATE PROCEDURE DBsp_ReciboDeNominaLLenar
@Fecha_Recibo			date,
@Cantidad_Depositada	money,

@Empresa_FK				int,
@Empleados_FK			int,
@Bancos_FK				int,
@GUID					varchar(30) 
AS

INSERT INTO ReciboDeNomina(Fecha_Recibo, Cantidad_Depositada,
Empresa_FK, Empleados_FK, Bancos_FK, GUID)
VALUES(@Fecha_Recibo, @Cantidad_Depositada,
@Empresa_FK, @Empleados_FK, @Bancos_FK, @GUID)

GO

exec DBsp_ReciboDeNominaLLenar '09/12/2024', 300, 5, 3, null, null

exec DB_Select_Empleados

CREATE PROCEDURE DBsp_ConceptoEmpleadosLLenar
@EmpleadoFK			int,
@ConceptosFK		int
AS

INSERT INTO ConceptosEmpleado(EmpleadoFK, ConceptosFK)
values(@EmpleadoFK, @ConceptosFK)

GO




CREATE PROCEDURE DB_Select_ConceptoNomina
AS
 select * from ConceptosDeNomina
GO

CREATE PROCEDURE DB_Select_Departamento
AS
 select * from Departamento
GO

CREATE PROCEDURE DB_Select_Empleados
AS
 select * from Empleado
GO

CREATE PROCEDURE DB_Select_Puesto
AS
 select * from Puesto
GO

CREATE PROCEDURE DB_Select_ReciboNomina
AS
 select * from ReciboDeNomina
GO







drop procedure BORRAR_TABLAS