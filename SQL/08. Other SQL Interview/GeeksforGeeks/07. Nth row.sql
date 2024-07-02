-- 1. Display the 2nd row
-- 2. Display the 4th row

WITH ranked_rows AS (
SELECT 
employee_name 
, emp_id 
, dept_id 
, salary 
, position 
, ROW_NUMBER() OVER () AS row_num
FROM sample_database.hr_dataset
)

 -- 1.
SELECT *
FROM ranked_rows
WHERE row_num = 2


 -- 2.
SELECT *
FROM ranked_rows
WHERE row_num = 4
