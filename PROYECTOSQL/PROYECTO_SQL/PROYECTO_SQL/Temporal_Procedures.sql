use Nomina_TEMPORAL;

CREATE PROCEDURE DBsp_EmpresaLLnear
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

drop procedure DBsp_EmpresaLLnear
truncate table Empresa

Exec DBsp_EmpresaLLnear 'FLORENCIA','Razon social', 'Enrique Segobiano', '8241260908', 'Registro pat', '1234567890123', '01/03/2021';

select * from Empresa

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

truncate table Direccion

Exec DBsp_DireccionLLenar 'Calle',123,'Colonia','Municipio','ESTADO','2205'

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

drop procedure DBsp_EmpleadoLLenar

exec DBsp_EmpleadoLLenar '12345', 'Dariel', 'Perez', 'Chavez',
'03/01/2003', 'curp12334', 'nss123', 'rfc123', 1, 'outlook.com',
'8241260908', 1, 1, 1, 1 

exec DBsp_EmpleadoLLenar '12345', 'Maria', 'Chavez', 'De leon',
'03/01/2000', 'curp12334', 'nss123', 'rfc123', 1, 'outlook.com',
'8241260908', 1, 1, 1, 1 

exec DBsp_EmpleadoLLenar '12345', 'Pablo', 'Cardenas', 'Martinez',
'03/01/2000', 'curp12334', 'nss123', 'rfc123', 1, 'outlook.com',
'8241260908', 1, 1, 1, 1 

exec DBsp_EmpleadoLLenar '12345', 'Griselda', 'Perez', 'Chavez',
'03/01/2000', 'curp12334', 'nss123', 'rfc123', 1, 'outlook.com',
'8241260908', 1, 1, 1, 1 

select * from Empleado




CREATE PROCEDURE DBsp_ConceptosDeNominaLLenar
@Nombre_Concepto		varchar(30) ,
@Tipo				int ,
@Obligatoria			bit ,
@Mensual				bit 
AS

INSERT INTO Concepto(Nombre_Concepto, Tipo, Obligatoria, Mensual)
values(@Nombre_Concepto, @Tipo, @Obligatoria, @Mensual)

GO

drop PROCEDURE DBsp_ConceptosDeNominaLLenar


exec DBsp_ConceptosDeNominaLLenar 'Aguinaldo', 0, 0, 0 
exec DBsp_ConceptosDeNominaLLenar 'Aguinaldo', 2, 0, 0 


CREATE PROCEDURE DBsp_BancoLLenar
@Banco			varchar(20) ,
@NumeroCuenta	varchar(20)
AS

INSERT INTO Cuenta_De_Banco(Banco, NumeroCuenta)
values(@Banco, @NumeroCuenta)

GO

exec DBsp_BancoLLenar 'Banco', '123456'


drop procedure DBsp_BancoLLenar

CREATE PROCEDURE DBsp_ReciboDeNominaLLenar
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

drop procedure DBsp_ReciboDeNominaLLenar

exec DBsp_ReciboDeNominaLLenar '09/12/2024', 300, 5, 3, null, null

exec DB_Select_Empleados

CREATE PROCEDURE DBsp_ConceptoEmpleadosLLenar
@EmpleadoFK			int,
@ConceptosFK		int
AS

INSERT INTO ConceptosEmpleado(EmpleadoFK, ConceptosFK)
values(@EmpleadoFK, @ConceptosFK)

GO


------------------------------------------------------------------------------------------

CREATE PROCEDURE DB_Select_ConceptoNomina
AS

 select
 ID_Concepto AS ID,
 Nombre_Concepto AS [NOMBRE DEL CONCEPTO],
 Tipo AS TIPO,
 Obligatoria AS OBLIGATORIA,
 Mensual AS MENSUAL
 from Concepto				

GO



CREATE PROCEDURE DB_Select_Departamento
AS

 select
 D.ID_Departamento AS ID,
 D.Nombre_Departamento AS [NOMBRE DEL DEPARTAMENTO],
 D.SueldoBase_Diario AS [SUELDO BASE POR DIA],
 E.Nombre AS EMPRESA
 from Departamento D join Empresa E ON D.Empresa_ID = E.ID_Empresa

GO




CREATE PROCEDURE DB_Select_Empleados
AS
 select
E.ID_Empleado AS ID,
concat(E.Nombre, ' ', E.ApellidoPat, ' ', E.ApellidoMat) AS [EMPLEADO],
E.Email AS EMAIL,
E.Contraseña	AS CONTRASEÑA,

Em.Nombre AS EMPRESA,
D.Nombre_Departamento AS [DEPARTAMENTO],
P.Titulo_de_Puesto AS [PUESTO],

E.FechaNacimiento	AS [FECHA DE NACIMIENTO],
E.CURP,
E.NSS,
E.RFC,
E.Teléfonos AS TELEFONO,

CONCAT(
Di.Estado, ' ',
Di.Municipio, ' ',		
Di.Colonia, ' ',
Di.Calle, ' ',			
Di.Numero, ' ',	
Di.Codigo_Postal	

) AS DIRECCION,


B.Banco AS BANCO


	
from Empleado E inner join Cuenta_De_Banco B on E.Cuenta_BancoID = B.ID_Banco
inner join Empresa Em on E.Empresa_ID = Em.ID_Empresa
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Direccion Di on E.Direccion_ID = Di.ID_Direccion

GO

select * from Empleado
exec DB_Select_Empleados


CREATE PROCEDURE DB_Select_Puesto
AS
 
 select

ID_Puesto AS ID,			
Titulo_de_Puesto AS [TITULO DEL PUESTO],
Proporcion AS PROPORCION

from Puesto

GO



CREATE PROCEDURE DB_Select_ReciboNomina
AS
 
 select 
R.ID_Recibo AS ID,
GUID AS FOLIO,
R.Fecha_Recibo AS [FECHA DE IMPRESION],
R.Cantidad_Depositada AS [CANTIDAD DEPOSITADA],

E.Nombre AS EMPRESA,
B.Banco AS BANCO,
concat(Em.Nombre, ' ', Em.ApellidoPat, ' ', Em.ApellidoMat) AS [EMPLEADO]

from ReciboDeNomina R
inner join Empresa E on R.Empresa_ID = E.ID_Empresa
inner join Empleado Em on R.Empleado_ID = Em.ID_Empleado
inner join Cuenta_De_Banco B on R.Banco_ID = B.ID_Banco

GO






