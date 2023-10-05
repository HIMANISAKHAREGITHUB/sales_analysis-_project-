# analyZE 
use sales_analysis;
show tables;
select * from sample_superstore
limit 5 ;


-- What are total sales and total profits of each year?
SELECT year('OrderDate') AS year, 
SUM(sales) AS total_sales,
SUM(profit) AS total_profit
FROM sample_superstore
GROUP BY year
ORDER BY year ASC;


-- 2. What are the total profits and total sales per quarter?
SELECT 
  EXTRACT(year from 'orderdate') as year, 
  CASE 
    WHEN extract(month from 'orderdate') IN (1,2,3) THEN 'Q1'
    WHEN extract(month from  'orderdate') IN (4,5,6) THEN 'Q2'
    WHEN extract(month from  'orderdate') IN (7,8,9) THEN 'Q3'
    ELSE 'Q4'
  END AS quarter,
  SUM(sales) AS total_sales,
  SUM(profit) AS total_profit
FROM sample_superstore
GROUP BY year, quarter
ORDER BY year, quarter;
-- What region generates the highest sales and profits ?
 SELECT region ,SUM(Sales) as total_sales, sum(profit) as total_profit
 from sample_superstore
 group by region
 order by total_sales desc,total_profit desc;
 -- each regions profit margins for further analysis;
 select region, round(sum(profit)/sum(sales)*100,2) as profit_margin
 from sample_superstore
 group by region
 order by profit_margin desc;
--  4. What state and city brings in the highest sales and profits ?-- 
SELECT State, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits, ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_margin
FROM sample_superstore
GROUP BY State
ORDER BY profit_margin DESC
LIMIT 10;

-- 5. The relationship between discount and sales and the total discount per category-- 
SELECT Discount, round(AVG(Sales),2) AS Avg_Sales
FROM sample_superstore
GROUP BY Discount
ORDER BY Discount;