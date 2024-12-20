USE school_db;
CREATE DATABASE retail_project;
CREATE TABLE retail_sales(
				transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT


			);
            

SELECT * FROM retail_sales
where           transaction_id IS NULL
			    OR	
                sale_date IS NULL
                OR
                sale_time IS NULL
                OR
                customer_id	IS NULL
                OR
                gender	IS NULL
                OR
                age	IS NULL
                OR
                category IS NULL
                OR
                quantity	IS NULL
                OR
                price_per_unit IS NULL
                OR
                cogs IS NULL
                OR
                total_sale IS NULL;
                
	-- DATA EXPLORATION
    -- How many sales we have?
    SELECT COUNT(transaction_id) FROM retail_sales;
    
    -- How many UNIQUE customers we have?
    SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- How many category we have?
SELECT DISTINCT category FROM retail_sales;

-- How many UNIQUE category we have?
SELECT COUNT(DISTINCT category) FROM retail_sales;


SELECT * FROM retail_sales;

-- Data Analysis
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    DATE_FORMAT(sale_date,'%Y-%m') = '2022-11'
    AND
    quantity >= 4 ;
    
    
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category , SUM(total_sale) FROM retail_sales 
GROUP BY category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT category , avg(age) FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category , gender , COUNT(transaction_id) FROM retail_sales
GROUP BY category,gender;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
     Year,Month,avg_sale
 FROM    
(
SELECT 
YEAR(sale_date) as Year,
MONTHNAME(sale_date) as Month,
AVG(total_sale) AS avg_sale,
RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC ) AS Rank_
FROM retail_sales
GROUP BY Year,Month
) AS T1
WHERE Rank_ = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale)AS max_sale FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category, COUNT(DISTINCT customer_id) FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS(
SELECT *,
 CASE
  WHEN HOUR(sale_time) <= 12 THEN 'Morning'
  WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
  ELSE 'Evening'
  END AS Shift
  
FROM retail_sales
)
SELECT 
Shift,
COUNT(*) AS total_
FROM hourly_sale
GROUP BY Shift;

--   End of PROJECT