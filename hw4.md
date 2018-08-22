<pre>
SELECT ('Павел Воробьев');
</pre>

--ТОП 5 таблиц
<pre>
--4.0 ТОП 5 таблиц
SELECT relname AS table_name, pg_size_pretty(pg_total_relation_size(relid)) AS table_size
FROM pg_catalog.pg_statio_all_tables
ORDER BY pg_total_relation_size(relid) DESC
LIMIT 5;
</pre>

-- собираем фильмы пользователей в массив
<pre>
SELECT DISTINCT userID, array_agg(movieId) as user_views 
FROM ratings
GROUP BY userID;
</pre>
-- сохраняем полученные данные в таблицу 
<pre>
SELECT userID, user_views INTO public.user_movies_agg 
FROM
  (SELECT userID, array_agg(movieId) as user_views FROM ratings
  GROUP BY userID) AS sample;
</pre>

--функция cross_arr
<pre>
CREATE OR REPLACE FUNCTION cross_arr (int[], int[]) RETURNS int[] language sql as $FUNCTION$ select array(select unnest($1) intersect select unnest($2)); $FUNCTION$;
</pre>
<pre>
WITH user_pairs as (SELECT agg.userId as u1, agg.userId as u2, agg.array_agg as ar1, agg.array_agg as ar2 from user_movies_agg as agg CROSS JOIN user_movies_agg GROUP BY agg.userid)
SELECT u1, u2, cross_arr(ar1, ar2) INTO common_user_views FROM user_pairs;
</pre>
<pre>
CREATE OR REPLACE FUNCTION diff_arr (int[], int[]) RETURNS int[] language sql as $FUNCTION$ select array(select unnest($1) except select unnest($2)); ; $FUNCTION$;
</pre>
