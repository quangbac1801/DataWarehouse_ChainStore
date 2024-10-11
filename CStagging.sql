Create database Stagging_ChainStore
go
use Stagging_ChainStore
go

create table Brand(
	Brand_Id nvarchar(50) primary key,
	Name nvarchar(50) not null,
) 

create table Category(
	Category_Id nvarchar(50) primary key,
	Name nvarchar(250) not null,
)

create table City(
	City_Id nvarchar(50) primary key,
	Name nvarchar(250) not null,
)

create table Customer(
	Customer_Id nvarchar(50) primary key,
	Name nvarchar(250) not null,
	Phone nvarchar(50) null,
)

create table Employee(
	Employee_Id nvarchar(50) primary key,
	Code nvarchar(10) not null,
	Name nvarchar(250) not null,
	DOB date null,
	HireDate date null,
	IdentityNumber nvarchar(50) NULL,
	Store_Id nvarchar(50) null,
)

create table Product(
	Product_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	Name nvarchar(255) not null,
	Description nvarchar(500) null,
	Size nvarchar(50) null,
	Color nvarchar(50) null,
	Brand_Id nvarchar(50) null,
	Category_Id nvarchar(50) null,
	StandardPrice numeric(18, 2) not null,
	Price numeric(18, 2) not null,
)

create table Source_Online(
	Source_Online_Id nvarchar(50) primary key,
	Name nvarchar(250) not null,
)

create table Store(
	Store_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	Name nvarchar(250) not null,
	City_Id nvarchar(50) not null,
)

create table Order_Header(
	Order_Header_Id nvarchar(50) primary key,
	Code nvarchar(50) not null,
	OrderDate date not null,
	Total decimal(18, 2) not null,
	StandardCost decimal(18, 2) not null,
	Status int not null,
	IsOnline bit not null,
	Source_Online_Id nvarchar(50) null,
	Customer_Id nvarchar(50) null,
	Employee_Id nvarchar(50) null,
	Store_Id nvarchar(50) null,
 )

create table Order_Detail(
	Order_Detail_Id nvarchar(50) primary key,
	Code nvarchar(50) null,
	Product_Id nvarchar(50) NULL,
	Qty numeric(8, 0) not null,
	Price numeric(18, 2) not null,
	Total numeric(18, 2) not null,
	Order_Header_Id nvarchar(50) null,
)

create table dim_date(
	Date date,
	month int,
	year int
)

create table dim_brand(
	Brand_Id nvarchar(50),
	Name nvarchar(150)
)

create table dim_category(
	Category_Id nvarchar(50),
	Name nvarchar(250)
)

create table dim_city(
	City_Id nvarchar(50),
	Name nvarchar(100)
)

create table dim_store(
	Store_Id nvarchar(50),
	Code nvarchar(50),
	Name nvarchar(250),
	City_Id nvarchar(50)
)

create table dim_employee(
	Employee_Id nvarchar(50),
	Name nvarchar(50),
	DOB date,
	HireDate date,
	Store_Id nvarchar(50),
	IdentityNumber nvarchar(50)
)

create table dim_customer(
	Customer_Id nvarchar(50),
	Name nvarchar(50),
	Phone nvarchar(15)
)

create table dim_product(
	Product_Id nvarchar(50),
	Code nvarchar(50),
	Name nvarchar(50),
	Description nvarchar(250),
	Size nvarchar(50),
	Color nvarchar(50),
	Brand_Id nvarchar(50),
	Category_Id nvarchar(50),
	StandardPrice numeric(18,2),
	Price numeric(18,2)

)

create table dim_source_online(
	Source_Online_Id nvarchar(50),
	Name nvarchar(50)
)

create table fact_product(
	OrderDate date,
	Product_Id nvarchar(50),
	Store_Id nvarchar(50),
	Qty int,
	StandardCost decimal(18,2),
	Revenue decimal(18,2),
	Profit decimal(18,2),
	NumberOrder int
)

create table fact_salesorder(
	OrderDate date,
	Employee_Id nvarchar(50),
	Store_Id nvarchar(50),
	Customer_Id nvarchar(50),
	Source_Online_Id nvarchar(50),
	Revenue decimal(18,2),
	StandardCost decimal(18,2),
	Profit decimal(18,2),
	NumberOrder int,
	RevenueOnline decimal(18,2),
	RevenueOffline decimal(18,2),
	NumberOrderOnline int,
	NumberOrderOffline int
)