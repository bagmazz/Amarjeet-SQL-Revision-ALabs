use database Pg_batch1

create table customer ( Cust_ID int , [Name] varchar(30), Age int, Gender Bit, Salary float );
insert into customer values ( 1, 'sam', 26, 0, 26000.35)

drop table customer
insert into customer values (2 , 'shiv', 27, 0, 25000.69),
 ( 3, 'john', 29, 0, 2456.89),
 ( 4, 'steve', 21, 0, 26657.67),
( 5, 'julie', 23, 1, 2575.67)

select * from customer

update customer set Age = 30 where Cust_ID = 1 


insert into customer values (6 , 'shivika', 21, 1, 35000.69),
 ( 7, 'sheetal', 29, 1, 2456.89),
 ( 8, 'ayesha', 21, 1, 26657.67),
( 9, 'aditi', 23, 1, 2575.67)

select * from customer

alter table customer 
add city varchar




