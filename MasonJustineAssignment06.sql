--*  BusIT 103           Assignment   #6              DUE DATE :  Consult course calendar
							
--You are required to use INNER JOINs to solve each problem. We are not using cross joins with WHERE clauses. 
--Even if you know another method that will produce the result, this module is practice in INNER JOINs.

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., SuneelPratimaAssignment06.sql). 
	Submit your file to the instructor through the course site.  
	
	Class standard: All KEYWORDS such as SELECT, FROM, WHERE, INNER JOIN and so on must be in all capital letters and on separate lines. */


--You are to develop SQL statements for each task listed. You should type your SQL statements under each task. 


USE AdventureWorks2012;

--  You are required to use INNER JOINs to solve each problem. We are not using cross joins with WHERE clauses.
--  To make the joins in the first 4 question more understandable, create a database diagram with the following tables:
	--Production.Product
	--Production.ProductReview
	--Production.ProductModel
	--Production.ProductSubcategory
	--Production.ProductCategory

--1.a.	List any products that have product reviews.  Show product ID, product name, and comments.
--		Hint:  Use the Production.Product and Production.ProductReview tables. (1 points)
--		4 Rows
 SELECT p.ProductID, p.Name, r.Comments
 FROM Production.Product p
 INNER JOIN Production.ProductReview r
 ON p.ProductID = r.ProductID

--1.b.	Modify 1.a. to list product reviews for Product ID 798.  Show product ID, product name,
-- and comments. (6 points)
--		1 Row
SELECT p.ProductID, p.Name, r.Comments
 FROM Production.Product p
 INNER JOIN Production.ProductReview r
 ON p.ProductID = r.ProductID
 WHERE p.ProductID = 798


--2.a.	List products with product model numbers. Show Product ID, product name, 
--		standard cost, model ID number, and model name. Order by model ID. (1 points)
--		Hint: Look for a table that contains "model" in its name
--		295 Rows
SELECT p.ProductID, p.Name, p.StandardCost, m.ProductModelID, m.Name
FROM Production.Product p
INNER JOIN Production.ProductModel m
ON p.ProductModelID = m.ProductModelID


--2. b.	Modify 2.a. to list products whose product model is 3 (Full-Finger Gloves). Show Product ID , product name, 
--		standard cost, ID number, and model name and order by model ID. (6 points)
--		3 Rows
SELECT p.ProductID, p.Name, p.StandardCost, m.ProductModelID, m.Name
FROM Production.Product p
INNER JOIN Production.ProductModel m
ON p.ProductModelID = m.ProductModelID
WHERE p.ProductModelID = 3



--3. a.	List Products, their subcategories and their categories.  Show the category name, subcategory name, 
--		product ID, and product name, in this order. Sort in alphabetical order on category name,
--		then subcategory name, and then by product name. (1 points)
--		295 Rows

--		Hint:  To understand the relationshships, refer to your database diagram and the following tables:
--		Production.Product
--		Production.ProductSubCategory
--		Production.ProductCategory
SELECT c.Name AS 'CategoryName', s.Name AS 'SubcategoryName', p.ProductID, p.Name AS 'ProductName'
FROM Production.ProductCategory c
INNER JOIN Production.ProductSubcategory s
ON c.ProductCategoryID = s.ProductCategoryID
INNER JOIN Production.Product p
ON s.ProductSubcategoryID = p.ProductSubcategoryID
ORDER BY 'CategoryName', 'SubcategoryName', 'ProductName'




--3. b.	Modify 3.a. to list Products in category 1.  Show the category name, subcategory name, 
--		product ID, and product name, in this order. Sort in alphabetical order on category name,
--		then subcategory name, and then by product name. (6 points)
--		Hint: Add the product category id field to the results set to check your results and then remove it or comment it out.
--		97 Rows
SELECT c.Name AS 'CategoryName', s.Name AS 'SubcategoryName', p.ProductID, p.Name AS 'ProductName'
FROM Production.ProductCategory c
INNER JOIN Production.ProductSubcategory s
ON c.ProductCategoryID = s.ProductCategoryID
INNER JOIN Production.Product p
ON s.ProductSubcategoryID = p.ProductSubcategoryID
WHERE c.ProductCategoryID = 1
ORDER BY 'CategoryName', 'SubcategoryName', 'ProductName'




--4.a.	List Products, their subcategories, their categories, and their model.  Show the model name, category name, 
--		subcategory name, product ID, and product name in this order. Sort in alphabetical order by model name. (1 points)
--		295 Rows

--		Hint:  To understand the relationshships, refer to your database diagram and the following tables:
--		Production.Product
--		Production.ProductSubCategory
--		Production.ProductCategory
--		Production.ProductModel
--		Choose a path from one table to the next and follow it in a logical order
SELECT m.Name AS 'ModelName', c.Name AS 'CategoryName', s.Name AS 'SubcategoryName', p.ProductID, p.Name AS 'ProductName'
FROM Production.ProductModel m
INNER JOIN Production.Product p
ON m.ProductModelID = p.ProductModelID
INNER JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory c
ON s.ProductCategoryID = c.ProductCategoryID
ORDER BY 'ModelName' 





--4. b.	Modify 4.a. to list those products in model ID 5 with silver in the product name. Change
-- the sort to sort only on Product ID. Hint: Add the product model id field to the results set to
-- check your results and then remove it or comment it out. (6 points)
--	5 Rows
SELECT m.Name AS 'ModelName', c.Name AS 'CategoryName', s.Name AS 'SubcategoryName', p.ProductID, p.Name AS 'ProductName'
FROM Production.ProductModel m
INNER JOIN Production.Product p
ON m.ProductModelID = p.ProductModelID
INNER JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
INNER JOIN Production.ProductCategory c
ON s.ProductCategoryID = c.ProductCategoryID
WHERE m.ProductModelID = 5 
AND p.Name LIKE '%Silver%'
ORDER BY 'ModelName' 


--5.	List sales for customer id 18759.  Show product names, sales order id, and OrderQty. (5 points)
--		8 Rows
--		Hint:  First create a database diagram with the following tables:
--		Production.Product
--		Sales.SalesOrderHeader
--		Sales.SalesOrderDetail
-- 
SELECT p.Name AS 'ProductName', h.SalesOrderID, d.OrderQty
FROM Sales.SalesOrderHeader h
INNER JOIN Sales.SalesOrderDetail d
ON h.SalesOrderID = d.SalesOrderID
INNER JOIN Production.Product p
ON p.ProductID = d.ProductID
WHERE h.CustomerID = 18759




--6.	List all sales for Bikes that were ordered during 2008.  Show product ID, product name,
-- and LineTotal for each line item sale.
--	Show the list in order alphabetically by product name. (7 points)
--	 Hint: Use the diagram you created in #5
--	11378 Rows. IMP: If using AdventureWorks2017, # of rows will be different. See below for more info 
/*
NOTE: If you are using AdventureWorks2017 Database (DB), your result set might be slightly different
 than what you would normally see with 2012 DB. So, do not worry too much about the number of 
rows returned by SQL Server when using 2017 DB. If your SQL/code is correct, I will run it 
under 2012 DB and it will be fine.Q#6: AdventureWorks2017 does not have OrderDate for year 2008.
So, you will use any year of your choice from 2011- 2014. Your result in that case will NOT be
11378 Rows and that is OK. I will run your query on 2012.
*/
SELECT p.ProductID, p.Name AS 'ProductName', d.LineTotal
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail d
ON p.ProductID = d.ProductID
INNER JOIN Sales.SalesOrderHeader h
ON h.SalesOrderID = d.SalesOrderID
INNER JOIN Production.ProductSubcategory s
ON p.ProductSubcategoryID = s.ProductSubcategoryID
WHERE h.OrderDate BETWEEN '2008-01-01' AND '2008-12-31'
AND s.Name LIKE '%bikes%'
ORDER BY p.Name

	
--7.	In your own words, write a business question for AdventureWorks that you will try to answer with a SQL query.
--		Then try to develop the SQL to answer the question. (10 points)
--		You may find that the AdventureWorks database structure is highly normalized and therefore, difficult
--		to work with.  As a result, you may not run into difficulties when developing your SQL.  For this task
--		that is fine.  Just show your question and as much SQL as you were able to figure out. 

--      Show order quantitiy of helments sold in 2005, display by order date

SELECT p.ProductID, p.Name AS 'ProductName', c.Name AS SubcatName, s.OrderQty, h.OrderDate
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail s
ON p.ProductID = s.ProductID
INNER JOIN Production.ProductSubcategory c
ON p.ProductSubcategoryID = c.ProductSubcategoryID
INNER JOIN Sales.SalesOrderHeader h
ON h.SalesOrderID = s.SalesOrderID
WHERE c.Name LIKE '%helmet%'
AND h.OrderDate BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY h.OrderDate

