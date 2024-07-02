-- Full Join:

-- A FULL JOIN, also known as a FULL OUTER JOIN, returns all rows from both tables, matching rows when possible and using NULL values when there is no match. 
-- It combines the results of both LEFT and RIGHT JOINs.

-- Use cases:
-- Comparing two related datasets to find matches and mismatches
-- Identifying data inconsistencies across tables
-- Merging data from different sources where not all records match
-- Analyzing data completeness across multiple tables


-- Example:
-- Let's say we have two tables: "employees" and "departments".

-- Table: employees:

-- id   name    dept_id
-- 1    Alice   101
-- 2    Bob     102
-- 3    Carol   NULL

-- Table: departments:

-- id     dept_name    
-- 101    HR   
-- 102    IT     
-- 103    Sales   




-- Query:
SELECT 
    e.name AS employee_name,
    d.dept_name
FROM employees e
FULL JOIN departments d 
ON e.dept_id = d.id;


-- Result:

-- employee_name    dept_name
-- Alice            HR
-- Bob              IT
-- Carol            NULL
-- NULL             Sales

-- In this example:

-- Alice and Bob match with their departments
-- Carol appears with a NULL department (she's not assigned to any)
-- Sales department appears with a NULL employee (no one is assigned to it)


-- FULL JOINs are particularly useful when you need to see all data from both tables, regardless of whether there are matches.
-- They help identify data that exists in one table but not in the other, which can be crucial for data reconciliation, finding inconsistencies, or ensuring completeness of data across related tables.
-- Note that not all database systems support FULL JOIN (e.g., MySQL). 
-- In such cases, you can simulate a FULL JOIN using a combination of LEFT JOIN, UNION, and RIGHT JOIN.

