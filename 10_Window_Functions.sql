/*
  Project   : SQLZoo Practice
  Module    : Window Functions
  Source    : https://sqlzoo.net/wiki/Window_functions
  Focus     : Ranking, PARTITION BY and analytical queries

  Concepts:
  - RANK()
  - PARTITION BY
  - ORDER BY within OVER()
  - Subquery with window function
  - Filtering top results (rank = 1)
  - GROUP BY after window calculation
*/

-- ========================================
-- 1. Warming up
-- Show lastName, party and votes
-- for constituency S14000024 in 2017
-- ========================================
SELECT lastName, party, votes
FROM ge
WHERE constituency = 'S14000024'
  AND yr = 2017
ORDER BY votes DESC;


-- ========================================
-- 2. Ranking candidates
-- Show party and RANK for constituency
-- S14000024 in 2017
-- ========================================
SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) AS posn
FROM ge
WHERE constituency = 'S14000024'
  AND yr = 2017
ORDER BY party;


-- ========================================
-- 3. PARTITION BY year
-- Ranking of each party in S14000021
-- for each election year
-- ========================================
SELECT yr, party, votes,
       RANK() OVER (
           PARTITION BY yr
           ORDER BY votes DESC
       ) AS posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party, yr;


-- ========================================
-- 4. Edinburgh constituencies ranking
-- Ranking of each party in Edinburgh (2017)
-- Winners first
-- ========================================
SELECT constituency, party, votes,
       RANK() OVER (
           PARTITION BY constituency
           ORDER BY votes DESC
       ) AS posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr = 2017
ORDER BY posn, constituency;


-- ========================================
-- 5. Winners only (subquery approach)
-- Show winning party in each Edinburgh
-- constituency (2017)
-- ========================================
SELECT constituency, party
FROM ge g1
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr = 2017
  AND votes >= ALL (
        SELECT votes
        FROM ge g2
        WHERE g2.constituency = g1.constituency
          AND g2.yr = 2017
  )
ORDER BY constituency;


-- ========================================
-- 6. Scottish seats (count winners)
-- Number of seats won by each party
-- in Scotland (2017)
-- ========================================
SELECT party, COUNT(*) AS seats
FROM (
    SELECT constituency, party,
           RANK() OVER (
               PARTITION BY constituency
               ORDER BY votes DESC
           ) AS posn
    FROM ge
    WHERE constituency LIKE 'S%'
      AND yr = 2017
) x
WHERE posn = 1
GROUP BY party
ORDER BY party ASC;