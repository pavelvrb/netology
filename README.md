# SELECT ('ФИО: Павел Воробьев');
-- первый запрос
--1.1
select * from ratings LIMIT 10;

--1.2
SELECT * FROM links
WHERE imdbid LIKE '%42' and movieid BETWEEN 100 AND 1000
LIMIT 10;

--2.1
SELECT imdbid FROM links
INNER JOIN ratings ON links.movieid = ratings.movieid
WHERE ratings.rating = 5
LIMIT 10;

--3.1
SELECT COUNT(movieid) from ratings
WHERE rating IS NULL
LIMIT 10;

--3.2
SELECT userid, AVG(rating) from ratings
GROUP BY userid
HAVING AVG(rating) > 3.5
LIMIT 10;

--4.1
SELECT AVG (avg)
FROM
    (SELECT links.imdbid, AVG(rating) as avg
    FROM links
    INNER JOIN ratings on links.movieid=ratings.movieid
    GROUP BY links.imdbid
    HAVING AVG(rating) > 3.5
    limit 10) AS podzapros;

--4.2
WITH cte_test AS
(SELECT userid,COUNT(movieid) FROM ratings
GROUP BY userid
HAVING COUNT(movieid) > 10)
SELECT AVG(rating)
FROM ratings
INNER JOIN cte_test ON ratings.userid = cte_test.userid
LIMIT 10;
