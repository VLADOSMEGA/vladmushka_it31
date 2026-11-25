-- Практична робота №19
-- Міграція бази даних SQLite до PostgreSQL

-- 1. Створення таблиць

CREATE TABLE IF NOT EXISTS books (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title TEXT,
    author TEXT,
    publication_year INTEGER,
    genre TEXT,
    copies_count INTEGER NOT NULL DEFAULT 1
        CHECK (copies_count >= 0)
);

CREATE TABLE IF NOT EXISTS readers (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    last_name TEXT NOT NULL,
    first_name TEXT,
    phone TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS loans (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    book_id INTEGER NOT NULL,
    reader_id INTEGER NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (reader_id) REFERENCES readers(id)
);

-- 2. Синхронізація послідовностей IDENTITY

SELECT setval(pg_get_serial_sequence('books', 'id'),
              (SELECT MAX(id) FROM books));

SELECT setval(pg_get_serial_sequence('readers', 'id'),
              (SELECT MAX(id) FROM readers));

SELECT setval(pg_get_serial_sequence('loans', 'id'),
              (SELECT MAX(id) FROM loans));

-- 3. Перевірка кількості записів

SELECT 'books' AS table_name, COUNT(*) FROM books
UNION ALL
SELECT 'readers', COUNT(*) FROM readers
UNION ALL
SELECT 'loans', COUNT(*) FROM loans;

-- 4. Перевірка автоматичної генерації ID
-- Тестовий запис був створений з ID 26, після чого видалений.

-- INSERT INTO books (title, author, publication_year, genre, copies_count)
-- VALUES ('Тестова книга', 'Тестовий автор', 2026, 'Тест', 1)
-- RETURNING id;

-- DELETE FROM books WHERE id = 26;

-- 5. Перевірка зовнішнього ключа
-- Запит навмисно викликає помилку, оскільки книги з ID 999 немає.

-- INSERT INTO loans (book_id, reader_id, issue_date, return_date)
-- VALUES (999, 1, '2026-11-25', NULL);
