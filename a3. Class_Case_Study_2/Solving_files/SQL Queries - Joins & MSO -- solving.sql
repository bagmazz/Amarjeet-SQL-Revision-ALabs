
/*************************** QUESTIONS FROM JOINS DATA **********************************/
--Q1: Display student details and the courses they are enrolled to.
--Q2: Display details of all students and the count of courses they are enrolled to.
--Q3: Display details of students which are not yet enrolled to any course.
--Q4: List all courses and the count of students enrolled to each course.

/************************* QUESTIONS FROM MSO DATABASE **********************************/


--Q1: In order to post welcome letters and user guides to customers, dispatch team need 
--    customer name, address and contact details. Write SQL query to get desired info.
   
   select FNAME_CUS+ ' '+LNAME_CUS as full_Name ,
   concat(house_id_hse, ' ', Address_hse, ' ', city_hse, ' ', country_hse) as Addresses, phone_cus ,email_cus from TBL_CUSTOMER
   INNER JOIN TBL_HOUSE on CUST_ID_CUS = CUST_ID_HSE
   
--Q2: Get the details of customers who are RESIDING in more than one location.

  select FNAME_CUS+ ' '+LNAME_CUS as full_Name , count(house_id_hse) as count_of_customers,
    phone_cus ,email_cus from TBL_CUSTOMER
   inner join tbl_house on cust_id_hse = cust_id_hse 
   group by FNAME_CUS+ ' '+LNAME_CUS , 
   phone_cus ,email_cus
   having count(house_id_hse) > 1

--Q3: Which are the customers that have not given their house details.
   
   select x.* from TBL_CUSTOMER as x
   left join TBL_HOUSE on CUST_ID_CUS =CUST_ID_HSE 
   where cust_id_hse is null


--Q4: Get the install dates corresponding to all customers in different locations.

      select CUST_ID_HSE, HOUSE_ID_HSE, COMPL_DTE_WO  from TBL_HOUSE 
	  inner join TBL_WORK_ORDER on CUST_ID_HSE = cust_id_wo and house_id_hse = HOUSE_ID_wo
	  where type_wo='install'



--Q5: Get the location details along with count of services installed in the location.

      select concat(house_id_hse, ' ', Address_hse, ' ', city_hse, ' ', country_hse) as address, count(type_wo) as count_services from TBL_WORK_ORDER
	  right join TBL_HOUSE on HOUSE_ID_HSE = HOUSE_ID_WO and cust_id_hse = CUST_ID_WO
	  where TYPE_WO ='install'
	  group by concat(house_id_hse, ' ', Address_hse, ' ', city_hse, ' ', country_hse)

	  
	  
--Q6: Get the customer name and contact details of the customers along with other info 
--   extracted in Q4 above.
     select FNAME_CUS+ ' '+LNAME_CUS as full_Name ,
     concat(house_id_hse, ' ', Address_hse, ' ', city_hse, ' ', country_hse) as Addresses, phone_cus ,email_cus ,
     count(type_wo) as count_services from TBL_WORK_ORDER
	  right join TBL_HOUSE on HOUSE_ID_HSE = HOUSE_ID_WO and cust_id_hse = CUST_ID_WO
	  join TBL_CUSTOMER on cust_id_cus = CUST_ID_HSE 
	  where TYPE_WO ='install'
	  group by FNAME_CUS+ ' '+LNAME_CUS  ,concat(house_id_hse, ' ', Address_hse, ' ', city_hse, ' ', country_hse),
	  phone_cus ,email_cus

--Q7: Location details where install orders are in open state.
     select concat(house_id_hse, ' ', Address_hse, ' ', city_hse, ' ', country_hse) as Addresses ,status_wo,type_wo from TBL_HOUSE 
	 inner join TBL_WORK_ORDER on 
	 HOUSE_ID_HSE=HOUSE_ID_WO 
	 where STATUS_WO='open' and TYPE_WO ='install'
	 

--Q8: Are their any customers who have made a complaint more than once?
      select count(*) as Total_count from(
	     select CUST_ID_CO, count(*) as count_of_complaint from TBL_COMPLAINT_ORDER
	     group by CUST_ID_CO
	     having count(*)>1)
	  as x

	  -- or

	  select CUST_ID_CO, count(*) as count_of_complaint from TBL_COMPLAINT_ORDER
	     group by CUST_ID_CO
	     having count(*)>1

--Q9: Count total open orders in the available data.
      
	  select count(*) as total_orders from (
	  select status_wo from TBL_WORK_ORDER
	  where STATUS_WO ='open'
	    union all
	  select status_co from TBL_COMPLAINT_ORDER
	  where status_co = 'open' 
	  ) as Y

--Q10: Are there any location ids where we have open service orders for disconnection and open complaint orders?
       select count(*) as count_of_location_ids  from (
	   select HOUSE_ID_WO from TBL_WORK_ORDER 
	   where STATUS_WO='open' and TYPE_WO like 'disco%'
       intersect

	   select HOUSE_ID_CO from TBL_COMPLAINT_ORDER 
	   where STATUS_CO ='open'
	   ) as x



--Q11: Locations where customers have never given any complaints but discontinued the services.
       


--Q12: List down the customers and no of total (WO + Complaints) orders placed by them 