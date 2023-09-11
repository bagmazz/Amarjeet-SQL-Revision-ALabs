create database SQL_CASE_STUDY_ADVANCE

-- alter table transactions 
-- alter column qty int


-- 1. List all customers

select * from Customer


-- 2. List the first name, last name, and city of all customers

select FirstName , LastName, city from customer

-- 3. List the customers in Sweden. Remember it is "Sweden" and NOT "sweden" because filtering

  select * from customer where country = 'Sweden'
 
-- 4. Create a copy of Supplier table. Update the city to Sydney for supplier starting with letter P.
      
   select * into [New_Supplier] from Supplier
   select * from New_Supplier

   update New_Supplier 
   set City ='Sydney' 
   where CompanyName like 'p%'

-- 5. Create a copy of Products table and Delete all products with unit price higher than $50.
  select * into [new_product] from Product
  select * from new_product


  alter table new_product
 alter column Unitprice float

   alter table product
 alter column Unitprice float

 -- 2. select convert(float ,unitprice) from new_product

  delete from new_product where UnitPrice >50


-- 6.List the number of customers in each country
 
 select country, count(id) as Count_of_Customers  from customer
 group by country


 --7. List the number of customers in each country sorted high to low
  select country, count(id) as Count_of_Customers  from customer
 group by country
 order by count(id) desc

--8. List the total amount for items ordered by each customer

select * from orders

alter table orders
 alter column TotalAmount float


select Customerid , sum(totalamount) as Total_Sales from Orders
group by CustomerId


--9. List the number of customers in each country. Only include countries with more than 10 customers.
 select country, count(id) as Count_of_Customers  from customer
 group by country
 having count(id) >10

--10. List the number of customers in each country, except the USA, sorted high to low. Only
-- include countries with 9 or more customers.
   
   select country, count(id) as Count_of_Customers  from customer
   where country <> 'usa'
 group by country
 having count(id) >9
 order by count(id)  desc

-- 11. List all customers whose first name or last name contains "ill".

select * from Customer where firstname like '%ill%' or LastName like '%ill%'

-- 12. List all customers whose average of their total order amount is between $1000 and
-- $1200.Limit your output to 5 results.

select top 5 customerid, avg(totalamount) as Avg from Orders 
group by CustomerId
having AVG(totalamount) >= 1000 and avg(totalamount)<=1200

-- 13.List all suppliers in the 'USA', 'Japan', and 'Germany', ordered by country from A-Z, and then
-- by company name in reverse order.

select * from Supplier

select CompanyName, country from supplier 
where country in ('usa' , 'japan' , 'germany') 
order by country asc , companyName desc 

--14.Show all orders, sorted by total amount (the largest amount first), within each year.

select * from orders

select  id, year(orderdate) as years, TotalAmount as Total_Amount  from orders 
order by years  ,(TotalAmount) desc 

-- 15. Products with UnitPrice greater than 50 are not selling despite promotions. You are asked to
-- discontinue products over $25. Write a query to relfelct this. Do this in the copy of the Product
-- table. DO NOT perform the update operation in the Product table.

select * from new_product

delete from new_product where unitprice > 25 

-- 16. List top 10 most expensive products 
select top 10 productname, unitprice from product
order by UnitPrice desc

--17. Get all but the 10 most expensive products sorted by price
select ProductName,UnitPrice, ranks from 
  (select *, ROW_NUMBER() over(order by unitprice) as ranks 
  from product) as X
 where ranks > 10

-- 18. Get the 10th to 15th most expensive products sorted by price
select ProductName,UnitPrice, ranks from 
 (select *, ROW_NUMBER() over(order by unitprice) as ranks 
   from product) as X
where ranks > = 10 and ranks >= 15

--19. Write a query to get the number of supplier countries. Do not count duplicate values.
select distinct country, count(country) as Count_of_countries from Supplier
group by country

--20. Find the total sales cost in each month of the year 2013.

select year(orderdate) as years,month(orderdate) as months, sum(totalamount) as totalamount from orders
group by month(orderdate), year(orderdate)
having year(orderdate) = 2013

--21. List all products with names that start with 'Ca'.

select productname from Product where ProductName like 'ca%'

--22. List all products that start with 'Cha' or 'Chan' and have one more character

select ProductName from Product where ProductName like 'cha_%' or productname like 'chan_%'

--23. Your manager notices there are some suppliers without fax numbers. He seeks your help to
--get a list of suppliers with remark as "No fax number" for suppliers who do not have fax
--numbers (fax numbers might be null or blank).Also, Fax number should be displayed for
--customer with fax numbers.

update Supplier set fax = 'No Fax Number' where fax is null or fax = ' '

select * from New_Supplier
select X.Id, firstname, lastname ,Fax as Fax_Number from Supplier as X
inner join Customer as Y on 
X.id = Y.id
where fax  = 'no fax number'

-- 24. List all orders, their orderDates with product names, quantities, and prices.
 
 select X.Id, OrderNumber, OrderDate, ProductName ,Quantity, Y.UnitPrice from Orders as X
 left join OrderItem as Y
 on x.id = y.OrderId 
 inner join Product as z
 on y.ProductId = z.id

 --25. List all customers who have not placed any Orders.

select x.id, firstname, lastname , OrderNumber
  from customer as X 
  left join orders as y on 
  x.id = y.CustomerId	
  where OrderNumber is null
  order by x.id asc

-- 26. List suppliers that have no customers in their country, and customers that have no suppliers
-- in their country, and customers and suppliers that are from the same country.
 
select  a.FirstName , a.LastName , a.Country as [Customer Country],
b.Country as [Supplier Country] , b.CompanyName
from customer as a
right join supplier as b
on a.Country = b.Country and a.city = b.City 
where a.Country is null
     union all
select  a.FirstName , a.LastName , a.Country as [Customer Country],
b.Country as [Supplier Country] ,  b.CompanyName
from customer as a
left join supplier as b
on a.Country = b.Country and a.city = b.City
where b.Country is null
     union all
select a.FirstName , a.LastName , a.Country as [Customer Country],
b.Country as [Supplier Country] ,  b.CompanyName
from customer as a
inner join supplier as b
on a.Country = b.Country and a.city = b.city
order by a.Country


--- using outer join

select a.FirstName , a.LastName , a.Country as [Customer Country],
b.Country as [Supplier Country] ,  CompanyName
from customer as a
full outer join supplier as b
on a.Country = b.Country and a.city = b.city
where a.country is null or b.Country is null or a.Country = b.Country
order by b.Country

union all 

select a.FirstName , a.LastName , a.Country as [Customer Country],
b.Country as [Supplier Country] ,  b.CompanyName
from customer as a
full outer join supplier as b
on a.Country = b.Country and a.city = b.city
where b.country is null 
union all

select a.FirstName , a.LastName , a.Country as [Customer Country],
b.Country as [Supplier Country] ,  b.CompanyName
from customer as a
full outer join supplier as b
on a.Country = b.Country and a.city = b.city
where b.country  = a.Country 
order by b.country

--27. Match customers that are from the same city and country. That is you are asked to give a list
-- of customers that are from same country and city. Display firstname, lastname, city and
-- coutntry of such customers.

select
    c1.firstname AS firstname1,
    c1.lastname AS lastname1,
    c2.firstname AS firstname2,
    c2.lastname AS lastname2,
    c1.city,c1.country,
	c1.id as c1_id, c2.id as c2_id
from  customer as c2
join
    customer as c1 ON c1.city = c2.city and c1.country = c2.country and c1.id <>c2.id
	order by country asc

--28. List all Suppliers and Customers. Give a Label in a separate column as 'Suppliers' if he is a
-- supplier and 'Customer' if he is a customer accordingly. Also, do not display firstname and
---lastname as twoi fields; Display Full name of customer or supplier

alter table customer
add [Type] varchar(20)

update Customer set [Type] = 'Customer'

alter table supplier
add [Type] varchar(20)

update Supplier set [Type] = 'Supplier'

select [Type] ,FirstName+ ' '+LastName as ContactName,City,country,phone 
from customer 
union
select [Type] ,ContactName,City,country,phone 
from supplier


select [Type] ,FirstName+ ' '+LastName as ContactName,City,country,phone 
from customer 
union
select [Type] ,ContactName,City,country,phone 
from supplier


--29. Create a copy of orders table. In this copy table, now add a column city of type varchar (40).
--Update this city column using the city info in customers table.

select * into New_orders from orders

select * from New_orders
 
 alter table new_orders 
 add City varchar(40)

 -- command to execute this
 update New_orders 
 set City = ( select b.city
 from customer  b
 where New_orders.customerid = b.id)


 -- select 



 select x.id,x.CustomerId, x.City as orderCity,  y.id as [customer id], y.city as customerCity
 from New_orders as X
 join Customer as Y on 
 x.CustomerId = y.Id 

 -- 30. Suppose you would like to see the last OrderID and the OrderDate for this last order that was shipped to 'Paris'. Along with that information, say you would also like to see the OrderDate for the last order shipped regardless of the Shipping City. In addition to this, you
-- would also like to calculate the difference in days between these two OrderDates that you get. Write a single query which performs this.
-- (Hint: make use of max (columnname) function to get the last order date and the output is a
-- single row output.)

Select 
    max(CASE WHEN city = 'Paris' THEN id END) AS id,
    max(CASE WHEN city = 'Paris' THEN orderdate END) AS parislastOrder,
    max(orderdate) AS lastOrderDate,
    DATEDIFF(day,
        max(CASE WHEN city = 'Paris' THEN orderdate END),
         max(orderdate) ) AS differenceInDays
From new_orders 


-- 31. Find those customer countries who do not have suppliers. This might help you provide
--better delivery time to customers by adding suppliers to these countires. Use SubQueries.

-- using join 
select *
from (
       select A.country as Customers_Country , S.country as Supplier_Country from Customer as A
       left join Supplier as S
	   on A.Country = S.Country
	   where S.country is null  
	   group by a.Country, s.Country
	   ) as x 


--using except

  select country from Customer
  except 
  select country from Supplier

-- using subqueries 
select distinct A.country 
    from customer as A
    where A.country NOT IN (
    select distinct S.country
    from supplier as S )

-- 32. Suppose a company would like to do some targeted marketing where it would contact
-- customers in the country with the fewest number of orders. It is hoped that this targeted
-- marketing will increase the overall sales in the targeted country. You are asked to write a query
-- to get all details of such customers from top 5 countries with fewest numbers of orders. Use
-- Subqueries.

  Select top 5 c.id, c.firstname, c.lastname, c.city, c.country, c.phone,  COUNT(o.id) AS order_count
  from customer c
  JOIN orders o ON c.id = o.customerid
  Where c.country IN (
      select  top 5 country
      from customer
      Group by country
  	order by count(*) asc
  )
  Group By c.id, c.firstname, c.lastname, c.city, c.country, c.phone
  Order By order_count ASC;
  
--33. Let's say you want report of all distinct "OrderIDs" where the customer did not purchase
-- more than 10% of the average quantity sold for a given product. This way you could review
-- these orders, and possibly contact the customers, to help determine if there was a reason for
-- the low quantity order. Write a query to report such orderIDs.

















