# Difficulty:  
# Problem:

 -- Display the highest paid employee in each department


 # Solution:
 
 WITH dept_salary AS (
 SELECT 
 employee_name 
 , dept_id 
 , salary 
 , DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rank_per_dept
 FROM sample_database.hr_dataset
)

SELECT 
*
FROM dept_salary
WHERE rank_per_dept = 1


-- Just using group by (don't have additional info on employee)

SELECT 
dept_id 
 , MAX(salary) AS highest_sal_dept
FROM sample_database.hr_dataset
GROUP BY dept_id
ORDER BY highest_sal_dept DESC





-- Select second highest using the subquery
-- Can just change the above to = 2 for the CTE approach

SELECT 
dept_id 
 , MAX(salary) AS highest_sal_dept
FROM sample_database.hr_dataset
WHERE salary NOT IN (SELECT MAX(salary) FROM sample_database.hr_dataset GROUP BY dept_id)
GROUP BY dept_id
ORDER BY 2 DESC 

