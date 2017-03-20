# 1. UPDATE

INSERT INTO table1(column1, column2, column3,...)  
VALUES(value1, value2, value3,...)

INSRRT INTO table1(column1, column2, column3,...)
SELECT column1, column2... FROM table2
WHERE conditions

UPDATE table1
SET column1 = value1, column2 = value2...
WHERE conditions

DELETE FROM table1
WHERE conditions

TRUNCATE TABLE table1


# 2. SELECT STATEMENTS

SELECT * FROM table1

SELECT column1, column2 FROM table1

SELECT column1, column2 FROM table1
WHERE conditions
ORDER BY column1 ASC, column2, DESC

SELECT DISTINCT column1, column2
FROM table1

SELECT column1, aggregate(expression)
FROM table1
GROUP BY column1

SELECT column1, aggregate(expression) AS column2
FROM table1
GROUP BY column1
HAVING column2 > x


# 3. JOIN

SELECT * FROM table1
INNER JOIN table ON join-conditions

SELECT * FROM table1
LEFT JOIN table2 ON join-conditions

SELECT * FROM table1
RIGHT JOIN table2 ON join-conditions

SELECT * FROM table1
FULL JOIN table2 ON join-conditions


# 4. TABLE SATAEMENTS

CREATE TABLE table1(
  column1 datatype1(length)
  column2 datatype2(length)
  column3 datatype3(length)
  ...
  PRIMARY KEY(column1)
)

DROP TABLE table1

ALTER TABLE table1
ADD COLUMN column1 datatype(length)

ALTER TABLE table1
DROP COLUMN column1
