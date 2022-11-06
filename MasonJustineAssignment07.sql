--*  BusIT 103           Assignment   #7              DUE DATE :  Consult course calendar
							
--You are to develop SQL statements for each task listed.  
--You should type your SQL statements under each task.  

/*	Submit your .sql file named with your last name, first name and assignment # (e.g., SuneelPratimaAssignment07.sql). 
	Submit your file to the instructor through the course site.  
	
	Class standard: All KEYWORDS such as SELECT, FROM, WHERE, INNER JOIN and so on must be in all capital letters and on separate lines. */


USE AdventureWorksDW2012; 

--1.a.	List AdventureWorks male customers.
--		Show first & last names and state.  
--		Order the list by last name, then first name. (1 point)
--      9351 Rows
SELECT cust.Gender, cust.LastName, cust.FirstName, geo.StateProvinceName
FROM dbo.DimCustomer cust
JOIN dbo.DimGeography geo
ON cust.GeographyKey = geo.GeographyKey
WHERE gender = 'M' 
ORDER BY 2,3



--1.b.	Copy/paste query from 1.a. and modify to list AdventureWorks female customers from Oregon. (4 points)
--		Show first & last names and state.  
--		Order the list by last name, then first name.
--      545 Rows
SELECT cust.Gender, cust.LastName, cust.FirstName, geo.StateProvinceName
FROM dbo.DimCustomer cust
JOIN dbo.DimGeography geo
ON cust.GeographyKey = geo.GeographyKey
WHERE gender = 'F' AND StateProvinceName = 'Oregon' 
ORDER BY 2,3



--2.a.	Explore the data warehouse using the Dim.Product table.  
--		Show the English product name, product key, product alternate key, standard cost and list price.
--		Sort on English product name. Note how the name and the alternate key remain the same but the
--		product is entered again using with a new primary key to reflect the history of changes to the product attributes. (1 point)
--	    606 rows
SELECT EnglishProductName, ProductKey, ProductAlternateKey, StandardCost, ListPrice
FROM dbo.DimProduct
ORDER BY 1




--2.b.	Show the English product name and product alternate key for each product only once.
--		Sort on English product name. Note the difference in record count. (1 point)
--		504 rows
SELECT DISTINCT EnglishProductName, ProductAlternateKey
FROM dbo.DimProduct
ORDER BY 1




--2.c.	List Products, their subcategories and their categories with each product appearing only once.
--		Show the English category name, English subcategory name, product alternate key, and English product name.
--		Sort the results by the English category name, English subcategory name, and English product name 
--		The record count will go down again because some products in the product table are inventory and
--		not for sale. They don't have a value in the ProductSubcategory field. (5 points)
--		295 rows
SELECT DISTINCT c.EnglishProductCategoryName, s.EnglishProductSubcategoryName, p.ProductAlternateKey, p.EnglishProductName
FROM dbo.DimProduct p
JOIN dbo.DimProductSubCategory s
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
JOIN dbo.DimProductCategory c
ON s.ProductCategoryKey = c.ProductCategoryKey
ORDER BY 1,2,4



--3.	List all English named products purchased over the Internet by customers who have a graduate degree.
--		Show Product key and English Product Name and English Education.  
--		Order the list by English Product name. (5 points)
--		Show a product only once even if it has been purchased several times.
--		155 Rows
SELECT DISTINCT i.ProductKey, p.EnglishProductName, c.EnglishEducation
FROM dbo.DimProduct p
JOIN dbo.FactInternetSales i
ON i.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c
ON i.CustomerKey = c.CustomerKey
WHERE c.EnglishEducation LIKE '%graduate%'
ORDER BY 2




--4.	List all English named products purchased over the Internet by customers whose work in professional or managerial jobs.
--		Show Product key and English Product Name and English Occupation.  
--		Order the list by English Product name. (5 points)
--		Show a product only once even if it has been purchased several times.
--	    314 Rows
SELECT DISTINCT i.ProductKey, p.EnglishProductName, c.EnglishOccupation
FROM dbo.DimProduct p
JOIN dbo.FactInternetSales i
ON i.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c
ON i.CustomerKey = c.CustomerKey
WHERE c.EnglishOccupation = 'Professional' 
OR c.EnglishOccupation = 'Management' 
ORDER BY 2



--5.	List customers who have purchased accessories over the Internet.  
--		Show customer first name and last name, and English product category.
--		If a customer has purchased accessories more than once, show only 1 row for that customer.  That customer should not appear twice.
--		Order the list by last name, then first name. (6 points)
--		15,062 rows
SELECT DISTINCT c.FirstName, c.LastName, ca.EnglishProductCategoryName
FROM dbo.DimProduct p
JOIN dbo.FactInternetSales i
ON i.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c
ON i.CustomerKey = c.CustomerKey
JOIN dbo.DimProductSubcategory sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN dbo.DimProductCategory ca
ON sc.ProductCategoryKey = ca.ProductCategoryKey
WHERE ca.EnglishProductCategoryName = 'Accessories'
ORDER BY 3,2


--6.	List all Internet sales for clothing that occurred during 2007 (Order Date in 2007).  
--		Show product Key, Product name, and SalesAmount for each line item sale.
--		Show the date as mm/dd/yyyy as DateOfOrder. (6 points)
--		Show the list in oldest to newest order by date and alphabetically by Product name.
--	    3708 Rows
SELECT f.ProductKey, p.EnglishProductName, f.SalesAmount, CAST(f.OrderDate AS Date) AS DateOfOrder, ca.EnglishProductCategoryName
FROM dbo.DimProduct p
JOIN dbo.FactInternetSales f
ON f.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c
ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimProductSubcategory sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN dbo.DimProductCategory ca
ON sc.ProductCategoryKey = ca.ProductCategoryKey
WHERE f.OrderDate >= '2007-01-01 00:00:00' 
AND f.OrderDate < '2007-12-31 23:59:59'
AND ca.EnglishProductCategoryName LIKE '%cloth%'
ORDER BY 4,2



--7.	List all Internet sales of Bikes purchased by customers in British Columbia during 2006.  
--		Show product Key, product name, and SalesAmount for each line item sale.
--		Show the list in order alphabetically by product name. (6 points)
--		223 Rows
SELECT f.ProductKey, p.EnglishProductName, f.SalesAmount
FROM dbo.DimProduct p
JOIN dbo.FactInternetSales f
ON f.ProductKey = p.ProductKey
JOIN dbo.DimCustomer c
ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimProductSubcategory sc
ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN dbo.DimProductCategory ca
ON sc.ProductCategoryKey = ca.ProductCategoryKey
JOIN dbo.DimGeography g
ON g.GeographyKey = c.GeographyKey
WHERE f.OrderDate >= '2006-01-01 00:00:00' 
AND f.OrderDate < '2006-12-31 23:59:59'
AND ca.EnglishProductCategoryName LIKE '%bike%'
AND g.StateProvinceName LIKE '%British%'
ORDER BY 2



--8.	In your own words, write a business question that you can answer by querying the data warehouse.
--		Then write the SQL query that will provide the information that you are seeking. (10 points)
--     Are the due dates of orders being met and where are the orders going? 
--    Show Order date, due date, ship date, and state/province name in order of location, then order and ship date
--    Display to show if the due dates exceed the order or ship dates 
SELECT CAST(f.OrderDate AS Date) AS OrderDate, CAST(f.DueDate AS Date) AS DueDate, CAST(f.ShipDate AS Date) AS ShipDate, g.StateProvinceName
FROM dbo.FactInternetSales f
JOIN dbo.DimCustomer c
ON f.CustomerKey = c.CustomerKey
JOIN dbo.DimGeography g
ON g.GeographyKey = c.GeographyKey
WHERE f.DueDate <= f.OrderDate
OR f.DueDate <= f.ShipDate
ORDER BY 4,1,3
 





	


