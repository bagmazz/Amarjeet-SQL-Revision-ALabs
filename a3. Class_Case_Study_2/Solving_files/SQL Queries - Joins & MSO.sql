/*************************** QUESTIONS FROM JOINS DATA **********************************/
select * from TBL_COURSE
select * from TBL_MAPPING
select * from TBL_STUDENT

--Q1: Display student details and the courses they are enrolled to 

select A.* , B.course_ID 
from TBL_STUDENT as A
Inner join TBL_MAPPING as B
on A.STU_ID = B.STU_ID

--Q2: Display details of all students and the count of courses they are enrolled to.
select A.* , count(B.stu_id) as Count_course
from TBL_STUDENT as A 
left join TBL_MAPPING as B
on A.STU_ID = B.STU_ID
group by 
A.STU_ID, [name], DoB, PHONE_CUS, EMAIL_CUS

--Q3: Display details of students which are not yet enrolled to any course.

select X.* from TBL_STUDENT as x
left join TBL_MAPPING as y
ON x.STU_ID = Y.STU_ID
where course_Id is null

----  or ------

select X.* from TBL_STUDENT as x
left join TBL_MAPPING as y
ON x.STU_ID = Y.STU_ID
where course_Id is null) 

--Q4: List all courses and the count of students enrolled to each course.

select C.*, count(stu_id) as Student_Count 
from TBL_COURSE as c
left join TBL_MAPPING as m
on c.COURSE_ID = m.COURSE_ID
group by c.course_id,[name]

/************************* QUESTIONS FROM MSO DATABASE **********************************/

select * from TBL_CUSTOMER
--Q1: In order to post welcome letters and user guides to customers, dispatch team need customer name, address and contact details. Write SQL query to get desired info.

select Fname_cus +' ' + Lname_cus as full_name, 
concat(house_id_hse, ' ', address_hse, ' ' , city_hse, ' ', country_hse) as address,
phone_cus, email_cus from TBL_CUSTOMER inner join tbl_house on cust_id_cus = cust_id_hse


--Q2: Get the details of customers who are RESIDING in more than one location.
select Fname_cus +' ' + Lname_cus as full_name,phone_cus,email_cus ,count(house_id_hse) as house_count from  TBL_CUSTOMER 
inner join TBL_HOUSE Y 
on cust_id_cus = cust_id_hse 
group by Fname_cus +' ' + Lname_cus,phone_cus,email_cus
having count(house_id_hse)>1


--Q3: Which are the customers that have not given their house details.
select X.* from TBL_CUSTOMER as X 
left join tbl_house as Y
on cust_id_cus = CUST_ID_HSE 
where house_id_hse is null


--or 

select Fname_cus +' ' + Lname_cus as full_name,phone_cus,email_cus, count(house_id_hse) from TBL_CUSTOMER as X 
left join tbl_house as Y
on cust_id_cus = cust_id_hse 
group by Fname_cus +' ' + Lname_cus ,phone_cus,email_cus
having count(house_id_hse)=0


--Q4: Get the install dates corresponding to all customers in different locations.
select house_id_hse, cust_id_hse, COMPL_DTE_WO as install_date from TBL_WORK_ORDER
inner join TBL_HOUSE as b on cust_id_hse = cust_id_hse 
       and 
   house_id_wo = house_id_hse 
   where type_wo = 'install'


--Q5: Get the location details along with count of services installed in the location.
select concat(house_id_hse, ' ', address_hse, ' ' , city_hse, ' ', country_hse) as house_address,
count(ord_id_wo) as count_of_services from tbl_work_order as A 
right join tbl_house as B on cust_id_wo = cust_id_hse 
   and 
house_id_wo = house_id_hse 
where type_wo = 'install' 
group by concat(house_id_hse, ' ', address_hse, ' ' , city_hse, ' ', country_hse)

--Q6: Get the customer name and contact details of the customers along with other info 
--   extracted in Q4 above.

select  Fname_cus +' ' + Lname_cus as full_name, concat(house_id_hse, ' ', address_hse, ' ' , city_hse, ' ', country_hse) 
as house_address,
count(ord_id_wo) as count_of_services from tbl_work_order as A 
right join tbl_house as B on cust_id_wo = cust_id_hse 
   and 
house_id_wo = house_id_hse 
inner join tbl_customer as C on 

where type_wo = 'install' 
group by concat(house_id_hse, ' ', address_hse, ' ' , city_hse, ' ', country_hse)

--Q7: Location details where install orders are in open state.
select * from tbl_house as h
inner join tbl_work_order as w
on house_id_hse = house_id_wo 
  and 
cust_id_hse = cust_id_wo 
where type_wo = 'install' and status_wo ='open'

--Q8: Are their any customers who have made a complaint more than once?

select cust_id_co, count(ord_id_co) as compl_count
from tbl_complaint_order 
group by cust_id_co 
having count(ord_id_co)>1

--Q9: Count total open orders in the available data.
select count(*) from (
  select * from tbl_complaint_order 
  where status_co = 'open'
  union all 

  select * from tbl_work_order 
  where status_wo ='open'
  ) as x

--Q10: Are there any location ids where we have open service orders for disconnection and open complaint orders?
select count(*) as count_of_location from ( 
     select house_id_co from tbl_complaint_order 
     where status_co ='open' 
     intersect 
     select * from tbl_work_order 
     where type_wo like 'disco%'
      and 
      status_wo ='open'
   ) as x

--Q11: Locations where customers have never given any complaints but discontinued the services.
select house_id from TBL_WORK_ORDER
where type_wo like 'disco%'
   and 
   status_wo ='close'
   except 
   select house_id_co from TBL_COMPLAINT_ORDER

--Q12: List down the customers and no of total (WO + Complaints) orders placed by them 
select cust_id_cus, Fname_cus +' ' + Lname_cus as cust_name,count(ord_id_co) as orders_count 
from TBL_CUSTOMER as A 
left join ( 
            select * from TBL_COMPLAINT_ORDER _order 
			union all 
			select * from tbl_work_order)  as B 
			on cust_id_cus = cusT_id_co 
			group by cust_id_cus, Fname_cus +' ' + Lname_cus 