create database sql_practice

create table Student_Data (
Stu_ID int identity(101,1) primary key not null,
Student_Name varchar(100) not null,
Student_Age bigint not null, 
College_With_City varchar(1000) not null,
Admission_Date date not null,
Gender char(1),
Student_email varchar(100),
Student_phone_number char(10),
Background varchar(100),
Term_1_Marks int,
Term_2_Marks int,
)

create table Course_Data (
Course_Id int identity(301 ,1) primary key not null,
Course varchar(100) not null
)

insert into Student_Data values
('Amarjeet', 21, 'Standford University, Cailfornia', '09/13/2017', 'M', 'amar987@gmail.com', '1234567890', 'Computer Science' , 88, 87),
('vanshaj' , 21, 'IIT Bombay, Mumbai', '12/14/2015', 'M', 'vanshaj534@gmail.com', '0987654321', 'Computer Science' , 80, 89),
('Vishal'  , 29, 'SRCC, Delhi', '12/23/2014', 'M', 'vishal123@gmail.com', '1122334455', 'Medical' , 45, 67),
('Karan'   , 23, 'Hansraj, Delhi', '11/14/2005', 'M', 'karamuee@gmail.com', '9988776655', 'Law' , 48, 78),
('Tushar'  , 27,'Hindu, Delhi', '10/15/2006', 'M', 'tushar234@gmail.com', '5566774422', 'Literature' , 56, 80),
('Shruti'  , 29,'LSR, Delhi', '11/16/2008', 'F', 'shruti86@gmail.com', '1122887766', 'Arts' , 87, 85),
('Aditi'   , 23,'Madras College, Chennai', '11/14/2016', 'F', 'aditi349@gmail.com', '5544663322', 'Law' , 78, 58),
('Shivika' , 21,'SRCC, Delhi', '09/13/2020', 'F', 'shivi097@gmail.com', '9977553322', 'Psychology' , 81, 86),
('Sheetal' , 22,'Thapar, Chandigarh', '12/09/2018', 'F', 'sheetal765@gmail.com', '1199882233', 'Medical' , 83, 56),
('Sonu'    , 23, 'IIT Delhi, Delhi', '09/07/2017', 'M', 'sonu234@gmail.com', '2244668811', 'Medical' , 97, 79),
('Ayesha'  , 34,'Hindu, Delhi', '11/18/2014', 'F', 'ayesha123@gmail.com', '1177446633', 'Computer Science' , 98, 93),
('Priya'   , 28,'IIT Delhi, Delhi', '10/19/2015', 'F', 'priya563@gmail.com', '4477883322', 'History' , 91, 92),
('Khalid' , 23,'IIT Bombay, Mumbai', '10/20/2016', 'M', 'khalid876@gmail.com', '2255778899', 'Commerce' , 76, 98),
('Yuvika' , 21,'IIT Delhi, Delhi', '11/21/2017', 'F', 'yuika343@gmail.com',  '2233445577', 'Geography' , 92, 91),
('Aparna' , 23,'Xavier, Mumbai', '12/25/2012', 'F', 'apar@gmail.com', '3344556677', 'Commerce' , 86, 23),
('Vedant' , 21,'PEC, Chandigarh', '09/13/2008', 'M', 'vedant567@gmail.com', '7766554422', 'Medical' , 10, 56),
('Gaurav' , 23,'NSUT, Delhi', '01/12/2007', 'M', 'gaurav875@gmail.com', '2244556677', 'Law' , 56,23 ),
('Ankit'  , 21,'VIT, Vellore', '09/17/2005', 'M', 'Ankit653@gmail.com', '7755332211', 'Music' , 12, 65),
('Saurabh' ,20, 'MIT, Banglore', '10/14/2006', 'M', 'saurab84@gmail.com', '2233557777', 'Commerce' , 50, 78),
('rishab' , 21,'YMCA, Faridabad', '11/20/2004', 'M', 'rishi83y@gmail.com', '9977664433', 'Medical' , 83, 80)

select * from Student_Data

insert into Course_Data values 
('Excel' ),              
('Web Development'),
('Android Development'),
('Python'),
('Java'),
('Kotlin'),
('SQL'),
('C++'),
('UI/UX Design'),
('ML/AI'),
('Big Data'),
('R'),
('Cloud Computing'),
('Saas'),
('Salesforce'),
('Tableau'),
('PHP'),
('Dot Net'),
('Ruby'),
('Perl');

select * from Course_Data

create table Student_Course_Mapping (
Student_Id int references student_data(Stu_ID),
Course_Id int references course_data(Course_ID)
);

insert into Student_Course_Mapping values
(101, 301),
(102, 301),
(103, 302),
(104, 303),
(105, 303),
(103, 301),
(104, 304),
(105, 304),
(106, 305),
(107, 304),
(107, 302),
(108, 301),
(108, 306),
(110, 308),
(111, 301),
(112, 302),
(113, 310),
(114, 310),
(101, 311),
(102, 312),
(104, 313),
(117, 314),
(113, 315), 
(119, 316),
(113, 315), 
(114, 316),
(116, 319),
(117, 320),
(118, 312),
(119, 313),
(120, 314);

select * from Student_Course_Mapping


-- 109 and 105 is the student number -- 
-- 307 and 317 and 318 is the Student_Id -- 

select * from Student_Data 

-- 1. Add a new column 'Nick Name' Using alter command 

alter table student_data add Nick_Name varchar(30)

-- 2. add data in the column nick name 

update Student_Data set Nick_name = 'amar' where Student_Name = 'amarjeet'
update Student_Data set Nick_name = 'vansh' where Student_Name = 'vanshaj'
update Student_Data set Nick_name = 'vish' where Student_Name = 'vishal'
update Student_Data set Nick_name = 'kat' where Student_Name = 'karan'
update Student_Data set Nick_name = 'tushi' where Student_Name = 'tushar'
update Student_Data set Nick_name = 'shree' where Student_Name = 'sheetal'
update Student_Data set Nick_name = 'monu' where Student_Name = 'sonu'
update Student_Data set Nick_name = 'ayeshu' where Student_Name = 'ayesha'
update Student_Data set Nick_name = 'piyu' where Student_Name = 'priya'
update Student_Data set Nick_name = 'shivi' where Student_Name = 'shivika'
update Student_Data set Nick_name = 'adi' where Student_Name = 'aditi'
update Student_Data set Nick_name = 'shron' where Student_Name = 'shruti'
update Student_Data set Nick_name = 'yuvi' where Student_Name = 'yuvika'
update Student_Data set Nick_name = 'appu' where Student_Name = 'aparna'
update Student_Data set Nick_name = 'ved' where Student_Name = 'vedant'
update Student_Data set Nick_name = 'gaur' where Student_Name = 'gaurav'
update Student_Data set Nick_name = 'ank' where Student_Name = 'ankit'
update Student_Data set Nick_name = 'khali' where Student_Name = 'khalid'
update Student_Data set Nick_name = 'sober' where Student_Name = 'saurabh'
update Student_Data set Nick_name = 'rishi' where Student_Name = 'rishab'

-- 3. extract a college name, city name from the data 
-- a. college name
select Student_Name ,college_with_city, left(college_with_city, 
         charindex(',', college_with_city) -1)as college from Student_Data

-- b. city
select student_name , college_with_city, right(college_with_city, 
          len(college_with_city)- charindex(',', college_with_city)) as city from Student_Data


-- 4. find the position of the comma in the college with city column 
select college_with_city , CHARINDEX(',', college_with_city) as Comma_position from Student_Data

-- 5. find the details of the details of the student whose starts with s and ends with a 
select * from Student_Data where Student_Name like 's%a'

-- 6. find the details of the student whose starts with end with i
select * from Student_Data where Student_Name like '%i'

-- 7. find the details of the student whose starts with a end with a 
select * from Student_Data where Student_Name like 'a%a'

--8 find the details whose marks above 80 in both term 1 and term 2
select * from Student_Data where Term_1_Marks > 80 and Term_2_Marks >80 

--9 update the marks of the some students belong to gender males
update Student_Data set Term_1_Marks = 81, Term_2_Marks= 82 where Student_Name = 'vanshaj'
update Student_Data set Term_1_Marks = 83, Term_2_Marks= 84 where Student_Name = 'sonu'
update Student_Data set Term_1_Marks = 87, Term_2_Marks= 88 where Student_Name = 'vishal'

-- 10 show the nick name of the students whose name is starts with s or a and ends with a
select nick_name as [Informal Name] from Student_Data where Student_Name like '[sa]%a'

-- 11. calulate the total marks as per genders in term 1 
select gender, sum(term_1_marks) as [Total Marks] 
from student_data
group by gender


--12. display the details of the students who has background of cs and medical
select * from Student_Data where Background in ('computer science', 'medical')

-- 13. hide the phone number 
select student_phone_number , stuff( student_phone_number, 5,10, 'xxxxx') as New_phone_number from Student_Data

-- 14. display total marks in term 1 of the students who has belong from medical
select background , sum(term_1_marks) as total_marks from Student_Data 
group by background 
having background = 'medical'

-- note having will be always used when there is we have to categorized by  aggregate functions. 


-- 15. display the months, years and day
select admission_date , month(admission_date) as Months, day(admission_date) as [Day], 
year(admission_date) as Years from Student_Data

--16. display the difference from today and admission date
select student_name, admission_date, getdate() as Today,
datediff(year, admission_date, getdate()) as Year_gap ,
datediff(month, admission_date, getdate()) as month_gap,
datediff(day, admission_date, getdate()) as day_gap from student_data

-- 17. display the months name 
select admission_date, datepart(month, admission_date)as month_number ,format(admission_date, 'mmm') 
as Months_name from Student_Data 

-- 18. display the course completion duration consider it 6 months
select admission_date, DATEADD(month, 6, admission_date) as Course_Duration, DATEADD(day, 10, admission_date) 
as Course_Duration from Student_Data


-- joins --- 

select * from Student_Data
select * from Course_Data
select * from Student_Course_Mapping

--Q1: Display student details and the courses they are enrolled to 

-- inner join 

select x.*, Y.course_id from Student_Data As X 
Inner join Student_Course_Mapping as Y
on X.stu_id = Y.student_id

--Q2: Display details of all students and the count of courses they are enrolled to.

select A.* , count(B.course_id) as Count_of_courses from Student_Data AS A
left join Student_Course_Mapping as B
on A.Stu_ID = B.Student_Id
group by A.Stu_ID, Student_Name,Student_Age, College_With_City, Admission_Date, Gender, Student_email,
Background, Nick_Name, Student_phone_number, Term_1_Marks, Term_2_Marks

--Q3: Display details of students which are not yet enrolled to any course.

select TableA.*, TableB.course_Id from Student_Data as TableA
left join Student_Course_Mapping as TableB
on TableA.Stu_ID = tableB.Student_Id
where TableB.Course_Id is null

--Q4: List all courses and the count of students enrolled to each course.
select A.*, count(b.Student_Id) as count_of_students from Course_Data as A
left join Student_Course_Mapping as B
on A.Course_Id = B.Course_Id
group by A.Course_Id, A.Course

----- case statement -----
--question: display the grades

select *, Case
when term_1_marks > 80 then 'good student'
when term_1_marks < =80 and term_1_marks >=60 then 'nice student'
else 'need improvement'
end as Grades
from Student_Data

-- get the education qualification
select *,case
when background = 'computer science' then 'BTECH CSE'
when background = 'medical' then 'MBBS'
when background = 'law' then 'LLB'
when background = ('Arts''psychology') then 'BA'
when background = 'commerce' then 'BCOM'
else 'others'
end as Educational_Qualification 
from Student_Data


-- 
-- sub queries -- remember you have to practice it after your exam 




