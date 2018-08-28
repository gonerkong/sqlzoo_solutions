/*
#1
Q: 
The first example shows the goal scored by a player with the last name 'Bender'.
The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
*/
SELECT matchid, player
FROM goal
WHERE teamid = 'GER'



/*
#2
Q: 
Notice in the that the column matchid in the goal table corresponds to the id column in the game table.
We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012
*/
SELECT id,stadium,team1,team2
FROM game
where id = 1012



/*
#3
Q: 
The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.

Modify it to show the player, teamid, stadium and mdate for every German goal.
*/
SELECT player, teamid, stadium, mdate
FROM goal INNER JOIN game ON (game.id=goal.matchid)
WHERE teamid = 'GER'



/*
#4
Q: 
Use the same JOIN as in the previous question.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/
SELECT team1, team2, player
FROM goal INNER JOIN game ON id = matchid
WHERE player LIKE 'Mario%'



/*
#5
Q: 
The table eteam gives details of every national team including the coach.
You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/
SELECT player, teamid, coach, gtime
FROM goal INNER JOIN eteam ON teamid = id
WHERE gtime <= 10



/*
#6
Q: 
To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/
SELECT mdate, teamname
FROM game INNER JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos'



/*
#7
Q: 
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/
SELECT player 
FROM game INNER JOIN goal ON matchid = id
WHERE stadium = 'National Stadium, Warsaw'



/*
#8
Q: 
The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany.
*/
SELECT DISTINCT player
FROM goal INNER JOIN game ON matchid = id
WHERE teamid != 'GER' AND (team1 = 'GER' OR team2 = 'GER')



/*
#9
Q: 
Show teamname and the total number of goals scored.
*/
SELECT teamname, COUNT(*)
FROM goal INNER JOIN eteam ON teamid = id
GROUP BY teamname



/*
#10
Q: 
Show the stadium and the number of goals scored in each stadium.
*/
SELECT stadium, COUNT(*)
FROM goal INNER JOIN game ON matchid = id
GROUP BY stadium



/*
#11
Q: 
For every match involving 'POL', show the matchid, date and the number of goals scored.
*/
SELECT matchid, mdate, COUNT(*)
FROM goal INNER JOIN game ON matchid= id
WHERE team1 = 'POL' OR team2 = 'POL'
GROUP BY matchid, mdate



/*
#12
Q: 
For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'
*/
SELECT matchid, mdate, COUNT(*)
FROM goal INNER JOIN game ON matchid = id
WHERE teamid = 'GER'
GROUP BY matchid, mdate



/*
#13
Q: 
List every match with the goals scored by each team as shown. 
This will use "CASE WHEN" which has not been explained in any previous exercises.

Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0.
You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.
*/
SELECT mdate, 
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) score2
FROM goal RIGHT OUTER JOIN game ON matchid = id
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2



