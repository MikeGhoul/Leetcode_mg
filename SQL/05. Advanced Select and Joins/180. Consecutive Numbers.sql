# Diffifculty: MEDIUM
# Problem:

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.



# Solution 1:
-- Window function solution:

-- One test case doesn't pass but this is the most logical imo
-- Order the rows by id and create two new columns:
    -- One for the previous value (lag)
    -- One for the next value (lead)
    -- If current value = previous value = future value then the num is repeated three times

SELECT
distinct num AS ConsecutiveNums
FROM
(SELECT
id
, num
, LAG(num) OVER (order by id) AS prev_val
, LEAD(num) OVER (order by id) AS future_val
FROM Logs) next_future
WHERE num = prev_val and prev_val = future_val

-- Note for more clarity:
-- This piece:

-- SELECT
-- id
-- , num
-- , LAG(num) OVER (order by id) AS prev_val
-- , LEAD(num) OVER (order by id) AS future_val
-- FROM Logs

-- Provides the following:
| id | num | prev_val | future_val |
| -- | --- | -------- | ---------- |
| 1  | 1   | null     | 1          |
| 2  | 1   | 1        | 1          |
| 3  | 1   | 1        | 2          |
| 4  | 2   | 1        | 1          |
| 5  | 1   | 2        | 2          |
| 6  | 2   | 1        | 2          |
| 7  | 2   | 2        | null       |

-- We can see for id 2, the num = prev = future which means above and below id 2 we have the same num



-- Solution 2:
-- Self joins:
-- Create three instances of the logs table using a self join
-- t1.id=t2.id-1 means find me a row in t2 with an id that is one greater than the id of a row in t1. This way we can compare the consecutive rows to check if the num values are the same. We're setting a condition for the join operation between the two aliases. The condition ensures that we're looking at two rows where the id of t2 is exactly one more than the id of t1. It's a relational condition that must be true for the rows to be joined in the query.
-- The same is done for t3.

SELECT distinct(t1.num) as ConsecutiveNums 
FROM logs t1, logs t2 , logs t3
WHERE 
    t1.id=t2.id-1 AND
    t2.id=t3.id-1 AND
    t1.num=t2.num AND
    t2.num=t3.num


t1      t2      t3
id num  id num  id num
-- ---  -- ---  -- ---
1  1    2  1    3  1   <- Consecutive sequence found for num = 1



# Solution 3 with CTE and window function - passes all test cases:
WITH lead_lag AS (
SELECT
id
, num
, LEAD(num, 1) OVER (ORDER BY id) AS next_val
, LEAD(num, 2) OVER (ORDER BY id) AS next_next_val
, LEAD(id, 1) OVER(ORDER BY id) AS id1
, LEAD(id, 2) OVER(ORDER BY id) AS id2
FROM Logs
)

SELECT
DISTINCT(num) AS ConsecutiveNums
FROM lead_lag
WHERE next_val = num  AND num = next_next_val
AND id1 = id +1 AND id2 = id1 + 1



# Solution 4 (same as above but using LAG and LEAD) - clearer to me
WITH lead_lag AS (
SELECT
id
, num
, LEAD(num) OVER (ORDER BY id) AS next_val
, LAG(num) OVER (ORDER BY id) AS prev_val
, LEAD(id) OVER(ORDER BY id) AS next_id
, LAG(id) OVER(ORDER BY id) AS prev_id
FROM Logs
)

SELECT
DISTINCT(num) AS ConsecutiveNums
FROM lead_lag
WHERE next_val = num  AND num = prev_val
AND next_id = id +1 AND prev_id = id - 1
