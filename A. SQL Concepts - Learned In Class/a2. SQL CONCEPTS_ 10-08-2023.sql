
								-- 10-08-2023
--------------------------------------------------------------------------------
-- last class topics:

/* 1. SQL Commands
   2. Delete vs. Drop vs.Truncate
   3. Constraints:
			a. identity
			b. Primary key
			c. Foreign key
			d. Default
			e. check
			f. not null
			g. unique
	4. char vs. varchar
	5. Rollback
	6. Select 
			SELECT * FROM TB_NAME
			WHERE condition/s
			HAVING condition/s
			ORDER BY column/s ASC| DESC
*/
SELECT * FROM customer

--Q: Add a new column in the customet table, PHONE which stores the phone no. of the 
-- customers.

ALTER TABLE CUSTOMER 
ADD PHONE char(10)

UPDATE customer SET PHONE = '9988776655'
WHERE CUSTOMER_ID = 101

-- Q: DELETE THE PHONE COLUMN FROM THE CUSTOMER TABLE.
ALTER TABLE CUSTOMER
DROP COLUMN PHONE

------------------------------------------------------------------------
							-- EXCEL VS. SQL
------------------------------------------------------------------------------
/*
		   EXCEL                                   SQL
		------------                            -----------
1. Aggregate functions                      1. same as that of excel
2. Number functions                         2. same as that of excel
3. Text functions                           3. Almost same , but few differences
	                                           MID()---> SUBSTRING()
                                              TRIM()---> LTRIM(), RTRIM()
									UPPER(), LOWER(), PROPER() ---> UPPER(), LOWER()
									SUBSTITUTE(), REPLACE() ----> REPLACE(), STUFF()
4. Date functions                            4. Same, but few new functions
													DATEDIFF(), DATEADD(), DATEPART()
													DATENAME(),...
5. Lookup functions							5. JOINS
6. Conditional functions                    6. CASE WHEN THEN ELSE END
7. Logical functions                        7. Logical statements
		AND(), OR(), NOT()                     AND, OR, NOT
8. Array functions                          8. No array functions: 
													CASE WHEN THEN ELSE END
9. Summarization                            9. GROUP BY
		Pivot tables & array functions
10. FILTERS                                 10. WHERE/HAVING
11. GROUPS & BINS                           11. CASE WHEN THEN ELSE END
12. SORTING                                 12. ORDER BY
13. DATA VALIDATIONS						13. CONSTRAINTS
14. CUSTOM FORMATTING                       14. FUNCTIONS:
												CAST(), CONVERT() <-- DATA TYPE CONVERSION FUNCTIONS
												
-----------------------------------------------------------------------------------------
					        -- OPERATORS
--------------------------------------------------------------------------------------
	** Operators are the symbols which perform certain task.
					a + b 
					where + : operator
					     a , b : operands

	** TYPES OF OPERATORS:
	==================================
			1. ARITHMATIC OPERATORS:
					+, -, /, *, **, %
					   
					   15/2 = 7
					   15%2 = 1
					   2**3 = 8
					   2*3 = 6
			2. CONDITIONAL OPERATORS | COMPARISON OPERATORS | RELATIONAL OPERATORS:
					a. Single- value comparison:
									>, >=, <, <=, =, != or <>
									 5 > 3  -> True

					b. Multi-value comparison:
									IN, BETWEEN
								5 IN (3,4,5,10) ---> TRUE
								AGE BETWEEN 18 AND 60

						IN---> use ()
						BETWEEN ---> use AND

				  c. Wildcard operator: (for  TEXT comparisons)
								LIKE used along with:
									- []
									- _(underscore)
									- %
		  3. Logical operators | statements:
						AND, OR, NOT

		  4. Bitwise operators:
					&, |, ~

================================================================================
				-- PRECEDENCE OF OPERATORS
================================================================================
B ---------> O -------> D/M -------> A/S -------> conditional operators----> NOT---> AND---> OR
(brackets)   **        /, *, %       +,-           

	    4+9/3*2-1
		4+3*2-1
		4+6-1
		10-1 = 9

		8/1 + 3 -9 *2 > 23 AND 4
		8+3-9*2 > 23 AND 4
		8+3-18 > 23 AND 4
		11-18>23 AND 4
		-7 > 23 AND 4
		FALSE AND 4
		FALSE AND TRUE
		FALSE

*/

				-- DATE & TIME FUNCTIONS
==============================================================================

SELECT * , MONTH(ORD_DTE) AS MONTH_NO, YEAR(ORD_DTE) AS YEARS, DAY(ORD_DTE) AS DATES
FROM TBL_ORDER

-- DATEPART():
		--	returns the interval of the dates, i.e. year, month, days, HOURS, MINUTES,
		-- SECONDS.

		-- RETURNS NUMERIC VALUE.

SELECT * , DATEPART(MONTH, ORD_DTE) AS MONTHS
FROM TBL_ORDER

-- DISPLAY THE MONTH NAMES.

SELECT ORD_DTE, DATEPART(MONTH, ORD_DTE) AS MONTH_NO,
FORMAT(ORD_DTE, 'MMMM') AS MONTH_NAMES
FROM TBL_ORDER
ORDER BY MONTH_NO

-- GET THE CURRENT DATE:
SELECT GETDATE() AS CUR_DATE

SELECT ORD_DTE , GETDATE() AS CURR_DATE,
DATEDIFF(YEAR, ORD_DTE, GETDATE()) AS YEAR_AGE,
DATEDIFF( MONTH, ORD_DTE, GETDATE()) AS MONTH_AGE,
DATEDIFF(DAY, ORD_DTE, GETDATE() ) AS DAY_AGE
FROM TBL_ORDER





