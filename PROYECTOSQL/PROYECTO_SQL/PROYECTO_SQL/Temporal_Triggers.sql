CREATE TRIGGER Nuevo_Empleado_AutoConcepto
ON Empleado
AFTER INSERT
AS
BEGIN


Insert into EmpleadoConceptos(Empleado_ID, Concepto_ID, Fecha)
select	E.ID_Empleado, 1, GETDATE() from inserted E

--ISR
Insert into EmpleadoConceptos(Empleado_ID, Concepto_ID, Fecha)
select	E.ID_Empleado, 7, GETDATE() from inserted E
--IMSS
Insert into EmpleadoConceptos(Empleado_ID, Concepto_ID, Fecha)
select	E.ID_Empleado, 8, GETDATE() from inserted E


--values (0,0,GETDATE())

--select * from Concepto
--select * from EmpleadoConceptos


END
-------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER Eliminar_Concepto_de_Empleado
on Concepto
AFTER DELETE
AS
BEGIN

Delete EC from EmpleadoConceptos EC inner join deleted D on EC.Concepto_ID = D.ID_Concepto
WHERE EC.Concepto_ID = D.ID_Concepto

END
-------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER Eliminar_Empleado_De_Conceptos
on Empleado
AFTER DELETE
AS
BEGIN

Delete EC from EmpleadoConceptos EC inner join deleted D on EC.Empleado_ID = D.ID_Empleado
where EC.Empleado_ID = D.ID_Empleado

END
-------------------------------------------------------------------------------------------------------------------------------------
