# Company:  
# Problem:


Write a query to identify the manager with the biggest team size.

You may assume there is only one manager with the largest team size.

Example:

Input:

employees table

Column	Type
id	INTEGER
name	VARCHAR
manager_id	INTEGER
managers table

Column	Type
id	INTEGER
name	VARCHAR
team	VARCHAR
Output:

Column	Type
manager	VARCHAR
team_size	INTEGER
Write a query to show the number of users, number of transactions placed, and total order amount per month in the year 2020. Assume that we are only interested in the monthly reports for a single year (January-December).


# Solution:
-- Group by manager
-- Count number of employees
-- Order desc and take the top 1
SELECT
managers.name AS manager
, COUNT(employees.id) AS team_size
FROM employees
LEFT JOIN managers 
ON employees.manager_id = managers.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

