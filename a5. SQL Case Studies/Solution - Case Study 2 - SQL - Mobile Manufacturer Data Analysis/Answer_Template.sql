--SQL Advance Case Study

--Q1--BEGIN 
	
Select distinct Loc.State
  From Fact_Transactions as Trans
  join Dim_Customer as Cust on Trans.IDCustomer = Cust.IDcustomer
  join DIM_LOCATION as Loc on Trans.IDLocation = Loc.IDLocation
  join DIM_DATE as  Dat on Trans.Date = Dat.Date
  where  Dat.Year >= 2005;

--Q1--END

--Q2--BEGIN
	
Select TOP 1
    loc.State
  from Fact_Transactions T
  join Dim_Customer as cust on T.IDCustomer = Cust.IDcustomer
  join DIM_LOCATION as loc on T.IDLocation = loc.IDLocation
  join Dim_Model as Mode on T.IDModel = Mode.IDModel
  Where Mode.Model_Name LIKE 'Galaxy%'
  Group BY loc.State
  Order BY count(*) Desc

--Q2--END

--Q3--BEGIN      
	
Select
    Loc.State,
    Loc.ZIPCode,
    Mode.Model_Name,
    Count(*) AS TransactionCount
      From Fact_Transactions Trans
      Join Dim_Customer as Cust on Trans.IDCustomer = Cust.IDcustomer
      join DIM_LOCATION as Loc on Trans.IDLocation = Loc.IDLocation
      Join Dim_Model as Mode on Trans.IDModel = Mode.IDModel
      Group By Loc.State, Loc.ZIPCode, Mode.Model_Name
      Order By Loc.State, Loc.ZIPCode, Mode.Model_Name

--Q3--END

--Q4--BEGIN

Select TOP 1
     M.Model_Name,
     M.Unit_Price
from Dim_Model M
Order By M.Unit_Price Asc

--Q4--END

--Q5--BEGIN

Select
      Model_Name,
      avg(Unit_Price) AS Average_Price_of_model
     From (
          Select
          Dm.Model_Name,
          Dm.Unit_Price,
          Manuf.Manufacturer_Name, 
          Dense_rank() over (order BY Sum(Trans.Quantity) Desc) AS Sales_Rank
          From Dim_Model as Dm
          join Fact_Transactions as Trans On Dm.IDModel = Trans.IDModel
          join Dim_Manufacturer as Manuf On Dm.IDManufacturer = Manuf.IDManufacturer
          Group By Dm.Model_Name, Dm.Unit_Price, Manuf.Manufacturer_Name
  ) as Ranked_Models
  where Sales_Rank <= 5
  Group By Model_Name
  Order By Average_Price_of_model

--Q5--END

--Q6--BEGIN
    
Select
    Cust.Customer_Name,
    Avg(Trans.TotalPrice) as Average_Amount
     from Dim_Customer as Cust
     join Fact_Transactions as Trans on Cust.IDCustomer = Trans.IDCustomer
     join DIM_DATE as Dat on Trans.Date = Dat.Date
      Where Dat.Year = 2009
      Group By Cust.Customer_Name
      Having Avg(Trans.TotalPrice) > 500;

--Q6--END
	
--Q7--BEGIN 

Select IDModel
From (
    Select Top 5
        IDModel
    From Fact_Transactions as T
    Join DIM_DATE as  D ON T.Date = D.Date
    Where D.Year = 2008
    Group By IDModel
    Order By SUM(Quantity) DESC
) as year_2008

Intersect

Select IDModel
From (
    Select Top 5
        IDModel
    From Fact_Transactions as T
    Join DIM_DATE as D ON T.Date = D.Date
    Where D.Year = 2009
    Group By IDModel
    Order By Sum(Quantity) DESC
) year_2009

Intersect

Select IDModel
From (
    Select Top 5
        IDModel
    From Fact_Transactions as T
    Join DIM_DATE as D ON T.Date = D.Date
    WHERE D.Year = 2010
    Group by IDModel
    Order by SUM(Quantity) DESC
) year_2010;


--Q7--END	


--Q8--BEGIN

Select
    M1.Manufacturer_Name AS Manufacturer_2009,
    M2.Manufacturer_Name AS Manufacturer_2010
From (
    Select
        Model.IDManufacturer,
        Dat.year,
        Rank() Over (Partition By Dat.Year Order By Sum(Trans.Quantity) Desc) as SalesRank
    From Fact_Transactions as Trans
    Join Dim_Model as Model on Trans.IDModel = Model.IDModel
    Join DIM_DATE as Dat on Trans.Date = Dat.Date
    Where Dat.Year IN (2009, 2010)
    Group by Model.IDManufacturer, Dat.Year
) as rank_1
JOIN (
    SELECT
        Model.IDManufacturer,
        Dat.Year,
        Rank() Over (Partition By Dat.Year Order By sum(Trans.Quantity) Desc) as SalesRank
    From Fact_Transactions as Trans
    Join Dim_Model as Model on Trans.IDModel = Model.IDModel
    Join DIM_DATE as Dat on Trans.Date = Dat.Date
    Where Dat.Year IN (2009, 2010)
    Group by Model.IDManufacturer, Dat.Year
) rank_2 
ON Rank_1.Year = 2009 AND Rank_2.Year = 2010 AND rank_1.SalesRank = 2 AND rank_2.SalesRank = 2
JOIN Dim_Manufacturer M1 ON Rank_1.IDManufacturer = M1.IDManufacturer
JOIN Dim_Manufacturer M2 ON Rank_2.IDManufacturer = M2.IDManufacturer

--Q8--END

--Q9--BEGIN
	
Select distinct manuf1.Manufacturer_Name
  FROM Dim_Manufacturer as Manuf1
  join Dim_Model as Model_1 On Manuf1.IDManufacturer = Model_1.IDManufacturer
  join Fact_Transactions as Trans_1 On Model_1.IDModel = Trans_1.IDModel
  join DIM_DATE Date1 ON Trans_1.Date = Date1.Date
  WHERE Date1.Year = 2010
  
  Except
  
select distinct Manuf2.Manufacturer_Name
  From Dim_Manufacturer as Manuf2
  join Dim_Model as Model_2 ON Manuf2.IDManufacturer = Model_2.IDManufacturer
  join Fact_Transactions as Trans_2 ON Model_2.IDModel = Trans_2.IDModel
  join DIM_DATE Date_2 ON Trans_2.Date = Date_2.Date
  Where Date_2.Year = 2009;

--Q9--END

--Q10--BEGIN
	
Select Top 100
    Cust.IDCustomer,
    Cust.Customer_Name,
    Date_1.Year,
   Avg(Trans.TotalPrice) AS Average_Spend_by_Customer,
    Avg(Trans.Quantity) AS Average_Quantity,
    Round(((Avg(Trans.TotalPrice) - Lag(avg(Trans.TotalPrice)) Over (Partition By Cust.IDCustomer Order By Date_1.Year)) /
	Lag(Avg(Trans.TotalPrice)) Over (Partition By Cust.IDCustomer Order By Date_1.Year)) * 100, 2) 
	As SpendChangePercentage
  From Dim_Customer as Cust
  Join Fact_Transactions as Trans on Cust.IDCustomer = Trans.IDCustomer
  Join DIM_DATE as Date_1 on Trans.Date = Date_1.Date
  Group By Cust.IDCustomer, Cust.Customer_Name, Date_1.Year
  Order By Cust.IDCustomer, Date_1.Year

--Q10--END
	