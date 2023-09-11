
								-- 11-08-2023
---------------------------------------------------------------------------
/* TEXT FUNCTIONS:
======================================= */
SELECT REF_NO,
LEFT(REF_NO, 2) AS COUNTRY_CODE,
RIGHT(REF_NO, 6) AS ORD_ID,
SUBSTRING(REF_NO, 4, 4) AS YEARS
FROM TBL_ORDER

-- FIRST & LAST NAME OF THE CUSTOMERS:

SELECT CUST_NAME , LEFT(CUST_NAME, CHARINDEX(' ', CUST_NAME)-1 ) AS FIRST_NAME,
RIGHT( CUST_NAME, LEN(CUST_NAME)- CHARINDEX(' ', CUST_NAME) ) AS LAST_NAME
FROM TBL_ORDER

-- FIND THE POSITION OF FIRST & SECOND HYPHEN IN REF_NO.
SELECT REF_NO, CHARINDEX('-', REF_NO) AS HYPHEN_1,
CHARINDEX( '-', REF_NO, CHARINDEX('-', REF_NO)+1 ) AS HYPHEN_2
FROM TBL_ORDER

-- REPLACE THE HYPHEN IN REF_NO WITH UNDERSCORE.
SELECT REF_NO,
REPLACE(REF_NO, '-', '_') AS NEW_REF_NO
FROM TBL_ORDER

-- HIDE THE ORDER ID FROM REF_NO WITH 'XXXXXXXXXXXXXX'.
SELECT REF_NO, STUFF(REF_NO, 9, 6, 'XXXXXXXXXX') AS NEW_REF_NO
FROM TBL_ORDER

					-- DATE FUNCTIONS:
================================================================================
-- DATEADD():

SELECT ORD_DTE,
DATEADD(MONTH, 5, ORD_DTE) AS FUTURE_DATE,
DATEADD(MONTH, -6, ORD_DTE) AS PAST_DATE
FROM TBL_ORDER

-- DATEDIFF():

SELECT ORD_DTE,
DATEDIFF(YEAR, ORD_DTE, GETDATE()) AS ORDER_AGE
FROM TBL_ORDER

-----------------------------------------------------------------------------
			-- DATA TYPE CONVERSION FUNCTIONS
-------------------------------------------------------------------------------
/* There are 2 types of data conversion functions:
		1. CAST():
		------------
				
				Syntax:
						CAST( column_name AS new_dtype)

					Q: Change the data type of sales to whole number.
					A:
							CAST(SALES AS int)
		2. CONVERT():
		----------------

				Syntax:
						CONVERT(new_dtype, column_name, [informat])
							where informat: input format

					a. If the first 2 parameters are used from Convert(), it will act 
					same as that of cast()

					b. The optional parameter is used while working with DATES.
*/

-- Q: Change the data type of sales so that it show only 2 decimal values.
SELECT SALES, ROUND(SALES, 2) AS NEW_SALES
FROM TBL_ORDER

-- ANS:
		SELECT SALES, ROUND( CAST(SALES AS FLOAT), 2 ) AS NEW_SALES1,
				     ROUND( CONVERT( FLOAT, SALES), 2 ) AS NEW_SALES2
		FROM TBL_ORDER

		-- First, convert the sales into float so that unnecessary 0s can be removed.
		-- Then, round off the numbers upto required decimal places.

----------------------------------------------------------------------------------
							-- WORKING WITH DATES
-----------------------------------------------------------------------------------
SELECT '05-08-2023' AS DATE1,
CAST( '05-08-2023' AS DATE) AS DATE2,  -- WRONG
CONVERT(DATE, '05-08-2023', 105) AS DATE3

SELECT '21-10-2023' AS DATE1,
CAST( '21-10-2023' AS DATE) AS DATE2  -- ERROR!

SELECT '21-10-2023' AS DATE1,
FORMAT( CONVERT( DATE, '21-10-2023',105), 'dd-MMMM-yyyy') AS DATE2

-----------------------------------------------------------------------------------
		                     -- SUB QUERY
------------------------------------------------------------------------------------
/* SUB-QUERY: A query within a Query.
Always written with ().

	There are 3 types of sub-queries:

				a. Ordinary Subquery:
						When a subquery is written within:
								SELECT, WHERE or HAVING

				b. Inline-View Subquery:
						When  a subquery is written within:
								FROM

				c. Co-Related Subquery:
						Its rarely used because it results in CARTESIAN Product.
*/

-- Q: Find the Total Sales by each category.
SELECT CATEGORY, SUM(SALES) AS TOTAL_SALES
FROM TBL_ORDER
GROUP BY CATEGORY

-- Q: Find the Total Sales from the given data.
SELECT SUM(SALES) AS OVERALL_SALES
FROM TBL_ORDER

-- Q: Find the %age of Sales done by each category.
SELECT CATEGORY, SUM(SALES) AS TOT_SALES,
SUM(SALES) /  ( SELECT SUM(SALES ) FROM TBL_ORDER ) as [SALES%]
FROM TBL_ORDER
GROUP BY CATEGORY

--Q: Find the products who have generates sales > average sales.
SELECT PRODUCT, SUM(SALES) AS TOT_SALES
FROM TBL_ORDER
GROUP BY PRODUCT
HAVING SUM(SALES) > ( SELECT AVG(sALES) FROM TBL_ORDER) 

SELECT TOT_SALES 
FROM (
		SELECT CATEGORY, SUM(SALES) AS TOT_SALES
		FROM TBL_ORDER
		GROUP BY  CATEGORY
	) AS X

SELECT *, DATEDIFF(YEAR, ORD_DTE, CURR_DTE) AS DIFFERENCES
FROM ( 
		SELECT ORD_DTE, GETDATE() AS CURR_DTE 
		FROM TBL_ORDER
	) AS DEMO

---------------------------------------------------------------------------------
					-- CALCULATED FIELDS | CONDITIONAL COLUMNS:
------------------------------------------------------------------------------
/* A new column  based on conditions can be created using:
		CASE WHEN THEN ELSE END
		- It is also used for GROUPS & BINS.

		Syntax:
				CASE
					WHEN condition1 THEN true_value1
					WHEN condition2 THEN true_value2
					..........
					.........
					ELSE false value
				END
*/

-- Q: Categorize the Sales as HIGH or LOW based on the cutoff 2100.
			-- EXCEL:  if( sales > 2100, "high", "low")

SELECT * , 
CASE 
	WHEN SALES > 2100 THEN 'HIGH'
	ELSE 'LOW'
END   AS LABELS
FROM TBL_ORDER

-- Q: Categorise the products as:
		-- cat1 : accessories, binders & tables
		-- cat2 : phones, machines
		-- others: left overs

SELECT * INTO prod_info
FROM (
		SELECT *,
		CASE
			WHEN PRODUCT IN ('ACCESSORIES', 'BINDERS', 'TABLES') THEN 'CAT1'
			WHEN PRODUCT IN ('PHONES', 'Machines') THEN 'CAT2'
			ELSE 'OTHERS'
		END  AS CATEGORIES
		FROM TBL_ORDER
) AS X












