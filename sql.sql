CREATE DATABASE retail_sales_project;
USE retail_sales_project;

SELECT COUNT(*) FROM sales_store;
SELECT * 
FROM sales_store
ORDER BY transaction_id DESC
LIMIT 10;
SELECT * FROM sales_store;

--Step 1:- To check for Duplicate 


SELECT transaction_id, COUNT(*) AS count
FROM sales_store
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT *
FROM sales_store
WHERE transaction_id IN (
SELECT transaction_id
FROM sales_store
GROUP BY transaction_id
HAVING COUNT(*) > 1
);

DELETE s1
FROM sales_store s1
JOIN sales_store s2
ON s1.transaction_id = s2.transaction_id
AND s1.customer_id > s2.customer_id;

SET SQL_SAFE_UPDATES = 0;

DELETE s1
FROM sales_store s1
JOIN sales_store s2
ON s1.transaction_id = s2.transaction_id
AND s1.customer_id > s2.customer_id;

SELECT *
FROM sales_store
WHERE transaction_id IS NULL
OR customer_id IS NULL
OR customer_name IS NULL
OR customer_age IS NULL
OR gender IS NULL
OR product_id IS NULL
OR product_name IS NULL
OR product_category IS NULL
OR quantiy IS NULL
OR payment_mode IS NULL
OR purchase_date IS NULL
OR status IS NULL
OR prce IS NULL;

UPDATE sales_store
SET gender = 'M'
WHERE gender = 'Male';

UPDATE sales_store
SET gender = 'F'
WHERE gender = 'Female';

SET SQL_SAFE_UPDATES = 0;

UPDATE sales_store
SET payment_mode = 'Credit Card'
WHERE payment_mode = 'CC';


select * from sales_store;
-- Top 5 Selling Products


SELECT product_name, SUM(quantiy) AS total_quantity_sold
FROM sales_store
WHERE status = 'delivered'
GROUP BY product_name
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- Most Cancelled Products

SELECT product_name, COUNT(*) AS total_cancelled
FROM sales_store
WHERE status='cancelled'
GROUP BY product_name
ORDER BY total_cancelled DESC
LIMIT 5;

-- Peak Purchase Time

SELECT 
CASE 
    WHEN HOUR(time_of_purchase) BETWEEN 0 AND 5 THEN 'Night'
    WHEN HOUR(time_of_purchase) BETWEEN 6 AND 11 THEN 'Morning'
    WHEN HOUR(time_of_purchase) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
END AS time_of_day,
COUNT(*) AS total_orders
FROM sales_store
GROUP BY time_of_day
ORDER BY total_orders DESC;

-- Top 5 Highest Spending Customers

SELECT customer_name,
SUM(prce * quantiy) AS total_spend
FROM sales_store
GROUP BY customer_name
ORDER BY total_spend DESC
LIMIT 5;

-- Highest Revenue Categories

SELECT product_category,
SUM(prce * quantiy) AS revenue
FROM sales_store
GROUP BY product_category
ORDER BY revenue DESC;

-- Cancellation Rate by Category
SELECT product_category,
ROUND(COUNT(CASE WHEN status = 'cancelled' THEN 1 END) * 100.0 / COUNT(*), 2) AS cancel_percent
FROM sales_store
GROUP BY product_category
ORDER BY cancel_percent DESC;


-- preffered payment mode

SELECT payment_mode, COUNT(*) AS total_count
FROM sales_store
GROUP BY payment_mode
ORDER BY total_count DESC;

-- Age Group vs Purchase

SELECT 
CASE 
    WHEN customer_age BETWEEN 18 AND 25 THEN '18-25'
    WHEN customer_age BETWEEN 26 AND 35 THEN '26-35'
    WHEN customer_age BETWEEN 36 AND 50 THEN '36-50'
    ELSE '50+'
END AS age_group,
SUM(prce * quantiy) AS total_spending
FROM sales_store
GROUP BY age_group
ORDER BY total_spending DESC;

-- Monthly Sales Trend

SELECT 
DATE_FORMAT(purchase_date, '%Y-%m') AS month,
SUM(prce * quantiy) AS total_sales
FROM sales_store
GROUP BY month
ORDER BY month;

SELECT purchase_date 
FROM sales_store
LIMIT 10;
DESCRIBE sales_store;
UPDATE sales_store
SET purchase_date = STR_TO_DATE(purchase_date, '%d-%m-%Y');
ALTER TABLE sales_store
MODIFY purchase_date DATE;

-- Gender vs Product Category

SELECT gender, product_category, COUNT(*) AS total
FROM sales_store
GROUP BY gender, product_category
ORDER BY gender;
