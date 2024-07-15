# Diffifculty: MEDIUM
# Problem:

Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last ones seat.



# Solution:

-- Check id:
    -- If even, take the previous student (LAG(student))
    -- If odd, take the next student (LEAD(student))
    -- IFNULL (last student is odd and there is not next student), we take the student
    -- Apply order by to specify the data should be ordered by id before applying LAG/LEAD

SELECT
id
, CASE WHEN id % 2 = 0 THEN (LAG(student) OVER (ORDER BY id))
        ELSE IFNULL(LEAD(student) OVER (ORDER BY id),student)
        END AS student
FROM Seat


# This is what is happening in the intermediary steps:

+----+---------+-------------+-------------+
| id | student | prev_student| next_student|
+----+---------+-------------+-------------+
| 1  | Abbot   | NULL        | Doris       |
| 2  | Doris   | Abbot       | Emerson     |
| 3  | Emerson | Doris       | Green       |
| 4  | Green   | Emerson     | Jeames      |
| 5  | Jeames  | Green       | NULL        |
+----+---------+-------------+-------------+


id = 1 (odd):

Takes LEAD(student) which is "Doris"


id = 2 (even):

Takes LAG(student) which is "Abbot"


id = 3 (odd):

Takes LEAD(student) which is "Green"


id = 4 (even):

Takes LAG(student) which is "Emerson"


id = 5 (odd):

LEAD(student) is NULL, so it takes the original student "Jeames"


