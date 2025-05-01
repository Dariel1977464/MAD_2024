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

select * from Empleado E
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
inner join Departamento D on E.Departamento_ID = D.ID_Departamento

--Departamento
--Puesto
--Empleados

--Departamento
--Empleados



