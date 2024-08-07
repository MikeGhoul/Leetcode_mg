# Diffifculty: MEDIUM
# Problem:

Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
Explanation: 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86

# Solution:

-- Create cte 1 to consolidate instances of dupe dates and aggregate amounts
-- Create cte 2 to SUM on Last 7 days (rows between 6 preceding and current row)
	-- Include Row num so we can filter in the final results to only include instances where we have 7 days (row num >= 7)
-- Select from cte 2, calculate the average over 7 days, filter where row num is greater or = to 7 to ensure we have 7 days of data to work with

WITH agg_date AS (
	SELECT visited_on
	, SUM(amount) AS amount
	FROM Customer
	GROUP BY 1
)
, agg_sliding_7 AS(
	SELECT
	visited_on
	, SUM(amount) OVER (ORDER BY visited_on rows between 6 preceding and current row) AS amount
	, ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
	FROM agg_date
)
	SELECT
	visited_on
	, amount
	, ROUND(amount / 7, 2) AS average_amount
	FROM agg_sliding_7
	WHERE row_num >= 7



# Can also do the running avg for past 7 days in second cte:

WITH amt_per_day AS (
SELECT
visited_on
, SUM(amount) AS amount_per_day
FROM Customer
GROUP BY 1
)
, running_tot AS (
SELECT
visited_on
, SUM(amount_per_day) OVER (ORDER BY visited_on rows between 6 preceding and current row) AS running_amt
, AVG(amount_per_day) OVER (ORDER BY visited_on rows between 6 preceding and current row) AS running_amt_avg
, ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
FROM amt_per_day
)

SELECT 
visited_on
, running_amt AS amount
, ROUND(running_amt_avg, 2) AS average_amount
FROM running_tot
WHERE row_num >= 7	

