# Company: Meta 
# Difficulty: MEDIUM
# Problem:

Given a employees and departments table, select the top 3 departments with at least ten employees and rank them according to the percentage of their employees making over 100K in salary.

Example:

Input:

employees table

Columns	Type
id	INTEGER
first_name	VARCHAR
last_name	VARCHAR
salary	INTEGER
department_id	INTEGER
departments table

Columns	Type
id	INTEGER
name	VARCHAR
Output:

Column	Type
percentage_over_100k	FLOAT
department_name	VARCHAR
number_of_employees	INTEGER

# Solution:

 -- count all employees by department id
 -- calculate the percentage of salaries greater than 100k
 -- filter by number of employees per department
SELECT
name AS department_name
, COUNT(employees.id) AS number_of_employees
, SUM(CASE WHEN salary > 100000 THEN 1 ELSE 0 END) / COUNT(employees.id) AS percentage_over_100k
FROM employees
LEFT JOIN departments
ON employees.department_id = departments.id
GROUP BY department_id
HAVING number_of_employees >= 10
ORDER BY percentage_over_100k DESC
LIMIT 3

# Using a CTE:
WITH grouped_dept_sal AS (
select
departments.name AS dept_name
, COUNT(employees.id) AS emp_count
, SUM(CASE WHEN employees.salary > 100000 THEN 1 ELSE 0 END) / COUNT(employees.id) AS percentage_over_100k
FROM employees 
INNER JOIN departments
ON employees.department_id = departments.id 
GROUP BY 1
ORDER BY 3 DESC
)

select
percentage_over_100k
, dept_name AS department_name
, emp_count AS number_of_employees
WHERE emp_count >= 10
LIMIT 3

