--*  BusIT 103           Assignment   #3              DUE DATE :  Consult course calendar
							
--You are to develop SQL statements for each task listed.  
--You should type your SQL statements under each task.  

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., SuneelPratimaAssignment03.sql). 
	Submit your file to the instructor through the course site.  
	
	Class standard: All KEYWORDS such as SELECT, FROM, WHERE, INNER JOIN and so on must be in all capital letters and on separate lines. */



Use AdventureWorksLT2012;


--1.  List the Customer ID and Name associated with the customer for each customer in the database.
--    The Name should be displayed in one column as the title, first, and last name.  The name for 
--    customer ID 29485 would be displayed as Ms. Catherine Abel. (5 points)
--    407 rows
SELECT CustomerID, Title +' '+ LastName +' '+ FirstName
AS CustomerName
FROM SalesLT.Customer



--2.  AdventureWorks foresees a 5% increase in production cost for all their products. They wish to see 
--	  how that will affect their profit margins. To help them understand this, create a list of all 
--	  products showing ProductID, Name, ListPrice, FutureCost (StandardCost * 1.05), Profit (ListPrice-FutureCost)
--    Order the result set by ListPrice with the greatest ListPrice first. Round money values to exactly 2 decimal places.

--	a. CAST is the ANSI standard. Write the statement using CAST. (7 points)
--     295 rows
SELECT ProductID, Name, ListPrice,
CAST(ROUND(ListPrice *1.05, 2) AS MONEY) AS 'FuturePrice'
FROM SalesLT.Product
ORDER BY ListPrice DESC



--  b. CONVERT is also commonly used. Use Help to find the SQL syntax for CONVERT. Write the statement again using CONVERT. (7 points)
--     295 rows
SELECT ProductID, Name, ListPrice,
ROUND(CONVERT(MONEY, ListPrice * 1.05), 2) AS 'FutureCost'
FROM SalesLT.Product
ORDER BY ListPrice DESC



--3. Use the SalesLT.SalesOrderDetail table to list all product sales.
--   Show SalesOrderID and TotalCost for each sale and LineTotal.  Compute total cost as
--   UnitPrice * (1-UnitPriceDiscount)* OrderQty. Round money values to exactly 2 decimal places.
--   Check your computation - the TotalCost you created should match the LineTotal value for each row.

--	a. CAST is the ANSI standard. Write the statement using CAST. (7 points)
--     542 rows
SELECT SalesOrderID, 
ROUND(CAST(UnitPrice *(1 - UnitPriceDiscount) * OrderQty AS MONEY), 2) AS 'TotalCost'
FROM SalesLT.SalesOrderDetail



--  b. Write the statement again using CONVERT. (7 points)
--     542 rows
SELECT SalesOrderID, 
ROUND(CONVERT(MONEY, UnitPrice *(1 - UnitPriceDiscount) * OrderQty), 2) AS 'TotalCost'
FROM SalesLT.SalesOrderDetail



--4.  List all customers showing CustomerID, CompanyName and ModifiedDate.  Format the modified date 
--    so that no time is displayed. 

--	a. CAST is the ANSI standard. Write the statement using CAST. (6 points)
--     407 rows
SELECT CustomerID, CompanyName,
CAST(ModifiedDate AS DATE) AS ModifiedDate
FROM SalesLT.Customer



--  b. Write the statement again using CONVERT. (6 points)
--     407 rows
SELECT CustomerID, CompanyName,
CONVERT(DATE, ModifiedDate) AS ModifiedDate
FROM SalesLT.Customer



--5.   EXPLORE: Find a date function that will return the current system date and time the PC 
--     on which the instance of SQL Server is running. The time zone offset is not included.
--     Format the date to show only the date AS SystemDate. (5 points)
--     Bonus +2: Find another one.
--     1 row
SELECT CAST(GETDATE() AS DATE) AS 'SystemDate'

SELECT CONVERT(DATE, GETDATE()) AS 'SystemDate'


	


