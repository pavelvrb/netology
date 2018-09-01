/*
        Написать запрос, который выводит общее число тегов
*/
<pre>
print("tags count: ", 'db.tags.count()');
</pre>
/*
        Добавляем фильтрацию: считаем только количество тегов woman
*/
<pre>
print("woman tags count: ", 'db.tags.count({name: 'woman'})');
</pre>
/*
        Используем группировку данных - посчитать количество вхождений для каждого тега
        и напечатать top-3 самых популярных
*/
<pre>
printjson(
        db.tags.aggregate([{$group: {_id: "$name",tag_count: { $sum: 1 }}}, {$sort: {tag_count: -1}}, {$limit: 3}])
);
</pre>
