# Diffifculty: EASY
# Problem:

Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 

Find the names of the customer that are not referred by the customer with id = 2.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
Output: 
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+


# Solution:

SELECT
name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL


# Explanation:
-- Have to add IS NULL comparison because when you use the " = " operator 
-- in a WHERE clause to filter rows where a column's value is equal to "something", 
-- it will exclude rows with NULL values because NULL is not equal to any value, including "something". 
-- To include rows with NULL values, you can use the IS NULL condition in your WHERE clause. 
-- For example, you can use "WHERE text = 'something' OR text IS NULL" to include rows where the "text" column is either "something" or NULL.
