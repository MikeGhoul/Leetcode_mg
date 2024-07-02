# Difficulty:  
# Problem:

In a data set, get the 2nd highest salary


# Solution:

-- If you just want the salary as an output:

SELECT
max(salary) AS second_highest
FROM emp
WHERE salary NOT IN (SELECT MAX(salary) FROM emp)

-- If you want more info (example data set is NBA salary 2017):

-- Using subquery:

SELECT
    name 
  , position 
  , team
  , salary
  FROM marquette_mscs.nba_2017_salary
  WHERE salary IN (
  SELECT 
 MAX(salary) AS salary
 FROM marquette_mscs.nba_2017_salary
 WHERE salary NOT IN (SELECT MAX(salary) FROM marquette_mscs.nba_2017_salary)
 )

 -- Better solution (using CTE and window):

 WITH ranked_salary AS(
SELECT 
name 
, position 
, team 
, salary 
, DENSE_RANK() OVER (ORDER BY salary DESC) AS ranked_sal
FROM marquette_mscs.nba_2017_salary
)

SELECT 
*
FROM ranked_salary
WHERE ranked_sal = 2

