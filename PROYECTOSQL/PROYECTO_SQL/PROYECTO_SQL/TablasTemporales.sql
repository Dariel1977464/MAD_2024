create table Empresa
(
ID_Empresa					int IDENTITY(1, 1) primary key,
Razon_Social				varchar(50),
Domicilio_Fiscal			varchar(50),
Datos_Contacto				varchar(10),
Registro_patronal			varchar(11),
RFC							varchar(13),
Fecha_inicio_operaciones	date
);

create table Puesto
(
ID_Puesto			int IDENTITY(1, 1) primary key,
Titulo_de_Puesto	varchar(30),
Proporcion			float,
);
create table Direccion
(
ID_Direccion    int IDENTITY(1, 1) primary key,
Calle			varchar(20),
Numero			int,
Colonia			varchar(20),
Municipio		varchar(20),
Estado			varchar(20),
Codigo_Postal	varchar(20),
);



create table Concepto
(
ID_Concepto			int IDENTITY(1, 1) primary key,
Nombre_Concepto		varchar(30),
Tipo				bit, --(Deducción, Percepción)
Obligatoria			bit,
Mensual				bit
);
create table Cuenta_De_Banco(
ID_Banco		int IDENTITY(1, 1) primary key,
Banco			varchar(20),
NumeroCuenta	varchar(20),
);
create table Departamento
(
ID_Departamento			int IDENTITY(1, 1) primary key ,
Nombre_Departamento		varchar(20),
SueldoBase_Diario		money,
Empresa_ID				int,

constraint Dep_EmpresaFK
FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID_Empresa)
);



create table Empleado
(
ID_Empleado 		int IDENTITY(1, 1) primary key,
Contraseña			varchar(20),
Nombre				varchar(30),
ApellidoPat			varchar(30),
ApellidoMat			varchar(30),
FechaNacimiento		date,
CURP				varchar(18),
NSS					varchar(11),
RFC					varchar(13),
Email				varchar(30),
Teléfonos			varchar(10),
Cuenta_BancoID		int,
Empresa_ID			int,
Puesto_ID			int,
Departamento_ID		int,
Direccion_ID		int,
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
Empleado_ID				int,
Concepto_ID				int,

constraint EmpCon_EmpleadoFK
FOREIGN KEY (Empleado_ID) REFERENCES Empleado(ID_Empleado),

constraint EmpCon_ConceptosFK
FOREIGN KEY (Concepto_ID) REFERENCES Concepto(ID_Concepto)
);


--Recibo
create table ReciboDeNomina(
ID_Recibo				int IDENTITY(1, 1) primary key,
Fecha_Recibo			date,
Cantidad_Depositada		money,

Empresa_ID				int,
Empleado_ID			int,
Banco_ID				int,
GUID					varchar(30) 


constraint Rec_EmpresaFK
FOREIGN KEY (Empresa_ID) REFERENCES Empresa(ID_Empresa),

constraint Rec_EmpleadoFK
FOREIGN KEY (Empleado_ID) REFERENCES Empleado(ID_Empleado),

constraint Rec_BancoFK
FOREIGN KEY (Banco_ID) REFERENCES Banco(ID_Banco)
);



