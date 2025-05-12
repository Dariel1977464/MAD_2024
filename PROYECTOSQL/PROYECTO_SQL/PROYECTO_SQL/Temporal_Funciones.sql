create function F_SUELDO_NETO
(
@EmpleadoID			int
)
returns money
as begin

declare @SalarioDiario	money
declare @Proporcion		money
declare @DiasTrabajados int
declare @SueldoBruto		money



select @SalarioDiario = D.SueldoBase_Diario 
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
where E.ID_Empleado = @EmpleadoID;

select @Proporcion = P.Proporcion
from Empleado E
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
inner join Puesto P on E.Puesto_ID = P.ID_Puesto
where E.ID_Empleado = @EmpleadoID;

set @SueldoBruto = @SalarioDiario * @Proporcion




return @SueldoBruto
end

drop function F_SUELDO_NETO

select dbo.F_sueldo_Neto(1)

--select D.SueldoBase_Diario
--from Empleado E
--inner join Departamento D on E.Departamento_ID = D.ID_Departamento
--inner join Puesto P on E.Puesto_ID = P.ID_Puesto
--where E.ID_Empleado = @EmpleadoID

