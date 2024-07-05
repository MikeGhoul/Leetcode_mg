# Diffifculty: EASY
# Problem:

Table: Activity

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
 

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+
Output: 
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+

#Explanation: 
#There are 3 machines running 2 processes each.
#Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
#Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
#Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456


# Solution:
# Self join
-- Create two copies of the table to calc the start time for one and end time for the other to get the processing time

SELECT
a.machine_id
, ROUND(AVG(b.timestamp - a.timestamp), 3) AS processing_time
FROM activity a 
JOIN activity b
ON a.machine_id = b.machine_id
AND a.process_id = b.process_id
WHERE a.activity_type = 'start'
AND b.activity_type = 'end'
GROUP BY 1
ORDER BY 1


# Using CTEs and Window Functions:

-- Take the current timestamp minus the previous timestamp
-- Partition by machine and process to keep them unique
-- Order by activity_type: take the end timestamp minus the start for each grouped pair
-- NOTE: Since activity_type is ENUM, 'start' comes before 'end' which explains the order showing start first
-- Take the second instance for each group pair which is the time_spent for each
-- Take the avg per machine_id

WITH time_per AS (
SELECT
machine_id
, process_id
, timestamp - LAG(timestamp) OVER (PARTITION BY machine_id, process_id ORDER BY activity_type) AS time_spent
, ROW_NUMBER() OVER () AS row_num
FROM Activity
),

process_per AS (
SELECT
machine_id
, process_id
, time_spent
FROM time_per
WHERE row_num % 2 = 0
)

SELECT
machine_id
, ROUND(AVG(time_spent), 3) AS processing_time
FROM process_per
GROUP BY machine_id
