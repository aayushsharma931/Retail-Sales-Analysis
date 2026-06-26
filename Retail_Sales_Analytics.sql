-- ==========================================
-- RETAIL SALES ANALYTICS PROJECT
-- SQL Server
-- ==========================================

USE RetailSalesDB;
GO

---------------------------------------------------
-- DATA VALIDATION
---------------------------------------------------

-- Total Records
SELECT COUNT(*) AS Total_Records
FROM Orders;

-- Duplicate Check
SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT Row_ID) AS UniqueRows
FROM Orders;

---------------------------------------------------
-- BUSINESS OVERVIEW
---------------------------------------------------

-- Total Sales, Profit & Orders
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers
FROM Orders;

-- Business Question:
-- What is the average revenue generated per order?

SELECT
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM Orders;

-- Business Question:
-- How many unique products are available?

SELECT
    COUNT(DISTINCT Product_ID) AS Total_Products
FROM Orders;

-- Business Question:
-- Which shipping mode is the most popular?

SELECT
    Ship_Mode,
    COUNT(*) AS Total_Orders
FROM Orders
GROUP BY Ship_Mode
ORDER BY Total_Orders DESC;

-- Business Question:
-- Which customer segment generates the highest sales and profit?

SELECT
    Segment,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Segment
ORDER BY Total_Sales DESC;

---------------------------------------------------
-- REGIONAL ANALYSIS
---------------------------------------------------

-- Business Question:
-- Which region contributes the highest sales and profit?

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Region
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which states generate the highest sales?

SELECT TOP 10
    State,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Orders
GROUP BY State
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which states generate the highest profit?

SELECT TOP 10
    State,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY State
ORDER BY Total_Profit DESC;

-- Business Question:
-- Which states are generating an overall loss?

SELECT
    State,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY State
HAVING SUM(Profit) < 0
ORDER BY Total_Profit;

-- Business Question:
-- Which cities generate the highest sales?

SELECT TOP 10
    City,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Orders
GROUP BY City
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which cities generate the highest profit?

SELECT TOP 10
    City,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY City
ORDER BY Total_Profit DESC;

-- Business Question:
-- Which region has the highest profit margin?

SELECT
    Region,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM Orders
GROUP BY Region
ORDER BY Profit_Margin_Percentage DESC;

---------------------------------------------------
-- PRODUCT ANALYSIS
---------------------------------------------------

-- Business Question:
-- Which product category generates the highest sales and profit?

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Category
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which product category has the highest profit margin?

SELECT
    Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM Orders
GROUP BY Category
ORDER BY Profit_Margin_Percentage DESC;

-- Business Question:
-- Which sub-categories contribute the highest sales and profit?

SELECT
    Sub_Category,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which products generate the highest sales?

SELECT TOP 10
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which products generate the highest profit?

SELECT TOP 10
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Product_Name
ORDER BY Total_Profit DESC;

-- Business Question:
-- Which products generate the highest losses?

SELECT TOP 10
    Product_Name,
    ROUND(SUM(Profit), 2) AS Total_Loss
FROM Orders
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Loss;


---------------------------------------------------
-- CUSTOMER ANALYSIS
---------------------------------------------------

-- Business Question:
-- Which customers generate the highest sales?

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales
FROM Orders
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Sales DESC;

-- Business Question:
-- Which customers generate the highest profit?

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM Orders
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Profit DESC;

-- Business Question:
-- Which customers place the most orders?

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders
FROM Orders
GROUP BY Customer_ID, Customer_Name
ORDER BY Total_Orders DESC;

-- Business Question:
-- Which customer segment has the highest average order value?

SELECT
    Segment,
    ROUND(
        SUM(Sales) / COUNT(DISTINCT Order_ID),
        2
    ) AS Average_Order_Value
FROM Orders
GROUP BY Segment
ORDER BY Average_Order_Value DESC;

-- Business Question:
-- Which customers generate the highest losses?

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Profit), 2) AS Total_Loss
FROM Orders
GROUP BY Customer_ID, Customer_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Loss;

-- Business Question:
-- Which customers have the highest lifetime value?

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Lifetime_Sales,
    ROUND(SUM(Profit), 2) AS Lifetime_Profit
FROM Orders
GROUP BY Customer_ID, Customer_Name
ORDER BY Lifetime_Sales DESC;

-- Business Question:
-- Which customers have the highest profit margin?

SELECT TOP 10
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Profit_Margin_Percentage
FROM Orders
GROUP BY Customer_ID, Customer_Name
HAVING SUM(Sales) > 0
ORDER BY Profit_Margin_Percentage DESC;

---------------------------------------------------
-- DISCOUNT & PROFIT ANALYSIS
---------------------------------------------------

-- Business Question:
-- Which product category receives the highest average discount?

SELECT
    Category,
    ROUND(AVG(Discount) * 100, 2) AS Average_Discount_Percentage
FROM Orders
GROUP BY Category
ORDER BY Average_Discount_Percentage DESC;

-- Business Question:
-- How does profit vary across discount levels?

SELECT
    Discount,
    COUNT(*) AS Total_Orders,
    ROUND(SUM(Sales),2) AS Total_Sales,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM Orders
GROUP BY Discount
ORDER BY Discount;

-- Business Question:
-- Which orders received discounts of 50% or more?

SELECT
    Order_ID,
    Customer_Name,
    Product_Name,
    Sales,
    Discount,
    Profit
FROM Orders
WHERE Discount >= 0.50
ORDER BY Discount DESC;

-- Business Question:
-- Which category has the highest average profit?

SELECT
    Category,
    ROUND(AVG(Profit),2) AS Average_Profit
FROM Orders
GROUP BY Category
ORDER BY Average_Profit DESC;

-- Business Question:
-- Compare average profit at different discount levels.

SELECT
    Discount,
    ROUND(AVG(Profit),2) AS Average_Profit
FROM Orders
GROUP BY Discount
ORDER BY Discount;

-- Business Question:
-- Which orders generated a loss?

SELECT
    Order_ID,
    Customer_Name,
    Product_Name,
    Sales,
    Discount,
    Profit
FROM Orders
WHERE Profit < 0
ORDER BY Profit;

---------------------------------------------------
-- ADVANCED SQL - WINDOW FUNCTIONS
---------------------------------------------------

-- Business Question:
-- Rank products based on total sales.

SELECT
    Product_Name,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    RANK() OVER (
        ORDER BY SUM(Sales) DESC
    ) AS Sales_Rank
FROM Orders
GROUP BY Product_Name
ORDER BY Sales_Rank;

-- Business Question:
-- Rank customers based on lifetime sales.

SELECT
    Customer_ID,
    Customer_Name,
    ROUND(SUM(Sales),2) AS Lifetime_Sales,
    RANK() OVER(
        ORDER BY SUM(Sales) DESC
    ) AS Customer_Rank
FROM Orders
GROUP BY Customer_ID, Customer_Name
ORDER BY Customer_Rank;

-- Business Question:
-- Find the top 3 products by sales within each category.

WITH ProductSales AS
(
    SELECT
        Category,
        Product_Name,
        ROUND(SUM(Sales),2) AS Total_Sales,
        ROW_NUMBER() OVER(
            PARTITION BY Category
            ORDER BY SUM(Sales) DESC
        ) AS Product_Rank
    FROM Orders
    GROUP BY Category, Product_Name
)

SELECT
    Category,
    Product_Name,
    Total_Sales,
    Product_Rank
FROM ProductSales
WHERE Product_Rank <= 3
ORDER BY Category, Product_Rank;

-- Business Question:
-- Compare monthly sales over time.

SELECT
    YEAR(Order_Date) AS Sales_Year,
    MONTH(Order_Date) AS Sales_Month,
    ROUND(SUM(Sales),2) AS Monthly_Sales
FROM Orders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Sales_Year, Sales_Month;


-- Business Question:
-- Rank states according to total profit.

SELECT
    State,
    ROUND(SUM(Profit),2) AS Total_Profit,
    DENSE_RANK() OVER(
        ORDER BY SUM(Profit) DESC
    ) AS Profit_Rank
FROM Orders
GROUP BY State
ORDER BY Profit_Rank;

-- Business Question:
-- Calculate the cumulative monthly sales over time.

WITH MonthlySales AS
(
    SELECT
        YEAR(Order_Date) AS Sales_Year,
        MONTH(Order_Date) AS Sales_Month,
        ROUND(SUM(Sales),2) AS Monthly_Sales
    FROM Orders
    GROUP BY YEAR(Order_Date), MONTH(Order_Date)
)

SELECT
    Sales_Year,
    Sales_Month,
    Monthly_Sales,
    SUM(Monthly_Sales) OVER(
        ORDER BY Sales_Year, Sales_Month
    ) AS Running_Total
FROM MonthlySales
ORDER BY Sales_Year, Sales_Month;

---------------------------------------------------
-- SUBQUERY
---------------------------------------------------

-- Business Question:
-- Which products have total sales above the average product sales?

SELECT
    Product_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM Orders
GROUP BY Product_Name
HAVING SUM(Sales) >
(
    SELECT AVG(ProductSales)
    FROM
    (
        SELECT SUM(Sales) AS ProductSales
        FROM Orders
        GROUP BY Product_Name
    ) AS AvgSales
)
ORDER BY Total_Sales DESC;

