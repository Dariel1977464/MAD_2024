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

declare @Cero_prueba money
set @Cero_prueba = 0;
declare @Sueldo_Neto		  money
declare @DeduccionesCantidad  money
declare @PercepcionesCantidad money

declare @HorasExtra			  money
declare @Incapacidad		  money


declare @SueldoDiario money
set @SueldoDiario = dbo.F_NominaRequisito_SalarioDiario(@EmpleadoID)

declare @ConceptoID_HorasExtra int
select @ConceptoID_HorasExtra = ID_Concepto from Concepto where Nombre_Concepto = 'Horas Extra'

declare @ConceptoID_Incapacidad int
select @ConceptoID_Incapacidad = ID_Concepto from Concepto where Nombre_Concepto = 'Dia Incapacitado'

--------------------------------------------------------------------------------------------------------------------------
declare @Empleado_Tiene_HorasExtra bit
set @Empleado_Tiene_HorasExtra = dbo.F_NominaRequisito_HorasExtra_checar(@EmpleadoID)
declare @Empleado_Tiene_Incapacidad bit
set @Empleado_Tiene_Incapacidad = dbo.F_NominaRequisito_Incapacidad_checar(@EmpleadoID)





select @HorasExtra =
(case when @Empleado_Tiene_HorasExtra = 1 then (COUNT(EC.ID_EmpleadoConceptos) * @SueldoDiario) else @Cero_prueba end)
from EmpleadoConceptos EC
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @EmpleadoID AND EC.Concepto_ID = @ConceptoID_HorasExtra
----------------------------------------------------------------------------------------------------------------------------

select @Incapacidad =
(case when @Empleado_Tiene_Incapacidad = 1 then (COUNT(EC.ID_EmpleadoConceptos) * @SueldoDiario) else @Cero_prueba end)
from EmpleadoConceptos EC
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @EmpleadoID AND EC.Concepto_ID = @ConceptoID_Incapacidad

----------------------------------------------------------------------------------------------------------------------------

declare @HayProporciones_Deducciones int




if NOT EXISTs(

select C.ID_Concepto from EmpleadoConceptos EC
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @EmpleadoID AND C.Proporcion = 1
)
begin 
set @HayProporciones_Deducciones = 0
end

else
begin
set @HayProporciones_Deducciones = 1
end





declare @DeduccionProporcion money
declare @Deduccion_ID int

--if(@HayProporciones_Deducciones = 1)

select @Deduccion_ID = C.ID_Concepto from Concepto C where C.Proporcion = 1



select @DeduccionesCantidad = SUM(C.Valor) from Concepto C
inner join EmpleadoConceptos EC on EC.Concepto_ID = C.ID_Concepto
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
where E.ID_Empleado = @EmpleadoID AND C.Proporcion = 0
AND
C.Tipo = 0;



if @HayProporciones_Deducciones = 1
begin

select @DeduccionProporcion = ((C.Valor / 100) * @Salario_Bruto)
from Concepto C
inner join EmpleadoConceptos EC on EC.Concepto_ID = C.ID_Concepto
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
where E.ID_Empleado = @EmpleadoID AND C.ID_Concepto = @Deduccion_ID AND
C.Tipo = 0;
end

else
begin

set @DeduccionProporcion = 0

end



set @DeduccionesCantidad = @DeduccionesCantidad + @DeduccionProporcion




select @PercepcionesCantidad = SUM(C.Valor) from Concepto C
inner join EmpleadoConceptos EC on EC.Concepto_ID = C.ID_Concepto
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
where E.ID_Empleado = @EmpleadoID
AND
C.Tipo = 1;

set @PercepcionesCantidad = @PercepcionesCantidad + @HorasExtra + @Incapacidad





set @Sueldo_Neto = @Salario_Bruto + @PercepcionesCantidad - @DeduccionesCantidad



return @Sueldo_Neto
--return @HayProporciones_Deducciones
END
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------






------------------------------------------------------------------------------------------------------
select dbo.F_SUELDO_BRUTO_ALT(6, 31)

29295

select dbo.F_SUELDO_NETO(29295, 6)




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
------------------------------------------------------------------------------------------------------
create function dbo.Dias_con_Incapacidad
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
where E.ID_Empleado = @Empleado AND C.Nombre_Concepto = 'Dia Incapacitado'



return @DiasTrabajados
end
------------------------------------------------------------------------------------------------------
create function dbo.F_NominaRequisito_SalarioDiario
(
@EmpleadoID			int
)
returns money
as begin

declare @Salario_Base	money
declare @Proporcion		money
declare @Salario_Diario	money





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

RETURN @Salario_Diario
END
------------------------------------------------------------------------------------------------------
create function dbo.F_NominaRequisito_Incapacidad_checar
(
@Empleado int
)
returns int
as
begin

declare @CantHorasExtra int

declare @Hay_HorasExtra bit

declare @ConceptoID_HorasExtra int
select @ConceptoID_HorasExtra = ID_Concepto from Concepto where Nombre_Concepto = 'Dia Incapacitado'

select @CantHorasExtra = count(EC.Empleado_ID)
from EmpleadoConceptos EC
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @Empleado AND EC.Concepto_ID = @ConceptoID_HorasExtra

set @Hay_HorasExtra = IIF(@CantHorasExtra > 0, 1, 0)




return @Hay_HorasExtra
end
------------------------------------------------------------------------------------------------------
create function dbo.F_NominaRequisito_HorasExtra_checar
(
@Empleado int
)
returns int
as
begin

declare @CantHorasExtra int

declare @Hay_HorasExtra bit

declare @ConceptoID_HorasExtra int
select @ConceptoID_HorasExtra = ID_Concepto from Concepto where Nombre_Concepto = 'Horas Extra'

select @CantHorasExtra = count(EC.Empleado_ID)
from EmpleadoConceptos EC
inner join Empleado E on EC.Empleado_ID = E.ID_Empleado
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto
where EC.Empleado_ID = @Empleado AND EC.Concepto_ID = @ConceptoID_HorasExtra

set @Hay_HorasExtra = IIF(@CantHorasExtra > 0, 1, 0)




return @Hay_HorasExtra
end
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
select dbo.F_NominaRequisito_HorasExtra_checar(5)

select * from EmpleadoConceptos




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

select dbo.F_NominaRequisito_SalarioDiario(5)


--select D.SueldoBase_Diario
--from Empleado E
--inner join Departamento D on E.Departamento_ID = D.ID_Departamento
--inner join Puesto P on E.Puesto_ID = P.ID_Puesto
--where E.ID_Empleado = @EmpleadoID

