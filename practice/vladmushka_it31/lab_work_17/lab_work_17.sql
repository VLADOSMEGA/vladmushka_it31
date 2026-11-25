-- Практична робота №17
-- Імпорт даних із CSV у SQLite: типові проблеми, перевірка й експорт

-- Завдання 1. Створення staging-таблиці
CREATE TABLE books_staging (
    title TEXT,
    author TEXT,
    publication_year INTEGER,
    genre TEXT,
    copies_count INTEGER
);

-- Неправильний імпорт без налаштування роздільника:
-- .mode csv
-- .import --skip 1 v1_raw_rows.csv books_staging
-- Результат: 10 рядків, але дані неправильно розподілені між стовпцями.

-- Очищення таблиці
DELETE FROM books_staging;

-- Завдання 2. Правильний імпорт
-- .mode csv
-- .separator ";"
-- .import --skip 1 v1_raw_rows.csv books_staging

SELECT COUNT(*) AS imported_rows FROM books_staging;

SELECT * FROM books_staging LIMIT 3;

-- Завдання 3. Перевірка порожніх значень
SELECT
    SUM(title = '') AS empty_title,
    SUM(author = '') AS empty_author,
    SUM(publication_year IS NULL OR publication_year = '') AS empty_year,
    SUM(genre = '') AS empty_genre,
    SUM(copies_count IS NULL OR copies_count = '') AS empty_copies
FROM books_staging;

-- Перевірка типів даних
SELECT title, publication_year, typeof(publication_year)
FROM books_staging;

-- Пошук дублікатів
SELECT title, author, publication_year, genre, copies_count,
       COUNT(*) AS repetitions
FROM books_staging
GROUP BY title, author, publication_year, genre, copies_count
HAVING COUNT(*) > 1;

-- Завдання 4. Перевірка кількості записів до перенесення
SELECT COUNT(*) AS books_before FROM books;
SELECT MAX(id) AS max_id_before FROM books;

-- Перенесення унікальних записів
INSERT INTO books (title, author, publication_year, genre, copies_count)
SELECT DISTINCT
    title,
    author,
    NULLIF(publication_year, ''),
    genre,
    copies_count
FROM books_staging;

-- Перевірка після перенесення
SELECT COUNT(*) AS books_after FROM books;
SELECT MAX(id) AS max_id_after FROM books;

SELECT id, title, publication_year, typeof(publication_year)
FROM books
WHERE id > 16;

SELECT COUNT(*) AS books_without_year
FROM books
WHERE id > 16 AND publication_year IS NULL;

-- Видалення тимчасової таблиці
DROP TABLE books_staging;

-- Завдання 5. Експорт нових записів
-- .headers on
-- .mode csv
-- .output v1_export.csv
-- SELECT id, title, author, publication_year, genre, copies_count
-- FROM books WHERE id > 16;
-- .output stdout
