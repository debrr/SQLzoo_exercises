/*
  Project   : SQLZoo Practice
  Module    : More JOIN Operations
  Source    : https://sqlzoo.net/wiki/More_JOIN_operations
  Focus     : Advanced joins and relational filtering

  Concepts:
  - INNER JOIN
  - SELF JOIN
  - Subqueries with JOIN
  - GROUP BY (joined tables)
  - HAVING
  - DISTINCT
*/

-- ========================================
-- 1. 1962 movies
-- List the films where the yr is 1962 and the budget is over 2000000
-- (Show id, title)
-- ========================================
SELECT id, title
FROM movie
WHERE yr = 1962 AND budget > 2000000;


-- ========================================
-- 2. When was Citizen Kane released?
-- Give the year of 'Citizen Kane'
-- ========================================
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';


-- ========================================
-- 3. Star Trek movies
-- List all Star Trek movies (id, title, yr)
-- Order by year
-- ========================================
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;


-- ========================================
-- 4. ID for actor Glenn Close
-- ========================================
SELECT id
FROM actor
WHERE name = 'Glenn Close';


-- ========================================
-- 5. ID for Casablanca (1942)
-- ========================================
SELECT id
FROM movie
WHERE title = 'Casablanca'
  AND yr = 1942;


-- ========================================
-- 6. Cast list for Casablanca (1942)
-- ========================================
SELECT name
FROM actor
JOIN casting ON actor.id = actorid
JOIN movie   ON movieid = movie.id
WHERE movieid = 132689;


-- ========================================
-- 7. Cast list for 'Alien'
-- ========================================
SELECT name
FROM actor
JOIN casting ON actor.id = actorid
JOIN movie   ON movieid = movie.id
WHERE title = 'Alien';


-- ========================================
-- 8. Films featuring Harrison Ford
-- ========================================
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor   ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford';


-- ========================================
-- 9. Harrison Ford (not starring role)
-- ========================================
SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor   ON actor.id = casting.actorid
WHERE actor.name = 'Harrison Ford'
  AND casting.ord <> 1;


-- ========================================
-- 10. Lead actors in 1962 movies
-- ========================================
SELECT title, actor.name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor   ON actor.id = casting.actorid
WHERE yr = 1962
  AND casting.ord = 1;


-- ========================================
-- 11. Busy years for Rock Hudson
-- Show years with more than 2 movies
-- ========================================
SELECT yr, COUNT(title) AS movies_num
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;


-- ========================================
-- 12. Lead actor in Julie Andrews movies
-- ========================================
SELECT title, name
FROM movie
JOIN casting ON movie.id = movieid
JOIN actor   ON actorid = actor.id
WHERE ord = 1
  AND movieid IN (
      SELECT movieid
      FROM casting
      JOIN actor ON actorid = actor.id
      WHERE name = 'Julie Andrews'
  );


-- ========================================
-- 13. Actors with at least 15 starring roles
-- ========================================
SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(*) >= 15
ORDER BY name;


-- ========================================
-- 14. Films released in 1978
-- Order by cast size (desc), then title
-- ========================================
SELECT title, COUNT(actorid) AS cast_size
FROM movie
JOIN casting ON movie.id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY cast_size DESC, title;


-- ========================================
-- 15. People who worked with Art Garfunkel
-- ========================================
SELECT DISTINCT name
FROM actor
JOIN casting ON actor.id = actorid
WHERE movieid IN (
    SELECT movieid
    FROM casting
    JOIN actor ON actorid = actor.id
    WHERE name = 'Art Garfunkel'
)
AND name <> 'Art Garfunkel';