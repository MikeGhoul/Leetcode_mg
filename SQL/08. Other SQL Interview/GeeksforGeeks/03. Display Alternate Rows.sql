# Difficulty:  
# Problem:

-- Display alternate rows 

# Solution:

-- Using CTEs and row_number

 WITH display_alt_rows AS (
 SELECT 
 employee_name 
 , dept_id 
 , salary 
 , ROW_NUMBER() OVER () AS row_per_dept
 FROM sample_database.hr_dataset
)

SELECT 
*
FROM display_alt_rows
WHERE row_per_dept % 2 != 0


-- Using sub-queries (data would need to have a row number):
SELECT
*
FROM (
SELECT
employee_name
, dept_id
, salary
, ROW_NUMBER() OVER () as rn
 FROM sample_database.hr_dataset
 LIMIT 100
 ) ranked_rows
 WHERE rn % 2 != 0
