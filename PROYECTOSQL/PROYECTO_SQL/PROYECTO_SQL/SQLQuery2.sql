select * from Concepto

select C.ID_Concepto, C.Nombre_Concepto, E.Nombre,
(case when C.Nombre_Concepto = 'Sueldo Diario' AND D.ID_Departamento = E.Departamento_ID then D.SueldoBase_Diario else 0 END) AS [IMP GRABADO],
(case when C.Nombre_Concepto != 'Sueldo Diario' then C.Valor else 0 END) AS [IMP EXT]
from Concepto C
inner join EmpleadoConceptos EC on C.ID_Concepto = EC.Concepto_ID
inner join Empleado E on E.ID_Empleado = EC.Empleado_ID
inner join Departamento D on E.Departamento_ID = D.Empresa_ID
where EC.Empleado_ID = 1



select E.Nombre, C.Nombre_Concepto from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
where E.ID_Empleado = 1
order by E.Nombre

select E.Nombre, C.Nombre_Concepto, C.Valor from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
where E.ID_Empleado = 1
order by E.Nombre

select E.Nombre, C.Nombre_Concepto,
(case when C.Nombre_Concepto = 'Sueldo Diario' then 1 else 0 end) AS [IMP GRABADO],
C.Valor AS [IMP EXT]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
where E.ID_Empleado = 1
order by E.Nombre


select E.Nombre, C.Nombre_Concepto,
(case when C.Nombre_Concepto = 'Sueldo Diario' then 1 else 0 end) AS [IMP GRABADO],
C.Valor AS [IMP EXT]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where E.ID_Empleado = 1
order by E.Nombre

select E.Nombre, C.Nombre_Concepto,
(case when C.Nombre_Concepto = 'Sueldo Diario' then D.SueldoBase_Diario else 0 end) AS [IMP GRABADO],
C.Valor AS [IMP EXT]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where E.ID_Empleado = 1 AND C.Tipo = 1
order by E.Nombre

select E.Nombre, C.Nombre_Concepto,
(case when C.Nombre_Concepto = 'Sueldo Diario' then D.SueldoBase_Diario else 0 end) AS [IMP GRABADO],
C.Valor AS [IMP EXT]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where C.Tipo = 1
order by E.Nombre

select E.Nombre, C.Nombre_Concepto,
(case when C.Nombre_Concepto = 'Sueldo Diario' then D.SueldoBase_Diario else 0 end) AS [IMP GRABADO],
C.Valor AS [IMP EXT]
from Empleado E
inner join EmpleadoConceptos EC on E.ID_Empleado = EC.Empleado_ID
inner join Concepto C on C.ID_Concepto = EC.Concepto_ID
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
where C.Tipo = 0
order by E.Nombre

---------------------------------------------------------------------------------------------------------------------------------------
select * from Empresa




