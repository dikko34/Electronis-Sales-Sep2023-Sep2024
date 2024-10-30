





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



SELECT SUM(Quantity)ToTalSalesNo ,SUM([Total Price]) TotalSales
FROM [Electronic_sales_Sep2023-Sep2024]


SELECT *, 
CASE
	WHEN [Purchase Date] LIKE '%2024%' THEN '2024'
	WHEN [Purchase Date] LIKE '%2023%' THEN '2023'
END Year
FROM [Electronic_sales_Sep2023-Sep2024]



SELECT * 
FROM [Electronic_sales_Sep2023-Sep2024]




