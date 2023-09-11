
-------------------------------PRACTICE QUESTIONS--------------------------------------
---------------------------(CREATE TABLE-ORDERS.SQL)----------------------------------
--Q1: List all customers in ascending order of CATEGORY and descending order by SALES.
SELECT * FROM TBL_ORDER
ORDER BY CATEGORY ASC, SALES DESC

--Q2: Display unique combination of CATEGORY and PRODUCT arranged in ASCENDING order.
SELECT DISTINCT CATEGORY, PRODUCT 
FROM TBL_ORDER
ORDER BY CATEGORY, PRODUCT  -- Both are in ASC order

--Q3: What is count of customers buying particular product in Technology and Furniture 
-- category  in year 2011 and 2012?

SELECT PRODUCT, YEAR(ORD_DTE) AS YEARS, CATEGORY, count(ref_no) as ORDERS_COUNT 
FROM TBL_ORDER
WHERE CATEGORY IN ('TECHNOLOGY', 'FURNITURE')  AND
	YEAR(ORD_DTE) IN ( 2011, 2012)
GROUP BY PRODUCT, YEAR(ORD_DTE), CATEGORY

--Q4: Get the maximum, minimum and average sales amount for each product along with 
-- customer count.
SELECT PRODUCT, SUM(SALES) AS TOT_SALES,
MAX(SALES) AS MAX_SALES, MIN(SALES) AS MIN_SALES, AVG(SALES) AS AVG_SALES,
COUNT(SALES) AS SALES_COUNT
FROM TBL_ORDER
GROUP BY PRODUCT

--Q5: Display data for only those products which are bought by more than one customer.
SELECT PRODUCT, COUNT(CUST_NAME) AS CUST_COUNT
FROM TBL_ORDER
GROUP BY PRODUCT
HAVING COUNT(CUST_NAME) > 1

--Q6: Output should be arranged in descending order of customer count and average 
-- sales amount.
SELECT PRODUCT , COUNT(CUST_NAME) AS CUST_COUNT, AVG(SALES) AS AVG_SALES
FROM TBL_ORDER
GROUP BY PRODUCT
ORDER BY CUST_COUNT DESC, AVG_SALES DESC
