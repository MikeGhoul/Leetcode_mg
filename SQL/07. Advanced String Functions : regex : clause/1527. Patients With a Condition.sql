# Diffifculty: EASY (Really Medium IMO)
# Problem:

Table: Patients

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |
+--------------+---------+
patient_id is the primary key (column with unique values) for this table.
'conditions' contains 0 or more code separated by spaces. 
This table contains information of the patients in the hospital.
 

Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. Type I Diabetes always starts with DIAB1 prefix.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Patients table:
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |
+------------+--------------+--------------+
Output: 
+------------+--------------+--------------+
| patient_id | patient_name | conditions   |
+------------+--------------+--------------+
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 | 
+------------+--------------+--------------+
Explanation: Bob and George both have a condition that starts with DIAB1.


# Solution:
SELECT
patient_id
, patient_name
, conditions
FROM Patients WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%'

# Question isn't worded correctly IMO:
# Question says Type I diabetes will "Start with DIAB1" meaning the first letters of the conditions column should be 'DIAB1%' 
# but that doesn't work per the example

# They give an example where DIAB1 is after 'ACNE' in patient 4 so we can add a % before DIAB1. 
# But that fails a testcase 'SADIAB100' which expects the result to output null.

# So it seems like the question wants 'DIAB1' to be a standalone word and not one embedded within another string. 
# But it can have text after it



