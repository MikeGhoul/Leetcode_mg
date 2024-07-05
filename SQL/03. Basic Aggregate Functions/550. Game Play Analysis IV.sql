# Diffifculty: MEDIUM
# Problem:

Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

# Solution:

-- Creating a cte with the use of a window function:
-- Partition by player_id
-- Check for where the datediff between each event date is within 1 of the min date
-- Pull from this CTE the counts of the flag created divided by the total unique ids


WITH players AS(
SELECT
player_id
-- set a flag for each event date and determine if it's within 1 day of the min date
, datediff(event_date, min(event_date) over(partition by player_id)) = 1 as temp
FROM Activity
)

SELECT
-- sum the flags divided by the distinct player_ids
ROUND(SUM(temp) / COUNT(DISTINCT player_id), 2) AS fraction
FROM players


# Other option using 2 CTEs:
-- Keep row level data and calc number of days between logins
-- Get the row number of each event ordered by date
-- Second CTE will pull instances where the criteria we want is met: 1 day from prev login and has to be on the second login
-- We count the number of player_ids where this criteria is met
-- Take that count and divide by total number of players from the Activity table

WITH login_dates AS(
SELECT
player_id
, event_date
, DATEDIFF(event_date, LAG(event_date) OVER (PARTITION BY player_id ORDER BY event_date)) AS days_from_prev
, ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS login_instance
FROM Activity
),

player_agg AS(
SELECT
COUNT(DISTINCT player_id) AS consecutive_players
FROM login_dates
WHERE days_from_prev = 1
AND login_instance = 2
)

SELECT
ROUND(consecutive_players / (SELECT COUNT(DISTINCT(player_id)) FROM Activity), 2) AS fraction
FROM player_agg



