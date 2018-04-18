/* Using the tables below, write queries to get the following: */

/* Return all family_ids for who live in Washington State */
SELECT family_id FROM table_2
WHERE home_state LIKE 'WA';

/* Return all family_ids for individuals who live in Seattle, Washington */
SELECT family_id FROM table_2
WHERE home_state LIKE 'WA'
AND home_city LIKE 'Seattle';

/* Return all family_ids for household between 20 and 35 years old on January 1, 2018 */
SELECT family_id FROM table_2
WHERE birthdate BETWEEN '1983-01-01' AND '1998-01-01';

/* Return all family_ids who have visited supermarket 1 and have never visited supermarket 2 */
SELECT family_id FROM table_1
WHERE supermarket_1 IN (TRUE)
AND supermarket_2 NOT IN (TRUE);

/* Return all family_ids for children who have visited supermarket 2 and live in a city that starts with "B" */
SELECT table_1.family_id
FROM table_1
INNER JOIN table_2 ON table_2.family_id = table_1.family_id
WHERE child IN (TRUE)
AND supermarket_2 IN (TRUE)
AND home_city LIKE 'B%';

/* Return a table that shows home_city and how many family are in each city, ordered from the city with the most to least family */
SELECT home_city, COUNT(family_id)
FROM table_2
GROUP BY home_city
ORDER BY COUNT DESC;

/* Return which supermarket each of the top ten highest paid families have visited */
SELECT supermarket_1, supermarket_2
FROM table_1
ORDER BY income DESC
LIMIT 10;
