
select * from TBL_ORDER
--Q1: List all orders in ascending or descending order of SALES.

-- Ascending 
select * from TBL_ORDER 
order by sales asc

-- Descending
select * from TBL_ORDER 
order by sales desc

--Q2: Display only unique records from the order table.
select distinct * from TBL_ORDER

--Q3: Which orders are giving loss to the company?
select * from TBL_ORDER where profit < 0

--Q4: Which are the orders that belong to Technology category?
select * from TBL_ORDER where CATEGORY ='technology'

--Q5: Are there any orders from Technology category where products were sold at loss?
select * from TBL_ORDER where profit < 0 and CATEGORY='technology'

--Q6: Which are the orders where Tables, Phones and Appliances are sold?

-- 1st method --
select * from TBL_ORDER where product ='tables' or product ='phones' or  product='appliances' 

-- 2nd method --
select * from TBL_ORDER where PRODUCT in ('tables', 'phones', 'appliances')

--Q7: List all orders excluding Tables product.
-- 1st method --
select * from TBL_ORDER where PRODUCT<> 'tables'

-- 2nd method -- 
select * from TBL_ORDER where product not in ('tables')

--Q8: From which of the orders, company has gained profit by selling Tables, Phones and Appliances?
select * from TBL_ORDER where PRODUCT in ('tables', 'phones', 'appliances') and profit>0

--Q9: List all order details where sales are between 3000 and 5000.
-- Ist method --
select * from TBL_ORDER where sales >= 3000 and sales <=5000

-- 2nd method-- 
select * from TBL_ORDER where sales between 3000 and 5000

--Q10: (A) List orders which are placed by customers where customer name starts with J.
 select * from TBL_ORDER where CUST_NAME like 'J%'

--(B) List orders which are placed by customers where customer name starts with J or T.
 select * from TBL_ORDER where CUST_NAME like '[JT]%'
--(C) List orders which are placed by customers where customer name starts with J or T AND ends with d
 select * from TBL_ORDER where CUST_NAME like '[JT]%d'
--Q11: Orders where characters at 2nd and 3rd of cust_name positions are is 'ar'.
 select * from TBL_ORDER where CUST_NAME like '_AR%'

--Q12: Which are the Top 5 orders in terms of sales amount?
select top 5 * from TBL_ORDER order by sales desc


--Q13: (A) Which are the bottom 5 orders in terms of profits?
select top 5 * from TBL_ORDER order by profit asc

--(B) Which are the bottom 25% orders in terms of profits?

-- there is no bottom keyword so we have to handled it by asc and desc --

select top 25 percent * from TBL_ORDER order by sales asc

--Q14: Display order details with appropiate header labels 
			-- e.g. Customer Name, Product category and Sales amount etc..
			select Ref_NO As REFERENCE_No, ORD_DTE As ORDER_DATE, CUST_NAME [CUSTOMER NAME], 
			CATEGORY  ,PRODUCT ,SALES AS [SALES AMOUNT],PROFIT from tbl_order


--Q15: Get all records where PROFIT is missing.
select * from TBL_ORDER where profit is null 
------------------------------------------------------------------------------
--FUNCTIONS IN  SQL.

------------------------------------------------------------------------------

--Q16: How many orders are placed for each category? Get the total sales amount as well.
      select category, count(ref_no) as [order count],sum(sales)[Total Amount] from TBL_ORDER
	  group by CATEGORY

--Q17: What is the monthly sales amount?
select month(ord_dte) as months, sum(sales) as total_sales from TBL_ORDER group by month(ord_dte)

--Q18: Are there any customers with duplicate reference number?
select ref_no, count(ref_no) as ref_count
from tbl_order 
group by ref_no
having count(ref_no)>1



