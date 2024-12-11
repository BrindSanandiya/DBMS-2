
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
SELECT ARTIST_ID,COUNT(ALBUM_TITLE) AS TOTAL_ALBUMS FROM ALBUMS GROUP BY ARTIST_ID;

--Retrieve the Album_id which has more than 5 songs in it.
SELECT ALBUM_ID,COUNT(SONG_ID) AS NOOFSONGS FROM SONGS GROUP BY ALBUM_ID HAVING COUNT(ALBUM_ID)>3;

--Retrieve all songs from the album 'Album1'. (using Subquery)
SELECT SONG_TITLE FROM SONGS WHERE ALBUM_ID IN(SELECT ALBUM_ID FROM ALBUMS WHERE ALBUM_TITLE='ALBUM1');

--Retrieve all albums name from the artist ‘Aparshakti Khurana’ (using Subquery)
SELECT ALBUM_TITLE FROM ALBUMS WHERE ARTIST_ID IN(SELECT ARTIST_ID FROM ARTISTS WHERE ARTIST_NAME='Aparshakti Khurana');

--Retrieve all the song titles with its album title.
SELECT SONGS.SONG_TITLE,ALBUMS.ALBUM_TITLE
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=ALBUMS.ALBUM_ID;

--Find all the songs which are released in 2020.
SELECT SONGS.SONG_TITLE,ALBUMS.RELEASE_YEAR
FROM ALBUMS JOIN SONGS 
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE RELEASE_YEAR=2020;

--Create a view called ‘Fav_Songs’ from the songs table having songs with song_id 101-105.
CREATE VIEW FAV_SONGS AS SELECT SONG_ID,SONG_TITLE FROM SONGS WHERE SONG_ID BETWEEN 101 AND 105;

--19. Update a song name to ‘Jannat’ of song having song_id 101 in Fav_Songs view.
UPDATE FAV_SONGS SET SONG_TITLE='JANNAT' WHERE SONG_ID=101;

--20. Find all artists who have released an album in 2020.
SELECT ARTISTS.ARTIST_NAME,ALBUMS.RELEASE_YEAR FROM ARTISTS JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID WHERE RELEASE_YEAR=2020;

--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
SELECT ARTISTS.ARTIST_NAME,SONGS.DURATION,ALBUMS.ALBUM_ID FROM ARTISTS 
JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
WHERE ARTIST_NAME='SHREYA GHOSHAL' ORDER BY DURATION;

-----------------------------------------------Part-B-------------------------------------------------
--22. Retrieve all song titles by artists who have more than one album.
SELECT SONGS.SONG_TITLE,COUNT(ALBUMS.ALBUM_ID) FROM SONGS 
JOIN ALBUMS ON SONGS.ALBUM_ID=ALBUMS.ALBUM_ID
JOIN ARTISTS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
GROUP BY SONGS.SONG_TITLE HAVING COUNT(ALBUMS.ALBUM_ID)>1;

--23. Retrieve all albums along with the total number of songs.
SELECT ALBUMS.ALBUM_TITLE,COUNT(SONGS.SONG_TITLE) AS TOTALSONGS FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID GROUP BY ALBUM_TITLE;

--24. Retrieve all songs and release year and sort them by release year.
SELECT SONGS.SONG_TITLE,ALBUMS.RELEASE_YEAR
FROM ALBUMS JOIN SONGS
ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
ORDER BY RELEASE_YEAR;

--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs.
SELECT GENRE,COUNT(SONG_TITLE) AS MORETHAN2SONGS
FROM SONGS
GROUP BY GENRE
HAVING COUNT(SONG_TITLE)>2;

--26. List all artists who have albums that contain more than 3 songs.
SELECT ARTISTS.ARTIST_NAME,COUNT(SONGS.SONG_TITLE)
FROM ARTISTS JOIN ALBUMS
ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ARTIST_NAME
HAVING COUNT(SONGS.SONG_TITLE)>3;

-----------------------------------------------Part-C-------------------------------------------------
--27. Retrieve albums that have been released in the same year as 'Album4'
select Album_title from Albums where Release_year = (select Release_year from Albums where Album_title = 'Ablum4')

--28. Find the longest song in each genre
SELECT GENRE,MAX(DURATION)
FROM SONGS
GROUP BY GENRE;

--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title.
select Song_title,Album_title from SONGS s join Albums a on s.Album_id = a.Album_id where Album_title like '%album%'  

--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes.
SELECT ARTISTS.ARTIST_NAME,SUM(SONGS.DURATION) AS TOTAL_DURATION
FROM ARTISTS JOIN ALBUMS ON ARTISTS.ARTIST_ID=ALBUMS.ARTIST_ID
JOIN SONGS ON ALBUMS.ALBUM_ID=SONGS.ALBUM_ID
GROUP BY ARTIST_NAME
HAVING SUM(SONGS.DURATION)>15.00;



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
