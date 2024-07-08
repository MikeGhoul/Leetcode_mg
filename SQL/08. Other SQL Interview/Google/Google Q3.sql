SQL Question 3: Google Maps Flagged UGC
As a Data Analyst on the Google Maps User Generated Content team, 
you and your Product Manager are investigating user-generated content (UGC) – photos and reviews that independent users upload to Google Maps.

Write a query to determine which type of place (place_category) attracts the most UGC tagged as "off-topic". 
In the case of a tie, show the output in ascending order of place_category.


place_info Example Input:
place_id	place_name		place_category
1			Baar Baar		Restaurant
2			Rubirosa		Restaurant
3			Mr. Purple		Bar
4			La Caverna		Bar

maps_ugc_review Example Input:
content_id		place_id	content_tag
101				1			Off-topic
110				2			Misinformation
153				2			Off-topic
176				3			Harassment
190				3			Off-topic

Example Output:
off_topic_places
Restaurant


place_id	place_category 	content_tag
1			Restaurant 		Off-topic
2			Restaurant 		Misinformation
2			Restaurant 		Off-topic
3			Bar   			Harassment
3			Bar      		Off-topic



# Explanation:
The restaurants (Baar Baar and Rubirosa) have a total of has 2 UGC posts tagged as "off-topic". 
The bars only have 1. Restaurant is shown here because its the type of place with the most UGC tagged as "off-topic".

# Solution:
WITH place_content_groups AS(
SELECT
place_category
, content_tag
, COUNT(content_tag) AS content_counts
FROM place_info 
LEFT JOIN maps_ugc_review
ON place_info.place_id = maps_ugc_review.place_id
GROUP BY 1, 2
)

SELECT
place_category AS off_topic_places
WHERE LOWER(content_tag) = "off-topic"
AND content_counts = (SELECT MAX(content_counts) FROM place_content_groups)



# Solution 2 (more logical imo):

-- Group the data on place_category and content tags and get a count per grouping
WITH ordered_counts AS(
SELECT
place_category
, content_tag
, COUNT(content_id) AS count_per_tag
FROM place_info
JOIN maps_ugc_review
ON place_info.place_id = maps_ugc_review.place_id
GROUP BY 1, 2
), 

-- Rank the grouped data based on content tag, order by most counts as highest, then category name
ranked_data AS(
SELECT
place_category
, content_tag
, count_per_tag
, DENSE_RANK() OVER (PARTITION BY content_tag ORDER BY count_per_tag DESC, place_category) AS ranked_counts
FROM ordered_counts
)

-- Pull instances where the content tag matches what we want (e.g. off-topic) and the rank is 1 (highest count)
SELECT 
place_category
FROM ranked_data
WHERE LOWER(content_tag) = 'off-topic'
AND ranked_counts = 1
