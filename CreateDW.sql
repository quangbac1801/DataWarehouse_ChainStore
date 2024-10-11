create database DW_ChainStore
go
use DW_ChainStore
go

create table dim_year(
	YearKey nvarchar(4) primary key,
	Year int
)

create table dim_month(
	MonthKey nvarchar(6) primary key,   
	Month int,                          
	YearKey nvarchar(4),                        
	foreign key (YearKey) references dim_year(YearKey)  
)

create table dim_date(
	DateKey nvarchar(8) primary key,
	Date date,
	MonthKey nvarchar(6) ,
	foreign key (MonthKey) references dim_month(MonthKey)

)

create table dim_customer(
	CustomerKey int identity(1,1) primary key,
	Customer_Id nvarchar(50),
	Name nvarchar(50),
	Phone nvarchar(15)
)

create table dim_city(
	CityKey int identity(1,1) primary key,
	City_Id nvarchar(50),
	Name nvarchar(100)
)

create table dim_store(
	StoreKey int identity(1,1) primary key,
	Store_Id nvarchar(50),
	Code nvarchar(50),
	Name nvarchar(50),
	CityKey int
	foreign key (CityKey) references dim_city(CityKey)
)

create table dim_employee(
	EmployeeKey int identity(1,1) primary key,
	Employee_Id nvarchar(50),
	Name nvarchar(50),
	DOB date,
	HireDate date ,
	StoreKey int,
	IdentityNumber nvarchar(50)
	foreign key (StoreKey) references dim_store(StoreKey)
)

create table dim_source_online(
	SourceOnlineKey int identity(1,1) primary key,
	Source_Online_Id nvarchar(50),
	Name nvarchar(50)
)

create table dim_brand(
	BrandKey int identity(1,1) primary key,
	Brand_Id nvarchar(50),
	Name nvarchar(150)
)

create table dim_category(
	CategoryKey int identity(1,1) primary key,
	Category_Id nvarchar(50),
	Name nvarchar(250)
)

create table dim_product(
	ProductKey int identity(1,1) primary key,
	Product_Id nvarchar(50),
	Code nvarchar(50),
	Name nvarchar(250),
	Description nvarchar(250),
	Size nvarchar(50) ,
	Color nvarchar(50) ,
	BrandKey int,
	CategoryKey int,
	StandardPrice numeric(18,2),
	Price numeric(18,2),
	foreign key (BrandKey) references dim_brand(BrandKey),
	foreign key (CategoryKey) references dim_category(CategoryKey)
)

create table fact_product(
	Id int identity(1,1) primary key,
	DateKey nvarchar(8),
	ProductKey int,
	StoreKey int,
	Qty int,
	Revenue decimal(18,2),
	StandardCost decimal(18,2), 
	Profit decimal(18,2),
	NumerOrder int,
	foreign key (DateKey) references dim_date(DateKey),
	foreign key (ProductKey) references dim_product(ProductKey),
	foreign key (StoreKey) references dim_store(StoreKey)
)

create table fact_salesorder(
	Id int identity(1,1) primary key,
	DateKey nvarchar(8),
	EmployeeKey int,
	StoreKey int,
	CustomerKey int,
	SourceOnlineKey int,
	Revenue decimal(18,2),
	StandardCost decimal(18,2),
	Profit decimal(18,2),
	NumberOrder int,
	RevenueOnline decimal(18,2),
	RevenueOffline decimal(18,2),
	NumberOrderOnline int,
	NumberOrderOffline int
	foreign key (DateKey) references dim_date(DateKey),
	foreign key (EmployeeKey) references dim_employee(EmployeeKey),
	foreign key (StoreKey) references dim_store(StoreKey),
	foreign key (CustomerKey) references dim_customer(CustomerKey),
	foreign key (SourceOnlineKey) references dim_source_online(SourceOnlineKey)
)