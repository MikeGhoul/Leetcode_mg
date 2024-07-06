# Diffifculty: EASY
# Problem:

Table: MyNumbers

+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.
 

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.

The result format is in the following example.

 

Example 1:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
Output: 
+-----+
| num |
+-----+
| 6   |
+-----+
Explanation: The single numbers are 1, 4, 5, and 6.
Since 6 is the largest single number, we return it.
Example 2:

Input: 
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
Output: 
+------+
| num  |
+------+
| null |
+------+
Explanation: There are no single numbers in the input table so we return null.


# Solution:
-- Select the max from a subquery where you group the num and filter on the aggregate having a count = 1
-- Using max will work becuase it will return null if there is no match in the subquery

SELECT
MAX(num) AS num
FROM 
    (SELECT
    num
    FROM MyNumbers
    GROUP BY 1
    HAVING (COUNT(num)) = 1) 
AS dev_num



# Using CTE:
WITH agg_nums AS (
SELECT
num
, COUNT(num) AS num_counts
FROM MyNumbers
GROUP BY num
ORDER BY num DESC
)

SELECT
MAX(num) AS num
FROM agg_nums
WHERE num_counts = 1


