# Diffifculty: EASY
# Problem:

Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

The result format is in the following example.

 

Example 1:

Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation: Hercy has 2 people report directly to him, Alice and Bob. Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.
Example 2:

Input: 
Employees table:
+-------------+---------+------------+-----+ 
| employee_id | name    | reports_to | age |
|-------------|---------|------------|-----|
| 1           | Michael | null       | 45  |
| 2           | Alice   | 1          | 38  |
| 3           | Bob     | 1          | 42  |
| 4           | Charlie | 2          | 34  |
| 5           | David   | 2          | 40  |
| 6           | Eve     | 3          | 37  |
| 7           | Frank   | null       | 50  |
| 8           | Grace   | null       | 48  |
+-------------+---------+------------+-----+ 
Output: 
+-------------+---------+---------------+-------------+
| employee_id | name    | reports_count | average_age |
| ----------- | ------- | ------------- | ----------- |
| 1           | Michael | 2             | 40          |
| 2           | Alice   | 2             | 37          |
| 3           | Bob     | 1             | 37          |
+-------------+---------+---------------+-------------+


# Solution:
-- Perform a self join on id joined with reports to 
-- Take the count and average age of the table with the reports to data

SELECT
e_1.employee_id
, e_1.name
, COUNT(e_2.reports_to) AS reports_count
, ROUND(AVG(e_2.age)) AS average_age
FROM employees AS e_1
JOIN employees AS e_2
ON e_1.employee_id = e_2.reports_to
GROUP BY 1, 2
ORDER BY 1


# Self Join 2:
SELECT
e.employee_id
, e.name
, SUM(CASE WHEN e.employee_id = r.reports_to THEN 1 ELSE 0 END) AS 
reports_count
, ROUND(SUM(CASE WHEN e.employee_id = r.reports_to THEN r.age ELSE 0 END) / COUNT(e.employee_id), 0) AS average_age
FROM Employees e
JOIN Employees r
ON e.employee_id = r.reports_to
GROUP BY 1, 2
ORDER BY 1


# CTE option:
WITH manager_agg AS (
SELECT
reports_to AS manager_id
, COUNT(*) AS reports_count
, ROUND(AVG(age), 0) AS average_age
FROM Employees
WHERE reports_to IS NOT NULL
GROUP BY reports_to
)

SELECT 
employee_id
, name
, COALESCE(manager_agg.reports_count, 0) AS reports_count
, manager_agg.average_age
FROM Employees
LEFT JOIN manager_agg
ON Employees.employee_id = manager_agg.manager_id
WHERE manager_agg.reports_count > 0
ORDER BY 1




# CTE option 2:
-- Switch the order of the join to avoid creating NULLS to deal with
-- Faster because we aren't joining unnecessary rows - only focusing on ids that are managers
WITH manager_agg AS (
SELECT
reports_to AS manager_id
, COUNT(*) AS reports_count
, ROUND(AVG(age), 0) AS average_age
FROM Employees
WHERE reports_to IS NOT NULL
GROUP BY reports_to
)

SELECT 
employee_id
, name
, manager_agg.reports_count
, manager_agg.average_age
FROM manager_agg
LEFT JOIN Employees
ON Employees.employee_id = manager_agg.manager_id
ORDER BY 1



