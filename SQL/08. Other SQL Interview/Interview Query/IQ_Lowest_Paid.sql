# Difficulty: MEDIUM
# Problem:

Given tables employees, employee_projects, and projects, find the 3 lowest-paid employees that have completed at least 2 projects.

Note: incomplete projects will have an end date of NULL in the projects table.

Example:

Input:

employees table

Column	Type
id	INTEGER
first_name	VARCHAR
last_name	VARCHAR
salary	INTEGER
department_id	INTEGER
employee_projects table

Column	Type
employee_id	INTEGER
project_id	INTEGER
projects table

Column	Type
id	INTEGER
title	VARCHAR
start_date	DATE
end_date	DATE
budget	INTEGER
Output:

Column	Type
employee_id	INTEGER
salary	INTEGER
completed_projects	INTEGER


# Solution:

 -- We can count the number of project ids as projects (filter on end date not being null)
 -- Pull in unique employee id and salary
 -- Filter where a project is completed
 -- Group by id and salary
 -- Filter the grouped data where completed projects are at least 2
 -- Order by salary ASC
 -- Limit 3 to take the top 3


select
COUNT(project_id) AS completed_projects
, employees.id AS employee_id
, salary
FROM employees
LEFT JOIN employee_projects
ON employees.id = employee_projects.employee_id
LEFT JOIN projects
ON employee_projects.project_id = projects.id 
WHERE end_date IS NOT NULL
GROUP BY 2, 3
HAVING completed_projects >= 2
ORDER BY salary 
LIMIT 3

# Using a CTE:
WITH employee_projects_count AS (
  SELECT
    e.id AS employee_id
    , e.salary
    , COUNT(DISTINCT p.id) AS completed_projects
  FROM employees e
  JOIN employee_projects ep ON e.id = ep.employee_id
  JOIN projects p ON ep.project_id = p.id 
  WHERE p.end_date IS NOT NULL
  GROUP BY e.id, e.salary
  HAVING COUNT(DISTINCT p.id) >= 2
)
SELECT
  employee_id,
  salary,
  completed_projects
FROM employee_projects_count
ORDER BY salary
LIMIT 3

