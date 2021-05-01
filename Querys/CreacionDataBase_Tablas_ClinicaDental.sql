--Creacion de base de datos
create database ClinicaDental

GO--Se usa para poder ejecutar todo de un jalon XD sin necesidad de ejecutar parte por parte.
--Usar Base de datos
use ClinicaDental
GO
--Creacion de tablas menores(sin dependencias)
create table Cliente
(
	IdCliente int not null,
	Nombre varchar(40) not null,
	RFC varchar(12) not null,
	DomFiscal varchar(40) not null,
	Colonia varchar(40) not null,
	CodPostal varchar(5) not null,
	Ciudad varchar(40)not null,
	Telefono varchar(10)not null,
	Email varchar(40),
	Primary Key (IdCliente)
)

create table Proveedores
(
	IdProveedor int not null,
	Nombre varchar(40) not null,
	Telefono varchar(10) not null,
	Celular varchar(10) not null,
	Domicilio varchar(40) not null,
	Colonia Varchar(40) not null,
	Ciudad varchar(40) not null,
	ConPostal varchar(5) not null,
	Email varchar(20),
	Primary key (IdProveedor)
)

create table Categoria
(
	IdCategoria int not null,
	Concepto varchar(20) not null,
	Primary key (IdCategoria)
)


--Creación de tablas mayores
create table Pacientes
(
	IdPaciente int not null,
	IdCliente int not null,
	Nombre varchar(40) not null,
	Genero varchar(9) not null,
	FecNacimiento Date not null,
	Telefono varchar(10) not null,
	Celular varchar(10) not null,
	Domicilio varchar(40) not null,
	Colonia Varchar(40) not null,
	ConPostal varchar(5) not null,
	Ciudad varchar(40) not null,
	SaldoTotal money not null,
	Alergias varchar(60),
	Padecimientos varchar(60) not null,

	Primary key (IdPaciente),
	Foreign key (IdCliente) references Cliente(IdCliente)
)

create table Ventas
(
	IdVenta int not null,
	IdPaciente int not null,
	Fecha date not null,
	Subtotal money not null,
	IVA money not null,
	Total money not null

	Primary key (IdVenta),
	foreign key (IdPaciente) references Pacientes(IdPaciente)
)

create table Compras
(
	IdCompra int not null,
	IdProveedor int not null,
	IdFactura int not null,
	Fecha date not null,
	Subtotal money not null,
	IVA money not null,
	Total money not null,

	Primary key (IdCompra),
	foreign key (IdProveedor) references Proveedores(IdProveedor)
)

create table Productos
(
	IdProducto varchar(10) not null,
	IdCategoria int not null,
	Unidad varchar(10) not null,
	Nombre varchar(40)not null,
	Descripcion varchar(150) not null,
	Precio money not null,
	Costo money not null,
	Existencia float not null,
	CantMinima  float not null,
	CantMaxima float not null,

	Primary key (IdProducto),
	Foreign key (IdCategoria) references Categoria(IdCategoria)
)

create table DetalleCompra
(
	IdCompra int not null,
	IdProducto varchar(10) not null,
	Cantidad Float not null,
	Costo Money not null,

	primary key (IdCompra, IdProducto),
	foreign key (IdCompra) references Compras(IdCompra),
	foreign key (IdProducto) references Productos(IdProducto)
)

create table Citas
(
	IdCita int not null,
	IdPaciente int not null,
	Fecha Date not null,
	Hora varchar not null,
	Estado varchar(20) not null,

	primary key (IdCita),
	foreign key (IdPaciente) references Pacientes(IdPaciente)
)

create table Adeudos
(
	IdAdeudo int not null,
	IdCita int not null,
	Concepto varchar(100) not null,
	Importe money not null,
	SaldoAdeudo money not null,

	primary key (IdAdeudo),
	foreign key (IdCita) references Citas(IdCita)
)

create table Expediente
(
	IdExpediente int not null,
	IdCita int not null,
	Descripcion varchar(300) not null,
	Tratamiento varchar(300) not null,

	primary key (IdExpediente),
	foreign key (IdCita) references Citas(IdCita)
)


create table DetalmagExp
(
	IdExpediente int not null,
	NumImagen int not null,
	Imagen varchar(20) not null,

	Primary key (IdExpediente, NumImagen),
	foreign key (IdExpediente) references Expediente(IdExpediente)
)

create table Cobros 
(
	IdCobro int not null,
	IdAdeudo int not null,
	Fecha date not null,
	Importe date not null,
	TipoCobro varchar(30) not null,

	primary key (IdCobro),
	foreign key (IdAdeudo) references Adeudos(IdAdeudo)
)

create table Receta
(
	IdReceta int not null,
	IdExpediente int not null,

	primary key (IdReceta),
	foreign key (IdExpediente) references Expediente(IdExpediente)
)

create table DetalleReceta
(
	IdReceta int not null,
	NumMedi int not null,
	Medicamento varchar(40) not null,
	Cantidad Float not null,
	Indicaciones varchar(30) not null,

	primary key (IdReceta,NumMedi),
	foreign key (IdReceta) references Receta(IdReceta)
)

create table Facturas
(
	IdFactura int not null,
	IdCobro int not null,
	TipoPago varchar(30) not null,
	Fecha date not null,
	Concepto varchar(40) not null,
	Subtotal money not null,
	Iva money not null,
	Total money not null,

	primary key (IdFactura),
	foreign key (IdCobro) references Cobros(IdCobro)
)

create table DetalleVenta
(
	IdVenta int not null,
	IdProducto varchar(10) not null,
	Cantidad Float not null,
	Precio money not null,

	primary key (IdVenta, IdProducto),
	foreign key (IdVenta) references Ventas(IdVenta),
	foreign key (IdProducto) references Productos(IdProducto)
)