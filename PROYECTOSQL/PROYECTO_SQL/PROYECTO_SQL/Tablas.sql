--sp_help Empleados;

--create database ReciboDeNomina
--use ReciboDeNomina
--drop database ReciboDeNomina




--Empresa


exec DB_CREAR_TABLAS;

drop procedure DB_CREAR_TABLAS;




CREATE PROCEDURE DB_CREAR_TABLAS
AS

--Empresa
create table Empresa
(
ID_Empresa					int IDENTITY(1, 1) primary key,
Nombre						varchar(10) not null,
Razon_Social				varchar(50) not null,
Domicilio_Fiscal			varchar(50) not null,
Datos_Contacto				varchar(10) not null,
Registro_patronal			varchar(11) not null,
RFC							varchar(13) not null,
Fecha_inicio_operaciones	date  not null
);


--Puesto
create table Puesto
(
ID_Puesto			int IDENTITY(1, 1) primary key not null,
Titulo_de_Puesto	varchar(30) not null,
Proporcion			float not null
);




--Direccion
create table Direccion
(
ID_Direccion    int IDENTITY(1, 1) primary key,
Calle			varchar(20) not null,
Numero			int not null,
Colonia			varchar(20) not null,
Municipio		varchar(20) not null,
Estado			varchar(20) not null,
Codigo_Postal	varchar(20) not null
);


--Concepto de Nomina
create table Concepto
(
ID_Concepto			int IDENTITY(1, 1) primary key,
Nombre_Concepto		varchar(30) not null,
Tipo				bit not null, --(0 Deducción, 1 Percepción)
Obligatoria			bit not null, --(0 Si, 1 No)
Mensual				bit not null, --(0 Si, 1 No)
Valor				MONEY
);



--Banco
create table Cuenta_De_Banco(
ID_Banco		int IDENTITY(1, 1) primary key,
Banco			varchar(20) not null,
NumeroCuenta	varchar(20) not null,
);


--Departamento
create table Departamento
(
ID_Departamento			int IDENTITY(1, 1) primary key ,
Nombre_Departamento		varchar(20) not null,
SueldoBase_Diario		money not null,
Empresa_ID				int not null,

constraint Dep_EmpresaFK
FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID_Empresa)
);


--Empleado
create table Empleado
(
ID_Empleado 		int IDENTITY(1, 1) primary key,
Contraseña			varchar(20) not null,
Nombre				varchar(30) not null,
ApellidoPat			varchar(30) not null,
ApellidoMat			varchar(30) not null,
FechaNacimiento		date not null,
CURP				varchar(18) not null,
NSS					varchar(11) not null,
RFC					varchar(13) not null,
Email				varchar(30) not null,
Teléfonos			varchar(10) not null,
FechaIngreso		date not null,

Cuenta_BancoID		int not null,
Empresa_ID			int not null,
Puesto_ID			int not null,
Departamento_ID		int not null,
Direccion_ID		int not null,

constraint Emp_EmpresaFK
FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID_Empresa),

constraint Emp_PuestoFK
FOREIGN KEY (Puesto_ID) REFERENCES Puesto(ID_Puesto),

constraint Emp_DepartamentoFK
FOREIGN KEY (Departamento_ID) REFERENCES Departamento(ID_Departamento),

constraint Emp_DireccionFK
FOREIGN KEY (Direccion_ID) REFERENCES Direccion(ID_Direccion),

constraint Emp_BancoFK
FOREIGN KEY (Cuenta_BancoID) REFERENCES Cuenta_De_Banco(ID_Banco)
);










--ConceptosEmpleado
create table EmpleadoConceptos
(
ID_EmpleadoConceptos	int IDENTITY(1, 1) primary key,
Empleado_ID				int not null,
Concepto_ID				int not null,
Fecha					date not null

constraint EmpCon_EmpleadoFK
FOREIGN KEY (Empleado_ID) REFERENCES Empleado(ID_Empleado),

constraint EmpCon_ConceptosFK
FOREIGN KEY (Concepto_ID) REFERENCES Concepto(ID_Concepto)
);


--Recibo
create table ReciboDeNomina(
ID_Recibo				int IDENTITY(1, 1) primary key,
Fecha_Recibo			date not null,
Cantidad_Bruta			money not null,
Cantidad_Depositada		money not null,
GUID					varchar(30) not null,

Empresa_ID				int not null,
Empleado_ID				int not null,
Banco_ID				int not null 


constraint Rec_EmpresaFK
FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID_Empresa),

constraint Rec_EmpleadoFK
FOREIGN KEY (Empleado_ID) REFERENCES Empleado(ID_Empleado),

constraint Rec_BancoFK
FOREIGN KEY (Banco_ID) REFERENCES Cuenta_De_Banco(ID_Banco)
);




GO






exec DB_BORRAR_TABLAS;

drop procedure DB_BORRAR_TABLAS;

CREATE PROCEDURE DB_BORRAR_TABLAS
AS

alter table Departamento
drop constraint Departamento_EmpresaFK;

alter table Empleado
drop constraint Empleados_EmpresaFK;

alter table Empleado
drop constraint Empleados_PuestoFK;

alter table Empleado
drop constraint Empleados_DepartamentoFK;

alter table Empleado
drop constraint Empleados_DireccionFK;

alter table EmpleadoConceptos
drop constraint ConceptosEmpleado_ReciboFK;

alter table EmpleadoConceptos
drop constraint ConceptosEmpleado_ConceptosFK;


alter table ReciboDeNomina
drop constraint Recibo_EmpresaFK;

alter table ReciboDeNomina
drop constraint Recibo_EmpleadosFK;

alter table ReciboDeNomina
drop constraint Recibo_BancosFK;




drop table Empresa;
drop table Puesto;
drop table Departamento;
drop table Direccion;
drop table Empleado;
drop table ConceptosDeNomina;
drop table Banco;
drop table ReciboDeNomina;
drop table EmpleadoConceptos;

GO


sp_help Concepto







