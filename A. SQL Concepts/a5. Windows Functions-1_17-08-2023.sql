
                    -- CASE WHEN THEN ELSE END:

-- Q: For the products, BINDERS & TABLES find sales = sales/profit. And for other
-- categories, keep the original sales.

SELECT REF_NO, ORD_DTE, CUST_NAME, CATEGORY, PRODUCT, PROFIT,
CASE
	WHEN PRODUCT IN ('TABLES', 'BINDERS')
		THEN SALES/PROFIT
	ELSE SALES
END  AS NEW_SALES
FROM TBL_ORDER

----------------------------------------------------------------------------------
			               -- WINDOW FUNCTIONS
----------------------------------------------------------------------------------

/*
-- WINDOW: A set of rows.
	Window functions can be:
			a. Aggregate Window functions: sum, count, max, min, avg,...
			b. Rank window functions:
									row_number(), rank(), dense_rank()
			c. LEAD() & LAG()

-- Window functions uses OVER clause, where OVEr consists of:
			
			i. PARTITION BY:
						-> optional
						-> Its the alternate for GROUP BY
			ii. ORDER BY:
						-> Mandatory
						-> Sorting the data in ASC or DESC order
*/

-- Q: Find the sales for each catgory
SELECT CATEGORY, SUM(SALES) AS TOT_SALES
FROM TBL_ORDER
GROUP BY CATEGORY

					-- AGGREGATE WINDOW FUNCTIONS:
==========================================================================
-- Q: Show the category wise sales along with the original records

SELECT CATEGORY, SALES , SUM(SALES) OVER(PARTITION BY CATEGORY) AS TOTAL_SALES
FROM TBL_ORDER

-- Q: For each category, find how much is the order SALES varying from the maximum sales.
SELECT *, MAX_CATEG_SALES - SALES AS DIFFERENCE_SALES
FROM (
	SELECT CATEGORY, SALES, 
	MAX(SALES) OVER( PARTITION BY CATEGORY) AS MAX_CATEG_SALES
	FROM TBL_ORDER
) AS X


				-- RANK WINDOW FUNCTIONS
==================================================================================
-- Q: Find the top 2 records with  maximum sales.
SELECT TOP 2 * FROM TBL_ORDER
ORDER BY SALES DESC

-- Q: Find the order details with 2nd highest Sales.
SELECT TOP 1 * FROM (
			SELECT TOP 2 * FROM TBL_ORDER
			ORDER BY SALES DESC
		) AS X
ORDER BY SALES ASC

/* 
1. ROW_NUMBER(): unique ranking
				    a  10   1
					b  20   2
					c  30   3
					d  30   4
					z  30   5
					e  40   6
2. RANK():
			if multiple records have same value, then rank will also be SAME.
			For the next record, the consecutive rank will be SKIPPED.
					a  10   1
					b  20   2
					c  30   3
					d  30   3
					z  30   3
					e  40   6
3. DENSE_RANK():
			if multiple records have same value, then rank will also be SAME.
			For the next record, the consecutive rank will NOT be SKIPPED.
					a  10   1
					b  20   2
					c  30   3
					d  30   3
					z  30   3
					e  40   4
*/
-- Q: Find the order details with 5th highest Sales USING RANK.
SELECT *
FROM (
		SELECT *,
		RANK() OVER( ORDER BY SALES DESC) AS RANKS
		FROM TBL_ORDER
	) AS X
WHERE RANKS = 5

-----
SELECT *
FROM (
		SELECT *,
		DENSE_RANK() OVER( ORDER BY SALES DESC) AS RANKS
		FROM TBL_ORDER
	) AS X
WHERE RANKS = 5
-------
SELECT *
FROM (
		SELECT *,
		ROW_NUMBER() OVER( ORDER BY SALES DESC) AS RANKS
		FROM TBL_ORDER
	) AS X
WHERE RANKS = 5

--Q: RANK EACH RECORD AS PER THE SALES FOR EACH CATEGORY.
-- GENERATE THE TOP 2 SALES RECORDS FROM EACH CATEGORY.
SELECT * FROM (
		SELECT *,
		DENSE_RANK() OVER (PARTITION BY CATEGORY ORDER BY SALES DESC) AS RANKS
		FROM TBL_ORDER
	) AS X
WHERE RANKS IN (1,2) -- | WHERE RANKS = 1 OR RANKS = 2 | WHERE RANKS <3


