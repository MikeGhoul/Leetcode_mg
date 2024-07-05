# Diffifculty: EASY
# Problem:

Table: Weather

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.
 

Write a solution to find all dates Id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Weather table:
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2015-01-01 | 10          |
| 2  | 2015-01-02 | 25          |
| 3  | 2015-01-03 | 20          |
| 4  | 2015-01-04 | 30          |
+----+------------+-------------+
Output: 
+----+
| id |
+----+
| 2  |
| 4  |
+----+
Explanation: 
In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
In 2015-01-04, the temperature was higher than the previous day (20 -> 30).


# Solution:

# CTE and Window Function:
WITH temp_diff_cte AS(
SELECT
id
, recordDate
, temperature
, temperature - LAG(temperature) OVER (ORDER BY recordDate) AS temp_diff
, DATEDIFF(recordDate, LAG(recordDate) OVER (ORDER BY recordDate)) AS date_diff
FROM Weather
)

SELECT
id
FROM temp_diff_cte
WHERE temp_diff > 0
AND date_diff = 1


# Using Self Join:
-- This joins each day with the previous day
SELECT
b.id
FROM weather a
JOIN weather b
ON DATEDIFF(b.recordDate, a.recordDate) = 1 
WHERE b.temperature > a.temperature


-- This is the intermediate result:
| a.id  | a.recordDate | a.temperature  | b.id  | b.recordDate | b.temperature  |
+-------+--------------+----------------+-------+--------------+----------------+
| 1     | 2015-01-01   | 10             | 2     | 2015-01-02   | 25             |
| 2     | 2015-01-02   | 25             | 3     | 2015-01-03   | 20             |
| 3     | 2015-01-03   | 20             | 4     | 2015-01-04   | 30             |
+-------+--------------+----------------+-------+--------------+----------------+

-- We then filter the results where b.temp > a.temp and select the b.id for those instances.



# Using Cross Join:
SELECT
b.id
FROM weather a
JOIN weather b
ON a.id = b.id
WHERE DATEDIFF(b.recordDate, a.recordDate) = 1 AND b.temperature > a.temperature

-- This is the intermediate result (partial - full with have all 16 row combos):
+----+-----------+-----------+-----------+
| id | prev_temp | curr_temp | date_diff |
+----+-----------+-----------+-----------+
| 1  |    10     |    10     |     0     |
| 2  |    10     |    25     |     1     |
| 3  |    10     |    20     |     2     |
| 4  |    10     |    30     |     3     |
| 1  |    25     |    10     |    -1     |
| 2  |    25     |    25     |     0     |
...
+----+-----------+-----------+-----------+


