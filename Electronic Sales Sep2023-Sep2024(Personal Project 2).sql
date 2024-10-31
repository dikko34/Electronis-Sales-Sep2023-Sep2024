





SELECT MAX(Age) MaxAge ,Min(Age) MinAge, AVG(Age) AvgAge
FROM [Electronic_sales_Sep2023-Sep2024]

-- Creating AgeGroup Column
DROP TABLE IF EXISTS #UpdatedElectronics
CREATE TABLE #UpdatedElectronics
(CustomerID int,
Age int,
Gender Nvarchar(255),
LoyaltyMember Nvarchar(255),
ProductType Nvarchar(255),
SKU Nvarchar(255),
Rating int,
OrderStatus Nvarchar(255),
PaymentMethod Nvarchar(255),
TotalSales float,
UnitPrice float,
Quantity int,
PurchaseDate datetime,
ShippingType Nvarchar(255),
Addons Nvarchar(255),
AddOnsTotal float,
AgeGroup Nvarchar(255)
)

INSERT INTO #UpdatedElectronics
SELECT *,
CASE 
	WHEN Age <=35 THEN 'Young'
	WHEN Age <=69 THEN 'MiddleAge'
	ElSE 'Old'
END AgeGroup 
FROM [Electronic_sales_Sep2023-Sep2024]

SELECT *
FROM #UpdatedElectronics


--Customer Purchase Patterns
SELECT CustomerID,COUNT(CustomerID) NoOfOrders,SUM(TotalSales) TotalSales
FROM #UpdatedElectronics
WHERE OrderStatus = 'Completed'
GROUP BY CustomerID




-- Product Sales Performance
SELECT [Product Type], SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
GROUP BY [Product Type]
ORDER BY TotalSales DESC


-- Total Sales by AgeGroup
SELECT AgeGroup ,SUM(TotalSales) TotalSales
FROM #UpdatedElectronics
GROUP BY AgeGroup
ORDER BY AgeGroup DESC


--Rolling sum of TotalSales OverTime
SELECT [Purchase Date],[Total Price],SUM([Total Price]) OVER (PARTITION BY [Purchase Date] ORDER BY [Purchase Date] ,[Total Price]) RollingTotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
GROUP BY [Purchase Date],[Total Price]

SELECT [Purchase Date]
FROM [Electronic_sales_Sep2023-Sep2024]
WHERE [Purchase Date] Like '%2024%'

--Temp table 1
CREATE TABLE #Product_Sales_Performance
(
Product_Types Nvarchar(255),
Total_Sales float
)

INSERT INTO #Product_Sales_Performance
-- Product Sales Performance
SELECT [Product Type], SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
GROUP BY [Product Type]
ORDER BY TotalSales DESC

--Temp table 2
DROP TABLE IF EXISTS #Total_Sales_AgeGroup
CREATE TABLE #Total_Sales_AgeGroup
(
Age_Group Nvarchar(255),
Total_Sales float
)

INSERT INTO #Total_Sales_AgeGroup
-- Total Sales by AgeGroup
SELECT AgeGroup ,SUM(TotalSales) TotalSales
FROM #UpdatedElectronics
GROUP BY AgeGroup
ORDER BY AgeGroup DESC

--Temp table 3
CREATE TABLE #Customer_Purchase_patterns 
(
CustomerID int,
OrderCount int,
Total_Sales float,
)

INSERT INTO #Customer_Purchase_patterns 
SELECT [Customer ID],COUNT([Customer ID]) NoOfOrders,SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
WHERE [Order Status] = 'Completed'
GROUP BY [Customer ID]

--CREATING VIEWS


--VIEW 1
CREATE VIEW Product_Sales_Performance AS
SELECT [Product Type], SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
GROUP BY [Product Type]
--ORDER BY TotalSales DESC

--VIEW 2
CREATE VIEW Rolling_sum_of_TotalSales_OverTime AS
SELECT [Purchase Date],[Total Price],SUM([Total Price]) OVER (PARTITION BY [Purchase Date] ORDER BY [Purchase Date] ,[Total Price]) RollingTotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
GROUP BY [Purchase Date],[Total Price]

--VIEW 3
CREATE VIEW Customer_Purchase_patterns  AS
SELECT [Customer ID],COUNT([Customer ID]) NoOfOrders,SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]
WHERE [Order Status] = 'Completed'
GROUP BY [Customer ID]

SELECT SUM(Quantity)ToTalSalesNo ,SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]



SELECT * 
FROM [Electronic_sales_Sep2023-Sep2024]




