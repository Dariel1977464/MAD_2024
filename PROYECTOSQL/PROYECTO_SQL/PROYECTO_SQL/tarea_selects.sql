select * from Empleado

execute sp_help 'Empleado';

--Select es select los recibos de nomina para los empleados del departamento compas
-- en el año 2024


select R.Empleado_ID from ReciboDeNomina R;

select * from Empleado E inner join Departamento D on E.Departamento_ID = D.ID_Departamento;

select * from ReciboDeNomina R where R.Fecha_Recibo = '2024'

----------------------------------------------------------------------------------------------------------------------------------
select R.ID_Recibo, R.Banco_ID, R.Cantidad_Depositada, E.Nombre, E.ApellidoPat, E.ApellidoMat, R.Empresa_ID, R.Fecha_Recibo, R.GUID
from
((ReciboDeNomina AS R inner join Empleado AS E on R.Empleado_ID = E.ID_Empleado)
inner join Departamento AS D on E.Departamento_ID = D.ID_Departamento)
where R.Fecha_Recibo = '2024'
AND D.Nombre_Departamento = 'Compras'


select ID_Recibo, Banco_ID, Cantidad_Depositada, Fecha_Recibo, GUID
from
((ReciboDeNomina inner join Empleado on ReciboDeNomina.Empleado_ID = Empleado.ID_Empleado)
inner join Departamento on Empleado.Departamento_ID = Departamento.ID_Departamento)
where ReciboDeNomina.Fecha_Recibo = '2024'
AND Departamento.Nombre_Departamento = 'Compras'






select E.Nombre, E.ApellidoPat, E.ApellidoMat, D.Nombre_Departamento 
from Empleado E inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where D.SueldoBase_Diario > 100




select E.Nombre, E.ApellidoPat, E.ApellidoMat, C.Nombre_Concepto
from ((Empleado E inner join EmpleadoConceptos EC on EC.Empleado_ID = E.ID_Empleado)
inner join Concepto C on EC.Concepto_ID = C.ID_Concepto)
where  E.FechaNacimiento > '2000' AND C.Obligatoria = 0


select E.Nombre, E.ApellidoPat, E.ApellidoMat, P.Titulo_de_Puesto
from ((Empleado E inner join Puesto P on E.Puesto_ID = P.ID_Puesto)
inner join Departamento D on E.Departamento_ID = D.ID_Departamento)
where D.Nombre_Departamento = 'Compras'



select E.Nombre, E.ApellidoPat, E.ApellidoMat, R.Cantidad_Depositada
from ((Empleado E inner join Puesto P on E.Puesto_ID = P.ID_Puesto)
inner join ReciboDeNomina R on R.Empleado_ID = E.ID_Empleado)
where P.Titulo_de_Puesto = 'Ingeniero'

