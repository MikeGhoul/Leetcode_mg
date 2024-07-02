# Difficulty:  
# Problem:

-- Calculate the number of duplicates in a column

# Solution:

-- How many orders are we shipping to the same customer (either id or ship_name)

SELECT 
ship_name 
, COUNT(*) AS count_of_orders
FROM hbsoe.orders
GROUP BY 1
HAVING COUNT(*) >= 10 -- optional to include a filter on the group (can't use alias)
ORDER BY 2 DESC
