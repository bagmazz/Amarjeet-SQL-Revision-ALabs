--------------- SET 1 ---------------------------

-- 1. Create database “CustomerDatabase”. 

Create database Customer_Database

-- 2. Create a table called “Customer”. 
create table Customer ( Id int identity(1,1) not null primary key, FirstName nvarchar(40) not null, LastName nvarchar(40)
not null, City nvarchar(40) null, Country nvarchar(40) null , Phone nvarchar(20) null)  
     
select * from Customer

-- 3. For the table created above, insert the following values

insert into Customer values ('Maria','Anders','Berlin','Germany','030-0074321'),
       ('Ana','Trujillo','Mexico D.F.','Mexico','(5) 555-4729'),
	('Antonio','Moreno','Mexico D.F.','Mexico','(5) 555-3932'),
	('Thomas','Hardy','London','UK','(171) 555-7788'),
	('Christina','Berglund','Lulea','Sweden','0921-12 34 65'),
	('Hanna','Moos','Mannheim','Germany','0621-08460'),
	('Frederique','Citeaux','Strasbourg','France','88.60.15.31'),
	('Martín','Sommer','Madrid','Spain','(91) 555 22 82'),
	('Laurence','Lebihan','Marseille','France','91.24.45.40'),
	('Elizabeth','Lincoln','Tsawassen','Canada','(604) 555-4729')

-- 4.	Write a Query to Display the records in the customer table.
	select * from Customer

-- 5.	Thomas Hardy who resides in London, UK has now moved to Berlin, Germany. Update the city and Country of Thomas Hardy.

	update Customer set city= 'Berlin' , Country = 'Germany' where FirstName = 'Thomas'

-- 6.	Now, Add a column Date_of_birth of type date.  
	Alter table customer add Date_of_Birth date

-- 7.	Update the Date_of_birth column ‘1992-12-25’ for customers in Germany and ‘1992-10-20’ for customers in other countries. 
--Note that you should write two update statements.

	update Customer set date_of_birth = '1992-12-25' where country = 'germany'
	update Customer set date_of_birth = '1992-10-20' where country != 'germany'

-- 8. and 9. 	Create a new table “CustomerDB” with the same design as that of “Customer” table that you created above.
	select * into CustomerDB from Customer

	select * from CustomerDB

-- another method first create and then Insert into CustomerDb Select * from Customer;

-- 10. Rename the ID column name to CustomerID in the “Customer” table.
	SP_RENAME 'CUSTOMER.[FirstName]' , '[FirstName]','COLUMN' 

-- 11. Change the data type for FirstName and LastName field in “Customer” table from nvarchar(40) to nvarchar(50).

	ALTER TABLE Customer alter COLUMN FirstName nvarchar(50)
	ALTER TABLE Customer alter COLUMN LastName nvarchar(50)
 
 --------------------- SET 2 -----------------------------------


