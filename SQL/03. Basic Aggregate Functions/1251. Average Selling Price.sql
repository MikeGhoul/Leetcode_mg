# Diffifculty: EASY
# Problem:

Table: Prices

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
 

Table: UnitsSold

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold. 
 

Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output: 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
Explanation: 
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96


# Solution:

-- We want to recreate the average function mathematically and round to two decimals
-- Add IFFNULL wrapper in case there is no matching product sold, return 0
-- See explanation why WHERE isn't used to filter the dates - capture the filter in the Join

SELECT
Prices.product_id
, IFNULL(ROUND(SUM(price * units) / SUM(units), 2), 0)  AS average_price
FROM Prices
LEFT JOIN UnitsSold
ON Prices.product_id = UnitsSold.product_id

-- Can't use WHERE -- Why?:
-- When we use the where clause, we're filtering out the NULL matches from the left join, as if we used an INNER JOIN.

-- When we use AND in the LEFT JOIN, we're trying to match on both conditions: 
-- the product IDs are the same, AND the purchase date is between the start and end dates. 
-- If the product IDs match but the purchase date is outside the given range, we get a NULL match in the right side of the join, 
-- which we cast to 0 to correctly compute the averages. This ensures all of the product IDs are accounted for in the average calculation.

AND purchase_date BETWEEN start_date AND end_date
GROUP BY 1



