CREATE database Sales;
use sales;
select * from inventory;
select * from products;
select * from sales;
select * from stores;

/*the monthly-wise sales trend across stores and locations for both years 2022 & 2023.*/
SELECT 
    YEAR(Date_Converted) AS Year,
    MONTH(Date_Converted) AS Month,
    st.Store_Location,
    SUM(s.Units * p.Product_retail_Price) AS Total_Sales
FROM SALES s
JOIN STORES st ON s.Store_ID = st.Store_ID
JOIN PRODUCTS p ON s.Product_ID = p.Product_ID
GROUP BY Year, Month, st.Store_Location
ORDER BY Year, Month, Total_Sales DESC;

/*Total Sales per Store*/

SELECT 
    st.Store_ID,
    st.Store_Name,
    SUM(s.Units * p.Product_Retail_Price) AS Total_Sales
FROM SALES s
JOIN STORES st ON s.Store_ID = st.Store_ID
JOIN PRODUCTS p ON s.Product_ID = p.Product_ID
GROUP BY st.Store_ID, st.Store_Name
ORDER BY Total_Sales DESC;

/*Product–Store Relationship Towards Sales*/
SELECT 
    s.Store_ID,
    st.Store_Name,
    p.Product_ID,
    p.Product_Name,
    SUM(s.Units) AS Total_Units_Sold,
    SUM(s.Units * p.Product_Retail_Price) AS Total_Sales
FROM SALES s
JOIN STORES st ON s.Store_ID = st.Store_ID
JOIN PRODUCTS p ON s.Product_ID = p.Product_ID
GROUP BY s.Store_ID, st.Store_Name, p.Product_ID, p.Product_Name
ORDER BY Total_Sales DESC;

/* Show All Categories Ranked by Sales */
SELECT 
    p.Product_Category,
    SUM(s.Units * p.Product_Retail_Price) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(s.Units * p.Product_Retail_Price) DESC) AS Category_Rank
FROM SALES s
JOIN PRODUCTS p ON s.Product_ID = p.Product_ID
GROUP BY p.Product_Category
ORDER BY Total_Sales DESC;

/*Find out the average inventory as per each store and product.*/
SELECT 
    i.Store_ID,
    i.Product_ID,
    AVG(i.Stock_On_Hand) AS Avg_Inventory
FROM INVENTORY i
GROUP BY i.Store_ID, i.Product_ID
ORDER BY Avg_Inventory DESC;


SELECT 
    st.Store_Location,
    SUM(s.Units) AS Total_Units
FROM SALES s
JOIN STORES st ON s.Store_ID = st.Store_ID
GROUP BY st.Store_Location
ORDER BY Total_Units DESC;

