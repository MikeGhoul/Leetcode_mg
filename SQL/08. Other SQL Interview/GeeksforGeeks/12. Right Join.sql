-- Additional notes on self join:
-- A right join returns all records from the right table and the matched records from the left table. 
-- If there's no match, the result is NULL on the left side.

-- Use cases:
-- Similar to left join, but when you want to prioritize the right table.
-- Checking for data integrity or finding missing records in the left table.
-- Combining data sets where you want to ensure all records from a secondary table are included.

-- Left join is more commonly used, as it's often more intuitive to think of the primary table first.
-- A right join can always be rewritten as a left join by switching the table order.