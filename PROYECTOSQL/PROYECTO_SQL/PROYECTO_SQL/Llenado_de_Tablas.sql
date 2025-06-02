
truncate table Departamento
truncate table Direccion
truncate table Cuenta_De_Banco
truncate table Concepto

truncate table Empleado
truncate table EmpleadoConceptos
truncate table ReciboDeNomina 

--select * from ReciboDeNomina

begin transaction trac1

commit transaction trac1
rollback trac1

exec sp_NominaRequisito_Deducciones 4
exec sp_NominaRequisito_Percepciones 4

select * from EmpleadoConceptos


select * from Empleado
select * from Departamento

exec SP_IMPRIMIR_EMPLEADO
exec SP_IMPRIMIR_EMPLEADO_1 1
exec SP_IMPRIMIR_RECIBO



exec SP_LLENAR_EMPRESA 'BYTEFORCE', 'Oficinas Modelo S.A. de C.V.', 'Enrique Segoviano', '8241230807',
'00000001234', 'PAZO020109MLIOLKA8', '01/08/1999'



--truncate table Empleado
--select * from Empleado
exec SP_AGREGAR_EMPLEADO 'vdhnr18368', 'Omar', 'Garza', 'Zapata', '03/01/2003',
'GAZO030301HNLRPMA7', 'nss826nss82', 'GAZO030301RP10', 'OmGaZa03@outlook.com', '8241260908', 1, 1, 4,
1, 1

exec SP_AGREGAR_EMPLEADO 'awdtg17350', 'Gisele', 'Cardenas', 'De leon','01/08/2002',
'CALG020108MNLRNSA7', 'nss912nss91', 'CALG0201088F6', 'GiCaDe02@outlook.com', '8241112028', 2, 1, 2,
3, 2 

EXEC SP_AGREGAR_EMPLEADO 'vbnt81254', 'Arangua', 'Alma', 'Patricia', '02/09/2002',
'AALK050209MNLMPRA5', 'nss916nss91', 'AALK050209MI9', 'ArAAlPa5@outlook.com', '8243459094', 3, 1,
6, 5,
3


select * from Puesto
select * from Departamento
select * from Direccion


exec SP_AGREGAR_EMPLEADO 'vbnt81254', 'ARANGUA', 'ALMA', 'PATRICIA', '02/09/2002',
'AALK050209MNLMPRA5', 'nss916nss91', 'AALK050209MI9', 'ArAAlPa5@outlook.com', '8243459094', 6, 1, 6,
7, 5






exec SP_AGREGAR_EMPLEADO 'dgjku17252', 'Pedro', 'Gutierrez', 'De leon', '09/02/2001',
'GULP010902HNLTNDA5', 'nss156nss15', 'GULP010902H66', 'PeGuDe01@outlook.com', '8244719812', 3, 1, 1,
2, 3 

exec SP_AGREGAR_EMPLEADO 'bcfd21825', 'Martin', 'Perez', 'Villareal', '01/01/2005',
'PEVM050101HNLRLRA6', 'nss260nss26', 'PEVM0501015BA', 'MaPeVi05@outlook.com', '8249241383', 4, 1, 3,
1, 4 

exec SP_AGREGAR_EMPLEADO 'avfwt81254', 'Karla', 'Amaro', 'Lopez', '02/09/2005',
'AALK050209MNLMPRA5', 'nss916nss91', 'AALK050209MI9', 'KaAmLo05@outlook.com', '8241690947', 5, 1, 5,
5, 5 



--select * from Empleado

--exec SP_AGREGAR_RECIBO_ALT 6, 5, 2025

--exec SP_IMPRIMIR_EMPLEADO_1 6

--exec SP_IMPRIMIR_RECIBO_1_EMPLEADO 6




--select * from Departamento
--truncate table Departamento
--exec SP_AGREGAR_DEPARTAMENTO 'Produccion', 37; 
exec SP_AGREGAR_DEPARTAMENTO 'Compras', 850; 
exec SP_AGREGAR_DEPARTAMENTO 'Ventas', 950; 
exec SP_AGREGAR_DEPARTAMENTO 'Compras', 850; 
exec SP_AGREGAR_DEPARTAMENTO 'Finanzas', 1250; 
exec SP_AGREGAR_DEPARTAMENTO 'Almacen', 900; 


--select * from Puesto
--truncate table Puesto
exec SP_AGREGAR_PUESTO 'Gerente', 1.1;
exec SP_AGREGAR_PUESTO 'Subgerente', 0.95;
exec SP_AGREGAR_PUESTO 'Director', 1.5;
exec SP_AGREGAR_PUESTO 'Analista', 0.9;
exec SP_AGREGAR_PUESTO 'Asociado', 0.8;
exec SP_AGREGAR_PUESTO 'Consultor', 1.05;


--select * from Direccion
--truncate table Direccion
Exec SP_AGREGAR_DIRECCION 'Zapata',512,'Cuactemoc','Monterrey','Nuevo leon','2205';
Exec SP_AGREGAR_DIRECCION 'Edgar almiran',515,'Cuactemoc','Monterrey','Nuevo leon','2205';
Exec SP_AGREGAR_DIRECCION 'General',135,'Limoneros','Sabinas Hidalgo','Nuevo leon','1923';
Exec SP_AGREGAR_DIRECCION 'General',271,'Pascuales','Saltillo','Nuevo leon','9012';
Exec SP_AGREGAR_DIRECCION 'Maderos',412,'Hospitalaria','Bustamante','Nuevo leon','5436';
Exec SP_AGREGAR_DIRECCION 'Piedras Negras',123,'Iglesias','Villaldama','Nuevo leon','5436';
Exec SP_AGREGAR_DIRECCION 'Piedras Negras',125,'Iglesias','Villaldama','Nuevo leon','5442';


--select * from Cuenta_De_Banco
--truncate table Cuenta_De_Banco
exec SP_LLENAR_BANCO 'Azteca', '3582513951472691489';
exec SP_LLENAR_BANCO 'Azteca', '2812149062585248579';
exec SP_LLENAR_BANCO 'Guajardo', '9209475024067309572';
exec SP_LLENAR_BANCO 'Benavides', '7693759472951645427';
exec SP_LLENAR_BANCO 'Azteca', '1037569375932058302';
exec SP_LLENAR_BANCO 'Azteca', '2748572958693820586';
exec SP_LLENAR_BANCO 'Azteca', '2356897315858371525';

--select * from Concepto
--truncate table Concepto
exec SP_AGREGAR_CONCEPTO 'Sueldo Diario' ,		1, 1, 1, 0,   0
exec SP_AGREGAR_CONCEPTO 'Llegada Tardia',		0, 0, 0, 20,  0
exec SP_AGREGAR_CONCEPTO 'Bono',				1, 0, 0, 200, 0
exec SP_AGREGAR_CONCEPTO 'Extra Mensual',		1, 0, 1, 50,  0
exec SP_AGREGAR_CONCEPTO 'Horas Extra',			1, 0, 0, 0,   0
exec SP_AGREGAR_CONCEPTO 'Dia Incapacitado',	1, 0, 1, 0,   0
exec SP_AGREGAR_CONCEPTO 'ISR',					0, 1, 0, 19,  1
exec SP_AGREGAR_CONCEPTO 'IMSS',				0, 1, 0, 783, 0



--delete from Concepto where Nombre_Concepto = 'Hora Extra'

--select * from EmpleadoConceptos
--truncate table EmpleadoConceptos

--exec SP_TEST_AsignarConceptos 1,1, '03/01/2020'
--exec SP_TEST_AsignarConceptos 1,2, '03/01/2020'
--exec SP_TEST_AsignarConceptos 1,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,5, '03/01/2020'
exec SP_TEST_AsignarConceptos 1,8, '03/01/2020'

--exec SP_TEST_AsignarConceptos 2,1, '03/01/2020'
--exec SP_TEST_AsignarConceptos 2,2, '03/01/2020'
--exec SP_TEST_AsignarConceptos 2,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,5, '03/01/2020'
exec SP_TEST_AsignarConceptos 2,8, '03/01/2020'

--exec SP_TEST_AsignarConceptos 3,1, '03/01/2020'
--exec SP_TEST_AsignarConceptos 3,2, '03/01/2020'
--exec SP_TEST_AsignarConceptos 3,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,5, '03/01/2020'
exec SP_TEST_AsignarConceptos 3,8, '03/01/2020'

--exec SP_TEST_AsignarConceptos 4,1, '03/01/2020'
--exec SP_TEST_AsignarConceptos 4,2, '03/01/2020'
--exec SP_TEST_AsignarConceptos 4,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,5, '03/01/2020'
exec SP_TEST_AsignarConceptos 4,8, '03/01/2020'

--exec SP_TEST_AsignarConceptos 5,1, '03/01/2020'
--exec SP_TEST_AsignarConceptos 5,2, '03/01/2020'
--exec SP_TEST_AsignarConceptos 5,3, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,4, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,5, '03/01/2020'
exec SP_TEST_AsignarConceptos 5,8, '03/01/2020'

--exec SP_TEST_AsignarConceptos 6,1, '03/01/2020'
exec SP_TEST_AsignarConceptos 6,10, '03/01/2020'
exec SP_TEST_AsignarConceptos 6,11, '03/01/2020'