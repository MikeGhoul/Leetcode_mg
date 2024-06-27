SQL Question 6: Filter Google Ads by Relevant Details
As a data analyst at Google, you are tasked with examining the Google Ads data for better ad placement and customer targeting.
You are asked to retrieve all records of ads from the database that fall into the following coditions:

The 'status' of the ad is 'active'.
The 'impressions' is greater than 500,000.
The ad 'last_updated' in the year 2024.

Your task is to write a query to filter down the ads records following these conditions.

ads Example Input:
ad_id	name			status		impressions		last_updated
1234	Google Phone	active		600000			06/25/2024 12:00:00
5678	Google Laptop	inactive	800000			05/18/2024 12:00:00
9012	Google App		active		300000			04/02/2024 12:00:00
3456	Google Cloud	active		700000			08/12/2024 12:00:00
7890	Google Mail		inactive	550000			09/03/2024 12:00:00

SELECT
*
FROM ads
WHERE status = 'active'
AND impressions > 500000
AND YEAR(last_updated) = 2024