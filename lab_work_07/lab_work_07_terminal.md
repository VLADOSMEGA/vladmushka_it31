vladosmega@MacBook-Pro-Vladosmega Documents % cp /Users/vladosmega/Documents/lab_work_6.db /Users/vladosmega/Documents/lab_work_7.db
vladosmega@MacBook-Pro-Vladosmega Documents % sqlite3 /Users/vladosmega/Documents/lab_work_7.db
SQLite version 3.51.0 2025-06-12 13:14:41
Enter ".help" for usage hints.
sqlite> PRAGMA foreign_keys = ON;
sqlite> SELECT COUNT(*) FROM books;
8
sqlite> SELECT COUNT(*) FROM readers;
6
sqlite> SELECT COUNT(*) FROM loans;
9
sqlite> SELECT books.id, books.title
   ...> FROM books
   ...> LEFT JOIN loans ON loans.book_id = books.id
   ...> WHERE loans.id IS NULL;
8|Книга за замовчуванням
sqlite> SELECT books.title AS книга, loans.issue_date AS дата_видачі
   ...> FROM loans
   ...> INNER JOIN books ON loans.book_id = books.id
   ...> ORDER BY loans.issue_date;
Тигролови|2026-09-01
Лісова пісня|2026-09-02
Захар Беркут|2026-09-03
Маленький принц|2026-09-04
Місто|2026-09-05
Тигролови|2026-09-06
Невідома книга|2026-09-07
Лісова пісня|2026-09-08
|2026-09-09
sqlite> SELECT books.title AS книга,
   ...>        readers.last_name AS читач,
   ...>        loans.issue_date AS дата_видачі
   ...> FROM loans
   ...> INNER JOIN books ON loans.book_id = books.id
   ...> INNER JOIN readers ON loans.reader_id = readers.id
   ...> ORDER BY loans.issue_date;
Тигролови|Мушка|2026-09-01
Лісова пісня|Шевченко|2026-09-02
Захар Беркут|Петренко|2026-09-03
Маленький принц|Мушка|2026-09-04
Місто|Коваленко|2026-09-05
Тигролови|Бондаренко|2026-09-06
Невідома книга|Мельник|2026-09-07
Лісова пісня|Петренко|2026-09-08
|Шевченко|2026-09-09
sqlite> SELECT books.id, books.title
   ...> FROM books
   ...> LEFT JOIN loans ON loans.book_id = books.id
   ...> WHERE loans.id IS NULL;
8|Книга за замовчуванням
sqlite> SELECT COUNT(*) FROM books;
8
sqlite> SELECT COUNT(*) FROM readers;
6
sqlite> SELECT COUNT(*) FROM books, readers;
48
sqlite> 
