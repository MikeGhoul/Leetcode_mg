# Company:  
# Problem:

Write a query to show the number of users, number of transactions placed, and total order amount per month in the year 2020. Assume that we are only interested in the monthly reports for a single year (January-December).

Example:

Input:

transactions table

Column	Type
id	INTEGER
user_id	INTEGER
created_at	DATETIME
product_id	INTEGER
quantity	INTEGER
products table

Column	Type
id	INTEGER
name	VARCHAR
price	FLOAT
users table

Column	Type
id	INTEGER
name	VARCHAR
sex	VARCHAR
Output:

Column	Type
month	INTEGER
num_customers	INTEGER
num_orders	INTEGER
order_amt	INTEGER

# Solution:
-- extract the month
-- count distinct users
-- count all transaction ids
-- SUM of the quantity multiplied by price to aggregate order amount
select 
MONTH(created_at) AS month
, COUNT(DISTINCT(user_id)) AS num_customers
, COUNT(transactions.id) AS num_orders
, SUM(quantity * price) AS order_amt
-- CONCAT(YEAR(created_at), "_", MONTH(created_at)) AS month_year
from transactions
LEFT JOIN products
ON transactions.product_id = products.id
GROUP BY 1

