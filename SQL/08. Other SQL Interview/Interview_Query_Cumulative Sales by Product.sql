# Company: 
# Problem:

You are working with the sales team of an e-commerce store to analyze their monthly performance.

They give you the sales table that tracks every purchase made on the store. The table contains the columns id (purchase id), product_id, date (purchase date), and price.

Write a SQL query to compute the cumulative sum of sales for each product, sorted by product_id and date.

Note: The cumulative sum for a product on a given date is the sum of the price of all purchases of the product that happened on that date and on all previous dates.

Example:
Input:

sales table

Column	Type
id	INTEGER
product_id	INTEGER
date	DATE
price	FLOAT
Output:

Column	Type
product_id	INTEGER
date	DATE
cumulative_sum	FLOAT


# Solution:

 -- select product, date
 -- sum the price based on product_id ordered ascending by date using a window function
SELECT 
product_id 
, date
, SUM(price) OVER (PARTITION BY product_id ORDER BY date) AS cumulative_sum
FROM sales

