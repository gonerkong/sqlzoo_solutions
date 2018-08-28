/*
#1
1962 movies
Q: 
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
FROM movie
WHERE yr=1962



/*
#2
When was Citizen Kane released?
Q: 
Give year of 'Citizen Kane'.
*/
SELECT yr 
FROM movie
WHERE title = 'Citizen Kane'



/*
#3
Star Trek movies
Q: 
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). 
Order results by year.
*/
SELECT id, title, yr
FROM movie
WHERE title REGEXP 'Star Trek'
ORDER BY yr



/*
#4
id for actor Glenn Close
Q: 
What id number does the actor 'Glenn Close' have?
*/
SELECT id
FROM actor
WHERE name = 'Glenn Close'



/*
#5
id for Casablanca
Q: 
What is the id of the film 'Casablanca'
*/
SELECT id
FROM movie
WHERE title = 'Casablanca'



/*
#6
Cast list for Casablanca
Q: 
Obtain the cast list for 'Casablanca'.
*/
SELECT name
FROM casting INNER JOIN actor ON id = actorid
WHERE movieid = (SELECT id FROM movie WHERE title = 'Casablanca')



/*
#7
Alien cast list
Q: 
Obtain the cast list for the film 'Alien'
*/
SELECT name
FROM casting INNER JOIN actor ON id = actorid
WHERE movieid = (SELECT id FROM movie WHERE title = 'Alien')



/*
#8
Harrison Ford movies
Q: 
List the films in which 'Harrison Ford' has appeared
*/
SELECT title
FROM casting INNER JOIN movie ON id = movieid
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford')



/*
#9
Harrison Ford as a supporting actor
Q: 
List the films where 'Harrison Ford' has appeared - but not in the starring role. 
[Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]ed
*/
SELECT title
FROM casting INNER JOIN movie ON id = movieid
WHERE actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford') AND ord != 1



/*
#10
Lead actors in 1962 movies
Q: 
List the films together with the leading star for all 1962 films.
*/
SELECT title, name
FROM casting INNER JOIN movie ON movieid = movie.id
             INNER JOIN actor ON actorid = actor.id
WHERE casting.ord = 1 AND movie.yr = 1962



/*
#11	
Busy years for John Travolta
Q: 
Which were the busiest years for 'John Travolta', 
show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr,COUNT(title) 
FROM movie JOIN casting ON movie.id=movieid
         JOIN actor ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2



/*
#12	
Lead actor in Julie Andrews movies
Q: 
List the film title and the leading actor for all of the films 'Julie Andrews' played in
*/
SELECT title, name
FROM casting INNER JOIN movie ON movie.id = movieid
             INNER JOIN actor ON actor.id = actorid
WHERE ord = 1 AND movie.id IN
(SELECT movie.id 
 FROM casting INNER JOIN movie ON movie.id = movieid
              INNER JOIN actor ON actor.id = actorid
 WHERE actor.name = 'Julie Andrews')



/*
#13
Actors with 30 leading roles
Q: 
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles
*/
SELECT actor.name
FROM casting INNER JOIN actor ON actor.id = casting.actorid
WHERE casting.ord = 1
GROUP BY actor.name
HAVING count(*) >= 30
ORDER BY actor.name DESC



/*
#14

Q: 
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/
SELECT title,count(*)
FROM casting INNER JOIN movie m ON m.id = movieid
WHERE yr = 1978
GROUP BY title
ORDER BY count(*) DESC, title



/*
#15

Q: 
List all the people who have worked with 'Art Garfunkel'.
*/
SELECT DISTINCT a.name
FROM casting c INNER JOIN actor a ON a.id = c.actorid
WHERE movieid IN 
(SELECT movieid
 FROM casting INNER JOIN actor ON id = actorid
 WHERE name = 'Art Garfunkel') 
AND a.name != 'Art Garfunkel'


