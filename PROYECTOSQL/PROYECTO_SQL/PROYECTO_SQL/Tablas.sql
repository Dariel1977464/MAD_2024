--sp_help Empleados;

--create database ReciboDeNomina
--use ReciboDeNomina
--drop database ReciboDeNomina

Begin

--Empresas
Begin
create table Empresa
(
PK_Empresa					int IDENTITY(1, 1) primary key,
Razón_Social				varchar(50),
Domicilio_Fiscal			varchar(50),
DatosContacto				varchar(10),
Registro_patronal			varchar(11),
RFC							varchar(13),
Fecha_inicio_operaciones	date

);
End

--Puestos
Begin
create table Puesto
(
PK_Puesto			int IDENTITY(1, 1) primary key,
Nombre_de_Puesto	varchar(30) ,
Proporcion			float ,
);
End

--Direccion
Begin
create table Direccion
(
PK_Direccion    int IDENTITY(1, 1) primary key ,
Calle			varchar(20) ,
Numero			int ,
Colonia			varchar(20) ,
Municipio		varchar(20) ,
Estado			varchar(20) ,
Codigo_Postal	varchar(20) ,

);
End

--Conceptos de Nomina
Begin
create table ConceptosDeNomina
(
PK_Concepto			int IDENTITY(1, 1) primary key ,
Nombre_Concepto		varchar(30) ,
Tipo				int , --(Deducción, Percepción)
Obligatoria			bit ,
Mensual				bit 


);
End

--Banco
Begin
create table Banco(
PK_Banco		int IDENTITY(1, 1) primary key ,
Banco			varchar(20) ,
NumeroCuenta	varchar(20) ,

);
End

--Departamento
Begin
create table Departamento
(
PK_Departamento			int IDENTITY(1, 1) primary key ,
Nombre_Departamento		varchar(20),
SueldoBase_Diario		money,
Empresa_FK				int,

constraint Departamento_EmpresaFK
FOREIGN KEY (Empresa_FK) REFERENCES Empresa(PK_Empresa)
);
End

--Empleados
Begin
create table Empleado
(
NumeroEmpleado	int IDENTITY(1, 1) primary key ,
Contraseña		varchar(20) ,
Nombre			varchar(30) ,
ApellidoPat		varchar(30) ,
ApellidoMat		varchar(30) ,
FechaNacimiento date,
CURP			varchar(18) ,
NSS				varchar(11) ,
RFC				varchar(13) ,
Banco			int ,
NumeroCuenta	int ,
Email			varchar(30) ,
Teléfonos		varchar(10) ,

Empresa_FK		int,
PuestoFK		int,
DepartamentoFK	int,
DireccionFK		int,

constraint Empleados_EmpresaFK
FOREIGN KEY (Empresa_FK) REFERENCES Empresa(PK_Empresa),

constraint Empleados_PuestoFK
FOREIGN KEY (PuestoFK) REFERENCES Puesto(PK_Puesto),

constraint Empleados_DepartamentoFK
FOREIGN KEY (DepartamentoFK) REFERENCES Departamento(PK_Departamento),

constraint Empleados_DireccionFK
FOREIGN KEY (DireccionFK) REFERENCES Direccion(PK_Direccion),


);
End

--ConceptosEmpleado
Begin
create table ConceptosEmpleado
(
PK_ReciboConceptos	int IDENTITY(1, 1) primary key ,
EmpleadoFK			int ,
ConceptosFK			int ,

constraint ConceptosEmpleado_ReciboFK
FOREIGN KEY (EmpleadoFK) REFERENCES Empleado(NumeroEmpleado),
constraint ConceptosEmpleado_ConceptosFK
FOREIGN KEY (ConceptosFK) REFERENCES ConceptosDeNomina(PK_Concepto)

);
End

--Recibo
Begin
create table ReciboDeNomina(
PK_Recibo				int IDENTITY(1, 1) primary key ,
Fecha_Recibo			date ,
Cantidad_Depositada		money ,

Empresa_FK				int ,
Empleados_FK			int ,
Bancos_FK				int ,
GUID					varchar(30) 


constraint Recibo_EmpresaFK
FOREIGN KEY (Empresa_FK) REFERENCES Empresa(PK_Empresa),
constraint Recibo_EmpleadosFK
FOREIGN KEY (Empleados_FK) REFERENCES Empleado(NumeroEmpleado),
constraint Recibo_BancosFK
FOREIGN KEY (Bancos_FK) REFERENCES Banco(PK_Banco)
);
End



drop table Empresa;
drop table Puesto;
drop table Departamento;
drop table Direccion;
drop table Empleado;
drop table ConceptosDeNomina;
drop table Banco;
drop table ReciboDeNomina;
drop table ConceptosEmpleado;




End



