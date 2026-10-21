sqlite> CREATE TABLE reservations (
(x1...>     id INTEGER PRIMARY KEY,
(x1...>     book_id INTEGER NOT NULL REFERENCES books(id),
(x1...>     reader_id INTEGER NOT NULL REFERENCES readers(id),
(x1...>     reservation_date TEXT NOT NULL,
(x1...>     status TEXT NOT NULL DEFAULT 'active'
(x1...>         CHECK (status IN ('active', 'fulfilled', 'cancelled')),
(x1...>     queue_position INTEGER NOT NULL
(x1...>         CHECK (queue_position > 0)
(x1...> );
sqlite> INSERT INTO reservations
   ...>     (book_id, reader_id, reservation_date, status, queue_position)
   ...> VALUES
   ...>     (2, 1, '2026-10-01', 'active', 1),
   ...>     (2, 2, '2026-10-02', 'active', 2),
   ...>     (2, 3, '2026-10-03', 'active', 3),
   ...>     (4, 1, '2026-10-04', 'active', 1),
   ...>     (4, 4, '2026-10-05', 'active', 2),
   ...>     (3, 2, '2026-10-06', 'active', 1),
   ...>     (5, 5, '2026-10-07', 'fulfilled', 1),
   ...>     (2, 6, '2026-10-08', 'cancelled', 4);
sqlite> SELECT * FROM reservations;
1|2|1|2026-10-01|active|1
2|2|2|2026-10-02|active|2
3|2|3|2026-10-03|active|3
4|4|1|2026-10-04|active|1
5|4|4|2026-10-05|active|2
6|3|2|2026-10-06|active|1
7|5|5|2026-10-07|fulfilled|1
8|2|6|2026-10-08|cancelled|4
sqlite> .schema books
CREATE TABLE IF NOT EXISTS "books" (
    id INTEGER PRIMARY KEY,
    title TEXT,
    author TEXT,
    publication_year INTEGER,
    genre TEXT,
    copies_count INTEGER NOT NULL DEFAULT 1 CHECK (copies_count >= 0)
);
sqlite> .schema readers
CREATE TABLE IF NOT EXISTS "readers" (
    id INTEGER PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT,
    phone TEXT UNIQUE
);
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     books.author,
   ...>     readers.last_name,
   ...>     COUNT(reservations.id) AS reservations_count
   ...> FROM reservations
   ...> JOIN books ON reservations.book_id = books.id
   ...> JOIN readers ON reservations.reader_id = readers.id
   ...> GROUP BY books.id;
2|Тигролови|Іван Багряний|Мушка|4
3|Захар Беркут|Іван Франко|Шевченко|1
4|Лісова пісня|Леся Українка|Мушка|2
5|Місто|Валер'ян Підмогильний|Бондаренко|1
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     books.author,
   ...>     COUNT(reservations.id) AS reservations_count
   ...> FROM reservations
   ...> JOIN books ON reservations.book_id = books.id
   ...> JOIN readers ON reservations.reader_id = readers.id
   ...> GROUP BY books.id;
2|Тигролови|Іван Багряний|4
3|Захар Беркут|Іван Франко|1
4|Лісова пісня|Леся Українка|2
5|Місто|Валер'ян Підмогильний|1
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     books.author,
   ...>     COUNT(reservations.id) AS reservations_count
   ...> FROM reservations
   ...> JOIN books ON reservations.book_id = books.id
   ...> JOIN readers ON reservations.reader_id = readers.id
   ...> GROUP BY books.id
   ...> HAVING COUNT(reservations.id) >= 2;
2|Тигролови|Іван Багряний|4
4|Лісова пісня|Леся Українка|2
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     books.author,
   ...>     COUNT(reservations.id) AS active_reservations
   ...> FROM reservations
   ...> JOIN books ON reservations.book_id = books.id
   ...> JOIN readers ON reservations.reader_id = readers.id
   ...> WHERE reservations.status = 'active'
   ...> GROUP BY books.id
   ...> HAVING COUNT(reservations.id) >= 2;
2|Тигролови|Іван Багряний|3
4|Лісова пісня|Леся Українка|2
sqlite> INSERT INTO books (title, author, publication_year, genre)
   ...> VALUES ('Тигролови', 'Інший автор', 2020, 'Роман');
sqlite> SELECT id, title, author
   ...> FROM books
   ...> WHERE title = 'Тигролови';
2|Тигролови|Іван Багряний
9|Тигролови|Інший автор
sqlite> INSERT INTO reservations
   ...>     (book_id, reader_id, reservation_date, status, queue_position)
   ...> VALUES
   ...>     (9, 1, '2026-10-09', 'active', 1),
   ...>     (9, 2, '2026-10-10', 'active', 2);
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     COUNT(reservations.id) AS reservations_count
   ...> FROM reservations
   ...> JOIN books ON reservations.book_id = books.id
   ...> GROUP BY books.id;
2|Тигролови|4
3|Захар Беркут|1
4|Лісова пісня|2
5|Місто|1
9|Тигролови|2
sqlite> SELECT
   ...>     books.title,
   ...>     COUNT(reservations.id) AS reservations_count
   ...> FROM reservations
   ...> JOIN books ON reservations.book_id = books.id
   ...> GROUP BY books.title;
Захар Беркут|1
Лісова пісня|2
Місто|1
Тигролови|6
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     COUNT(reservations.id) AS active_reservations
   ...> FROM books
   ...> JOIN reservations ON reservations.book_id = books.id
   ...> WHERE reservations.status = 'active'
   ...> GROUP BY books.id
   ...> HAVING COUNT(reservations.id) >= 2;
2|Тигролови|3
4|Лісова пісня|2
9|Тигролови|2
sqlite> SELECT
   ...>     books.id,
   ...>     books.title,
   ...>     COUNT(reservations.id) AS active_reservations
   ...> FROM books
   ...> LEFT JOIN reservations ON reservations.book_id = books.id
   ...> WHERE reservations.status = 'active'
   ...> GROUP BY books.id
   ...> HAVING COUNT(reservations.id) >= 2;
2|Тигролови|3
4|Лісова пісня|2
9|Тигролови|2
sqlite> .quit