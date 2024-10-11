use ChainStore;
go
--Brand--
--1.create--
create procedure Brand_Create(
	@Name nvarchar(150)
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into Brand
	(
		Brand_Id,
		Name,
		CreatedDate,
		UpdatedDate

	)
	values
	(
		@temp,
		@Name,
		GETDATE(),
		null
		)
end
go

--2.update--
create procedure Brand_Update
(	
	@Brand_Id nvarchar(50),
	@Name nvarchar(150)
)
as
begin
	set nocount on

	update Brand set Name = @Name, UpdatedDate = getdate() where Brand_Id = @Brand_Id
end
go

--3.Delete--
create procedure Brand_Delete
(
	@Brand_ID nvarchar(50)
)
as
begin
	set nocount on
	delete from Brand where Brand_Id = @Brand_ID
end
go

--4. GetbyId--
create procedure Brand_GetId
(	
	@Brand_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from Brand where Brand_Id = @Brand_Id
end
go

--Category--
--1.create--
create procedure Category_Create
(
	@Name nvarchar(250) 
)
as
begin
	set nocount on

	declare @temp nvarchar(50) = lower(newid())
	
	insert into Category
	(
		Category_Id,
		Name,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Name,
		GETDATE(),
		null
	)
end
go

--2.update--
create procedure Category_Update
(
	@Category_Id nvarchar(50),
	@Name nvarchar(250)
)
as
begin
	set nocount on
	update Category set Name = @Name, UpdatedDate = GETDATE() where Category_Id = @Category_Id
end
go

--3.Delete--
create procedure Category_Delete
(
	@Category_Id nvarchar(50)	
)
as
begin
	set nocount on
	delete from Category where Category_Id = @Category_Id
end
go

--4.GetbyId--
create procedure Category_GetId
(
	@Category_Id nvarchar(50) 
)
as
begin
	set nocount on
	select * from Category where Category_Id = @Category_Id
end
go

--City--
--1.create--
create procedure City_Create
(
	@Name nvarchar(50)	
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into City 
	(
		City_Id,
		Name,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Name,
		GETDATE(),
		null
		)
end
go

--2.Update--
create procedure City_Update
(
	@City_Id nvarchar(50),
	@Name nvarchar(250)
)
as
begin
	set nocount on
	update City set Name = @Name, UpdatedDate = GETDATE() where City_Id = @City_Id
end
go

--3.Delete--
create procedure City_Delete
(
	@City_Id nvarchar(50)
)
as
begin
	set nocount on
	delete from City where City_Id = @City_Id
end
go

--4.GetbyId
create procedure City_GetId
(
	@City_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from City where City_Id = @City_Id
end
go

--Product
--1.create--
create procedure Product_Create
(
	@Code nvarchar(50),
	@Name nvarchar(250) ,
	@Description nvarchar(250),
	@Size nvarchar(50),
	@Color nvarchar(50),
	@Brand_Id nvarchar(50),
	@Category_Id nvarchar(50),
	@StandardPrice numeric(18,2),
	@Price numeric(18,2)
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into Product
	(
		Product_Id,
		Code,
		Name,
		Description,
		Size,
		Color,
		Brand_Id,
		Category_Id,
		StandardPrice,
		Price,
		CreatedDate,
		UpdatedDate
	)
	values
	(	
		@temp,
		@Code,
		@Name,
		@Description,
		@Size,
		@Color,
		@Brand_Id,
		@Category_Id,
		@StandardPrice,
		@Price,
		GETDATE(),
		null
	)
end
go

--2.update--
create procedure Product_Update
(
	@Product_Id nvarchar(50),
	@Code nvarchar(50),
	@Name nvarchar(250) ,
	@Description nvarchar(250),
	@Size nvarchar(50),
	@Color nvarchar(50),
	@Brand_Id nvarchar(50),
	@Category_Id nvarchar(50),
	@StandardPrice numeric(18,2),
	@Price numeric(18,2)
)
as
begin
	set nocount on
	update Product set 
			Code=@Code
			,Name=@Name
			,Description=@Description
			,Size=@Size
			,Color=@Color
			,Brand_Id=@Brand_Id
			,Category_Id=@Category_Id
			,StandardPrice=@StandardPrice
			,Price=@Price
			,UpdatedDate=getdate()
	where Product_Id = @Product_Id
end
go

--3.Delete--
create procedure Product_Delete
(
	@Product_Id nvarchar(50)
)
as
begin
	set nocount on
	delete from Product where Product_Id = @Product_Id
end
go

--4.GetbyId
create procedure Product_GetId
(
	@Product_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from Product where Product_Id = @Product_Id
end
go

--Store--
--1.create--
create procedure Store_Create
(
	@Code nvarchar(50),
	@Name nvarchar(250),
	@City_Id nvarchar(50)
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into Store
	(
		Store_Id,
		Code,
		Name,
		City_Id,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Code,
		@Name,
		@City_Id,
		GETDATE(),
		null
	)
end
go

--2.update--
create procedure Store_Update
(
	@Store_Id nvarchar(50),
	@Code nvarchar(50),
	@Name nvarchar(250),
	@City_Id nvarchar(50)
)
as
begin
	set nocount on
	update Store set Code = @Code, Name = @Name, City_Id = @City_Id, UpdatedDate = GETDATE() where Store_Id = @Store_Id
end
go

--3.Delete--
create procedure Store_Delete
(
	@Store_Id nvarchar(50)
)
as
begin
	set nocount on
	delete from Store where Store_Id = @Store_Id
end
go

--4.GetbyId
create procedure Store_GetId
(
	@Store_Id nvarchar(50) 
)
as
begin
	set nocount on
	select * from Store where Store_Id = @Store_Id
end
go

--Employee--
--1. Create--
create procedure Employee_Create
(
	@Name nvarchar(50),
	@DOB date,
	@HireDate date,
	@Store_Id nvarchar(50) ,
	@IdentityNumber nvarchar(50),
	@Address nvarchar(250)
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into Employee
	(
		Employee_Id,
		Name,
		DOB,
		HireDate,
		Store_Id,
		IdentityNumber,
		Address,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Name,
		@DOB,
		@HireDate,
		@Store_Id,
		@IdentityNumber,
		@Address,
		GETDATE(),
		null
	)
end
go

--2.Update
create procedure Employee_Update
(
	@Employee_Id nvarchar(50),
	@Name nvarchar(50),
	@DOB date ,
	@HireDate date ,
	@Store_Id nvarchar(50),
	@IdentityNumber nvarchar(50),
	@Address nvarchar(250)
)
as
begin
	set nocount on
	update Employee set
		Name = @Name,
		DOB = @DOB,
		HireDate = @HireDate,
		Store_Id = @Store_Id,
		IdentityNumber = @IdentityNumber,
		Address = @Address,
		UpdatedDate = GETDATE()
	where Employee_Id = @Employee_Id
end
go

--3.Delete--
create procedure Employee_Delete
(
	@Employee_Id nvarchar(50)
)
as
begin
	set nocount on
	delete from Employee where Employee_Id = @Employee_Id
end
go

--4.GetbyId--
create procedure Employee_GetId
(
	@Employee_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from Employee where Employee_Id = @Employee_Id
end
go

--Customer--
--1.Create--
create procedure Customer_Create
(
	@Name nvarchar(50),
	@Phone nvarchar(15),
	@Address nvarchar(250)
)
as
begin
	set nocount on 
	declare @temp nvarchar(50) = lower(newid())
	
	insert into Customer
	(
		Customer_Id,
		Name,
		Phone,
		Address,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Name,
		@Phone,
		@Address,
		GETDATE(),
		null
	)
end
go

--2.Update--
create procedure Customer_Update
(
	@Customer_Id nvarchar(50),
	@Name nvarchar(50),
	@Phone nvarchar(15),
	@Address nvarchar(250)
)
as
begin
	set nocount on
	update Customer set
		Name = @Name,
		Phone = @Phone,
		Address = @Address,
		UpdatedDate = GETDATE()
	where Customer_Id = @Customer_Id
end
go

--3. Delete--
create procedure Customer_Delete
(
	@Customer_Id nvarchar(50)
)
as
begin
	set nocount on
	delete from Customer where Customer_Id = @Customer_Id
end
go

--4.GetbyId--
create procedure Customer_GetId
(
	@Customer_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from Customer where Customer_Id = @Customer_Id
end
go

--Source Online
--1. create
alter procedure Source_Online_Create
(
	@Name nvarchar(50)
)
as
begin
	set nocount on
	declare @temp int = (SELECT ISNULL(MAX(Source_Online_Id), 0) + 1 FROM Source_Online);
	insert into Source_Online 
	(	
		Source_Online_Id,
		Name,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Name,
		GETDATE(),
		null
	)
end
go

--2.Update--
alter procedure Source_Online_Update
(
	@Source_Online_Id int,
	@Name nvarchar(50)
)
as
begin
	set nocount on
	update Source_Online set Name = @Name, UpdatedDate = GETDATE() where Source_Online_Id = @Source_Online_Id
end
go

--3. Delete--
alter procedure Source_Online_Delete
(
	@Source_Online_Id int
)
as
begin
	set nocount on
	delete from Source_Online where Source_Online_Id = @Source_Online_Id
end
go

--4.GetbyId--
alter procedure Source_Online_GetId
(
	@Source_Online_Id int
)
as
begin
	set nocount on
	select * from Source_Online where Source_Online_Id = @Source_Online_Id
end
go

--Order Header--
--1.create
alter procedure Order_Header_Create
(
	@Code nvarchar(50),
	@Orderdate date,
	@Total decimal(18,2),
	@StandardCost decimal(18, 2),
	@Status int,
	@IsOnline bit,
	@Source_Online_Id int,
	@Customer_Id nvarchar(50) ,
	@Store_Id nvarchar(50) ,
	@Employee_Id nvarchar(50)
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into Order_Header
	(
		Order_Header_Id,
		Code,
		Orderdate,
		Total,
		StandardCost,
		Status,
		IsOnline,
		Source_Online_Id,
		Customer_Id,
		Store_Id,
		Employee_Id,
		CreatedDate,
		UpdatedDate
	)
	values
	(	
		@temp,
		@Code,
		@Orderdate,
		@Total,
		@StandardCost,
		@Status,
		@IsOnline,
		@Source_Online_Id,
		@Customer_Id,
		@Store_Id,
		@Employee_Id,
		GETDATE(),
		null
	)
end
go

--2. update--
alter procedure Order_Header_Update
(	
	@Order_Header_Id nvarchar(50),
	@Code nvarchar(50),
	@Orderdate date,
	@Total decimal(18,2),
	@StandardCost decimal(18, 2),
	@Status int,
	@IsOnline bit,
	@Source_Online_Id int,
	@Customer_Id nvarchar(50) ,
	@Store_Id nvarchar(50) ,
	@Employee_Id nvarchar(50)
)
as
begin
	set nocount on

	update Order_Header set
		Code = @Code,
		Orderdate = @Orderdate,
		Total = @Total,
		StandardCost = @StandardCost,
		Status = @Status,
		IsOnline = @IsOnline,
		Source_Online_Id = Source_Online_Id,
		Customer_Id = Customer_Id,
		Store_Id = @Store_Id,
		Employee_Id = @Employee_Id,
		UpdatedDate = GETDATE()
	where Order_Header_Id = @Order_Header_Id
end
go

--3.Delete--
alter procedure Order_Header_Delete
(
	@Order_Header_Id nvarchar(50) 
)
as
begin
	set nocount on
	delete from Order_Header where Order_Header_Id = @Order_Header_Id
end
go

--4. GetbyId--
alter procedure Order_Header_GetId
(	
	@Order_Header_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from Order_Header where Order_Header_Id = @Order_Header_Id
end
go

--Order Detail
--1.create--
create procedure Order_Detail_Create
(
	@Code nvarchar(50),
	@Product_Id nvarchar(50),
	@Qty numeric(18,2),
	@Price numeric(18,2),
	@Total numeric(18, 2),
	@Order_Header_Id nvarchar(50)
)
as
begin
	set nocount on
	declare @temp nvarchar(50) = lower(newid())

	insert into Order_Detail
	(
		Order_Detail_Id,
		Code,
		Product_Id,
		Qty,
		Price,
		Total,
		Order_Header_Id,
		CreatedDate,
		UpdatedDate
	)
	values
	(
		@temp,
		@Code,
		@Product_Id,
		@Qty,
		@Price,
		@Total,
		@Order_Header_Id,
		GETDATE(),
		null
	)
end
go

--2.Update--
create procedure Order_Detail_Update
(	
	@Order_Detail_Id nvarchar(50),
	@Code nvarchar(50),
	@Product_Id nvarchar(50),
	@Qty numeric(18,2),
	@Price numeric(18,2),
	@Total numeric(18, 2),
	@Order_Header_Id nvarchar(50)
)
as
begin
	set nocount on
	update Order_Detail set
		Code = @Code,
		Product_Id = @Product_Id,
		Qty = @Qty,
		Price = @Price,
		Total = @Total,
		Order_Header_Id = @Order_Header_Id,
		UpdatedDate = GETDATE()
	where Order_Detail_Id = @Order_Detail_Id
end
go

--3.Delete--
create procedure Order_Detail_Delete
(
	@Order_Detail_Id nvarchar(50)
)
as
begin
	set nocount on
	delete from Order_Detail where Order_Detail_Id = @Order_Detail_Id
end
go

--4. GetbyId--
create procedure Order_Detail_GetId
(
	@Order_Detail_Id nvarchar(50)
)
as
begin
	set nocount on
	select * from Order_Detail where Order_Detail_Id = @Order_Detail_Id
end
go