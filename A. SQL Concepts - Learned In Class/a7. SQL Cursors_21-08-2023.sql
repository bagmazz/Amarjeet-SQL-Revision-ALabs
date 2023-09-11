
--LAST CLASS TOPICS:
------------------------------------------------------------------
/* 1. LEAD(), LAG()
   2. CTES
   3. VIEWS
   4. STORED PROCEDURES
   5. CURSORS
			IMPLICIT & EXPLICIT

		STEPS:
			1. create the cursor
				declare cusrso_name cursor
				for
					......
			2. open cursor
			3. fetch next/previous/last/first from curso_name
			4. close cursor
			5. deallocate cursor

*/

-- Q: Create 2 variable that store the ID & Salary of the employee. Create a cursor now
-- to hold the results of the query that retrieves the ID & salary from the emp_table.
-- Also, print the said information as a meaningful message.


-- CREATING VARIABLES:
DECLARE
		@ID INT, @SAL FLOAT

-- CREATE CURSOR:
DECLARE EMP_INFO2 CURSOR
FOR
		SELECT EMP_ID, SALARY
		FROM EMPLOYEE

-- OPEN CURSOR:
OPEN EMP_INFO2

-- FETCHING THE RESULTS:
FETCH NEXT FROM EMP_INFO2
INTO @ID, @SAL

WHILE @@FETCH_STATUS = 0

	BEGIN
		PRINT 'ID = ' + CAST(@ID AS VARCHAR(10) ) + ' ,' + 
		'SALARY = ' + CAST( @SAL AS VARCHAR(20) )
		
		FETCH NEXT FROM EMP_INFO2
		INTO @ID, @SAL

	END

-- CLOSE THE CURSOR:
CLOSE EMP_INFO2

-- DEALLOACTE CURSOR:
DEALLOCATE EMP_INFO2

							-- SCROLL CURSOR:
-------------------------------------------------------------------------------------
-- CREATE THE SCROLL CURSOR:
DECLARE SALARY_INFO SCROLL CURSOR
FOR
		SELECT EMP_ID, SALARY
		FROM EMPLOYEE

-- OPEN CURSOR:
OPEN SALARY_INFO

-- FETCH THE RECORDS:
FETCH LAST FROM SALARY_INFO  -- DATA FROM LAST ROW

FETCH PRIOR FROM SALARY_INFO  -- IMMEDIATE PRIOR ROW FROM THE CURRENT ROW

FETCH ABSOLUTE 2 FROM SALARY_INFO -- DATA FROM THE 2ND ROW

FETCH RELATIVE 3 FROM SALARY_INFO  -- 3 ROWS AFTER THE CURRENT ROW

FETCH RELATIVE -2 FROM SALARY_INFO  --2 ROWS PRIOR THE CURRENT ROW.

-- CLOSE THE CURSOR
CLOSE SALARY_INFO


----------------------------------------------------------------------------
SELECT * FROM customer

-- Q: Create 3 variable that store the ID, AGE & GENDER of the customer (customer table). 
-- Create a cursor now to hold the results of the query that retrieves the ID, age, gender 
-- from the customer. Also, print the said information as a meaningful message.









