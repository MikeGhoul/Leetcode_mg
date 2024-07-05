# Difficulty: MEDIUM
# Company: Airbnb
# Problem:

Let’s say we have a table representing vacation bookings. Write a query that returns columns representing the total number of bookings in the last 90 days, last 365 days, and overall.

Note: You may assume that today is the 1st of January 2022.

Example:

Input:

bookings table

Column	Type
reservation_id	INTEGER
guest_id	INTEGER
check_in_date	DATE
check_out_date	DATE
Output:

Column	Type
num_bookings_last90d	INTEGER
num_bookings_last365d	INTEGER
num_bookings_total	INTEGER

# Solution:

 -- Sum the instances where the date diff is within the range of number of days
 
SELECT 
SUM(CASE WHEN DATEDIFF('2022-01-01', check_in_date) <= 90 THEN 1 ELSE 0 END) AS num_bookings_last90d
, SUM(CASE WHEN DATEDIFF('2022-01-01', check_in_date) <= 365 THEN 1 ELSE 0 END) AS num_bookings_last365d
, COUNT(*) AS num_bookings_total
FROM bookings

