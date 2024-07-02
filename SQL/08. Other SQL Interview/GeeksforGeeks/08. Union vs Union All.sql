-- Union - removes duplicates

SELECT 
artist_name 
FROM cdips.billboard_artist_names_2014_15 
UNION 
SELECT 
artist_name 
FROM cdips.billboard_artist_names_2015 
ORDER BY 1 


-- Union ALL - contains duplicates

SELECT 
artist_name 
FROM cdips.billboard_artist_names_2014_15 
UNION ALL
SELECT 
artist_name 
FROM cdips.billboard_artist_names_2015 
ORDER BY 1 