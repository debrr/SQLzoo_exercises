/*
  Project   : SQLZoo Practice
  Module    : Self Join
  Source    : https://sqlzoo.net/wiki/Self_join
  Focus     : Self joins and route connections

  Concepts:
  - Self JOIN (joining a table to itself)
  - COUNT
  - GROUP BY with HAVING
  - DISTINCT
  - Multi-table JOIN
  - Filtering by name vs id
  - Route connection logic
*/

-- ========================================
-- 1. Count total stops
-- How many stops are in the database
-- ========================================
SELECT COUNT(id) AS stop_count
FROM stops;


-- ========================================
-- 2. Find stop id by name
-- Get the id value for 'Craiglockhart'
-- ========================================
SELECT id
FROM stops
WHERE name = 'Craiglockhart';


-- ========================================
-- 3. Stops on specific service
-- Get id and name for stops on service 4 (LRT)
-- ========================================
SELECT id, name
FROM stops
JOIN route
  ON stops.id = route.stop
WHERE route.num = '4'
  AND route.company = 'LRT';


-- ========================================
-- 4. Routes connecting two stops (by id)
-- Services visiting both London Road (149)
-- and Craiglockhart (53)
-- ========================================
SELECT company, num, COUNT(*)
FROM route
WHERE stop IN (149, 53)
GROUP BY company, num
HAVING COUNT(*) = 2;


-- ========================================
-- 5. Self join on route
-- Services from Craiglockhart (53)
-- to London Road (149)
-- ========================================
SELECT a.company, a.num, a.stop, b.stop
FROM route a
JOIN route b
  ON a.company = b.company
 AND a.num = b.num
WHERE a.stop = 53
  AND b.stop = 149;


-- ========================================
-- 6. Self join with stop names
-- Services between Craiglockhart
-- and London Road
-- ========================================
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a
JOIN route b
  ON a.company = b.company
 AND a.num = b.num
JOIN stops stopa
  ON a.stop = stopa.id
JOIN stops stopb
  ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road';


-- ========================================
-- 7. Services connecting Haymarket and Leith
-- ========================================
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b
  ON a.company = b.company
 AND a.num = b.num
JOIN stops stopa
  ON a.stop = stopa.id
JOIN stops stopb
  ON b.stop = stopb.id
WHERE stopa.name = 'Haymarket'
  AND stopb.name = 'Leith';


-- ========================================
-- 8. Services connecting Craiglockhart and Tollcross
-- ========================================
SELECT DISTINCT a.company, a.num
FROM route a
JOIN route b
  ON a.company = b.company
 AND a.num = b.num
JOIN stops stopa
  ON a.stop = stopa.id
JOIN stops stopb
  ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
  AND stopb.name = 'Tollcross';


-- ========================================
-- 9. Stops reachable from Craiglockhart
-- (one bus, LRT only)
-- ========================================
SELECT DISTINCT stopb.name, a.company, a.num
FROM route a
JOIN route b
  ON a.company = b.company
 AND a.num = b.num
JOIN stops stopa
  ON a.stop = stopa.id
JOIN stops stopb
  ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart'
  AND a.company = 'LRT';