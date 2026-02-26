/*
  SQLZoo - Nobel Prize Winners
  Platform: https://sqlzoo.net/wiki/SELECT_names
  
  Description:
  Solutions to the Nobel Prize exercises.
  Topics covered:
  - Filtering with WHERE
  - Logical operators (AND, OR, NOT IN)
  - Pattern matching with LIKE
  - BETWEEN for ranges
  - Ordering results with ORDER BY
  - Handling special characters (apostrophes, non-ASCII)
*/

-- 1. Show Nobel prizes for the year 1950.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950;

-- 2. Show who won the 1962 prize for Literature.
SELECT winner
FROM nobel
WHERE yr = 1962
  AND subject = 'Literature';

-- 3. Show the year and subject of Albert Einstein's Nobel Prize.
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4. Show the Peace Prize winners since 2000 (inclusive).
SELECT winner
FROM nobel
WHERE subject = 'Peace'
  AND yr >= 2000;

-- 5. Show all details of Literature winners from 1980 to 1989 (inclusive).
SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature'
  AND yr BETWEEN 1980 AND 1989;

-- 6. Show all details of the specified presidential winners.
SELECT yr, subject, winner
FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                 'Thomas Woodrow Wilson',
                 'Jimmy Carter',
                 'Barack Obama');

-- 7. Show the winners whose first name is John.
SELECT winner
FROM nobel
WHERE winner LIKE 'John%';

-- 8. Show Physics winners for 1980 and Chemistry winners for 1984.
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
   OR (subject = 'Chemistry' AND yr = 1984);

-- 9. Show winners for 1980 excluding Chemistry and Medicine.
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980
  AND subject NOT IN ('Chemistry', 'Medicine');

-- 10. Show Medicine winners before 1910 (excluding 1910)
-- together with Literature winners from 2004 onwards.
SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Medicine' AND yr < 1910)
   OR (subject = 'Literature' AND yr >= 2004);

-- 11. Show all details of the prize won by PETER GRÜNBERG.
SELECT yr, subject, winner
FROM nobel
WHERE winner = 'PETER GRÜNBERG';

-- 12. Show all details of the prize won by EUGENE O''NEILL.
SELECT yr, subject, winner
FROM nobel
WHERE winner = 'EUGENE O''NEILL';

-- 13. List winners whose name starts with 'Sir',
-- ordered by most recent year first, then by name.
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner;

-- 14. Show the 1984 winners ordered by subject and winner,
-- but list Chemistry and Physics last.
SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY 
  subject IN ('Chemistry', 'Physics'),
  subject,
  winner;