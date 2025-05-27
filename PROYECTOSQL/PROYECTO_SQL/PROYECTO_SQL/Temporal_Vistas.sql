SELECT * FROM [LISTA DE EMPLEADOS]

SELECT * FROM [LISTA DE DEDUCCIONES]

SELECT * FROM [LISTA DE PERCEPCIONES]

SELECT * FROM [DIRECCIONES DE LOS EMPLEADOS]

SELECT * FROM [PERSONAL POR DEPARTAMENTO]

SELECT * FROM [PERSONAL POR PUESTO]




------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [LISTA DE EMPLEADOS]
AS
SELECT
concat(E.Nombre, ' ', E.ApellidoPat, ' ', E.ApellidoMat) AS [EMPLEADO],
D.Nombre_Departamento AS [DEPARTAMENTO],
P.Titulo_de_Puesto AS [PUESTO]

FROM Empleado E inner join Puesto P on E.Puesto_ID = P.ID_Puesto
inner join Departamento D on E.Departamento_ID = D.ID_Departamento
------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [LISTA DE DEDUCCIONES]
AS
SELECT
C.Nombre_Concepto AS [DEDUCCION],
C.Valor AS [VALOR]
FROM Concepto C
WHERE C.Tipo = 0
------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [LISTA DE PERCEPCIONES]
AS
SELECT
C.Nombre_Concepto AS [DEDUCCION],
C.Valor AS [VALOR]
FROM Concepto C
WHERE C.Tipo = 1
------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [DIRECCIONES DE LOS EMPLEADOS]
AS
SELECT
concat(E.Nombre, ' ', E.ApellidoPat, ' ', E.ApellidoMat) AS [EMPLEADO],
concat(D.Estado, ', ', D.Municipio, ', ', D.Colonia, ', ', D.Calle, ' ',D.Numero) AS DIRECCION
FROM Empleado E inner join Direccion D on E.Direccion_ID = D.ID_Direccion
------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [PERSONAL POR DEPARTAMENTO]
AS
SELECT
D.Nombre_Departamento AS [DEPARTAMENTO],
COUNT(E.Departamento_ID) AS [CANTIDAD DE EMPLEADOS]
FROM Departamento D inner join Empleado E on E.Departamento_ID = D.ID_Departamento
GROUP BY D.Nombre_Departamento
------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW [PERSONAL POR PUESTO]
AS
SELECT
P.Titulo_de_Puesto AS [PUESTO],
COUNT(E.Puesto_ID) AS [CANTIDAD DE EMPLEADOS]
FROM Puesto P inner join Empleado E on E.Puesto_ID = P.ID_Puesto
GROUP BY P.Titulo_de_Puesto