
				-- WINDOWS FUNCTIONS
--------------------------------------------------------------------
SELECT * FROM TBL_ORDER
-- Q: find the category wise sales but also retain the actual sales data.

SELECT CATEGORY, SALES, SUM(SALES) OVER(PARTITION BY  CATEGORY) AS TOTAL_SALES 
FROM TBL_ORDER

-- VALUE WINDOW FUNCTIONS:
			-- To find the first, last, previous & next values fom the table.
			-- Used with LAG(), LEAD()
			--	LEAD(): 
/*						It finds the immediate next record value by default, or we can find
						nth next value as well.
						NULL will be at the end of the table.
				 LAG():
						It finds the immediate previous record value by default, or  we can
						find the nth previous value as well.
						NULL will be the top of the table.
*/
SELECT *, SALES- NEXT_SALES AS DIFFERENCE_SALES
FROM( 
		SELECT *,
		LEAD(SALES, 1) OVER( ORDER BY ORD_DTE ASC) AS NEXT_SALES,
		LAG(SALES, 1) OVER( ORDER BY ORD_DTE ASC) AS PREV_SALES
		FROM TBL_ORDER
) AS X

SELECT *,
LEAD(SALES, 3) OVER( ORDER BY ORD_DTE ASC) AS NEXT_SALES,
LAG(SALES, 3) OVER( ORDER BY ORD_DTE ASC) AS PREV_SALES
FROM TBL_ORDER

-------------------------------------------------------------------------------
-- Q: Find the year wise difference in sales for each month.
-- To get the difference in %age= (CURRENT - PREV)/PREV*100
SELECT *,
LAG(TOT_SALES, 1) OVER(PARTITION BY YEARS ORDER BY MONTHS ASC) AS PREV_SALES,
TOT_SALES - LAG(TOT_SALES, 1) OVER( PARTITION BY YEARS ORDER BY MONTHS ASC)  AS DIFF_SALES
--( TOT_SALES - LAG(TOT_SALES, 1) OVER( PARTITION BY YEARS ORDER BY MONTHS ASC))/
--LAG(TOT_SALES, 1) OVER( PARTITION BY YEARS ORDER BY MONTHS ASC) *100 AS [%age Difference]
FROM (
	SELECT YEAR(ORD_DTE) AS YEARS, MONTH(ORD_DTE) AS MONTHS, SUM(SALES) AS TOT_SALES 
	FROM TBL_ORDER
	GROUP BY MONTH(ORD_DTE), YEAR(ORD_DTE)
) AS X

--ORDER BY YEARS, MONTHS
-----------------------------------------------------------------------------------------
					-- CTE: COMMON TABLE EXPRESSIONS
-----------------------------------------------------------------------------------------
/*   -> It is a VIRTUAL TABle, just like a regular table.
     -> CTE is a query which is executed before the main query, i.e. SELECT statement.
	 -> Created using WITH clause.

	 -> TYPES:
				i. Static CTE : used by analyst
				ii. Recursive CTE : used by developers

	-> Syntax:
				WITH <cte_name> AS
				(
						statement/s
						......
						.....
				)
				SELECT * FROM <cte_name>

							OR
				WITH <cte_name1> AS
				(
						statement/s
						......
						.....
				),
				<cte_name2> AS
				(
						statement/s
						select * from cte_name1
						where col_name = 4
						.....
				)
				SELECT * FROM <cte_name2>
*/
WITH CUST_INFO 
AS (
	SELECT 101 AS ID, 'john' as [NAME], 23 AS AGE, 1234 AS PINCODE
	union all
	SELECT 102 AS ID, 'sMITH' as [NAME], 32 AS AGE, 1224 AS PINCODE
	union all
	SELECT 103 AS ID, 'maRY' as [NAME], 36 AS AGE, 1334 AS PINCODE
	union all
	SELECT 104 AS ID, 'aNDY' as [NAME], 39 AS AGE, 1234 AS PINCODE
)
SELECT * FROM CUST_INFO
WHERE PINCODE = 1234

-------------------

SELECT *, SALES- NEXT_SALES AS DIFFERENCE_SALES
FROM( 
	SELECT *,
	LEAD(SALES, 1) OVER( ORDER BY ORD_DTE ASC) AS NEXT_SALES
	FROM TBL_ORDER
) AS X


-- WITH CTE:

WITH NEXT_SALES 
AS (
	SELECT *,
	LEAD(SALES, 1) OVER( ORDER BY ORD_DTE ASC) AS NEXT_SALES
	FROM TBL_ORDER
)
SELECT * , SALES - NEXT_SALES AS DIFFERENCE_SALES
FROM NEXT_SALES

-------------------------------------------------------------------------------------
						-- VIEWS
--------------------------------------------------------------------------------------
/*
		-> VIEW is a virtual table, but it gets storage in the database server.
		-> Its like an actual table itself, with one difference:
					Actual table is protected by this VIEW(virtual table).

		-> Advantages | Uses of views:
				i. View act as a filter on the actual or raw table, i.e. if we need to
				make changes in the raw table, we can create copy of it & then update that
				copy. Hence, original table is protected from modifications.

				ii. Restricted access to the table.

				iii. If someone doesnt have the knowledge of JOINS, views can be used to
				join the tables without actualy using any type of join.

	SYNTAX TO CREATE A VIEW:
	-----------------------

			CREATE VIEW <view_name>
			AS
				DML OPERATIONS --> SELECT, INSERT, UPDATE, DELETE

			SELECT * FROM <view_name>
*/

SELECT * FROM TBL_ORDER

-- Q: Show the data for Technology category and store it in a table.
CREATE VIEW Technology_data
AS
	SELECT * FROM TBL_ORDER
	WHERE CATEGORY = 'TECHNOLOGY'

SELECT * FROM Technology_data

-- Q: Create a view that shows the data of those products whose sales is more than 
-- average sales.
CREATE VIEW [Products above avg sales]
AS
	SELECT * FROM TBL_ORDER
	WHERE SALES > ( SELECT AVG(SALES) FROM TBL_ORDER)

SELECT * FROM [Products above avg sales]

-- WITHOUT VIEW:
	SELECT * INTO [Products_avg_sales]
	FROM TBL_ORDER
	WHERE SALES > ( SELECT AVG(SALES) FROM TBL_ORDER)

SELECT * FROM Products_avg_sales

-- Q: Join the tables customer & house without explicit use of any type of join.
SELECT * FROM TBL_CUSTOMER
SELECT * FROM TBL_HOUSE

CREATE VIEW [Customer House Info]
AS
	SELECT CUST_ID_CUS, FNAME_CUS + ' ' +  LNAME_CUS AS CUST_NAME, DOB_CUS, PHONE_CUS,
	EMAIL_CUS, HOUSE_ID_HSE, ADDRESS_HSE, CITY_HSE, COUNTRY_HSE
	FROM TBL_CUSTOMER, TBL_HOUSE
	WHERE CUST_ID_CUS = CUST_ID_HSE

SELECT * FROM [Customer House Info]

-- limitations of views:
/*
		1.View can only be created if one have the access to the table.
		2. At max, a view can have 1024 columns.
		3. View can be created in the current d/b only.
*/

---------------------------------------------------------------------------------------
			             -- STORED PROCEDURES
-------------------------------------------------------------------------------------
/* PROCEDURE:
				A set of instructions to execute a task.
	STORED PROCEDURES:
				-> It is used to execute the DML operations.
				-> It will execute the plan once, but gives the output multiple times.

	BENEFITS:
				1. Created to perform a task multiple times.
				2. Better efficiency:
							The logic will be saved in a buffer after the execution. For the 
							next time, the code will give the results without executing the plan
							again

SYNTAX FOR STORED PROCEDURE:
				
				-- execute only once:
				CREATE PROCEDURE < proc_name> (parameter/s ---> @ VARIABLE DTYPE)
				AS
					Statements
					.....
					.....

				-- executed multiple times after providing different values.
				EXEC <proc_name> Parameter = value

*/

-- Q: FIND THE TOP N PRODUCTS WITH MAXIMUM SALES.
SELECT TOP 4 PRODUCT, SUM(SALES) AS TOT_SALES 
FROM TBL_ORDER
GROUP BY PRODUCT
ORDER BY TOT_SALES DESC

-- WITH STORED PROCEDURE:

CREATE PROCEDURE [TOP N PRODUCTS] @N INT
AS
		SELECT TOP (@N) PRODUCT, SUM(SALES) AS TOTAL_SALES
		FROM TBL_ORDER
		GROUP BY PRODUCT
		ORDER BY TOTAL_SALES DESC

EXEC [TOP N PRODUCTS] @N = 5

-- Q: SHOW THE DATA FOR THE CATEGORY CHOSEN  BY USER DURING THE EXECUTION. ( 1 PARAMETER)

CREATE PROCEDURE [CATEGORY_INFO] @CAT VARCHAR(20)
AS
		SELECT * FROM TBL_ORDER
		WHERE CATEGORY = @CAT

EXEC CATEGORY_INFO @CAT = 'FURNITURE'

-- Q: SHOW THE DATA FOR THE CATEGORY & PRODUCT CHOSEN BY THE USER. (2 PARAMETERS)
CREATE PROCEDURE [ CATEGORY_PROD_INFO] @CAT VARCHAR(20), @PROD VARCHAR(20)
AS
	SELECT * FROM TBL_ORDER
	WHERE CATEGORY = @CAT AND PRODUCT = @PROD

EXEC [ CATEGORY_PROD_INFO] @CAT = 'FURNITURE', @PROD = 'CHAIRS'

--------------------------------------------------------------------------------------
				             -- CURSORS
----------------------------------------------------------------------------------------
/* 
- For all SQL statements, the execution steps are stored in a memory area, called
  CONTEXT AREA.
- Cursor is a pointer to this context area, through which we can fetch the results row wise.
- Cursor will point to one row at a time.

-- TYPES OF CURSORS:
		
		IMPLICIT CURSOR                               EXPLICIT CUSRSOR
    --------------------------------------------------------------------------
	- Created automatically by                     - Created by the user
	  Oracle server.

	- Server has the full control                  - Controlled by the user.
	  of the cursor.

	- Server will automatically                   - User has to open & close the 
	  open & close the cursor.                      cursor.

	- Attributes:                                - Attributes:
			SQL%Found									%ISOPEN
			SQL%notfound								%ISCLOSED
			SQL%ISOPEN									%NOTFOUND
			.......                                      .......

-- SYNTAX TO CREATE A CURSOR

1. Create the cusror:

		DECLARE <cursor_name> CURSOR
		FOR
			statements
			.......
			........
2. Open the cusror:
		
		OPEN <cusror_name>

3. Fetch the data from the context area:
		FETCH NEXT|PREVIOUS|LAST|FIRST from <cursor_name>

4. Close the cursor:
		
		CLOSE <cursor_name>

5. De-allocate the cursor:
	DEALLOCATE <cursor_name>
*/

-- 1. CREATE CURSOR
DECLARE ORDERS_INFO CURSOR
FOR
	SELECT * FROM TBL_ORDER

-- 2. OPEN CURSOR:
OPEN ORDERS_INFO

-- 3. FETCH THE DATA:
FETCH NEXT FROM ORDERS_INFO

-- 4. CLOSE CURSOR:
CLOSE ORDERS_INFO

-- 5. DEALLOCATE CURSOR:
DEALLOCATE ORDERS_INFO







