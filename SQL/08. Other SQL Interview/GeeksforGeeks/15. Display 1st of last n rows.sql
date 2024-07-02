-- 1. Display the first and last row of the table
-- 2. Display the last two rows of the table
-- 3. Display the first and last two rows of the table

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
WHERE row_num = 1 OR 
row_num = (SELECT COUNT(*) FROM ranked_rows)


 -- 2.
SELECT *
FROM ranked_rows
WHERE row_num > (SELECT COUNT(*) FROM ranked_rows) - 2


 -- 3.
SELECT *
FROM ranked_rows
WHERE row_num IN (1, 2) 
OR row_num >= (SELECT COUNT(*) FROM ranked_rows) - 1