-- 1. Display the employee names whose name contains exactly 10 letters
-- 2. Display the employee names whose name contains 'L' as the second letter and 'e' as the fifth letter
-- 3. Display the names of all employees and state where the state is Massachusetts
-- 4. Display the names of all employees whose name contains 2 L's consecutively
-- 5. Display the names of all employees whose name starts with 'b' and ends with 'a'
 
 
 -- 1.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LENGTH(employee_name)  = 10

 -- 2.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) LIKE '_l%'
AND LOWER(employee_name) LIKE '____e%'
-- WHERE LOWER(SUBSTRING(employee_name, 2, 1)) = 'l'
-- AND LOWER(SUBSTRING(employee_name, 5, 1)) = 'e'

 -- 3.
SELECT 
 employee_name
 , state 
FROM sample_database.hr_dataset
WHERE state = 'MA'

 -- 4.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) LIKE '%ll%'
-- WHERE LEN(epmployee_name) - LEN(REPLACE(LOWER(employee_name), 'l', '')) = 2


 -- 5.
SELECT 
 employee_name
FROM sample_database.hr_dataset
WHERE LOWER(employee_name) LIKE 'b%'
AND LOWER(employee_name) LIKE '%a'


