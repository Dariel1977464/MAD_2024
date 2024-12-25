--sp_help Empleados;

--create database ReciboDeNomina
--use ReciboDeNomina
--drop database ReciboDeNomina

Begin

--Empresas
Begin
create table Temp_Empresa
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
create table Temp_Puesto
(
PK_Puesto			int IDENTITY(1, 1) primary key,
Nombre_de_Puesto	varchar(30) ,
Proporcion			float ,
);
End

--Direccion
Begin
create table Temp_Direccion
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
create table Temp_ConceptosDeNomina
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
create table Temp_Banco(
PK_Banco		int IDENTITY(1, 1) primary key ,
Banco			varchar(20) ,
NumeroCuenta	varchar(20) ,

);
End

--Departamento
Begin
create table Temp_Departamento
(
PK_Departamento			int IDENTITY(1, 1) primary key ,
Nombre_Departamento		varchar(20),
SueldoBase_Diario		money,
Empresa_FK				int,

--constraint Departamento_EmpresaFK
--FOREIGN KEY (Empresa_FK) REFERENCES Empresa(PK_Empresa)
);
End

--Empleados
Begin
create table Temp_Empleado
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

--constraint Empleados_EmpresaFK
--FOREIGN KEY (Empresa_FK) REFERENCES Empresa(PK_Empresa),
--
--constraint Empleados_PuestoFK
--FOREIGN KEY (PuestoFK) REFERENCES Puesto(PK_Puesto),
--
--constraint Empleados_DepartamentoFK
--FOREIGN KEY (DepartamentoFK) REFERENCES Departamento(PK_Departamento),
--
--constraint Empleados_DireccionFK
--FOREIGN KEY (DireccionFK) REFERENCES Direccion(PK_Direccion),


);
End

--ConceptosEmpleado
Begin
create table Temp_ConceptosEmpleado
(
PK_ReciboConceptos	int IDENTITY(1, 1) primary key ,
EmpleadoFK			int ,
ConceptosFK			int ,

--constraint ConceptosEmpleado_ReciboFK
--FOREIGN KEY (EmpleadoFK) REFERENCES Temp_Empleado(NumeroEmpleado),
--constraint ConceptosEmpleado_ConceptosFK
--FOREIGN KEY (ConceptosFK) REFERENCES Temp_ConceptosDeNomina(PK_Concepto)

);
End

--Recibo
Begin
create table Temp_ReciboDeNomina(
PK_Recibo				int IDENTITY(1, 1) primary key ,
Fecha_Recibo			date ,
Cantidad_Depositada		money ,

Empresa_FK				int ,
Empleados_FK			int ,
Bancos_FK				int ,
GUID					varchar(30) 


--constraint Recibo_EmpresaFK
--FOREIGN KEY (Empresa_FK) REFERENCES Temp_Empresa(PK_Empresa),
--constraint Recibo_EmpleadosFK
--FOREIGN KEY (Empleados_FK) REFERENCES Temp_Empleado(NumeroEmpleado),
--constraint Recibo_BancosFK
--FOREIGN KEY (Bancos_FK) REFERENCES Temp_Banco(PK_Banco)
);
End



drop table Temp_Empresa;
drop table Temp_Puesto;
drop table Temp_Departamento;
drop table Temp_Direccion;
drop table Temp_Empleado;
drop table Temp_ConceptosDeNomina;
drop table Temp_Banco;
drop table Temp_ReciboDeNomina;
drop table Temp_ConceptosEmpleado;




End



