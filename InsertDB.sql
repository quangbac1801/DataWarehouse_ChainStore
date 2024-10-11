use ChainStore 
go

--Insert Brand--
exec Brand_Create 'Nike'
exec Brand_Create 'Adidas'
exec Brand_Create 'Vans'
exec Brand_Create 'MLB'
exec Brand_Create 'Puma'
exec Brand_Create 'Gucci'
exec Brand_Create 'New Balance'
exec Brand_Create 'Promax'
exec Brand_Create 'Supreme'
exec Brand_Create 'Fila'

--Insert City--
exec City_Create N'Hà Nội'
exec City_Create N'TP Hồ Chí Minh'
exec City_Create N'Đà Nẵng'
exec City_Create N'Hải Phòng'
exec City_Create N'Cần Thơ'
exec City_Create N'Vĩnh Phúc'
exec City_Create N'Thái Nguyên'
exec City_Create N'Thừ Thiên Huế'
exec City_Create N'Lâm Đồng'
exec City_Create N'Ninh Bình'

--Insert Source Online--
exec Source_Online_Create 'Shopee'
exec Source_Online_Create 'Lazada'
exec Source_Online_Create 'TikTok'
exec Source_Online_Create 'Tiki'
exec Source_Online_Create 'Sendo'

--insert Store--
declare @noStore int = 25
declare @Storeindex int = 1
declare @Code nvarchar(50)
declare @Name nvarchar(250)
declare @City_Id nvarchar(50)
while (@Storeindex <= @noStore )
begin
	set @Code = (select CONCAT('ST',@Storeindex))
	set @Name = (select CONCAT('Store',@Storeindex))
	set @City_Id = (Select Top 1 City_Id from City order by newid())
	exec Store_Create @Code,@Name,@City_Id
	set @Storeindex = @Storeindex + 1
end
go
ALTER TABLE Employee
ALTER COLUMN DOB DATE NOT NULL;


--Insert employee--
declare @maxEmployee int = 5
declare @minEmployee int = 2
declare @EmployeIndex int = 1
declare @Name nvarchar(50)
declare @Store_Id nvarchar(50)

declare cursorStore cursor for
select Store_Id from Store

open cursorStore 
fetch next from cursorStore into @Store_Id

while @@FETCH_STATUS = 0
begin
	declare @noEmployee int = (select round(rand() * (@maxEmployee - @minEmployee), 0) + @minEmployee)
	declare @i int = 1
	while @i <= @noEmployee
	begin
		set @Name = (select CONCAT('Employee',@EmployeIndex))
		exec Employee_Create @Name,null,null,@Store_Id,null,null

		set @i = @i+ 1
		set @EmployeIndex = @EmployeIndex + 1
	end
	fetch next from cursorStore 
	into @Store_Id

end
close cursorStore
deallocate cursorStore
go



--insert Category--
declare @noCategory int = 10
declare @CategoryIndex int = 1
declare @NameCategory nvarchar(250)
while (@CategoryIndex <= @noCategory)
begin
	set @NameCategory = (select CONCAT('Category',@CategoryIndex))

	exec Category_Create @NameCategory

	set @CategoryIndex += 1
end
go


--insert Product--
declare @noProduct int = 400
declare @ProductIndex int = 1
declare @Code nvarchar(50)
declare @NameProduct nvarchar(250)
declare @Brand_Id nvarchar(50)
declare @Category_Id nvarchar(50)
declare @StandardPrice numeric(18,2)
declare @Price numeric(18,2)
declare @minPrice int = 10
declare @maxPrice int = 10000
DECLARE @a DECIMAL(5, 2) = 60 
DECLARE @b DECIMAL(5, 2) = 90
while (@ProductIndex <= @noProduct)
begin
	set @Code = (select CONCAT('P',@ProductIndex))
	set @NameProduct = (select CONCAT('Product',@NameProduct))
	set @Brand_Id = (select top 1 Brand_Id from Brand order by newid())
	set @Category_Id = (select top 1 Category_Id from Category order by newid())
	set @Price = ( select round(rand()*(@maxPrice - @minPrice ),0 ) + @minPrice)*1000
	set @StandardPrice = round((@Price/1000)*((round(rand()*(@b-@a),0) +@a)/100),0)*1000
	exec Product_Create @Code, @NameProduct, null,null,null,@Brand_Id, @Category_Id, @StandardPrice, @Price

	set @ProductIndex += 1
end
go

--insert Customer--
declare @noCustomer int = 25000
declare @CustomerIndex int = 1
declare @NameCustomer nvarchar(50)
while (@CustomerIndex <= @noCustomer)
begin
	set @NameCustomer = (select CONCAT('Customer', @CustomerIndex))

	exec Customer_Create @NameCustomer, null, null

	set @CustomerIndex += 1
end
go

--insert Order--
declare @StartDate date = '2023/01/01'
declare @EndDate date = getdate()
declare @CodeHeader nvarchar(50)
declare @OrderDate date
declare @IsOnline int
declare @Employee_Id nvarchar(50)
declare @Customer_Id nvarchar(50)
declare @Store_Id nvarchar(50)
declare @Source_Online_Id nvarchar(50)

declare @noOrder_Header int = 80000
declare @Order_Header_Idx int = 1

while @Order_Header_Idx <= @noOrder_Header
begin
	set @CodeHeader = (select concat('OH ', @Order_Header_Idx))
	set @OrderDate = dateadd(DAY, round(rand() * datediff(DAY, @StartDate, @EndDate), 0), @StartDate)
	set @IsOnline = round(rand(), 0)
	set @Customer_Id = (select top 1 Customer_Id from Customer order by newid())

	select top 1 @Employee_Id = Employee_Id, @Store_Id = Store_Id from Employee order by newid()

	if @IsOnline = 0
		set @Source_Online_Id = null
	else
		set @Source_Online_Id = (select top 1 Source_Online_Id from Source_Online order by newid())

	exec Order_Header_Create @CodeHeader, @OrderDate, 0, 0, null, @IsOnline, @Source_Online_Id, @Customer_Id,@Store_Id, @Employee_Id 
	set @Order_Header_Idx += 1
end

--Order_Detail--
declare @CodeDetail nvarchar(50)
declare @Product_Id nvarchar(50)
declare @Price numeric(18,2)
declare @StandardPrice numeric(18,2)
declare @Order_Header_Id nvarchar(50)
declare @minNoProduct int = 1
declare @maxNoProduct int = 5
declare @Qty int
declare @minQty int = 1
declare @maxQty int = 10
declare @OrderDetailIdx int = 1
declare @Total numeric(18,2)

declare cursorOrderHeader cursor for 
select Order_Header_Id from Order_Header

open cursorOrderHeader

fetch next from cursorOrderHeader into @Order_Header_Id

while @@fetch_status = 0
begin
	declare @TotalAll numeric(18,2) = 0
	declare @StandardPriceAll numeric(18,2) = 0
	declare @noProduct int = round(rand() * (@maxNoProduct - @minNoProduct), 0) + @minNoProduct
	declare @i int = 1

	while @i <= @noProduct
	begin
		set @CodeDetail = (select concat('OD ', @OrderDetailIdx))

		select top 1 @Product_Id = Product_Id, @Price = Price, @StandardPrice = StandardPrice 
		from Product 
		order by newid()

		set @Qty = round(rand() * (@maxQty - @minQty), 0) + @minQty
		set @Total = @Price * @Qty

		set @TotalAll += @Total
		set @StandardPriceAll += @StandardPrice * @Qty

		exec Order_Detail_create @CodeDetail, @Product_Id, @Qty, @Price, @Total, @Order_Header_Id
		set @i += 1
		set @OrderDetailIdx += 1
	end

	update Order_Header
	set 
		Total = @TotalAll,
		StandardCost = @StandardPriceAll
	where Order_Header_Id = @Order_Header_Id

	fetch next from cursorOrderHeader into @Order_Header_Id
end

close cursorOrderHeader
deallocate cursorOrderHeader



