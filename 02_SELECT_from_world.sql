/*
  SQLZoo - SELECT from WORLD Tutorial
  Platform: https://sqlzoo.net/wiki/SELECT_from_WORLD_Tutorial
  
  Description:
  Solutions to the "SELECT from WORLD" tutorial exercises.
  Topics covered:
  - Basic SELECT statements
  - Filtering with WHERE
  - Logical operators (AND, OR, XOR)
  - Pattern matching with LIKE
  - Arithmetic operations
  - Aggregate calculations
  - Rounding values with ROUND
  - String functions (LEFT, LENGTH)
*/

-- 1. Show the name, continent and population of all countries.
SELECT name, continent, population
FROM world;

-- 2. Show the name for the countries that have a population of at least 200 million.
SELECT name
FROM world
WHERE population >= 200000000;

-- 3. Give the name and the per capita GDP for countries with a population of at least 200 million.
SELECT name, gdp / population AS per_capita_gdp
FROM world
WHERE population >= 200000000;

-- 4. Show the name and population (in millions) for countries in South America.
SELECT name, population / 1000000 AS population_millions
FROM world
WHERE continent = 'South America';

-- 5. Show the name and population for France, Germany and Italy.
SELECT name, population
FROM world
WHERE name IN ('France', 'Germany', 'Italy');

-- 6. Show the countries that include the word 'United' in their name.
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7. Show the countries that are big by area or big by population.
SELECT name, population, area
FROM world
WHERE population >= 250000000 OR area >= 3000000;

-- 8. Show countries that are big by area or big by population but not both (XOR).
SELECT name, population, area
FROM world
WHERE (population >= 250000000 AND area < 3000000)
   OR (population < 250000000 AND area >= 3000000);

-- 9. For South America show population (millions) and GDP (billions), rounded to 2 decimal places.
SELECT 
    name,
    ROUND(population / 1000000.0, 2) AS population_millions,
    ROUND(gdp / 1000000000.0, 2) AS gdp_billions
FROM world
WHERE continent = 'South America';

-- 10. Show per-capita GDP for trillion-dollar countries, rounded to the nearest $1000.
SELECT 
    name,
    ROUND(gdp / population, -3) AS per_capita_gdp
FROM world
WHERE gdp >= 1000000000000;

-- 11. Show the name and capital where both have the same number of characters.
SELECT name, capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12. Show the name and capital where both start with the same letter, excluding identical names.
SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital;

-- 13. Find the country that has all vowels and no spaces in its name.
SELECT name
FROM world
WHERE name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';