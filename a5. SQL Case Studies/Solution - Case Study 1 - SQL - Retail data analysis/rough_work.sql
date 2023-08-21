------ Data Preparartion and Understanding ----

-- Q1. what is the total number of rows in each of the 3 tables in the database. 

select * from Customer

-- 1. total rows in customer table is 5647 rows

select * from prod_cat_info

-- 2. total rows in customer table is 23 rows

select * from Transactions

-- 3. total rows in customer table is  23,053 rows


-- Q2. What is the total number of transaction that have a return

select count(transaction_id) as Count_of_Return 
        from transactions where qty <0 


-- Q3. As you would have noticed, the dates provided across the datasets are not in a correctformat. --
-- As first steps, pls convert the date variables into valid date formats before procedding ahead. 
  
UPDATE transactions
       SET tran_date = CONVERT(DATE, tran_date, 105)
       WHERE ISDATE(tran_date) = 1; --- but this leads to in varchar 

-- 2nd method ....... 

select * from Transactions

        alter table transactions 
       alter column tran_date date; -- did not work 

-- 3rd method ........
     ALTER TABLE Transactions
     ADD New_tran_date DATE;

UPDATE Transactions
SET new_tran_date = CONVERT(DATE, tran_date, 105); -- work finally 

--q4. What is the time range of the transaction data available for analysis?
-- Show the output in number of days, months and years simultaneously in different columns.

select  max(new_tran_date)  as [Maximum Transaction Date] , 
        min(new_tran_date) as [Minimum Transaction Date] 
        from Transactions  

select new_tran_date, month(new_tran_date) as [Month],
       year(new_tran_date) as [Year], 
       day(new_tran_date) as [Day]
       from transactions

--q5. Which product category does the sub-category “DIY” belong to?
select * from prod_cat_info

select prod_cat from prod_cat_info where prod_subcat = 'DIY'

-------- DATA ANALYSIS------

--1.	Which channel is most frequently used for transactions?
select  store_type ,count(cust_id) as Most_Used  from transactions
group by store_type

-- ans - e-shop 

--2.	What is the count of Male and Female customers in the database?
select * from customer

select gender, count(customer_id) as count_by_gender from Customer
group by gender

--3.	From which city do we have the maximum number of customers and how many?
select city_code , count(customer_id) as Count_of_person_in_city from customer group by city_code

--4.	How many sub-categories are there under the Books category?
select prod_cat as categories, prod_subcat as Sub_Categories from prod_cat_info 
group by prod_subcat, prod_cat
having prod_cat='Books'

--5.	What is the maximum quantity of products ever ordered?
select max(qty) as maximum_quantity_ordered from Transactions

--6.	What is the net total revenue generated in categories Electronics and Books?

SELECT SUM(t.total_amt) AS NetTotalRevenue
FROM transactions AS t
JOIN prod_cat_info AS p ON t.prod_cat_code = p.prod_cat_code AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE p.prod_cat IN ('Electronics', 'Books');

-- this one 
SELECT p.prod_cat,
       SUM(t.total_amt) AS NetTotalRevenue
FROM transactions AS t
inner JOIN prod_cat_info AS p ON t.prod_cat_code = p.prod_cat_code AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE p.prod_cat IN ('Electronics', 'Books')
GROUP BY p.prod_cat;

alter table transactions 
alter column total_amt float


alter table transactions 
alter column qty int

alter table transactions 
alter column tax float



--7.	How many customers have >10 transactions with us, excluding returns?
SELECT c.customer_id, COUNT(*) AS TransactionCount
FROM customer AS c
inner JOIN transactions AS t ON c.customer_id = t.cust_id
WHERE t.qty > 0 
GROUP BY c.customer_id    -- chatgpt 
HAVING COUNT(*) > 10; 




-- 8.	What is the combined revenue earned from the “Electronics” & “Clothing” categories, from “Flagship stores”?
SELECT SUM(t.total_amt) AS NetTotalRevenue , Store_type
FROM transactions AS t
JOIN prod_cat_info AS p ON t.prod_cat_code = p.prod_cat_code AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE p.prod_cat IN ('Electronics', 'Clothing')
group by store_type

--9.	What is the total revenue generated from “Male” customers in “Electronics” category? 
-- Output should display total revenue by prod sub-cat.

SELECT p.prod_subcat, SUM(t.total_amt) AS TotalRevenue
FROM Transactions AS t
JOIN customer AS c ON c.customer_id = t.cust_id
JOIN prod_cat_info AS p ON t.prod_cat_code = p.prod_cat_code AND t.prod_subcat_code = p.prod_sub_cat_code
WHERE c.gender = 'Male' AND p.prod_cat = 'Electronics'
GROUP BY p.prod_subcat;

-- 10. 