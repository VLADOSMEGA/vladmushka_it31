-- Практична робота №16. Імпорт CSV у SQLite

-- Завдання 1. Перевірка початкових даних
.schema books
SELECT COUNT(*) FROM books;

-- Завдання 3. Створення проміжної таблиці
CREATE TABLE books_staging (
    title TEXT,
    author TEXT,
    publication_year INTEGER,
    genre TEXT,
    copies_count INTEGER
);

-- Імпорт CSV
.mode csv
.import --skip 1 v1_new_rows.csv books_staging

-- Перевірка проміжної таблиці
SELECT * FROM books_staging;

-- Перенесення даних до основної таблиці
INSERT INTO books (title, author, publication_year, genre, copies_count)
SELECT title, author, publication_year, genre, copies_count
FROM books_staging;

-- Видалення проміжної таблиці
DROP TABLE books_staging;

-- Завдання 4. Перевірка результатів
SELECT COUNT(*) FROM books;

SELECT id, title, author
FROM books
WHERE id > 8;

-- Завдання 5. Перевірка прямого імпорту
-- Виконується окремо в тестовій базі lab_work_16_test.db
.open lab_work_16_test.db .mode csv
.import --skip 1 v1_new_rows.csv books
SELECT COUNT(*) FROM books;
