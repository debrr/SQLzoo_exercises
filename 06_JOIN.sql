/*
  Project   : SQLZoo Practice
  Module    : The JOIN Operation
  Source    : https://sqlzoo.net/wiki/The_JOIN_operation
  Focus     : Relational queries using table joins

  Concepts:
  - INNER JOIN
  - LEFT JOIN
  - Multi-table joins
  - WHERE with JOIN
  - COUNT with JOIN
  - SUM with JOIN
  - GROUP BY (joined data)
  - CASE WHEN (conditional aggregation)
  - DISTINCT
*/

-- ========================================
-- 1. matchid and player for all goals scored by Germany.
-- ========================================
SELECT matchid, player
FROM goal
WHERE teamid = 'GER';


-- ========================================
-- 2. id, stadium, team1, team2 for game 1012.
-- ========================================
SELECT id, stadium, team1, team2
FROM game
WHERE id = 1012;


-- ========================================
-- 3. player, teamid, stadium, mdate for every German goal.
-- ========================================
SELECT player, teamid, stadium, mdate
FROM game
JOIN goal ON game.id = goal.matchid
WHERE teamid = 'GER';


-- ========================================
-- 4. team1, team2, player for goals scored by players named Mario.
-- ========================================
SELECT team1, team2, player
FROM game
JOIN goal ON game.id = goal.matchid
WHERE player LIKE 'Mario%';


-- ========================================
-- 5. player, teamid, coach, gtime for goals in first 10 minutes.
-- ========================================
SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam ON teamid = eteam.id
WHERE gtime <= 10;


-- ========================================
-- 6. Match dates and team name where Fernando Santos was team1 coach.
-- ========================================
SELECT mdate, teamname
FROM game
JOIN eteam ON team1 = eteam.id
WHERE coach = 'Fernando Santos';


-- ========================================
-- 7. Player for every goal at National Stadium, Warsaw.
-- ========================================
SELECT player
FROM goal
JOIN game ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';


-- ========================================
-- 8. Players who scored against Germany.
-- ========================================
SELECT DISTINCT player
FROM game
JOIN goal ON matchid = id
WHERE teamid != 'GER'
  AND (team1 = 'GER' OR team2 = 'GER');


-- ========================================
-- 9. Team name and total goals scored.
-- ========================================
SELECT teamname, COUNT(*) AS goals_scored
FROM eteam
JOIN goal ON eteam.id = goal.teamid
GROUP BY teamname;


-- ========================================
-- 10. Stadium and total goals scored in each stadium.
-- ========================================
SELECT stadium, COUNT(*) AS goals_scored
FROM game
JOIN goal ON game.id = goal.matchid
GROUP BY stadium;


-- ========================================
-- 11. For every match involving POL, show matchid, date and total goals.
-- ========================================
SELECT matchid, mdate, COUNT(*) AS goals_num
FROM game
JOIN goal ON matchid = id
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate;


-- ========================================
-- 12. For every match where GER scored, show matchid, date and GER goals.
-- ========================================
SELECT matchid, mdate, COUNT(*) AS scored_by_GER
FROM goal
JOIN game ON matchid = id
WHERE teamid = 'GER'
GROUP BY matchid, mdate;


-- ========================================
-- 13. Match result summary with goals for each team.
-- ========================================
SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal ON matchid = id
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2;