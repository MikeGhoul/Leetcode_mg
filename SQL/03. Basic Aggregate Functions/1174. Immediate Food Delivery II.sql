# Diffifculty: MEDIUM
# Problem:

Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customers preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
Explanation: 
The customer id 1 has a first order with delivery id 1 and it is scheduled.
The customer id 2 has a first order with delivery id 2 and it is immediate.
The customer id 3 has a first order with delivery id 5 and it is scheduled.
The customer id 4 has a first order with delivery id 7 and it is immediate.
Hence, half the customers have immediate first orders.



# Solution:

# 1. Get the first orders of each customer_id
# 2. If the first order has order date = to delivery date, then immediate
# 3. Calc % of customers who's orders are immediate for first order
WITH first_order AS (
SELECT 
customer_id
, MIN(order_date) AS first_date
FROM Delivery
GROUP BY 1
)

SELECT
ROUND(SUM(CASE WHEN first_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100/ COUNT(DISTINCT first_order.customer_id), 2)  AS immediate_percentage
FROM first_order
LEFT JOIN Delivery
ON first_order.customer_id = Delivery.customer_id




# CTE + Window function to get the first instance of each customer order:
-- Create a column to determine if an order is immediate or scheduled
-- Create a ranked column that takes the first order by customer_id
-- Select from CTE where conditions are met: first order and order is immediate
-- Divide by total number of distinct customers

WITH ranked_order AS (
SELECT
delivery_id
, customer_id
, order_date
, customer_pref_delivery_date
, CASE WHEN order_date = customer_pref_delivery_date THEN 'immediate' ELSE 'scheduled' END AS cust_pref_type
, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS cust_order
FROM Delivery
ORDER BY customer_id, order_date
)

SELECT
ROUND((SUM(CASE WHEN cust_pref_type = 'immediate' THEN 1 ELSE 0 END) / COUNT(DISTINCT(customer_id))) * 100, 2) AS immediate_percentage
FROM ranked_order
WHERE cust_order = 1




# Solution not using cte (simpler):

SELECT
-- ROUND(SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) * 100/ COUNT(DISTINCT customer_id), 2)  AS immediate_percentage
ROUND(AVG(IF(order_date = customer_pref_delivery_date, 1, 0)) * 100, 2) AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id)

