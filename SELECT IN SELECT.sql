
QUIZ  
  -- 1. Select the code which gives the name of countries beginning with U

SELECT name
  FROM world
 WHERE name LIKE 'U%'

--2. Select the code which shows just the population of United Kingdom?

SELECT population
  FROM world
 WHERE name = 'United Kingdom'

--3. Select the answer which shows the problem with this SQL code - the intended result should be the continent of France:

'name' should be name


--4. Select the result that would be obtained from the following code:

 SELECT name, population / 10 
  FROM world 
 WHERE population < 10000

--5. Select the code which would reveal the name and population of countries in Europe and Asia

SELECT name, population
  FROM world
 WHERE continent IN ('Europe', 'Asia')

--6. Select the code which would give two rows

SELECT name FROM world
 WHERE name IN ('Cuba', 'Togo')


--7. Select the result that would be obtained from this code:

Brazil
Colombia

SELECT ON SELECT

-- 1 
/* List each country name where the population is larger than that of 'Russia'. */

SELECT name
FROM world
WHERE population > (SELECT population 
                    FROM world
                    WHERE name = 'Russia')

--2 
/* Show the countries in Europe with a per capita GDP greater than 'United Kingdom'.
Per Capita GDP
The per capita GDP is the gdp/population */

SELECT name 
FROM world
WHERE gdp/population >(SELECT gdp/population FROM world WHERE name= 'United Kingdom') AND continent = 'Europe'

--3
/* List the name and continent of countries in the continents containing either Argentina or Australia. Order by name of the country. */
SELECT name, continent 
FROM world 
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name

--4
/ * Which country has a population that is more than United Kingdom but less than Germany? Show the name and the population. */

SELECT name, population
FROM world
WHERE population >(SELECT population FROM world WHERE name = 'United Kingdom') AND population< (SELECT population FROM world WHERE name = 'GERMANY')

--5
/* Germany (population 80 million) has the largest population of the countries in Europe. Austria (population 8.5 million) has 11% of the population of Germany.
Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.
The format should be Name, Percentage for example: */

SELECT 
  name, 
  CONCAT(ROUND((population*100)/(SELECT population 
                                 FROM world WHERE name='Germany'), 0), '%') AS percent
FROM world
WHERE continent='Europe')

--6 
/* Which countries have a GDP greater than every country in Europe? [Give the name only.] (Some countries may have NULL gdp values)  */

SELECT name 
FROM world as x
WHERE gdp > ALL (SELECT gdp FROM world as y WHERE continent = 'Europe')
  
--7
/* Find the largest country (by area) in each continent, show the continent, the name and the area: */
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

--8
/* List each continent and the name of the country that comes first alphabetically. */

SELECT DISTINCT x.continent, x.name
FROM world x
WHERE x.name = (
    SELECT MIN(y.name)
    FROM world y
    WHERE x.continent = y.continent
)

--9
/* Find the continents where all countries have a population <= 25000000. Then find the names of the countries associated with these continents. Show name, continent and population. */

SELECT x.name, x.continent, x.population 
FROM world as x 
WHERE x.continent NOT IN 
     (SELECT y.continent 
      FROM world y 
      WHERE y.population > 25000000)

--10
/* Some countries have populations more than three times that of all of their neighbours (in the same continent). Give the countries and continents. */

SELECT a.name AS country, a.continent
FROM world a
WHERE a.population > 3 * (SELECT SUM(b.population)
                          FROM world b
                          WHERE a.continent = b.continent
                            AND a.name <> b.name)
