create database ChainStore;
go
use ChainStore
go

--Brand--
create table Brand(
	Brand_Id nvarchar(50) primary key,
	Name nvarchar(150) not null,
	CreatedDate datetime not null,
	UpdatedDate datetime null
)

--Category--
create table Category(
		Category_Id nvarchar(50) primary key,
		Name nvarchar(250) not null,
		CreatedDate datetime not null,
		UpdatedDate datetime null
)

--Product--
create table Product(
	Product_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	Name nvarchar(250) not null,
	Description nvarchar(250) null,
	Size nvarchar(50) null,
	Color nvarchar(50) null,
	Brand_Id nvarchar(50) null,
	Category_Id nvarchar(50) null,
	StandardPrice numeric(18,2) not null,
	Price numeric(18,2) not null,
	CreatedDate datetime not null,
	UpdatedDate datetime null,
	Foreign key(Brand_Id) references Brand(Brand_Id),
	Foreign key(Category_Id) references Category(Category_Id)
)

--City--
create table City(
	City_Id nvarchar(50) primary key,
	Name nvarchar(100) not null,
	CreatedDate datetime not null,
	UpdatedDate datetime null
)

--Store--
create table Store(
	Store_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	Name nvarchar(250) not null,
	City_Id nvarchar(50) not null,
	CreatedDate datetime not null,
	UpdatedDate datetime null,
	Foreign key(City_Id) references City(City_Id)
)

--Employee--
create table Employee(
	Employee_Id nvarchar(50) primary key,
	Name nvarchar(50) not null,
	DOB date not null,
	HireDate date null,
	Store_Id nvarchar(50) null,
	IdentityNumber nvarchar(50) null,
	Address nvarchar(250) null,
	CreatedDate datetime not null,
	UpdatedDate datetime null,
	Foreign key(Store_Id) references Store(Store_Id)
)

--Customer--
create table Customer(
	Customer_Id nvarchar(50) primary key,
	Name nvarchar(50) null,
	Phone nvarchar(15) null,
	Address nvarchar(250) null,
	CreatedDate datetime not null,
	UpdatedDate datetime null
)

--Source Online--
create table Source_Online(
		Source_Online_Id nvarchar(50) primary key,
		Name nvarchar(50) not null,
		CreatedDate datetime not null,
		UpdatedDate datetime null
)


--Order Header--
create table Order_Header(
	Order_Header_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	Orderdate date not null,
	Total decimal(18,2) not null,
	StandardCost decimal(18, 2) not null,
	Status int not null,
	IsOnline bit not null,
	Source_Online_Id nvarchar(50) null,
	Customer_Id nvarchar(50) not null,
	Store_Id nvarchar(50) not null,
	Employee_Id nvarchar(50) not null,
	CreatedDate datetime not null,
	UpdatedDate datetime null,
	Foreign key(Customer_Id) references Customer(Customer_Id),
	Foreign key(Source_Online_Id) references Source_Online(Source_Online_Id),
	Foreign key(Store_Id) references Store(Store_Id)
)

--Order Detail--
create table Order_Detail(
	Order_Detail_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	Product_Id nvarchar(50) not null,
	Qty numeric(18,2) not null,
	Price numeric(18,2) not null,
	Total numeric(18, 2) not null,
	Order_Header_Id nvarchar(50) not null,
	CreatedDate datetime not null,
	UpdatedDate datetime null,
	Foreign key(Product_Id) references Product(Product_Id),
	Foreign key(Order_Header_Id) references Order_Header(Order_Header_Id)
)