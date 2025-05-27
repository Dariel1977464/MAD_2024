create function dbo.F_EDAD(
@FechaNacimiento date
) returns int
as begin

declare @Edad int
declare @FechaHoy date

set @FechaHoy = getdate()

--@Edad = @FechaHoy - @FechaNacimiento

--select @Edad = datediff(year, @FechaHoy, @FechaNacimiento)
select @Edad = datediff(year, @FechaNacimiento, @FechaHoy)



return @Edad
end
--------------------------------------------------------------------------------------------------------------------------
create function dbo.F_SUELDO_BRUTO
(
@EmpleadoID			int
)
returns money
as begin

declare @Salario_Base	money
declare @Salario_Diario	money
declare @Salario_Bruto	money
declare @Salario_Neto	money

declare @Proporcion		money
declare @DiasTrabajados int

DECLARE @ADate DATETIME

SET @ADate = GETDATE()

SET @DiasTrabajados =  DAY(EOMONTH(@ADate))

---------------------------------------------------------------------------------------------------
--Sueldo Base
select @Salario_Base = D.SueldoBase_Diario 
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
where E.ID_Empleado = @EmpleadoID;
---------------------------------------------------------------------------------------------------
--Sueldo Diario
select @Proporcion = P.Proporcion
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
where E.ID_Empleado = @EmpleadoID;

set @Salario_Diario = @Salario_Base * @Proporcion
---------------------------------------------------------------------------------------------------
--Sueldo Bruto
set @Salario_Bruto = @Salario_Diario * @DiasTrabajados

RETURN @Salario_Bruto
END

-----------------------------------------------------------------------------------------------------------

create function dbo.F_SUELDO_BRUTO_ALT
(
@EmpleadoID			int,
@DiasTrabajados		int
)
returns money
as begin

declare @Salario_Base	money
declare @Salario_Diario	money
declare @Salario_Bruto	money
declare @Salario_Neto	money

declare @Proporcion		money
---------------------------------------------------------------------------------------------------
--Sueldo Base
select @Salario_Base = D.SueldoBase_Diario 
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
where E.ID_Empleado = @EmpleadoID;
---------------------------------------------------------------------------------------------------
--Sueldo Diario
select @Proporcion = P.Proporcion
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
where E.ID_Empleado = @EmpleadoID;

set @Salario_Diario = @Salario_Base * @Proporcion
---------------------------------------------------------------------------------------------------
--Sueldo Bruto
set @Salario_Bruto = @Salario_Diario * @DiasTrabajados

RETURN @Salario_Bruto
END

------------------------------------------------------------------------------------------------------
create function dbo.F_SUELDO_NETO
(
@Salario_Bruto	money,
@EmpleadoID		int
)
Returns money
AS
BEGIN

declare @Sueldo_Neto		  money
declare @DeduccionesCantidad  money
declare @PercepcionesCantidad money

select @DeduccionesCantidad = SUM(C.Valor) from Concepto C
inner join EmpleadoConceptos EC on EC.Concepto_ID = C.ID_Concepto
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
where E.ID_Empleado = @EmpleadoID
AND
C.Tipo = 0;

select @PercepcionesCantidad = SUM(C.Valor) from Concepto C
inner join EmpleadoConceptos EC on EC.Concepto_ID = C.ID_Concepto
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
where E.ID_Empleado = @EmpleadoID
AND
C.Tipo = 1;

set @Sueldo_Neto = @Salario_Bruto + @PercepcionesCantidad - @DeduccionesCantidad

return @Sueldo_Neto
END
------------------------------------------------------------------------------------------------------
create function dbo.DIAS_POR_MES
(
@Mes int
)
returns int
AS
BEGIN

declare @CantDias int
declare @MESDADO int

select @MESDADO = @Mes	

if @MESDADO = 2
begin
select @CantDias = 28
end
else
begin
	if @MESDADO = 4 OR @MESDADO = 6 OR @MESDADO = 9 OR @MESDADO = 11
	select @CantDias = 30
	else
	select @CantDias = 31
END



return @CantDias
END
------------------------------------------------------------------------------------------------------
create function dbo.Empleado_Imprimir_Nombre
()
returns varchar(50)
as
begin
declare @return varchar(50)

return @return
end
------------------------------------------------------------------------------------------------------
create function dbo.Dias_con_Horas_Extra
(
@Empleado int
)
returns int
as
begin
declare @DiasTrabajados int


select @DiasTrabajados =
count(C.ID_Concepto)
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where E.ID_Empleado = @Empleado AND C.Nombre_Concepto = 'Horas Extra'



return @DiasTrabajados
end

select dbo.Dias_con_Horas_Extra(5)

select E.Nombre, C.Nombre_Concepto
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento


------------------------------------------------------------------------------------------------------

update Concepto
set Concepto.Valor = 0
where Concepto.Valor IS NULL

select * from Concepto

select dbo.DIAS_POR_MES(4)

select dbo.F_SUELDO_BRUTO(1)

select dbo.F_SUELDO_NETO(802.9,1)

select E.Nombre, C.Nombre_Concepto, c.Valor from Concepto C
inner join EmpleadoConceptos EC on EC.Concepto_ID = C.ID_Concepto
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
where E.Nombre = 'Omar'









select dbo.F_EDAD(getdate())

drop function dbo.F_EDAD

select dbo.F_SUELDO_BRUTO(1)

select * from Empleado where ID_Empleado = 1
select * from Puesto where ID_Puesto = 4
select * from Departamento where ID_Departamento = 1


--select D.SueldoBase_Diario
--from Empleado E
--inner join Departamento D on E.Departamento_ID = D.ID_Departamento
--inner join Puesto P on E.Puesto_ID = P.ID_Puesto
--where E.ID_Empleado = @EmpleadoID

