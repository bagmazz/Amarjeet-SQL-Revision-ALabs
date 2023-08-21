
							-- DDL Statements:
--------------------------------------------------------------------------------
-- 1. CREATE DATABASE:
CREATE DATABASE PG_BATCH_2;

-- 2. Make database active:
USE PG_BATCH_2;

-- 3. CREATE TABLE:
create table customer ( Cust_id int, [Name] varchar(50), Age int, 
						Gender bit, Region char)

-- DML STATMENT----> SELECT
--------------------------------------------------------------
SELECT * FROM customer

-- 4. DROP TABLE:
DROP TABLE customer

-- DROP DATABASE:
DROP DATABASE PG_BATCH_2

-- 5. TRUNCATE:

-- Q: REMOVE ALL THE RECORDS FROM CUSTOMER TABLE:
TRUNCATE TABLE CUSTOMER

-----------------------------------------------------------------------
						-- DML STATEMENTS:
-----------------------------------------------------------------------
-- 1. INSERT :
INSERT INTO CUSTOMER VALUES (101, 'RAMESH', 34, 0, 'N')

select * from customer

INSERT INTO CUSTOMER VALUES ( 102, 'SACHIN', 45, 0, 'W') ,
							(103, 'AJAY', 40, 0, 'S'),
							(104, 'SEEMA', 23, 1, 'E')

-- 2. UPDATE:

--Q: Update the age of the customer to 32 whose id = 104 .
UPDATE CUSTOMER SET AGE = 32 
WHERE CUST_ID =  104

--3. DELETE:

-- Q: DELETE THE RECORD FROM THE CUSTOMET TABLE WHOSE ID = 102.

DELETE FROM CUSTOMER WHERE CUST_ID = 102

SELECT * FROM CUSTOMER

-- Q: REMOVE ALL THE RECORDS FROM THE CUSTOMER TABLE.
DELETE FROM CUSTOMER

---------------------------------------------------------------------------------------
					-- CONSTRAINTS IN SQL
---------------------------------------------------------------------------------------
/*
	- Validate the data | check the integrity of the data.

	1. IDENTITY:
				To perform auto-increment on the column.
				In MySQl/Orcale: for auto increment, there is AUTO NUMBER.

	2. PRIMARY KEY:
				To make any column as a Primary key
	3. FOREIGN KEY:
				To make a column of a table as Foreign Key refering to the
				Primary Key of the other table.
	4. UNIQUE:
				A Column will not allowed to have a duplicate data.
	5. CHECK:
				Condition checking on the column
				AGE int CHECK ( AGE>= 18 & AGE <= 60)
	6. DEFAULT:
				If a record doesn't get a value, then instead of having NULL,
				we can provide default data as:
					PHONE varchar(10) DEFAULT '000000000'
	7. NOT NULL:
				A condition to make sure that the column doesn't accept
				null values
				eg: NAME varchar(50) NOT NULL;

*/

CREATE TABLE EMPLOYEE (EMP_ID INT PRIMARY KEY IDENTITY(1001, 1),
					   [NAME] VARCHAR(50) NOT NULL, 
					   AGE INT, SALARY FLOAT,
					   GENDER CHAR(1), 
					   PHONE CHAR(10) UNIQUE DEFAULT '000000' )

INSERT INTO EMPLOYEE VALUES ('ANDY', 34, 3456.78, 'M', '9876543210')

--SELECT * FROM EMPLOYEE

INSERT INTO EMPLOYEE VALUES ('ANDREA', 28, 4456.78, 'F', '9876543211')

INSERT INTO EMPLOYEE VALUES ('SMITH', 45, 9456.78, 'M', '9876543222'),
						    ('JOHN', 56, 10056.78, 'M', '8876543222')

INSERT INTO EMPLOYEE ( [NAME], AGE, SALARY, GENDER  )
				VALUES ('JOHN. M', 56, 9056.78, 'M')

--DROP TABLE EMPLOYEE

-- DELETE THE LAST RECORD FROM THE TABLE.
DELETE FROM EMPLOYEE WHERE EMP_ID = 1005

INSERT INTO EMPLOYEE ( [NAME], AGE, SALARY, GENDER  )
				VALUES ('JOHN. M', 56, 9056.78, 'M')
SELECT * FROM EMPLOYEE

-- TRUNCATE THE RECORDSFROM THE TABLE.
TRUNCATE TABLE EMPLOYEE

-- DROP THE TABLE EMPLOYEE.
DROP TABLE EMPLOYEE


-- TRANSACTION:

BEGIN TRAN
	delete from Employee
	Rollback

SELECT * FROM EMPLOYEE

--------------------------------------------------------------------
						-- SELECT STATEMENT
-----------------------------------------------------------------
/* There are 2 syntax for SELECT :

		a. SELECT * FROM <tb_name>
			where * : every column

			SELECT col1, col2,... FROM <tb_name>

		b. SELECT * FROM <tb_name>
		   WHERE constraints| condition/s
		   GROUP BY col1, col2, ....
		   HAVING condition/s
		   ORDER BY col1, col2, ....

*/

SELECT * FROM EMPLOYEE

-- Q: DISPLAY THE EMPLOYEE ID, NAME & SALARY FROM EMPLOYEE TABLE  (SUBSETTING)
SELECT EMP_ID, [NAME], SALARY
FROM EMPLOYEE

-- Q: DISPLAY THE EMPLOYEE INFO WHOSE SALARY > 9999. (FILTER)
SELECT * FROM EMPLOYEE
WHERE SALARY > 9999

-- Q: DISPLAY THE DATA OF THOSE EMPLOYEES WHO ARE MALE & HAVING SALARY > 7700.
SELECT * FROM EMPLOYEE
WHERE GENDER = 'M' AND SALARY > 7700

-- Q: DISPLAY THE TOTAL SALARY OF MALES & FEMALES.
SELECT GENDER, SUM(SALARY)AS [TOTAL SALARY] , SUM(AGE) AS TOT_AGE
FROM EMPLOYEE  
GROUP BY GENDER

						    