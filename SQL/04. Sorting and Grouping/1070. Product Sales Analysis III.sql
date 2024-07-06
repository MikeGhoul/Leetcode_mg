# Diffifculty: MEDIUM
# Problem:

Table: Sales

+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |
+-------------+-------+
(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.
 

Table: Product

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| product_id   | int     |
| product_name | varchar |
+--------------+---------+
product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.
 

Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

Return the resulting table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Sales table:
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+ 
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
Product table:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
Output: 
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+ 
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+


# Solution:
-- NOTE: the problem says order doesn't matter 
-- but it threw an error when using the other where condition was used showing errors that were clearly based on the order of the results
-- including product_id in the where condition's subquery fixed it but the question should be clearer

SELECT
product_id
, year AS first_year
, quantity
, price
FROM Sales
WHERE (product_id , year) IN (SELECT product_id, min(year) FROM Sales GROUP BY product_id)

-- WHERE year IN (SELECT min(year) FROM Sales GROUP BY product_id)


# Using CTE:
-- Note there was an issue on some of the test cases using row_number() instead
-- of DENSE_RANK() and that might mean there are instances where products had multiple records in the same start year
-- The problem wasn't clear on this edge case but DENSE_RANK() pulls in all instances of the first year if we rank by year.

WITH ranked_sales_year AS (
SELECT
sale_id
, product_id
, year
, quantity
, price
, DENSE_RANK() OVER (PARTITION BY product_id ORDER BY year) AS rank_year
FROM Sales
)

SELECT
product_id
, year AS first_year
, quantity
, price
FROM ranked_sales_year
WHERE rank_year = 1

