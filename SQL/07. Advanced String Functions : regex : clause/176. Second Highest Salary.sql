# Diffifculty: MEDIUM
# Problem:

Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

# Solution:

# Option 1 (Using window function and CTE):
WITH cte_rank AS 
(SELECT 
salary
, dense_rank() OVER (ORDER BY salary DESC) AS ranked
FROM employee
)
SELECT 
MAX(salary) AS SecondHighestSalary
FROM cte_rank
WHERE ranked = 2
# Explanation: Using MAX allows a return of NULL if there is only one value
# It also will just return the one value if there are two values for rank = 2


# Option 2 (Subquery)
SELECT
MAX(salary) AS SecondHighestSalary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee)
# Explanation 2: 
# Using the same max logic to handle nulls
# Getting the Max salary where the salary is less than the overall MAX


