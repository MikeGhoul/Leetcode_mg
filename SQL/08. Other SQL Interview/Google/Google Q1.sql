Google Q1:

users Example Input:
user_id	user_name
123	Alice
265	Bob
362	Charlie
192	David
981	Eve


searches Example Input:
search_id	user_id	search_date
001	123	06/08/2024 00:00:00
002	265	06/10/2024 00:00:00
003	362	06/18/2024 00:00:00
004	192	07/26/2024 00:00:00
005	981	07/05/2024 00:00:00
006	123	06/08/2024 00:00:01
007	192	06/18/2024 00:00:01
...	...	...
600	123	07/28/2024 00:00:00
601	123	07/29/2024 00:00:00


SQL Question 1: Identify Most Active Google Search Users
The Google Search team wants to identify their 'power users' or VIP users that perform a lot of search activities. 
These users are determined by those who have conducted more than 500 searches in the past month. 
Write a SQL query to find user ids and number of searches in the last month for these power users.


SELECT
users.user_id
-- , users.user_name
, COUNT(searches.search_id) AS num_searches
FROM users
LEFT JOIN searches
ON users.user_id = searches.user_id
WHERE users.search_date >= DATEADD(month, -1, GETDATE())
--WHERE users.search_date BETWEEN '06/01/2024' AND '07/01/2024'
GROUP BY users.user_id
HAVING num_searches > 500



This query joins the users and searches tables on user_id. It filters the search records to only include those made in the last month. 
It then groups by user_id and user_name, counting the number of searches. The HAVING clause is used to filter the grouped records, showing only users who have made more than 500 searches.