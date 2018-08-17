SELECT ('Воробьев Павел');

--1.1 оконные функции
<pre>
SELECT userid, movieid,
case
when (MAX(rating) - MIN(rating) OVER (PARTITION BY userid)) = 0
then 0
else (rating - MIN(rating) OVER (PARTITION BY userid)) / (MAX(rating) - MIN(rating) OVER (PARTITION BY userid))
end as normed_rating,
AVG(rating) OVER (PARTITION BY userid)
from (SELECT DISTINCT userId, movieId, rating FROM ratings) as podz
GROUP BY userid, movieid, podz.rating
ORDER BY userid,normed_rating
LIMIT 30;
</pre>

--2.1 ETL. Создание таблицы.
<pre>
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "DROP TABLE IF EXISTS keywords"
psql --host $APP_POSTGRES_HOST -U postgres -c '
  CREATE TABLE IF NOT EXISTS keywords (
    id bigint,
    tags VARCHAR
  );'
psql --host $APP_POSTGRES_HOST  -U postgres -c \
    "\\copy keywords FROM '/data/keywords.csv' DELIMITER ',' CSV HEADER"
</pre>

--2.2 ETL. Команда заливки данных в таблицу.
<pre>
psql --host $APP_POSTGRES_HOST  -U postgres -c \
>     "\\copy keywords FROM '/data/keywords.csv' DELIMITER ',' CSV HEADER"
</pre>

--2.3 ETL. Запрос 3
<pre>
WITH top_rated as(
SELECT movieid, userid, rating,
AVG(rating) OVER (PARTITION BY movieid) as avg,
COUNT(userid) OVER (PARTITION BY movieid) as cnt
from ratings
)
SELECT DISTINCT movieid, avg, keywords INTO top_rated_tags
from top_rated
INNER JOIN keywords ON keywords.id=top_rated.movieid
WHERE cnt >50
ORDER BY avg DESC, movieid ASC
Limit 150;
</pre>

--2.4 ETL. Команда выгрузки таблицы в файл
<pre>
\copy (select * from top_rated_tags) to '/data/top_tags_file.tsv' with  delimiter as E'\t';
</pre>
