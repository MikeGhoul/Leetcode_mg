# Difficulty: MEDIUM
# Problem:

Given a table called user_experiences, write a query to determine the percentage of users that held the title of “Data Analyst” immediately before holding the title “Data Scientist”.

Immediate is defined as the user holding no other titles between the “Data Analyst” and “Data Scientist” roles.

Example:

Input:

user_experiences table

Column	Type
id	INTEGER
position_name	VARCHAR
start_date	DATETIME
end_date	DATETIME
user_id	INTEGER
Output:

Column	Type
percentage	FLOAT


# Solution:

 -- The idea here is to create a cte where we capture instances of the previous role
 -- We partition by user_id and order by start date to see the most recent role
 -- Then we select from this data instances where the previous role is analyst and current role is scientist
 -- In order to solve for an instance where a user switches from analyst to scientist twice, we add the row num
 -- Since we partition by user_id and position, we'll get multiple row_numbers where the same position was repeated
 -- By only taking the rn = 1 we'll take one instance 


 WITH prev_roles AS (
select
user_id
, LAG(position_name) OVER (PARTITION BY user_id ORDER BY start_date) AS prev_role
, position_name
, ROW_NUMBER() OVER (PARTITION BY user_id, position_name ORDER BY start_date) as rn
FROM user_experiences
)

  SELECT
    SUM(CASE WHEN prev_role = 'Data Analyst' AND position_name = 'Data Scientist' AND rn = 1  
    THEN 1 ELSE 0 END) / COUNT(DISTINCT user_id) AS percentage
  FROM prev_roles

