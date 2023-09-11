
/*************************** QUESTIONS FROM JOINS DATA **********************************/
select * from TBL_COURSE
select * from TBL_MAPPING
select * from TBL_STUDENT

--Q1: Display student details and the courses they are enrolled to 

select A.* , B.course_ID 
from TBL_STUDENT as A
Inner join TBL_MAPPING as B
on A.STU_ID = B.STU_ID

---

--Q2: Display details of all students and the count of courses they are enrolled to.
select A.* , count(B.stu_id) as Count_course
left join TBL_MAPPING as B
on A.STU_ID = B.STU_ID
from TBL_STUDENT as A 
group by 
A.STU_ID, [name], DoB, PHON  E_CUS, EMAIL_CUS

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
--Q1: In order to post welcome letters and user guides to customers, dispatch team need 
--    customer name, address and contact details. Write SQL query to get desired info.
--Q2: Get the details of customers who are RESIDING in more than one location.
--Q3: Which are the customers that have not given their house details.
--Q4: Get the install dates corresponding to all customers in different locations.
--Q5: Get the location details along with count of services installed in the location.
--Q6: Get the customer name and contact details of the customers along with other info 
--   extracted in Q4 above.
--Q7: Location details where install orders are in open state.
--Q8: Are their any customers who have made a complaint more than once?

--Q9: Count total open orders in the available data.
--Q10: Are there any location ids where we have open service orders for disconnection and open complaint orders?
--Q11: Locations where customers have never given any complaints but discontinued the services.
--Q12: List down the customers and no of total (WO + Complaints) orders placed by them 