
                              -- CUBE & ROLLUP
------------------------------------------------------------------------------
CREATE TABLE SALES (COUNTRY VARCHAR(50), PRODUCT VARCHAR(50), SALES INT)

INSERT INTO SALES VALUES( 'USA', 'Laptop', 234),
						('Canada', 'Laptop', 456),
						('USA', 'Laptop', 123),
						('USA', 'Mobile', 230),
						('Canada', 'Mobile', 345)

select * from SALES

-- Q: Get the Sales & Product data by each country from Sales table.
SELECT PRODUCT, SUM(SALES) AS TOTAL_SALES, COUNTRY
FROM SALES
GROUP BY PRODUCT, COUNTRY


-- ROLLUP():
			/* It generates the sub-totals & grand-totals for the FIRST dimension
			only.*/

-- Q: Display the sub-totals & Grand totals for each country & product wise sales.
SELECT COUNTRY, PRODUCT, SUM(SALES) AS TOT_SALES
FROM SALES
GROUP BY ROLLUP--(product , country)
(COUNTRY, PRODUCT)

------
-- CUBE():
		/* It generates the sub-totals & grand-totals for the ALL the dimensions */

SELECT COUNTRY, PRODUCT, SUM(SALES) AS TOT_SALES
FROM SALES
GROUP BY CUBE(COUNTRY, PRODUCT)


