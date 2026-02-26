/*
  SQLZoo - Nested SELECT (Subqueries)
  Platform: https://sqlzoo.net/wiki/SELECT_within_SELECT
  
  Description:
  Solutions to exercises involving nested queries and correlated subqueries.
  Topics covered:
  - Scalar subqueries
  - Correlated subqueries
  - ALL operator
  - IN with subqueries
  - Comparison with aggregated values
*/

-- 1. List countries with a population larger than Russia.
SELECT name
FROM world
WHERE population >
      (SELECT population
       FROM world
       WHERE name = 'Russia');

-- 2. Show European countries with a per capita GDP greater than the United Kingdom.
SELECT name
FROM world
WHERE continent = 'Europe'
  AND gdp / population >
      (SELECT gdp / population
       FROM world
       WHERE name = 'United Kingdom');

-- 3. List name and continent of countries in the same continents as Argentina or Australia.
SELECT name, continent
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    WHERE name IN ('Argentina', 'Australia')
)
ORDER BY name;

-- 4. Show the country with population between the United Kingdom and Germany.
SELECT name, population
FROM world
WHERE population >
      (SELECT population FROM world WHERE name = 'United Kingdom')
  AND population <
      (SELECT population FROM world WHERE name = 'Germany');

-- 5. Show European countries with population as a percentage of Germany.
SELECT name,
       CONCAT(
           ROUND(
               population * 100.0 /
               (SELECT population
                FROM world
                WHERE name = 'Germany')
           ),
           '%'
       ) AS percentage
FROM world
WHERE continent = 'Europe';

-- 6. Show countries with GDP greater than every country in Europe.
SELECT name
FROM world
WHERE gdp > (
    SELECT MAX(gdp)
    FROM world
    WHERE continent = 'Europe'
);

-- 7. Find the largest country (by area) in each continent.
SELECT continent, name, area
FROM world x
WHERE area >= ALL (
    SELECT area
    FROM world y
    WHERE y.continent = x.continent
);

-- 8. List each continent and the country that comes first alphabetically.
SELECT continent, name
FROM world x
WHERE name <= ALL (
    SELECT name
    FROM world y
    WHERE y.continent = x.continent
)
ORDER BY continent;

-- 9. Find continents where all countries have population <= 25,000,000,
-- and show their countries.
SELECT name, continent, population
FROM world x
WHERE 25000000 >= ALL (
    SELECT population
    FROM world y
    WHERE y.continent = x.continent
);

-- 10. Show countries whose population is more than three times
-- that of all other countries in the same continent.
SELECT name, continent
FROM world x
WHERE population > ALL (
    SELECT population * 3
    FROM world y
    WHERE y.continent = x.continent
      AND y.name <> x.name
);