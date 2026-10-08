sqlite> SELECT book_id, COUNT(*) AS loans_count
   ...> FROM loans
   ...> GROUP BY book_id;
1|1
2|2
3|1
4|2
5|1
6|1
7|1
sqlite> SELECT books.title AS book,
   ...>        COUNT(loans.id) AS loans_count
   ...> FROM books
   ...> LEFT JOIN loans ON loans.book_id = books.id
   ...> GROUP BY books.id;
|1
Тигролови|2
Захар Беркут|1
Лісова пісня|2
Місто|1
Маленький принц|1
Невідома книга|1
Книга за замовчуванням|0
sqlite> SELECT books.title AS book,
   ...>        COUNT(loans.id) AS loans_count,
   ...>        MIN(loans.issue_date) AS first_issue
   ...> FROM books
   ...> LEFT JOIN loans ON loans.book_id = books.id
   ...> GROUP BY books.id;
|1|2026-09-09
Тигролови|2|2026-09-01
Захар Беркут|1|2026-09-03
Лісова пісня|2|2026-09-02
Місто|1|2026-09-05
Маленький принц|1|2026-09-04
Невідома книга|1|2026-09-07
Книга за замовчуванням|0|
sqlite> SELECT book_id,
   ...>        reader_id,
   ...>        COUNT(*) AS loans_count
   ...> FROM loans
   ...> GROUP BY book_id, reader_id;
1|2|1
2|1|1
2|5|1
3|3|1
4|2|1
4|3|1
5|4|1
6|1|1
7|6|1
sqlite> SELECT book_id,
   ...>        issue_date,
   ...>        COUNT(*) AS loans_count
   ...> FROM loans
   ...> GROUP BY book_id;
1|2026-09-09|1
2|2026-09-01|2
3|2026-09-03|1
4|2026-09-02|2
5|2026-09-05|1
6|2026-09-04|1
7|2026-09-07|1
sqlite> 
