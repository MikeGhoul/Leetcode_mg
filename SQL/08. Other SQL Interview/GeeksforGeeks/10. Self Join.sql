-- Returns first 100 rows from cyrus_ian.employee_table
  SELECT 
		employee_id,
		firstname,
		lastname,
		job_id,
		salary,
		manager_id,
		department_id
 FROM cyrus_ian.employee_table LIMIT 100;


-- Self Join:

-- First let's create a self joined table:
-- We want the manager id in one row to match the employee id in another row
-- We can add table aliases where one of the tables is the employee and the other employee table is the manager
SELECT 
e.employee_id
, e.lastname AS employee
, e.manager_id
, m.lastname AS manager
FROM cyrus_ian.employee_table e -- employee
INNER JOIN cyrus_ian.employee_table m -- manager
ON e.manager_id = m.employee_id 



-- Let's see instances where the employee makes more salary than their manager:

SELECT 
e.employee_id
, e.lastname AS employee
, e.manager_id
, e.salary AS emp_salary
, m.lastname AS manager
, m.salary AS manager_salary
FROM cyrus_ian.employee_table e -- employee
INNER JOIN cyrus_ian.employee_table m -- manager
ON e.manager_id = m.employee_id 
WHERE e.salary > m.salary


-- Let's see where the employee and manager are in the same department


SELECT 
e.employee_id 
, e.lastname AS emp_name
, e.manager_id 
, e.department_id AS emp_dept
, m.lastname AS manager 
, m.department_id  AS manager_dept
FROM cyrus_ian.employee_table e -- employee
INNER JOIN cyrus_ian.employee_table m -- manager
ON e.manager_id = m.employee_id -- the manager id of the employee matches the employee id of the manager
WHERE e.department_id = m.department_id



-- If we want to see all employees including ones where there are no manager, we should use a LEFT JOIN instead of INNER:


SELECT 
e.employee_id
, e.lastname AS employee
, e.manager_id
, m.lastname AS manager
FROM cyrus_ian.employee_table e -- employee
LEFT JOIN cyrus_ian.employee_table m -- manager
ON e.manager_id = m.employee_id 


-- Additional notes on self join:
-- A self join is a regular join, but the table is joined with itself. It's used when a table has a column that references another row in the same table. This is often seen with hierarchical or recursive data.

-- Use cases:
-- Organizational hierarchies (employees and their managers)
-- Hierarchical product categories
-- Finding pairs or relationships within the same table
-- Comparing rows to other rows in the same table

-- Example:
-- Let's say we have an "employees" table with columns: id, name, and manager_id (which references another employee's id).

-- Table: employees:

-- id   name    manager_id
-- 1    Alice   NULL
-- 2    Bob     1
-- 3    Carol   1
-- 4    Dave    2

-- To get each employee's name along with their manager's name:
SELECT 
    e.name AS employee_name,
    m.name AS manager_name
FROM employees e
LEFT JOIN employees m 
ON e.manager_id = m.id; -- employees manager id = manager’s emp id

-- Result:

-- employee_name    manager_name
-- Alice            NULL
-- Bob              Alice
-- Carol            Alice
-- Dave             Bob

-- In this example, we join the table to itself, treating one instance as the employee (e) and the other as the manager (m). 
-- The LEFT JOIN ensures that employees without managers (like Alice) are included in the result.

-- Self joins are powerful for working with hierarchical data or when you need to compare rows within the same table. 
-- They're particularly useful in scenarios involving organizational structures, nested categories, 
-- or any situation where rows in a table relate to other rows in the same table.
