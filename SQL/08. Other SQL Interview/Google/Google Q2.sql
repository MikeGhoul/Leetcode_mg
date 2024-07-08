SQL Question 2: Odd & Even Measurements

measurements Example Input:
measurement_id	measurement_value	measurement_time
131233	1109.51	07/10/2024 09:00:00
135211	1662.74	07/10/2024 11:00:00
523542	1246.24	07/10/2024 13:15:00
143562	1124.50	07/11/2024 15:00:00
346462	1234.14	07/11/2024 16:45:00


SQL Question 2: Odd & Even Measurements
Assume youre given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.
Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns.
Note the rows are what we are using to consider odd or even


Example Output:
measurement_day	odd_sum	even_sum
07/10/2024 00:00:00	2355.75	1662.74
07/11/2024 00:00:00	1124.50	1234.14
Example Explanation
Based on the results,

On 07/10/2024, the sum of the odd-numbered measurements is 2355.75, while the sum of the even-numbered measurements is 1662.74.
On 07/11/2024, there are only two measurements available. The sum of the odd-numbered measurements is 1124.50, and the sum of the even-numbered measurements is 1234.14.



# Solution:

WITH row_nums_meas AS (
SELECT
measurement_id
, measurement_value
, measurement_time
, ROW_NUMBER() OVER (PARTITION BY DATE(measurement_time) ORDER BY measurement_time) AS row_num 
FROM measurements 
)

SELECT
DATE(measurement_time) AS measurement_day
, SUM(CASE WHEN row_num % 2 != 0 THEN measurement_value ELSE 0 END) AS odd_sum
, SUM(CASE WHEN row_num % 2 = 0 THEN measurement_value ELSE 0 END) AS even_sum
FROM row_nums_meas
GROUP BY 1
ORDER BY 1






#Full Raw Data:
measurement_id	measurement_value	measurement_time		day
131233			1109.51				07/10/2022 09:00:00		1
135211			1662.74				07/10/2022 11:00:00		2
523542			1246.24				07/10/2022 14:30:00		3


143562			1124.50				07/11/2022 13:15:00		1
346462			1234.14				07/11/2022 15:00:00		2
124245			1252.62				07/11/2022 16:45:00		3
143251			1246.56				07/11/2022 18:00:00		4

141565			1452.40				07/12/2022 08:00:00		1
253622			1244.30				07/12/2022 14:00:00		2
353625			1451.00				07/12/2022 15:00:00		3


# Output from solution:
measurement_day			odd_sum		even_sum
07/10/2022 00:00:00		2355.75		1662.74
07/11/2022 00:00:00		2377.12		2480.70
07/12/2022 00:00:00		1451.00		2696.70