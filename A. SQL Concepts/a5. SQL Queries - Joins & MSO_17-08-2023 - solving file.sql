
/*************************** QUESTIONS FROM JOINS DATA **********************************/
SELECT * FROM TBL_COURSE
SELECT * FROM TBL_MAPPING
SELECT * FROM TBL_STUDENT

--Q1: Display student details and the courses they are enrolled to.
SELECT A.*, B.COURSE_ID
FROM TBL_STUDENT AS A
INNER JOIN TBL_MAPPING AS B
ON A.STU_ID = B.STU_ID

-- Q: Display the student details along with the course details in which they are
-- enrolled.
SELECT A.*, B.COURSE_ID, C.[NAME]
FROM TBL_STUDENT AS A
INNER JOIN TBL_MAPPING AS B
ON A.STU_ID = B.STU_ID
INNER JOIN TBL_COURSE AS C
ON B.COURSE_ID = C.COURSE_ID

--Q2: Display details of all students and the count of courses they are enrolled to.
SELECT A.*, COUNT(B.STU_ID) AS COUNT_COURSE
FROM TBL_STUDENT AS A
LEFT JOIN TBL_MAPPING AS B
ON A.STU_ID = B.STU_ID
GROUP BY A.STU_ID, [NAME], DOB, PHONE_CUS, EMAIL_CUS

--Q3: Display details of students which are not yet enrolled to any course.
SELECT X.*
FROM TBL_STUDENT AS X
LEFT JOIN TBL_MAPPING AS Y
ON X.STU_ID = Y.STU_ID
WHERE COURSE_ID IS NULL

-- OR

SELECT A.*, COUNT(B.STU_ID) AS COUNT_COURSE
FROM TBL_STUDENT AS A
LEFT JOIN TBL_MAPPING AS B
ON A.STU_ID = B.STU_ID
GROUP BY A.STU_ID, [NAME], DOB, PHONE_CUS, EMAIL_CUS
HAVING COUNT(B.STU_ID) = 0

--Q4: List all courses and the count of students enrolled to each course.
SELECT C.*, COUNT(STU_ID) AS STUDENT_COUNT
FROM TBL_COURSE AS C
LEFT JOIN TBL_MAPPING AS M
ON C.COURSE_ID = M.COURSE_ID
GROUP BY C.COURSE_ID, [NAME]


/************************* QUESTIONS FROM MSO DATABASE **********************************/
--Q1: In order to post welcome letters and user guides to customers, dispatch team need 
--    customer name, address and contact details. Write SQL query to get desired info.
SELECT  FNAME_CUS + ' ' + LNAME_CUS AS FULL_NAME,
CONCAT(HOUSE_ID_HSE, ' ' , ADDRESS_HSE,  ' ' , CITY_HSE, ' ' , COUNTRY_HSE) AS ADDRESSES,
PHONE_CUS, EMAIL_CUS
FROM TBL_CUSTOMER X
INNER JOIN TBL_HOUSE Y
ON CUST_ID_CUS = CUST_ID_HSE

--Q2: Get the details of customers who are RESIDING in more than one location.
SELECT  FNAME_CUS + ' ' + LNAME_CUS AS FULL_NAME, PHONE_CUS, EMAIL_CUS,
COUNT(HOUSE_ID_HSE) AS HOUSE_COUNT
FROM TBL_CUSTOMER X
INNER JOIN TBL_HOUSE Y
ON CUST_ID_CUS = CUST_ID_HSE
GROUP BY FNAME_CUS + ' ' + LNAME_CUS, PHONE_CUS, EMAIL_CUS 
HAVING COUNT(HOUSE_ID_HSE) > 1

--Q3: Which are the customers that have not given their house details?
SELECT X.*
FROM TBL_CUSTOMER AS X
LEFT JOIN TBL_HOUSE AS Y
ON X.CUST_ID_CUS = Y.CUST_ID_HSE
WHERE HOUSE_ID_HSE IS NULL

-- OR
SELECT  FNAME_CUS + ' ' + LNAME_CUS AS FULL_NAME, PHONE_CUS, EMAIL_CUS,
COUNT(HOUSE_ID_HSE) AS HOUSE_COUNT
FROM TBL_CUSTOMER X
LEFT JOIN TBL_HOUSE Y
ON CUST_ID_CUS = CUST_ID_HSE
GROUP BY FNAME_CUS + ' ' + LNAME_CUS, PHONE_CUS, EMAIL_CUS
HAVING COUNT(HOUSE_ID_HSE) = 0

--Q4: Get the install dates corresponding to all customers in different locations.
SELECT HOUSE_ID_HSE,  CUST_ID_HSE, COMPL_DTE_WO AS INSTALL_DATES
FROM TBL_WORK_ORDER AS A
INNER JOIN TBL_HOUSE AS B
ON CUST_ID_WO = CUST_ID_HSE
			AND
HOUSE_ID_WO = HOUSE_ID_HSE
WHERE  TYPE_WO = 'INSTALL'

--Q5: Get the location details along with count of services installed in the location.
SELECT
CONCAT(HOUSE_ID_HSE, ' ' , ADDRESS_HSE,  ' ', CITY_HSE,  ' ', COUNTRY_HSE) AS HOUSE_DETAIL,
COUNT(ORD_ID_WO) AS COUNT_OF_SERVICES
FROM TBL_WORK_ORDER AS A
RIGHT JOIN TBL_HOUSE AS B
ON CUST_ID_WO = CUST_ID_HSE
			AND
HOUSE_ID_WO = HOUSE_ID_HSE
WHERE TYPE_WO = 'INSTALL'
GROUP BY CONCAT(HOUSE_ID_HSE, ' ' , ADDRESS_HSE,  ' ', CITY_HSE,  ' ', COUNTRY_HSE)

--Q6: Get the customer name and contact details of the customers along with other info 
--   extracted in Q4 above.


--Q7: Location details where install orders are in open state.
SELECT H.*
FROM TBL_HOUSE AS H
INNER JOIN TBL_WORK_ORDER AS W
ON HOUSE_ID_HSE = HOUSE_ID_WO
		AND
 CUST_ID_HSE = CUST_ID_WO
WHERE TYPE_WO = 'INSTALL'
	        AND
	STATUS_WO = 'OPEN'

--Q8: Are their any customers who have made a complaint more than once?
SELECT CUST_ID_CO , COUNT(ORD_ID_CO) AS COMPL_COUNT
FROM TBL_COMPLAINT_ORDER
GROUP BY CUST_ID_CO
HAVING COUNT(ORD_ID_CO) > 1

-- OR
SELECT COUNT(CUST_ID_CO)  AS CUST_COUNT
FROM (
		SELECT CUST_ID_CO , COUNT(ORD_ID_CO) AS COMPL_COUNT
		FROM TBL_COMPLAINT_ORDER
		GROUP BY CUST_ID_CO
		HAVING COUNT(ORD_ID_CO) > 1
	) AS X

--Q9: Count total open orders in the available data.
SELECT COUNT(*)  AS COUNT_OPEN_ORDER
FROM ( 
		SELECT * FROM TBL_COMPLAINT_ORDER
		WHERE STATUS_CO = 'OPEN'
		UNION ALL
		SELECT * FROM TBL_WORK_ORDER
		WHERE STATUS_WO = 'OPEN'
	) AS X

-- Q10: Are there any location ids where we have open service orders for disconnection 
-- and open complaint orders?
SELECT COUNT(*) AS COUNT_HOUSE_IDS
FROM (
		SELECT HOUSE_ID_CO FROM TBL_COMPLAINT_ORDER
		WHERE STATUS_CO = 'OPEN'
		INTERSECT
		SELECT HOUSE_ID_WO FROM TBL_WORK_ORDER
		WHERE TYPE_WO LIKE 'DISCO%'
					AND
			 STATUS_WO = 'OPEN'
	) AS X	
--Q11: Locations where customers have never given any complaints but discontinued 
-- the services.

SELECT HOUSE_ID_WO FROM TBL_WORK_ORDER
WHERE TYPE_WO LIKE 'DISCO%'
		AND STATUS_WO = 'CLOSE'
EXCEPT
SELECT HOUSE_ID_CO FROM TBL_COMPLAINT_ORDER 

--Q12: List down the customers and no of total (WO + Complaints) orders placed by them.

SELECT CUST_ID_CUS, FNAME_CUS+ ' '+ LNAME_CUS AS CUST_NAME,
COUNT(ORD_ID_CO) AS ORDERS_COUNT
FROM TBL_CUSTOMER AS A
LEFT JOIN (
		SELECT * FROM TBL_COMPLAINT_ORDER
		UNION ALL
		SELECT * FROM TBL_WORK_ORDER
		) AS B
ON CUST_ID_CUS = CUST_ID_CO
GROUP BY CUST_ID_CUS, FNAME_CUS+ ' '+ LNAME_CUS

-- OR
SELECT CUST_ID_CO, COUNT(ORD_ID_CO) AS ORDERS_COUNT
FROM (
		SELECT * FROM TBL_COMPLAINT_ORDER
		UNION ALL
		SELECT * FROM TBL_WORK_ORDER
	)  X
GROUP BY CUST_ID_CO
