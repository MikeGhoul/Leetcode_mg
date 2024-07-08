SQL Question 4: Determine the Most Popular Google Search Category

For this scenario, assume that Google wants to analyze the top searched categories in their platform to optimize their search results. 
We have two tables, searches which has information about each search, and categories where every category ID is associated with a category name.

The searches table has the following structure:

searches Example Input:
search_id	user_id	search_date	category_id	query
1001	7654	06/01/2024 00:00:00	3001	"chicken recipe"
1002	2346	06/02/2024 00:00:00	3001	"vegan meal prep"
1003	8765	06/03/2024 00:00:00	2001	"google stocks"
1004	9871	07/01/2024 00:00:00	1001	"python tutorial"
1005	8760	07/02/2024 00:00:00	2001	"tesla stocks"
The categories table has the following structure:

categories Example Input:
category_id	category_name
1001	"Programming Tutorials"
2001	"Stock Market"
3001	"Recipes"
4001	"Sports News"


The question is: Can you write a SQL query that gives the total count of searches made in each category by month for the available data in the year 2024?

Expected output:

Example Output:
category_name			month		total_searches
"Programming Tutorials"	07			1
"Stock Market"			06			1
"Stock Market"			07			1
"Recipes"				06			2


# Solution:
SELECT
category_name
, month(search_date) AS month
, COUNT(search_id) AS total_searches
FROM searches
LEFT JOIN categories 
ON searches.category_id = categories.category_id
WHERE year(search_date) = 2024
GROUP BY 1, 2

# Output from chatgpt (codehs couldn't handle dates properly or LEFT even in the hacky way)
| category_name         | month | total_searches |
|-----------------------|-------|----------------|
| Programming Tutorials | 6     | 0              |
| Stock Market          | 6     | 1              |
| Recipes               | 6     | 2              |
| Programming Tutorials | 7     | 1              |
| Stock Market          | 7     | 1              |
| Recipes               | 7     | 0              |

# In order to remove the 0's just incorporate a HAVING clause at the end to filter out 0.


# Use Inner Join instead of Left Join to avoid any nulls and therefore 0s:
SELECT
category_name
, MONTH(search_date) AS month
, COUNT(search_id) AS total_searches
FROM searches 
INNER JOIN categories
ON searches.category_id = categories.category_id
WHERE YEAR(search_date) = 2024
GROUP BY 1, 2







