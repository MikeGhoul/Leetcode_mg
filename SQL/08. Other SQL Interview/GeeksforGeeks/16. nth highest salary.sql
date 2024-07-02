-- Display the nth ranked salary:

WITH total_ranked_salary AS (
SELECT 
employee_name 
, emp_id 
, dept_id 
, salary 
, position 
, DENSE_RANK() OVER (ORDER BY salary DESC) AS ranked_salary
FROM sample_database.hr_dataset
)

SELECT 
*
FROM total_ranked_salary
WHERE ranked_salary IN (3)
-- WHERE ranked_salary IN (150, 176, 214)
 



-- Find instances where there are more than 1 instance of the same salary

SELECT 
salary
, ranked_salary
, COUNT(*) AS num_salary
FROM total_ranked_salary
GROUP BY 1, 2
HAVING COUNT(*) > 1

-- (results are ranks 150, 176, 214)
