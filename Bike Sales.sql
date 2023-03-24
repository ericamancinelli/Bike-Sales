
----Data Cleaning 

--Remove TimeStamp from date column
ALTER TABLE SupplySales..BikeSales
ALTER COLUMN DATE date 

--Remove Unnecessary column
ALTER TABLE SupplySales..BikeSales
DROP COLUMN Column1

--Now Calc Margin + Unit Margin
SELECT *, ([Unit Price] - [Unit Cost]) AS Unit_Margin
FROM SupplySales..BikeSales

SELECT *, ROUND((([Unit Price] - [Unit Cost])/[Unit Price])*100, 2) AS UnitMargin_Percent
FROM SupplySales..BikeSales

SELECT *, Revenue - Cost AS Profit_Margin
FROM SupplySales..BikeSales

SELECT *, ROUND(((Revenue - Cost)/Revenue)*100,2) AS Percent_Margin
FROM SupplySales..BikeSales

--Add to Table as new columns 
ALTER TABLE SupplySales..BikeSales
ADD Unit_Margin integer
UPDATE SupplySales..BikeSales
SET Unit_Margin = ([Unit Price] - [Unit Cost])

ALTER TABLE SupplySales..BikeSales
ADD Percent_Unit_Margin integer
UPDATE SupplySales..BikeSales
SET Percent_Unit_Margin = ROUND((([Unit Price] - [Unit Cost])/[Unit Price])*100, 2)

ALTER TABLE SupplySales..BikeSales
ADD Profit_Margin integer
UPDATE SupplySales..BikeSales
SET Profit_Margin = Revenue - Cost 

ALTER TABLE SupplySales..BikeSales
ADD Percent_Profit_Margin integer
UPDATE SupplySales..BikeSales
SET Percent_Profit_Margin = ROUND(((Revenue - Cost)/Revenue)*100,2)


----Data Exploration

--Types of Products Sold 
SELECT DISTINCT [Sub Category]
FROM SupplySales.dbo.BikeSales

--Look at Revenue per Country 
SELECT Country, SUM(Revenue)
FROM SupplySales..BikeSales
WHERE Country IS NOT NULL
GROUP BY Country

--Look at Sales in US 
SELECT State, SUM(Revenue) AS State_Revenue
FROM SupplySales..BikeSales
WHERE Country = 'United States'
GROUP BY State
ORDER BY State_Revenue DESC

--Most profitable Accessories 
SELECT [Sub Category], SUM(Revenue) AS Category_Revenue
FROM SupplySales..BikeSales
WHERE [Product Category] = 'Accessories'
GROUP BY [Sub Category]
ORDER BY Category_Revenue DESC






