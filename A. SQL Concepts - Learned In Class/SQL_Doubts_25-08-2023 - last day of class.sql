
SELECT * FROM SALES

-- Q: Display the products who have contirbuted to average Sales which are more
-- than overall average sales.

select PRODUCT
from  SALES
group by PRODUCT
having avg(sales) > (Select avg(sales) from SALES)

-- Q: Get the details of all the transaction which were done in last 3 months.

SELECT * FROM Transactions
WHERE tran_date >= DATEADD(MONTH, -3, (SELECT MAX(TRAN_DATE) FROM TRANSACTIONS) )
ORDER BY tran_date

-- GET THE TOP 2 CATEGORIES AS PER THE SALES AND THEN DISPLAY THE SUBACATEGORY WISE 
--SALES FOR THESE TOP 2 CATEGORIES.

SELECT P.PROD_CAT, P.PROD_SUBCAT, SUM(TOTAL_aMT) AS REVENUE
FROM Transactions AS T
INNER JOIN PROD_CAT_INFO AS P
ON T.prod_cat_code = P.PROD_CAT_CODE
		AND
	T.prod_subcat_code = P.PROD_SUB_CAT_CODE
WHERE prod_cat IN (
		SELECT TOP 2 P.PROD_CAT
		FROM Transactions AS T
		INNER JOIN PROD_CAT_INFO AS P
		ON T.prod_cat_code = P.PROD_CAT_CODE
				AND
			T.prod_subcat_code = P.PROD_SUB_CAT_CODE
		GROUP BY P.PROD_CAT
		ORDER BY SUM(TOTAL_AMT) DESC
	)
GROUP BY P.PROD_CAT, P.PROD_SUBCAT

-------------------------------------------------------------
-- with cte:

WITH TOP2_CATEGORY 
AS(
		SELECT TOP 2 P.PROD_CAT
		FROM Transactions AS T
		INNER JOIN PROD_CAT_INFO AS P
		ON T.prod_cat_code = P.PROD_CAT_CODE
				AND
			T.prod_subcat_code = P.PROD_SUB_CAT_CODE
		GROUP BY P.PROD_CAT
		ORDER BY SUM(TOTAL_AMT) DESC
),
sub_cat_revenue 
as(
		SELECT P.PROD_CAT, P.PROD_SUBCAT, SUM(TOTAL_aMT) AS REVENUE
		FROM Transactions AS T
		INNER JOIN PROD_CAT_INFO AS P
		ON T.prod_cat_code = P.PROD_CAT_CODE
				AND
			T.prod_subcat_code = P.PROD_SUB_CAT_CODE
		WHERE PROD_CAT IN  (SELECT * FROM TOP2_CATEGORY)
		GROUP BY P.PROD_CAT, P.PROD_SUBCAT
)

SELECT * FROM SUB_CAT_REVENUE

----------% AGE OF CHANGE:

SELECT *, ROUND( (SALES - PREV_SALES)/PREV_SALES * 100, 2) AS [SALES% CHANGE]
FROM (
		SELECT *, LAG(SALES,1) OVER(ORDER BY TRAN_DATE) AS PREV_SALES
		FROM (
			SELECT tran_date, SUM(total_amt) AS SALES
			FROM Transactions
			GROUP BY tran_date
		) AS X
	) AS Y




