-- USE DEMO;

select * from TBL_COURSE
select * from TBL_MAPPING
select * from TBL_STUDENT


CREATE TABLE TBL_STUDENT (
STU_ID INT IDENTITY(101, 1) PRIMARY KEY,
NAME VARCHAR(50) NOT NULL,
DOB DATETIME NOT NULL,
PHONE_CUS CHAR(12),
EMAIL_CUS VARCHAR(70)
);

CREATE TABLE TBL_COURSE (
COURSE_ID INT IDENTITY(201, 1) PRIMARY KEY,
NAME VARCHAR(10) NOT NULL
);

CREATE TABLE TBL_MAPPING (
STU_ID INT REFERENCES TBL_STUDENT(STU_ID),
COURSE_ID INT REFERENCES TBL_COURSE(COURSE_ID)
);

INSERT INTO TBL_STUDENT VALUES
('Kallie Blackwood', '09/07/1975', '415-9170-276', 'kallie.blackwood@abc.com'), 
('Johnetta Abdallah', '08/08/1995', '919-6014-934', 'johnetta_abdallah@abc.com'), 
('Bobbye Rhym', '09/18/1972', '650-5905-578', 'brhym@abc.com'), 
('Micaela Rhymes', '08/05/1967', '925-1192-329', 'micaela_rhymes@abc.com'), 
('Tamar Hoogland', '12/14/1994', '740-1061-857', 'tamar@abc.com');

select * from TBL_STUDENT

INSERT INTO TBL_COURSE VALUES
('EXCEL'), 
('VBA'), 
('TABLEAU'), 
('JAVA'), 
('PYTHON'), 
('SAS'), 
('SQL'), 
('R'), 
('DOT NET'), 
('PHP');

INSERT INTO TBL_MAPPING VALUES
(101, 201), 
(101, 202), 
(101, 203), 
(102, 205), 
(102, 208), 
(105, 201), 
(105, 202), 
(105, 203), 
(105, 205), 
(105, 207), 
(105, 208);