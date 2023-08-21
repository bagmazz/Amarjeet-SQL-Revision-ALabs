

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


-- Q3. As you would have noticed, the dates provided across the datasets are not in a correct format.
-- As first steps, pls convert the date variables into valid date formats before procedding ahead. 

select Dob,
format(convert(date, dob,121), 'dd-MM-yyyy')
from Customer

