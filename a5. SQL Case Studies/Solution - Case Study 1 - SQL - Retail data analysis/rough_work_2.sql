create database SQL_Practice_1

-- 1.	What is the total number of rows in each of the 3 tables in the database?

select * from Customer
-- 5647 rows

select * from prod_cat_info
-- 23 rows 

select * from Transactions
-- 23053 rows 

alter table transactions 
alter column prod_cat_code int

--2.	What is the total number of transactions that have a return?

alter table transactions 
alter column tran_date date

select count(transaction_id) as Count_of_return from Transactions where qty <  0

--3.	As you would have noticed, the dates provided across the datasets are not in a correct format. As first steps, 
-- pls convert the date variables into valid date formats before proceeding ahead.




alter table customer 
alter column dob date

select * from Customer








update Transactions
set new_trans_date = convert(date, tran_date, 105)

--4.	What is the time range of the transaction data available for analysis? 
-- Show the output in number of days, months and years simultaneously in different columns.

select  max(new_trans_date) as [Maximum Date], min(new_trans_date) as [Minimum Date] from Transactions

select new_trans_date , Year(new_trans_date) as [Years], month(new_trans_date) as [Months], day(new_trans_date) as [day] 
from Transactions

--5.	Which product category does the sub-category “DIY” belong to?
select prod_cat from prod_cat_info where prod_subcat='DIY'

--Books 

---------------- Data Analysis ---------------

--1.	Which channel is most frequently used for transactions?

select Store_type, count(transaction_id) as [Most_Channel_used] from Transactions group by Store_type


--2.	What is the count of Male and Female customers in the database?
select gender, count(customer_id) as Count_of_Genders  from Customer group by Gender

--3.	From which city do we have the maximum number of customers and how many?
select city_code, count(customer_id)  as Count_of_customers
from Customer group by city_code

--4.	How many sub-categories are there under the Books category?
select prod_subcat as Sub_Categories_Books from prod_cat_info group by prod_cat, prod_subcat
having prod_cat='books';


-- 5.	What is the maximum quantity of products ever ordered?
select max(qty) as Maximum_Quantity_Ordered from Transactions

--6.	What is the net total revenue generated in categories Electronics and Books?

alter table transactions 
alter column total_amt float

select  pr.prod_cat as category, sum(totaL_amt) as [Net Total Revenue] from Transactions as tr
inner join prod_cat_info as pr 
on tr.prod_cat_code = pr.prod_cat_code 
where pr.prod_cat in ('electronics' ,'books')
group by pr.prod_cat

--7.	How many customers have >10 transactions with us, excluding returns?
select cust.customer_id, count(cust.customer_Id) as transaction_count from customer as Cust
inner join Transactions as tr
on tr.cust_id = CUST.customer_Id 
where tr.qty > 0 
group by cust.customer_Id
having count(cust.customer_Id)>10

--8.	What is the combined revenue earned from the “Electronics” & “Clothing” categories, from “Flagship stores”?
select pr.prod_cat as category, store_type ,sum(tr.total_amt) as Combined_revenue from Transactions as tr
inner join prod_cat_info as pr
on tr.prod_cat_code = pr.prod_cat_code 
where pr.prod_cat in ('electronics', 'clothing') and tr.Store_type = 'flagship store'
group by pr.prod_cat, Store_type

--9.   What is the total revenue generated from “Male” customers in “Electronics” category?
--Output should display total revenue by prod sub-cat.

Select pci.prod_subcat AS product_subcategory,
     SUM(t.total_amt) AS total_revenue
     From transactions as  t
     inner Join prod_cat_info as pci  ON t.prod_cat_code = pci.prod_cat_code AND t.prod_subcat_code = pci.prod_sub_cat_code
     inner Join customer c ON t.cust_id = c.customer_id
     Where pci.prod_cat = 'Electronics'
       and c.gender = 'M'
     Group By pci.prod_subcat,gender;

--10.	What is percentage of sales and returns by product sub category; 
-- display only top 5 sub categories in terms of sales?

Select
    pci.prod_subcat AS product_subcategory,
    sum(Case when trans.total_amt > 0 then trans.total_amt else 0 end) as [Total Sales by Sub Category],
    sum(Case when trans.total_amt < 0 then trans.total_amt else 0 end) as [Total returns by Sub Categoty],
    sum(Case when trans.total_amt > 0 then trans.total_amt else 0 end) / (sum(trans.total_amt)) * 100 as [Sales_percentage],
    sum(Case when trans.total_amt < 0 then trans.total_amt else 0 end) / (sum(trans.total_amt)) * 100 as [Returns Percentage]
from transactions trans
join prod_cat_info pci ON trans.prod_cat_code = pci.prod_cat_code AND trans.prod_subcat_code = pci.prod_sub_cat_code
Group by pci.prod_subcat;



 Select TOP 5
    pci.prod_subcat as [Product Subcategory],
    Sum(Case when trans.total_amt > 0 Then trans.total_amt Else 0 End) as total_sales
    From transactions trans
    Join prod_cat_info pci ON trans.prod_cat_code = pci.prod_cat_code AND trans.prod_subcat_code = pci.prod_subcat_code
   GROUP BY pci.prod_subcat
   ORDER BY total_sales DESC;


 


