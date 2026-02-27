/*
  Project   : SQLZoo Practice
  Module    : Aggregate Functions
  Source    : https://sqlzoo.net/wiki/SUM_and_COUNT
  Focus     : Aggregation, grouping and filtering aggregated results

  Concepts:
  - SUM
  - COUNT
  - DISTINCT
  - MIN
  - MAX
  - GROUP BY
  - HAVING
*/

-- ========================================
-- SECTION 1 - WORLD TABLE
-- Plataform: https://sqlzoo.net/wiki/SUM_and_COUNT
-- Exercises: 1–8
-- Table structure: world(name, continent, area, population, gdp)
-- (queries 1–8 go here)
-- ========================================


-- ========================================
-- 1. Show the total population of the world.
-- ========================================
SELECT SUM(population) AS total_world_population
FROM world;


-- ========================================
-- 2. List all continents (no duplicates).
-- ========================================
SELECT DISTINCT continent
FROM world;


-- ========================================
-- 3. Show the total GDP of Africa.
-- ========================================
SELECT SUM(gdp) AS total_gdp_africa
FROM world
WHERE continent = 'Africa';


-- ========================================
-- 4. Count how many countries have an area of at least 1,000,000.
-- ========================================
SELECT COUNT(name) AS countries_large_area
FROM world
WHERE area >= 1000000;



-- ========================================
-- 5. Show the total population of Estonia, Latvia and Lithuania.
-- ========================================
SELECT SUM(population) AS baltic_population
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania');


-- ========================================
-- 6. For each continent, show the number of countries.
-- ========================================
SELECT continent, COUNT(name) AS country_count
FROM world
GROUP BY continent;


-- ========================================
-- 7. For each continent, show the number of countries 
-- with population of at least 10 million.
-- ========================================
SELECT continent, COUNT(name) AS large_population_countries
FROM world
WHERE population >= 10000000
GROUP BY continent;


-- ========================================
-- 8. List continents with total population of at least 100 million.
-- ========================================
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000;


-- ========================================
-- SECTION 2 - NOBEL TABLE
-- Plataform: https://sqlzoo.net/wiki/The_nobel_table_can_be_used_to_practice_more_SUM_and_COUNT_functions.
-- Exercises: 9–12
-- Table structure: nobel(winner, subject, yr)
-- (queries 9–12 go here)
-- ========================================


-- ========================================
-- 9. Show the years in which three prizes were given for Physics.
-- ========================================
SELECT yr
FROM nobel
WHERE subject = 'physics'
GROUP BY yr
HAVING COUNT(yr) = 3;


-- ========================================
-- 10. Show winners who have won more than once.
-- ========================================
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(winner) > 1;


-- ========================================
-- 11. Show winners who have won more than one subject.
-- ========================================
SELECT winner
FROM nobel
GROUP BY winner
HAVING COUNT(DISTINCT subject) > 1;


-- ========================================
-- 12. Show the year and subject where 3 prizes were given.
-- Show only years 2000 onwards.
-- ========================================
SELECT yr, subject
FROM nobel
WHERE yr >= 2000
GROUP BY yr, subject
HAVING COUNT(winner) = 3;