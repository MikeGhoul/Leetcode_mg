-- Find the highest and lowest salary by dept_id

WITH total_ranked_salary AS (
SELECT 
employee_name 
, emp_id 
, dept_id 
, salary 
, position 
, DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS ranked_salary
FROM sample_database.hr_dataset
)

SELECT 
*
FROM total_ranked_salary
WHERE (dept_id, ranked_salary) IN (SELECT dept_id, MAX(ranked_salary) 
									FROM total_ranked_salary 
									GROUP BY dept_id)
OR (dept_id, ranked_salary) IN 
						(SELECT dept_id, MIN(ranked_salary) 
							FROM total_ranked_salary 
							GROUP BY dept_id) -- Obv can just pull ranked_salary = 1 for highest salary across each dept
 
