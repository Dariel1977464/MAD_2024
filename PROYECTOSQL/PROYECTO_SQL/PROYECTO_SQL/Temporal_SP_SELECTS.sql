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
create PROCEDURE SP_IMPRIMIR_PUESTO
AS
 
 select

ID_Puesto AS ID,			
Titulo_de_Puesto AS [PUESTO],
concat ((Proporcion * 100), '%') AS [PROPORCION %]
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
create PROCEDURE SP_IMPRIMIR_CONCEPTO
AS

 select
 ID_Concepto AS ID,
 Nombre_Concepto AS [CONCEPTO],
 Tipo AS TIPO,
 Obligatoria AS OBLIGATORIA,
 Mensual AS MENSUAL,
 Proporcion AS [PROPORCION]
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
------------------------------------------------------------------------------------------------------------------
create procedure sp_NominaRequisito_Percepciones
@Empleado int

as

declare @SueldoDiario money
set @SueldoDiario = dbo.F_NominaRequisito_SalarioDiario(@Empleado)

select
C.ID_Concepto AS [CLAVE],
C.Nombre_Concepto AS [CONCEPTO],
(case when C.Nombre_Concepto = 'Sueldo Diario' then @SueldoDiario else 0 end) AS [IMP GRAVADO],
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

declare @BrutoTemp money
declare @NetoTemp money

select @BrutoTemp = dbo.F_SUELDO_BRUTO (@Empleado)

--select @NetoTemp = dbo.F_SUELDO_BRUTO_ALT(@Empleado, 31)

select

C.ID_Concepto AS [CLAVE],
C.Nombre_Concepto AS [CONCEPTO],

--C.Valor AS [IMPORTE],

(case when C.Proporcion = 0 then C.Valor
else ((C.Valor / 100) * @BrutoTemp)
end

) AS [IMPORTE]


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

--Pruebas


declare @CantDias int
select @CantDias = dbo.Dias_con_Horas_Extra(@Empleado)
declare @SueldoDiario money
set @SueldoDiario = dbo.F_NominaRequisito_SalarioDiario(@Empleado)

declare @Empleado_Tiene_HorasExtra bit
set @Empleado_Tiene_HorasExtra = dbo.F_NominaRequisito_HorasExtra_checar(@Empleado)

declare @Cero_prueba money
set @Cero_prueba = 0;

declare @ConceptoID_HorasExtra int
select @ConceptoID_HorasExtra = ID_Concepto from Concepto where Nombre_Concepto = 'Horas Extra'

select
(case when @Empleado_Tiene_HorasExtra = 1 then COUNT(EC.ID_EmpleadoConceptos) else 0 end) AS [DIAS],
(case when @Empleado_Tiene_HorasExtra = 1 then (COUNT(EC.ID_EmpleadoConceptos) * 8) else 0 end) AS [HORAS],
(case when @Empleado_Tiene_HorasExtra = 1 then (COUNT(EC.ID_EmpleadoConceptos) * @SueldoDiario) else @Cero_prueba end) AS [IMP PAGADO]
from EmpleadoConceptos EC
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @Empleado AND EC.Concepto_ID = @ConceptoID_HorasExtra
go
------------------------------------------------------------------------------------------------------------------
create procedure sp_NominaRequisito_INCAPACIDAD
@Empleado int
as


declare @CantDias int
select @CantDias = dbo.Dias_con_Incapacidad(@Empleado)
declare @SueldoDiario money
set @SueldoDiario = dbo.F_NominaRequisito_SalarioDiario(@Empleado)

declare @Empleado_Tiene_HorasExtra bit
set @Empleado_Tiene_HorasExtra = dbo.F_NominaRequisito_Incapacidad_checar(@Empleado)

declare @Cero_prueba money
set @Cero_prueba = 0;

declare @ConceptoID_HorasExtra int
select @ConceptoID_HorasExtra = ID_Concepto from Concepto where Nombre_Concepto = 'Horas Extra'

select
(case when @Empleado_Tiene_HorasExtra = 1 then COUNT(EC.ID_EmpleadoConceptos) else 0 end) AS [DIAS],
(case when @Empleado_Tiene_HorasExtra = 1 then (COUNT(EC.ID_EmpleadoConceptos) * 8) else 0 end) AS [HORAS],
(case when @Empleado_Tiene_HorasExtra = 1 then (COUNT(EC.ID_EmpleadoConceptos) * @SueldoDiario) else @Cero_prueba end) AS [IMP MONETARIO]
from EmpleadoConceptos EC
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @Empleado AND EC.Concepto_ID = @ConceptoID_HorasExtra
go







select * from EmpleadoConceptos









exec sp_NominaRequisito_HorasExtra 5












exec sp_NominaRequisito_Percepciones 1
exec sp_NominaRequisito_Deducciones 1





exec SP_IMPRIMIR_CONCEPTO

exec SP_IMPRIMIR_EMPLEADO

exec SP_IMPRIMIR_RECIBO
truncate table ReciboDeNomina

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



