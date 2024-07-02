# Difficulty:  
# Problem:

-- 1. Display the employee names whose name starts with 'M'
-- 2. Display the employee names whose name ends with 'M'
-- 3. Display the names of all employees having an 'M' in any position in their name
-- 4. Display the names of all employees whose name does not contain 'M' anywhere

 
 # Solutions:

 -- 1.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) LIKE 'm%'

 -- 2.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) LIKE '%m'

 -- 3.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) LIKE '%m%'

 -- 4.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) NOT LIKE '%m%'