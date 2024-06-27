# Difficulty: MEDIUM 
# Problem:

To finish a class, students must pass four exams (exam ids: 1,2,3 and 4).

Given a table exam_scores containing the data about all of the exams that students took, form a new table to track the scores for each student.

Note: Students took each exam only once.

Example:

For the given input:

student_id	student_name	exam_id	score
100	Anna	1	71
100	Anna	2	72
100	Anna	3	73
100	Anna	4	74
101	Brian	1	65
the expected output should be:

student_name	exam_1	exam_2	exam_3	exam_4
Anna	71	72	73	74
Brian	65	NULL	NULL	NULL
Input:

exam_scores table

Column	Type
student_id	INTEGER
student_name	VARCHAR
exam_id	INTEGER
score	INTEGER
Output:

Column	Type
student_name	VARCHAR
exam_1	INT
exam_2	INT
exam_3	INT
exam_4	INT


# Solution:

 -- We can create a new column for each score and group the data by student_id
 -- We use CASE WHEN and take the MAX of each column
 -- Since the output of the query without group by and max looks like this:

 student_name	exam_1	exam_2	exam_3	exam_4
Anna			83		NULL	NULL	NULL
Anna			NULL	77		NULL	NULL
Anna			NULL	NULL	74		NULL
Anna			NULL	NULL	NULL	70
John			95		NULL	NULL	NULL
John			NULL	87		NULL	NULL
John			NULL	NULL	81		NULL
John			NULL	NULL	NULL	99
Chris			80		NULL	NULL	NULL
Chris			NULL	83		NULL	NULL

-- We want to take the max of each column and have the data grouped
-- If we only group by and don't include a max arg, we only get the first non-null in exam_1:

student_name	exam_1	exam_2	exam_3	exam_4
"Anna"			83		NULL	NULL	NULL
"John"			95		NULL	NULL	NULL
"Chris"			80		NULL	NULL	NULL


-- Therefore our answer should look like this:

SELECT
student_name
, MAX(CASE WHEN exam_id = 1 THEN score ELSE NULL END) AS exam_1
, MAX(CASE WHEN exam_id = 2 THEN score ELSE NULL END) AS exam_2
, MAX(CASE WHEN exam_id = 3 THEN score ELSE NULL END) AS exam_3
, MAX(CASE WHEN exam_id = 4 THEN score ELSE NULL END) AS exam_4
FROM exam_scores
GROUP BY student_id

-- Output:

student_name	exam_1	exam_2	exam_3	exam_4
"Anna"			83		77		74		70
"John"			95		87		81		99
"Chris"			80		83		NULL	NULL

