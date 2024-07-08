-- From SQL For Data Analysis:
-- I give candidates a hypothetical table called orders, which has a date, customer identifier, order identifier, 
-- and an amount, and then ask them to write a SQL query that returns the distribution of orders per customer

-- orders:
-- - date
-- - customer_id
-- - order_id
-- - amount

-- First get the number of orders per customer

WITH num_orders_per_cust AS (
SELECT 
customer_id 
, COUNT(order_id) AS num_orders
FROM hbsoe.orders
GROUP BY 1
)

-- Take the discrete number of orders and count the number of customers in each bucket: e.g. 7 customers made 3 ordersOrder 

SELECT 
num_orders 
, COUNT(customer_id) AS num_customers
FROM num_orders_per_cust
GROUP BY 1
ORDER BY 1