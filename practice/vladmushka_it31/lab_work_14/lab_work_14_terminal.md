sqlite> SELECT id, title, copies_count
   ...> FROM books;
1||5
2|Тигролови|4
3|Захар Беркут|4
4|Лісова пісня|6
5|Місто|2
6|Маленький принц|7
7|Невідома книга|1
8|Книга за замовчуванням|1
sqlite> BEGIN;
sqlite> 
sqlite> INSERT INTO loans (book_id, reader_id, issue_date)
   ...> VALUES (7, 1, '2026-11-11');
sqlite> 
sqlite> UPDATE books
   ...> SET copies_count = copies_count - 1
   ...> WHERE id = 7;
sqlite> 
sqlite> SELECT * FROM loans ORDER BY id DESC LIMIT 1;
10|7|1|2026-11-11|
sqlite> 
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|0
sqlite> 
sqlite> COMMIT;
sqlite> BEGIN;
sqlite> 
sqlite> UPDATE books
   ...> SET copies_count = copies_count + 5
   ...> WHERE id = 7;
sqlite> 
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|5
sqlite> 
sqlite> ROLLBACK;
sqlite> 
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|0
sqlite> BEGIN;
sqlite> 
sqlite> UPDATE books
   ...> SET copies_count = copies_count + 2
   ...> WHERE id = 7;
sqlite> 
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|2
sqlite> 
sqlite> ROLLBACK;
sqlite> BEGIN;
sqlite> 
sqlite> UPDATE books
   ...> SET copies_count = copies_count + 1
   ...> WHERE id = 7;
sqlite> 
sqlite> INSERT INTO readers (last_name, first_name, phone)
   ...> VALUES ('Тест', 'Тест', '123456789');
sqlite> INSERT INTO readers (last_name, first_name, phone)
   ...> VALUES ('Помилка', 'Тест', '123456789');
Runtime error: UNIQUE constraint failed: readers.phone (19)
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|1
sqlite> 
sqlite> SELECT * FROM readers
   ...> WHERE phone = '123456789';
7|Тест|Тест|123456789
sqlite> ROLLBACK;
sqlite> 
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|0
sqlite> 
sqlite> SELECT * FROM readers
   ...> WHERE phone = '123456789';
sqlite> BEGIN;
sqlite> 
sqlite> UPDATE books
   ...> SET copies_count = copies_count + 1
   ...> WHERE id = 7;
sqlite> 
sqlite> INSERT INTO readers (last_name, first_name, phone)
   ...> VALUES ('Тест', 'Тест', '123456789');
sqlite> 
sqlite> INSERT INTO readers (last_name, first_name, phone)
   ...> VALUES ('Помилка', 'Тест', '123456789');
Runtime error: UNIQUE constraint failed: readers.phone (19)
sqlite> COMMIT;
sqlite> 
sqlite> SELECT id, title, copies_count
   ...> FROM books WHERE id = 7;
7|Невідома книга|1
sqlite> 
sqlite> SELECT * FROM readers
   ...> WHERE phone = '123456789';
7|Тест|Тест|123456789
sqlite> 
