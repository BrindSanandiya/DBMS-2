
------------- LAB - 1-------------


---- PART A

--Retrieve a unique genre of songs.
select distinct genre from SONGS

--Find top 2 albums released before 2010.
select top 2 * from Albums where Release_year < 2010

--Insert Data into the Songs Table. (1245, ‘Zaroor’, 2.55, ‘Feel good’, 1005)
insert into SONGS values
(1245,'Zaroor', 2.55, 'Feel good', 1005)

--Change the Genre of the song ‘Zaroor’ to ‘Happy’
update SONGS set Genre = 'Happy' where Song_title = 'zaroor'

--Delete an Artist ‘Ed Sheeran’
delete from Artists where Artist_name = 'Ed sheeran'
select * from Artists

--Add a New Column for Rating in Songs Table. [Ratings decimal(3,2)]
alter table songs add Ratings decimal(3,2)

--Retrieve songs whose title starts with 'S'.
select song_title from SONGS where Song_title like 'S%'

--Retrieve all songs whose title contains 'Everybody'.
select Song_title from SONGS where Song_title like '%everybody%'

--Display Artist Name in Uppercase.
select upper(artist_name) from Artists

--Find the Square Root of the Duration of a Song ‘Good Luck’
select SQRT(duration) from songs where Song_title = 'good luck'

--Find Current Date.
select getdate()

--Find the number of albums for each artist.
SELECT ARTIST_ID,COUNT(ALBUM_TITLE) AS TOTAL_ALBUMS FROM ALBUMS GROUP BY ARTIST_ID

--Retrieve the Album_id which has more than 5 songs in it.
SELECT ALBUM_ID,COUNT(SONG_ID) AS NOOFSONGS FROM SONGS GROUP BY ALBUM_ID HAVING COUNT(ALBUM_ID)>3

--Retrieve all songs from the album 'Album1'. (using Subquery)
SELECT SONG_TITLE FROM SONGS WHERE ALBUM_ID IN(SELECT ALBUM_ID FROM ALBUMS WHERE ALBUM_TITLE='ALBUM1')

--Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
SELECT ALBUM_TITLE FROM ALBUMS WHERE ARTIST_ID IN(SELECT ARTIST_ID FROM ARTISTS WHERE ARTIST_NAME='Aparshakti Khurana')

--Retrieve all the song titles with its album title.
SELECT SONG_TITLE,ALBUM_TITLE
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=ALBUMS.ALBUM_ID

--Find all the songs which are released in 2020.
SELECT SONG_TITLE,RELEASE_YEAR
FROM ALBUMS JOIN SONGS 
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE RELEASE_YEAR=2020

--Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
CREATE VIEW FAV_SONGS AS SELECT SONG_ID,SONG_TITLE FROM SONGS WHERE SONG_ID BETWEEN 101 AND 105

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
UPDATE FAV_SONGS SET SONG_TITLE='JANNAT' WHERE SONG_ID=101

--20. Find all artists who have released an album in 2020.
SELECT ARTIST_NAME,RELEASE_YEAR FROM ARTISTS JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID WHERE RELEASE_YEAR=2020

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
SELECT ARTIST_NAME,DURATION,ALBUM_ID FROM ARTISTS 
JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE ARTIST_NAME='SHREYA GHOSHAL' ORDER BY DURATION

-----------------------------------------------Part-B-------------------------------------------------
--22. Retrieve all song titles by artists who have more than one album.
SELECT SONG_TITLE,COUNT(ALBUMS.ALBUM_ID) FROM SONGS 
JOIN ALBUMS ON SONGS.ALBUM_ID=ALBUMS.ALBUM_ID
JOIN ARTISTS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
GROUP BY SONGS.SONG_TITLE HAVING COUNT(ALBUMS.ALBUM_ID)>1

--23. Retrieve all albums along with the total number of songs.
SELECT ALBUM_TITLE,COUNT(SONGS.SONG_TITLE) AS TOTALSONGS FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID GROUP BY ALBUM_TITLE

--24. Retrieve all songs and release year and sort them by release year.
SELECT SONG_TITLE,RELEASE_YEAR
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
ORDER BY RELEASE_YEAR

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
SELECT GENRE,COUNT(SONG_TITLE) AS MORETHAN2SONGS
FROM SONGS
GROUP BY GENRE
HAVING COUNT(SONG_TITLE)>2

--26. List all artists who have albums that contain more than 3 songs.
SELECT ARTIST_NAME,COUNT(SONGS.SONG_TITLE)
FROM ARTISTS JOIN ALBUMS
ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ARTIST_NAME
HAVING COUNT(SONGS.SONG_TITLE)>3

-----------------------------------------------Part-C-------------------------------------------------
--27. Retrieve albums that have been released in the same year as 'Album4'
select Album_title from Albums where Release_year = (select Release_year from Albums where Album_title = 'Ablum4')

--28. Find the longest song in each genre
SELECT GENRE,MAX(DURATION)
FROM SONGS
GROUP BY GENRE

--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
select Song_title,Album_title from SONGS s join Albums a on s.Album_id = a.Album_id where Album_title like '%album%'  

--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.
SELECT ARTIST_NAME,SUM(SONGS.DURATION) AS TOTAL_DURATION
FROM ARTISTS JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ARTIST_NAME
HAVING SUM(SONGS.DURATION)>15.00



----------------------------------------------------------------------------------------------------------------------


--------  LAB-2  ---------

CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
)

CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),-- aa no use identity thi auto increment dai saki
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
)

INSERT INTO Department (DepartmentID, DepartmentName)
VALUES 
(1, 'Admin'),
(2, 'IT'),
(3, 'HR'),
(4, 'Account');
select * from Department


INSERT INTO Designation (DesignationID, DesignationName)
VALUES 
(11, 'Jobber'),
(12, 'Welder'),
(13, 'Clerk'),
(14, 'Manager'),
(15, 'CEO');
select * from Designation

INSERT INTO Person (FirstName, LastName, Salary, JoiningDate, DepartmentID, DesignationID) VALUES 
('Rahul', 'Anshu', 56000.00, '1990-01-01', 1, 12),
('Hardik', 'Hinsu', 18000.00, '1990-09-25', 2, 11),
('Bhavin', 'Kamani', 25000.00, '1991-05-14', NULL, 11),
('Bhoomi', 'Patel', 39000.00, '2014-02-20', 1, 13),
('Rohit', 'Rajgor', 17000.00, '1990-07-23', 2, 15),
('Priya', 'Mehta', 25000.00, '1990-10-18', 2, NULL),
('Neha', 'Trivedi', 18000.00, '2014-02-20', 3, 15);
select * from person
truncate table person


--PartA--
--Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.
create procedure pr_department_ins
	@departmentID int,
	@departmentName varchar(50)
as
begin
	insert into Department values(
		@departmentID,
		@departmentName
	)
end

exec pr_department_ins 1,'Admin'
exec pr_department_ins 2,'IT'
exec pr_department_ins 3,'HR'
exec pr_department_ins 4,'Account'

--

create procedure pr_designation_ins
	@designationtID int,
	@designationName varchar(50)
as
begin
	insert into Designation values(
		@designationtID,
		@designationName
	)
end

exec pr_designation_ins 11,'Jobber'
exec pr_designation_ins 12,'Welder'
exec pr_designation_ins 13,'Clerk'
exec pr_designation_ins 14,'Manager'
exec pr_designation_ins 15,'CEO'

--

create procedure pr_person_ins
	@FirstName varchar(50),
	@lastname varchar(50),
	@Salary Decimal(8,2),
	@JoiningDate datetime,
	@DepartmentID int,
	@designation int
as
begin
	insert into Person values(
		@FirstName,
		@lastname,
		@Salary,
		@JoiningDate,
		@DepartmentID,
		@designation
	)
end

exec pr_person_ins 'Rahul', 'Anshu', 56000.00, '1990-01-01', 1, 12
exec pr_person_ins 'Hardik', 'Hinsu', 18000.00, '1990-09-25', 2, 11
exec pr_person_ins'Bhavin', 'Kamani', 25000.00, '1991-05-14', NULL, 11
exec pr_person_ins'Bhoomi', 'Patel', 39000.00, '2014-02-20', 1, 13
exec pr_person_ins'Rohit', 'Rajgor', 17000.00, '1990-07-23', 2, 15
exec pr_person_ins'Priya', 'Mehta', 25000.00, '1990-10-18', 2, NULL
exec pr_person_ins'Neha', 'Trivedi', 18000.00, '2014-02-20', 3, 15

--

create procedure pr_person_upd
	@Salary decimal(8,2),
	@Firstname varchar(50)
as 
begin
	update Person
	set Salary = @Salary
	where FirstName = @Firstname
end

exec pr_person_upd 30000,'hardik'

--

create procedure pr_dept_upd
	@departmentid int,
	@departmentname varchar(50)
as 
begin
	update Department
	set DepartmentID = @departmentid
	where DepartmentName = @departmentname
end

exec pr_dept_upd 6,'HR'

--

create procedure pr_dsgn_upd
	@designationid int,
	@designationname varchar(50)
as 
begin
	update Designation
	set DesignationID = @designationid
	where DesignationName = @designationname
end

exec pr_dsgn_upd 30,'clerk'
--
select * from person
select * from Designation
select * from Department
--

create procedure pr_person_dlt
	@firstname varchar(50)
as
begin
	delete from Person
	where FirstName = @firstname
end

--

create procedure pr_dept_dlt
	@departmentid int
as
begin
	delete from Department
	where DepartmentID = @departmentid
end

--

create procedure pr_dsgn_dlt
	@designationid int
as
begin
	delete from Designation
	where designationid = @designationid
end

	--------


--Department, Designation & Person Table’s SELECTBYPRIMARYKEY
create procedure pr_department_spk
	@departmentid int
as 
begin
	select * from Department
	where DepartmentID = @departmentid
end

exec pr_department_spk 2

--

create procedure pr_person_spk
	@personid int
as 
begin
	select * from Person
	where PersonID = @personid
end

exec pr_person_spk 2

--

create procedure pr_designation_spk
	@designationid int
as 
begin
	select * from Designation
	where DesignationID = @Designationid
end
exec pr_designation_spk 30 


--Create a Procedure that shows details of the first 3 persons.

create procedure pr_persondetail_t3
as 
begin
	select top 3 * from person
end

exec pr_persondetail_t3

----PartB----


--Create a Procedure that takes the department name as input and returns a table with all workers working in that department.

--Create Procedure that takes department name & designation name as input and returns a table with worker’s first name, salary, joining date & department name.

--Create a Procedure that takes the first name as an input parameter and display all the details of the worker with their department & designation name.

--Create Procedure which displays department wise maximum, minimum & total salaries.

--Create Procedure which displays designation wise average & total salaries.



----PartC----


--Create Procedure that Accepts Department Name and Returns Person Count.

--Create a procedure that takes a salary value as input and returns all workers with a salary greater than input salary value along with their department and designation details.

--Create a procedure to find the department(s) with the highest total salary among all departments.

--Create a procedure that takes a designation name as input and returns a list of all workers under that designation who joined within the last 10 years, along with their department.

--Create a procedure to list the number of workers in each department who do not have a designation assigned.

--Create a procedure to retrieve the details of workers in departments where the average salary is above 12000.



----------------------------------------------------


--------LAB-3---------

CREATE TABLE Departments (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE,
 ManagerID INT NOT NULL,
 Location VARCHAR(100) NOT NULL
);

CREATE TABLE Employee (
 EmployeeID INT PRIMARY KEY,
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 DoB DATETIME NOT NULL,
 Gender VARCHAR(50) NOT NULL,
 HireDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 Salary DECIMAL(10, 2) NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create Projects Table

CREATE TABLE Projects (
 ProjectID INT PRIMARY KEY,
 ProjectName VARCHAR(100) NOT NULL,
 StartDate DATETIME NOT NULL,
 EndDate DATETIME NOT NULL,
 DepartmentID INT NOT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID, Location) VALUES
 (1, 'IT', 101, 'New York'),
 (2, 'HR', 102, 'San Francisco'),
 (3, 'Finance', 103, 'Los Angeles'),
 (4, 'Admin', 104, 'Chicago'),
 (5, 'Marketing', 105, 'Miami');

INSERT INTO Employee (EmployeeID, FirstName, LastName, DoB, Gender, HireDate, DepartmentID,Salary) VALUES
 (101, 'John', 'Doe', '1985-04-12', 'Male', '2010-06-15', 1, 75000.00),
 (102, 'Jane', 'Smith', '1990-08-24', 'Female', '2015-03-10', 2, 60000.00),
 (103, 'Robert', 'Brown', '1982-12-05', 'Male', '2008-09-25', 3, 82000.00),
 (104, 'Emily', 'Davis', '1988-11-11', 'Female', '2012-07-18', 4, 58000.00),
 (105, 'Michael', 'Wilson', '1992-02-02', 'Male', '2018-11-30', 5, 67000.00);

INSERT INTO Projects (ProjectID, ProjectName, StartDate, EndDate, DepartmentID) VALUES
 (201, 'Project Alpha', '2022-01-01', '2022-12-31', 1),
 (202, 'Project Beta', '2023-03-15', '2024-03-14', 2),
 (203, 'Project Gamma', '2021-06-01', '2022-05-31', 3),
 (204, 'Project Delta', '2020-10-10', '2021-10-09', 4),
 (205, 'Project Epsilon', '2024-04-01', '2025-03-31', 5);


 ----PART A ----

--Create Stored Procedure for Employee table As User enters either First Name or Last Name and based on this you must give EmployeeID, DOB, Gender & Hiredate.
create procedure pr_printemp
	@firstname varchar(50) null,
	@lastname varchar(50) null
as
begin
	select EmployeeId, doB, Gender, hiredate 
	from employee 
	where (firstname = @firstname) or (lastname = @lastname)
end

exec pr_printemp 'john',null

--Create a Procedure that will accept Department Name and based on that gives employees list who belongs to that department. 

create procedure pr_emplist
	@departmentname varchar(50) null
as
begin 
	select * from Employee p join Departments d 
	on p.DepartmentID = d.DepartmentID
	where d.DepartmentName = @departmentname
end
drop procedure pr_emplist

exec pr_emplist 'HR'

--Create a Procedure that accepts Project Name & Department Name and based on that you must give all the project related details. 

create procedure pr_projectdetails
	@projectname varchar(50) null,
	@departmentname varchar(50) null
as
begin
	select * from Projects p join departments d
	on p.departmentid = d.departmentid
	where (projectname=@projectname) and (departmentname = @departmentname)
end

exec pr_projectdetails 'Project beta','hr'

--Create a procedure that will accepts any integer and if salary is between provided integer, then those employee list comes in output.

create procedure pr_printsal
	@integer1 int,
	@integer2 int
as
begin
	select salary from employee
	where salary between @integer1 and @integer2
END

exec pr_printsal 50000,70000

--Create a Procedure that will accepts a date and gives all the employees who all are hired on that date. 

create procedure pr_showhdate
	@date date
as
begin
	select * from employee 
	where hiredate = @date
end

exec pr_showhdate '2008-09-25'


---- PART B

--Create a Procedure that accepts Gender’s first letter only and based on that employee details will be served.

create procedure pr_empgender
	@gender varchar(5)
as 
begin 
	select * from employee
	where gender like '@gender%'
end

exec pr_empgender m

--Create a Procedure that accepts First Name or Department Name as input and based on that employee data will come.
--Create a procedure that will accepts location, if user enters a location any characters, then he/she will get all the departments with all data. 

create database CSE_A9_273


-------------------------------------------------------------------------------

------ LAB 4 -------


--1. Write a function to print "hello world". 

create function fn_printHello()
returns varchar(20)
as
begin
	return 'hello'
end

select dbo.fn_printhello()

--2. Write a function which returns addition of two numbers. 

create function fn_add2(@a int,@b int)
returns int
as
begin
	return @a+@b
end

select dbo.fn_add2(3,5)

--3. Write a function to check whether the given number is ODD or EVEN.

create function fn_check_eo(@num int)
returns varchar(20)
as 
begin 
	declare @ans varchar(10)
	if @num%2=0
		set @ans='Is even'
	else
		set @ans='Is odd'
	return @ans
end

select dbo.fn_check_eo(5)

--4. Write a function which returns a table with details of a person whose first name starts with B. 

create table person(
	fname varchar(5)
)

create function fn_startwB()
returns table
as
	return(select * from person where fname like 'b%')

--5. Write a function which returns a table with unique first names from the person table. 
	
create function fn_startwB_name()
returns table
as 
	return(select distinct fname from person)

--6. Write a function to print number from 1 to N. (Using while loop) 

create function fn_1toN(@n int)
returns varchar(500)
as
begin
	declare @ans varchar(100) = ''
	declare @i int = 1

	while @i <= @n
	begin
		set @ans = @ans + cast(@i as varchar)+' '
		set @i = @i + 1
	end
	return @ans
end

select dbo.fn_1ton(23)

--7. Write a function to find the factorial of a given integer.

create or alter function fn_factorial(@num int)
returns int
as 
begin
	declare @mul int = 1
	declare @i int = 1
	while @i <= @num
	begin
		set @mul = @mul * @i
		set @i = @i + 1
	end
	return @mul
end

select dbo.fn_factorial(7)


-----------------------

----PART B-----

--8. Write a function to compare two integers and return the comparison result. (Using Case statement) 

create or alter function fn_compare(@n1 int,@n2 int)
returns varchar(50)
as 
begin
	declare @ans varchar(50)
	set @ans = 
		case
		when @n1 > @n2 then 'number1 > number2'
		when @n1 < @n2 then 'number1 < number2'
		when @n1 = @n2 then 'number1 = numebr2'
		end
	return @ans
end

select dbo.fn_compare(4,5)

--9. Write a function to print the sum of even numbers between 1 to 20. 

create or alter function fn_even_sum()
returns int
as 
begin 
	declare @sum int = 0
	declare @num int = 1
	while @num <= 20
	begin 
		if @num%2=0
			set @sum = @sum + @num
			set @num = @num + 1
	end	
	return @sum
end

select dbo.fn_even_sum()

--10. Write a function that checks if a given string is a palindrome

create or alter function fn_palindrome(@string varchar(10))
returns varchar(15)
as begin
	declare @ans varchar(15)
	if @string = reverse(@string)
		set @ans = 'is palindrome'
	else
		set @ans = 'not palindrome'
	return @ans
end
		
select dbo.fn_palindrome('asdffdsa')


----------------------

----- PART-C ------
-- 11. Write a function to check whether a given number is prime or not. 

create or alter function fn_prime(@n int)
returns varchar(10)
as 
begin
	declare @i int = 2
	declare @cnt int = 0
	declare @ans varchar(10)
	while @i < @n
	begin
		if @n % @i = 0
			set @cnt = @cnt + 1
			set @i = @i + 1
		if @cnt = 0 
			set @ans = 'Prime'
		else
			set @ans = 'Not Prime'
	end
	return @ans
end

select dbo.fn_prime(13)

--12. Write a function which accepts two parameters start date & end date, and returns a difference in days. 



--13. Write a function which accepts two parameters year & month in integer and returns total days each year. 



--14. Write a function which accepts departmentID as a parameter & returns a detail of the persons. 



--15. Write a function that returns a table with details of all persons who joined after 1-1-1991. 




-------------------------------------------------------------------------

---------LAB-6-----------

CREATE TABLE Products ( 
Product_id INT PRIMARY KEY, 
Product_Name VARCHAR(250) NOT NULL, 
Price DECIMAL(10, 2) NOT NULL 
)

INSERT INTO Products (Product_id, Product_Name, Price) VALUES 
(1, 'Smartphone', 35000), 
(2, 'Laptop', 65000), 
(3, 'Headphones', 5500), 
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000); 

drop table Products

----PART A

--1. Create a cursor Product_Cursor to fetch all the rows from a products table.

declare @product_Id int, @ProductName varchar(50), @Price decimal(8,2)
declare Product_Cursor cursor
for select product_Id, Product_Name, price from Products 
open product_cursor;
declare @ProductInfo varchar(300)
fetch next from product_cursor into @product_Id, @ProductName, @Price 
while @@FETCH_STATUS = 0
begin
	select @product_Id, @ProductName, @Price 
	fetch next from product_cursor into @product_Id, @ProductName, @Price 
end
close Product_cursor
deallocate product_cursor


--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone) 

declare @productId int, @Product_Name varchar(50)
declare product_cursor_fetch cursor
for select product_Id, Product_Name from Products
open product_cursor_fetch
fetch next from product_cursor_fetch into @productid, @product_name
while @@FETCH_STATUS = 0
begin
	select cast(@productId as varchar) + '_' + @Product_Name
	fetch next from product_cursor_fetch into @productid, @product_name
end
close product_cursor_fetch
deallocate product_cursor_fetch

--3. Create a Cursor to Find and Display Products Above Price 30,000. 

declare @productId1 int, @ProductName1 varchar(100), @Price1 decimal(8,2)
declare product_cursor_gt30000 cursor
for select product_Id, Product_Name ,Price from Products where price > 30000
open product_cursor_gt30000
fetch next from product_cursor_gt30000 into @productId1, @ProductName1 , @Price1 
while @@FETCH_STATUS = 0 
begin
	select @productId1, @ProductName1, @Price1 
	fetch next from product_cursor_gt30000
end
close product_cursor_gt30000
deallocate product_cursor_gt30000


--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table. 

declare @productId2 int
declare product_cursor_delete cursor
for select product_id from Products
open product_cursor_delete
fetch next from product_cursor_delete into @productId2
while @@FETCH_STATUS = 0
begin 
	delete from Products where Product_id = @productId2
	fetch next from product_cursor_delete into @productId2
end
close product_cursor_delete
deallocate product_cursor_delete


----PART - B 

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%. 

declare @productId4 int, @ProductName2 varchar(100), @Price2 decimal(8,2)
declare product_cursor_inc10pr cursor
for select product_Id, Product_Name ,Price*1.1 from Products
open product_cursor_inc10pr
fetch next from product_cursor_inc10pr into @productId4, @ProductName2 , @Price2
while @@FETCH_STATUS = 0 
begin
	select @productId4, @ProductName2, @Price2 
	fetch next from product_cursor_inc10pr
end
close product_cursor_inc10pr
deallocate product_cursor_inc10pr


--6. Create a Cursor to Rounds the price of each product to the nearest whole number.

update products set price = 2500.5 where Product_id = 2
select * from products

declare @ProductId5 int, @price3 decimal(8,2)
declare product_cursor_round cursor
for select product_id, round(price,3) from products
open product_cursor_round
fetch next from product_cursor_round into @ProductId5, @price3
while @@FETCH_STATUS = 0
begin 
	select @ProductId5, @price3
	fetch next from product_cursor_round into @ProductId5, @price3 
end
close product_cursor_round
deallocate product_cursor_round

----PART C

--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop” (Note: Create NewProducts table first with same fields as Products table) 
select * into newProduct from products

declare @product_name6 varchar(100), @productid6 int, @price6 decimal(8,2)
declare nproduct_cursor_laptop cursor
for select product_id, product_name, price into NewProducts from products where product_name = 'laptop'
open nproduct_cursor_laptop
fetch next from nproduct_cursor_laptop into @product_name6, @productid6, @price6
while @@FETCH_STATUS = 0 
begin 
	select @product_name6,  @productid6, @price6
	fetch next from nproduct_cursor_laptop into @product_name6, @productid6, @price6
end
close nproduct_cursor_laptop
deallocate nproduct_cursor_laptop

--------DOUBT CHE AMA ^ 


--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products with a price above 50000 to an archive table, removing them from the original Products table.



-------------------------------------------------------------------------------------

------------  LAB - 5  ---------------


CREATE TABLE PersonInfo ( 
	PersonID INT PRIMARY KEY, 
	PersonName VARCHAR(100) NOT NULL, 
	Salary DECIMAL(8,2) NOT NULL, 
	JoiningDate DATETIME NULL, 
	City VARCHAR(100) NOT NULL, 
	Age INT NULL, 
	BirthDate DATETIME NOT NULL 
);

-- Creating PersonLog Table 
CREATE TABLE PersonLog ( 
	PLogID INT PRIMARY KEY IDENTITY(1,1), 
	PersonID INT NOT NULL, 
	PersonName VARCHAR(250) NOT NULL, 
	Operation VARCHAR(50) NOT NULL, 
	UpdateDate DATETIME NOT NULL, 
	FOREIGN KEY (PersonID) REFERENCES PersonInfo(PersonID) ON DELETE CASCADE 
)


-----PART A

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display a message “Record is Affected.”  

create trigger tr_Record_affected
on personInfo
after insert, update, delete
as 
begin
	print 'Record is affected'
end

insert into PersonInfo values
(101,'Jeignesh',3000.00,'2003-06-03','rajkot',45,'1996-08-23')

update PersonInfo set Age = 46 where PersonID = 101

delete from PersonInfo where PersonID = 101

drop trigger tr_record_affected

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 
   
   -- insert
create trigger tr_Recordlog_ins
on personinfo
after insert
as 
begin
	declare @personID int
	declare @personName varchar(100)
	select @personID = personId from inserted
	select @personName = personname from inserted

	insert into PersonLog values
	(@personID,@personName,'INSERT',getdate())
end

insert into PersonInfo values
(101,'Jeignesh',30000.00,'2024-10-17','rajkot',36,'1998-04-07')

	--update
create trigger tr_Recordlog_upd
on personInfo
after update
as 
begin 
	declare @personId int
	declare @personName varchar(100)
	select @personId = personID,
	@personName = personname from inserted

	insert into PersonLog values
	(@personId, @personName,'Updated',getdate())
end

update PersonInfo set Age = 39 where PersonID = 101

select * from PersonInfo

	--delete
create trigger tr_PersonLog_dlt
on personInfo
after delete
as 
begin
	declare @personId int

	select @personId = personId from inserted
	
	delete from PersonLog where PersonID = @personId
end

delete from PersonInfo where PersonID = 101

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that, log all operations performed on the person table into PersonLog. 

create trigger tr_InsteadOf
on personInfo
after delete
as 
begin
	declare @personId Int 
	declare @personName varchar(100)
	
end
--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into uppercase whenever the record is inserted. 

create or alter trigger tr_ConvertToUppercase
on personInfo
after insert
as
begin
	declare @personId int
	declare @personName varchar(100)

	select @personId = personId from inserted
	select @personname = personname from inserted

	update PersonInfo set personName = upper(PersonName) where PersonID = @personId
end

insert into PersonInfo values
(104,'Ramesh',40000.00,'2023-11-19','Morbi',36,'1998-04-07')

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table. 

create trigger tr_NoDups
on personInfo
after insert
as 
begin
	declare @personID int
	declare @personname varchar(100)
	
	select @personID = personID from inserted
	
	update PersonLog set 

end

			

--6. Create trigger that prevent Age below 18 years.

create trigger tr_Age_gt18
on personInfo
after insert
as 
begin
	insert into PersonInfo (PersonID,PersonName,Salary,JoiningDate,City,Age,BirthDate)
	select PersonID, Personname, salary, JoiningDate, City, age, birthdate from inserted
	where age>= 18
end


drop trigger tr_age_gt18



----------------------------------------------------

-----------Trigger Extra

CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)


CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);


--Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message "Employee record inserted", "Employee record updated", "Employee record deleted"

--         insert
create or alter trigger tr_display_msg
on employeedetails
after insert
as 
begin 
	print 'Employee record inserted'
end

insert into employeedetails values(101,'Jeignesh','9099222922','CSE',3600,'1998-04-07')

drop trigger tr_display_msg

--        update
create or alter trigger tr_display_msgUpd
on employeedetails
after update
as 
begin 
	print 'Employee record Updated'
end

update employeedetails set salary = 40051 where employeeId = 101

drop trigger tr_display_msgupd

--        delete

create or alter trigger tr_display_msgdlt
on employeedetails
after delete
as 
begin 
	print 'Employee record deleted'
end

delete from employeedetails where employeeId = 101


drop trigger tr_display_msgdlt

--Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the EmployeeLog table.

--insert
create or alter trigger tr_log_ins
on employeedetails
after insert
as 
begin
	declare @EmployeeID int
	declare @EmployeeName varchar(100)
	select @EmployeeID = EmployeeID from inserted
	select @EmployeeName = Employeename from inserted

	insert into EmployeeLogs values
	(@EmployeeID,@EmployeeName,'INSERT',getdate())
end

insert into employeedetails values(101,'Jeignesh','9099222922','CSE',3600,'1998-04-07')

drop trigger tr_log_ins

--update
create or alter trigger tr_log_upd
on employeedetails
after update
as 
begin
	declare @EmployeeId int
	declare @Employeename varchar(100)
	select @EmployeeId = EmployeeId, @Employeename = Employeename from inserted
	insert into Employeelogs values
	(@EmployeeId , @Employeename,'updated',getdate())
end

update employeedetails set salary = 40051 where employeeId = 101

drop trigger tr_log_upd

--delete
create or alter trigger tr_log_dlt
on employeedetails
after delete
as 
begin
	declare @employeeId int
	declare @employeeName varchar(100)
	select @employeeId = employeeId, @employeeName = employeeName from inserted
	insert into employeelogs values
	(@employeeId, @employeeName,'deleted',GETDATE())
end

delete from employeedetails where employeeId=101
drop trigger tr_log_dlt


--Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and update a bonus column in the EmployeeDetails table.

create or alter trigger tr_bonus
on employeedetails
after insert
as 
begin
	declare @employeeId int, @salary int
	select @employeeId = employeeId, @salary = salary from inserted
	update employeedetails set salary = @salary*1.1 where EmployeeId = @employeeId
end


insert into employeedetails values(102,'Naresh','9499222922','CSE',36000,'1999-04-07')

delete from employeeDetails where employeeId = 102

select * from EmployeeDetails


--Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.

create or alter trigger tr_date_null
on employeedetails
after insert
as
begin
	declare @joiningdate datetime
	select @joiningdate = joiningdate from inserted
	update employeedetails set joiningdate = getdate() where joiningdate is null
end

insert into employeedetails values(104,'Paresh','9499225922','CSE',36000,null)

drop trigger tr_date_null

--Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)

create or alter trigger tr_Validate_Contact
on employeedetails
after insert
as
begin 
	declare @contact varchar(10) 
end

-----------------------------------------------------------------------

----INSTEAD OF TRIGGER

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);

--Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.



--Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .



--Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.



--Create trigger that prevents to insert pre-release movies.



--Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.



--------------------------------------------------------------------------------------------

-------- LAB - 7 -----------

CREATE TABLE Customers ( 
	Customer_id INT PRIMARY KEY,                 
	Customer_Name VARCHAR(250) NOT NULL,         
	Email VARCHAR(50) UNIQUE                     
);

CREATE TABLE Orders ( 
	Order_id INT PRIMARY KEY,                    
	Customer_id INT,                             
	Order_date DATE NOT NULL,                    
	FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)  
);

--PART-A

--Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error. 

begin try
	declare @num int = 10, @num2 int = 0, @result int
	SET @result = @num/@num2
end try
begin catch 
	print 'Error: Cannot divide by zero'
end catch

--Try to convert string to integer and handle the error using try…catch block. 

begin try
	declare @str varchar(10) = '123'
	declare @Num int
	set @num = cast(@str as int)
end try
begin catch
	Print'Cannot convert to string'
end catch

--Create a procedure that prints the sum of two numbers: take both numbers as integer & handle exception with all error functions if any one enters string value in numbers otherwise print result. 

create or alter procedure pr_Exphandle
	@num1 varchar(10),
	@num2 varchar(10)
as 
begin
		begin try
			declare @n1 int = cast(@num1 as int)
			declare @n2 int = cast(@num2 as int)
			declare @sum int
			set @sum = @n1+@n2
			print @sum
		end try
		begin catch
			print 'Cannot accept string in integer'
		end catch
end

pr_exphandle 2,'5'

--Handle a Primary Key Violation while inserting data into customers table and print the error details such as the error message, error number, severity, and state. 

insert into customers values(101,'ravi','abc@gmail.com')


begin try 
	insert into customers(customer_Id, customer_name, Email)
	values(101,'jeel','asd@gmail.com')
end try
begin catch
	print 'cannot enter a duplicate primary key'
	print 'Error Number: ' + cast(Error_number() as nvarchar(10))
	print 'error severity: ' + cast(error_severity() as nvarchar(10))
	print 'error state: '+ cast(error_state() as nvarchar(10))
	print 'error message: ' + cast(error_message() as nvarchar(10))
end catch
	

--Throw custom exception using stored procedure which accepts Customer_id as input & that throws Error like no Customer_id is available in database. 

create or alter procedure pr_IdNotAvailable
	@CstId int
as 
begin
	if not exists (select * from customers where customer_id = @CstId)		
	begin 
		throw 50002, 'CID not found',1
	end
	else
	begin
		print 'CID found'
	end 
end

pr_Idnotavailable 105


------ PART-B-------

-- Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error message. 

insert into customers values(101,'ravi','abc@gmail.com')


begin try 
	insert into orders(order_Id, customer_id, Order_date)
	values(105,1023,'2024-04-08')
end try
begin catch
	print 'cannot find refernce for foreign key'
	print 'Error Number: ' + cast(Error_number() as nvarchar(10))
	print 'error severity: ' + cast(error_severity() as nvarchar(10))
	print 'error state: '+ cast(error_state() as nvarchar(10))
	print 'error message: ' + cast(error_message() as nvarchar(10))
end catch

-- Throw custom exception that throws error if the data is invalid. 

create procedure pr_InvalidData
	@value int
	as begin
	if @value<0 
	begin
		throw 213132, 'Data cannot be negative',1
	end
	else
	begin
		print 'Data is valid'
	end
end

pr_invalidData 2

-- Create a Procedure to Update Customer’s Email with Error Handling

create or alter procedure pr_EmailUpdate
	@Email varchar(50)
as 
begin
	if @Email in (select email from customers)
	begin
		throw 120321, 'Cannot update email',1
	end
	else begin
		update customers set email = @Email
		print 'Email Updated'
	END
end

pr_emailUpdate 'abs@gmailcom'

select * from customers


--------PART-C

--Create a procedure which prints the error message that “The Customer_id is already taken. Try another one

begin try 
	insert into customers(customer_Id, customer_name, Email)
	values(101,'jeel','asd@gmail.com')
end try
begin catch
	print 'Customer_Id not available'
	print 'Error Number: ' + cast(Error_number() as nvarchar(10))
	print 'error severity: ' + cast(error_severity() as nvarchar(10))
	print 'error state: '+ cast(error_state() as nvarchar(10))
	print 'error message: ' + cast(error_message() as nvarchar(10))
end catch

--Handle Duplicate Email Insertion in Customers Table.

create or alter procedure pr_DuplicateUpdate
	@Email varchar(50)
as 
begin
	if @Email in (select email from customers)
	begin
		throw 120321, 'Cannot update email',1
	end
end

pr_emailUpdate 'abs@gmailcom'

select * from customers
