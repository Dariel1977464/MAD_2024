CREATE PROCEDURE SP_IMPRIMIR_DEPARTAMENTO
AS

 select
 D.ID_Departamento AS ID,
 D.Nombre_Departamento AS [DEPARTAMENTO],
 D.SueldoBase_Diario AS [SUELDO DIARIO],
 E.Nombre AS EMPRESA
 from Departamento D join Empresa E ON D.Empresa_ID = E.ID_Empresa

GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_IMPRIMIR_PUESTO
AS
 
 select

ID_Puesto AS ID,			
Titulo_de_Puesto AS [PUESTO],
Proporcion AS PROPORCION

from Puesto

GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_IMPRIMIR_EMPLEADO
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
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_IMPRIMIR_EMPLEADO_1
@Empleado int
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

where E.ID_Empleado = @Empleado

GO

------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_IMPRIMIR_CONCEPTO
AS

 select
 ID_Concepto AS ID,
 Nombre_Concepto AS [CONCEPTO],
 Tipo AS TIPO,
 Obligatoria AS OBLIGATORIA,
 Mensual AS MENSUAL
 from Concepto				

GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_IMPRIMIR_RECIBO
AS
 
select 
R.ID_Recibo AS ID,
GUID AS FOLIO,
R.Fecha_Recibo AS [FECHA DE IMPRESION],
R.Cantidad_Bruta AS [CANTIDAD BRUTA],
R.Cantidad_Depositada AS [CANTIDAD DEPOSITADA],

E.Nombre AS EMPRESA,
B.Banco AS BANCO,
concat(Em.Nombre, ' ', Em.ApellidoPat, ' ', Em.ApellidoMat) AS [EMPLEADO]

from ReciboDeNomina R
inner join Empresa E on R.Empresa_ID = E.ID_Empresa
inner join Empleado Em on R.Empleado_ID = Em.ID_Empleado
inner join Cuenta_De_Banco B on R.Banco_ID = B.ID_Banco

GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_IMPRIMIR_RECIBO_1_EMPLEADO
@Empleado int
AS

select 
R.ID_Recibo AS ID,
GUID AS FOLIO,
R.Fecha_Recibo AS [FECHA DE IMPRESION],
R.Cantidad_Bruta AS [CANTIDAD BRUTA],
R.Cantidad_Depositada AS [CANTIDAD DEPOSITADA],

E.Nombre AS EMPRESA,
B.Banco AS BANCO,
concat(Em.Nombre, ' ', Em.ApellidoPat, ' ', Em.ApellidoMat) AS [EMPLEADO]

from ReciboDeNomina R
inner join Empresa E on R.Empresa_ID = E.ID_Empresa
inner join Empleado Em on R.Empleado_ID = Em.ID_Empleado
inner join Cuenta_De_Banco B on R.Banco_ID = B.ID_Banco

where Em.ID_Empleado = @Empleado

GO

------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_REPORTE_NOMINA
AS

select
D.Nombre_Departamento AS [DEPARTAMENTO],
year(R.Fecha_Recibo) AS [AÑO],
month(R.Fecha_Recibo) AS [MES],
R.Cantidad_Bruta AS [SUELDO BRUTO],
R.Cantidad_Depositada AS [SUELDO NETO]



From ReciboDeNomina R
inner join Empleado E on R.Empleado_ID = E.ID_Empleado
inner join Departamento D on E.Departamento_ID = D.ID_Departamento


GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_REPORTE_GENERAL
AS

--EMPLEADOS QUE LABORAN EN CADA DEPARTAMENTO
--DEPARTAMENTO, PUESTO, NOMBRE DEL EMPLEADO, FECHA DE INGRESO A LA EMPRESA, EDAD, SALARIO DIARIO

select 
D.Nombre_Departamento AS [DEPARTAMENTO],
P.Titulo_de_Puesto AS [PUESTO],
concat(E.Nombre, ' ', E.ApellidoPat, ' ', E.ApellidoMat) AS [EMPLEADO],
E.FechaIngreso AS [FECHA DE INGRESO],
dbo.F_EDAD(E.FechaNacimiento)	AS [EDAD],
D.SueldoBase_Diario AS [SUELDO DIARIO]


from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_REPORTE_HEADCOUNTER_1
AS
--Listado de los Departamentos con la cantidad de empleados por puesto y departamento
--Departamento, puesto, cantidad de empleados en ese puesto-departamento


select 
--P.Titulo_de_Puesto AS [PUESTO],
D.Nombre_Departamento AS [DEPARTAMENTO],
--E.ID_Empleado
COUNT(E.ID_Empleado) AS [CANTIDAD DE EMPLEADOS]
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
group by Nombre_Departamento
--order by Nombre_Departamento





GO
------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE SP_REPORTE_HEADCOUNTER_2
AS

--Departamento, puesto, cantidad de empleados en ese puesto-departamento
select 
P.Titulo_de_Puesto AS [PUESTO],
COUNT(E.ID_Empleado) AS [CANTIDAD DE EMPLEADOS]

from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
group by Titulo_de_Puesto
--order by Nombre_Departamento
GO



exec SP_IMPRIMIR_CONCEPTO

exec SP_IMPRIMIR_EMPLEADO

exec SP_IMPRIMIR_RECIBO

exec SP_IMPRIMIR_RECIBO_1_EMPLEADO 1

exec SP_IMPRIMIR_EMPLEADO_1 1

select * from ReciboDeNomina

exec SP_AGREGAR_RECIBO 1


select * from Empleado E
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
inner join Departamento D on E.Departamento_ID = D.ID_Departamento

--Departamento
--Puesto
--Empleados

--Departamento
--Empleados



