# Difficulty: MEDIUM 
# Problem:

Let’s say we have a table representing a company payroll schema.

Due to an ETL error, the employees table, instead of updating the salaries every year when doing compensation adjustments, did an insert instead. The head of HR still needs the current salary of each employee.

Write a query to get the current salary for each employee.

Note: Assume no duplicate combination of first and last names (I.E. No two John Smiths). Assume the INSERT operation works with ID autoincrement.

Example:

Input:

employees table

Column	Type
id	VARCHAR
first_name	VARCHAR
last_name	VARCHAR
salary	INTEGER
department_id	INTEGER
Output:

Column	Types
first_name	VARCHAR
last_name	VARCHAR
salary	INTEGER

# Solution:

 -- We assume the latest value is the correct one from HR's insert
 -- Since we can't group by employee id (new rows were added) and we can assume names are unique
 -- We can group by name (first and last) and then pull the latest record from each group


-- First we create a CTE and a new column where we partition the data by first and last
-- Create a row_number for each employee and order DESC to get the latest
-- Then we can pull the latest (row = 1) for each from this CTE

WITH aggregate_data AS(
select
first_name
, last_name
, ROW_NUMBER() OVER (PARTITION BY first_name, last_name ORDER BY id DESC) AS row_num
, salary
FROM employees
)

select
first_name
, last_name
, salary
FROM aggregate_data
WHERE row_num = 1

