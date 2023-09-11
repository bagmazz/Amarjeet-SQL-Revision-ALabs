--USE DB_JAN22;

create database Class_Case_Study_1
/*********************************************************************************************
CREATE A TABLE
*********************************************************************************************/
CREATE TABLE TBL_ORDER (
REF_NO CHAR(14) NOT NULL,
ORD_DTE DATE NOT NULL DEFAULT '01/01/1990',
CUST_NAME VARCHAR(50) NOT NULL,
CATEGORY VARCHAR(20) NOT NULL,
PRODUCT VARCHAR(20) NOT NULL,
SALES NUMERIC(18, 5),
PROFIT FLOAT
);

INSERT INTO TBL_ORDER VALUES
('CA-2012-124891', '7/31/2012', 'Rick Hansen', 'Technology', 'Accessories', 2309.65, 762.1845), 
('CA-2014-135909', '10/14/2014', 'Jane Waco', 'Office Supplies', 'Binders', 5083.96, 1906.485), 
('CA-2012-116638', '1/28/2012', 'Joseph Holt', 'Furniture', 'Tables', 4297.644, -1862.3124), 
('CA-2014-143567', '11/3/2014', 'Thomas Boland', 'Technology', 'Accessories', 2249.91, 517.4793), 
('CA-2011-154627', '10/29/2011', 'Sue Ann Reed', 'Technology', 'Phones', 2735.952, 341.994), 
('CA-2013-159016', '3/11/2013', 'Karen Ferguson', 'Technology', 'Phones', 4158.912, 363.9048), 
('CA-2012-139731', '10/15/2012', 'Joel Eaton', 'Furniture', 'Chairs', 2453.43, -350.49), 
('CA-2011-168494', '12/12/2011', 'Nora Preis', 'Furniture', 'Tables', 3610.848, 135.4068), 
('CA-2011-160766', '9/14/2011', 'Darrin Martin', 'Technology', 'Machines', 2799.96, 1371.9804), 
('US-2014-168116', '11/5/2014', 'Grant Thornton', 'Technology', 'Machines', 7999.98, -3839.9904), 
('CA-2011-116904', '9/23/2011', 'Sanjit Chand', 'Office Supplies', 'Binders', 9449.95, 4630.4755), 
('US-2012-163825', '6/16/2012', 'Lena Creighton', 'Office Supplies', 'Binders', 3050.376, 1143.891), 
('US-2014-135013', '7/25/2014', 'Harold Ryan', 'Technology', 'Copiers', 2399.96, 839.986), 
('CA-2012-111829', '3/19/2012', 'Fred Hopkins', 'Technology', 'Copiers', 3149.93, 1480.4671), 
('CA-2014-129021', '8/24/2014', 'Patrick Brill', 'Technology', 'Phones', 4367.896, 327.5922), 
('CA-2012-114811', '11/8/2012', 'Keith Dawkins', 'Technology', 'Machines', 4643.8, 2229.024), 
('CA-2013-143805', '12/2/2013', 'Jonathan Doherty', 'Office Supplies', 'Appliances', 2104.55, 694.5015), 
('CA-2012-145352', '3/16/2012', 'Christopher Martinez', 'Office Supplies', 'Binders', 6354.95, 3177.475), 
('CA-2014-138289', '1/17/2014', 'Andy Reiter', 'Office Supplies', 'Binders', 5443.96, 2504.2216), 
('CA-2014-118892', '8/18/2014', 'Tom Prescott', 'Furniture', 'Chairs', 4416.174, -630.882), 
('US-2012-163825', '6/16/2012', 'Lena Creighton', 'Office Supplies', 'Binders', 3050.376, 1143.891), 
('CA-2012-114811', '11/8/2012', 'Keith Dawkins', 'Technology', 'Machines', 4643.8, 2229.024)

select * from TBL_ORDER