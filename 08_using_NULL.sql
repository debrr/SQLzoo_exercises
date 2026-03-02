/*
  Project   : SQLZoo Practice
  Module    : Using NULL
  Source    : https://sqlzoo.net/wiki/Using_Null
  Focus     : Handling NULL values and outer joins

  Concepts:
  - NULL handling (IS NULL)
  - INNER JOIN
  - LEFT JOIN
  - RIGHT JOIN
  - COALESCE
  - COUNT / COUNT(DISTINCT)
  - GROUP BY with JOIN
  - CASE expressions
*/


-- ========================================
-- 1. Teachers with NULL department
-- List the teachers who have no department assigned
-- ========================================
SELECT name
FROM teacher
WHERE dept IS NULL;


-- ========================================
-- 2. INNER JOIN teachers and departments
-- Show teacher name and department name (INNER JOIN)
-- ========================================
SELECT teacher.name, dept.name
FROM teacher
INNER JOIN dept
  ON teacher.dept = dept.id;


-- ========================================
-- 3. LEFT JOIN - list all teachers
-- Show all teachers, including those without department
-- ========================================
SELECT teacher.name, dept.name
FROM teacher
LEFT JOIN dept
  ON teacher.dept = dept.id;


-- ========================================
-- 4. RIGHT JOIN - list all departments
-- Show all departments, including those without teachers
-- ========================================
SELECT teacher.name, dept.name
FROM teacher
RIGHT JOIN dept
  ON teacher.dept = dept.id;


-- ========================================
-- 5. COALESCE mobile number
-- Show teacher name and mobile (use '07986 444 2266' as default if NULL)
-- ========================================
SELECT name,
       COALESCE(mobile, '07986 444 2266') AS mobile
FROM teacher;


-- ========================================
-- 6. COALESCE department name
-- Show teacher and department (use 'None' if NULL)
-- ========================================
SELECT teacher.name,
       COALESCE(dept.name, 'None') AS department
FROM teacher
LEFT JOIN dept
  ON dept.id = teacher.dept;


-- ========================================
-- 7. Count teachers and mobile numbers
-- Show total teachers and distinct mobile numbers
-- ========================================
SELECT COUNT(name) AS teachers_count,
       COUNT(DISTINCT mobile) AS mobiles_count
FROM teacher;


-- ========================================
-- 8. Staff per department
-- Show each department and number of staff (include empty ones)
-- ========================================
SELECT d.name,
       COUNT(t.id) AS staff_num
FROM teacher t
RIGHT JOIN dept d
  ON d.id = t.dept
GROUP BY d.name;


-- ========================================
-- 9. CASE classification (Sci / Art)
-- Label teachers as 'Sci' if dept 1 or 2, otherwise 'Art'
-- ========================================
SELECT t.name,
       CASE
           WHEN t.dept IN (1,2) THEN 'Sci'
           ELSE 'Art'
       END AS dept
FROM teacher t
LEFT JOIN dept d
  ON d.id = t.dept;


-- ========================================
-- 10. CASE classification with NULL handling
-- 'Sci' for dept 1 or 2, 'Art' for dept 3, 'None' otherwise
-- ========================================
SELECT t.name,
       CASE
           WHEN t.dept IN (1,2) THEN 'Sci'
           WHEN t.dept = 3 THEN 'Art'
           ELSE 'None'
       END AS dept
FROM teacher t
LEFT JOIN dept d
  ON d.id = t.dept;