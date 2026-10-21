sqlite> SELECT *
   ...> FROM loans
   ...> ORDER BY issue_date DESC;
9|1|2|2026-09-09|2026-09-15
8|4|3|2026-09-08|
7|7|6|2026-09-07|
6|2|5|2026-09-06|2026-09-13
5|5|4|2026-09-05|
4|6|1|2026-09-04|2026-09-14
3|3|3|2026-09-03|2026-09-20
2|4|2|2026-09-02|2026-09-12
1|2|1|2026-09-01|2026-09-10
sqlite> SELECT *
   ...> FROM loans
   ...> ORDER BY return_date DESC, issue_date ASC;
3|3|3|2026-09-03|2026-09-20
9|1|2|2026-09-09|2026-09-15
4|6|1|2026-09-04|2026-09-14
6|2|5|2026-09-06|2026-09-13
2|4|2|2026-09-02|2026-09-12
1|2|1|2026-09-01|2026-09-10
5|5|4|2026-09-05|
7|7|6|2026-09-07|
8|4|3|2026-09-08|
sqlite> SELECT *
   ...> FROM loans
   ...> ORDER BY issue_date DESC
   ...> LIMIT 3;
9|1|2|2026-09-09|2026-09-15
8|4|3|2026-09-08|
7|7|6|2026-09-07|
sqlite> SELECT DISTINCT genre
   ...> FROM books
   ...> ORDER BY genre;

Історичний роман
Драма-феєрія
Казка
Поезія
Роман
Тест
sqlite> SELECT COUNT(DISTINCT genre)
   ...> FROM books;
6
sqlite> SELECT id, title, genre
   ...> FROM books
   ...> WHERE genre IN ('Роман', 'Казка');
2|Тигролови|Роман
5|Місто|Роман
6|Маленький принц|Казка
sqlite> SELECT id, last_name
   ...> FROM readers;
1|Мушка
2|Шевченко
3|Петренко
4|Коваленко
5|Бондаренко
6|Мельник
sqlite> SELECT last_name
   ...> FROM readers
   ...> WHERE last_name LIKE 'М%';
Мушка
Мельник
sqlite> SELECT last_name
   ...> FROM readers
   ...> WHERE last_name LIKE 'м%';
sqlite> .quit