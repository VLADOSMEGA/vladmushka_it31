-- Практична робота №18
-- Генеровані стовпці в SQLite

-- Завдання 1. Числовий генерований стовпець
ALTER TABLE books
ADD COLUMN total_loan_days INTEGER
GENERATED ALWAYS AS (copies_count * 14) VIRTUAL;

-- Перевірка першого генерованого стовпця
SELECT id, title, copies_count, total_loan_days
FROM books
LIMIT 10;

-- Завдання 2. Логічний генерований стовпець
ALTER TABLE books
ADD COLUMN is_novel INTEGER
GENERATED ALWAYS AS (genre = 'Роман') VIRTUAL;

-- Перевірка другого генерованого стовпця
SELECT id, title, genre, is_novel
FROM books
LIMIT 15;

-- Завдання 3. Спроба змінити генерований стовпець
-- UPDATE books SET total_loan_days = 100 WHERE id = 2;
-- Помилка: cannot UPDATE generated column "total_loan_days"

-- Завдання 4. Зміна вихідного значення
SELECT id, title, copies_count, total_loan_days
FROM books WHERE id = 2;

UPDATE books SET copies_count = 5 WHERE id = 2;

SELECT id, title, copies_count, total_loan_days
FROM books WHERE id = 2;

-- Відновлення початкового значення
UPDATE books SET copies_count = 4 WHERE id = 2;

-- Завдання 5. Використання генерованого стовпця у WHERE
SELECT id, title, copies_count, total_loan_days
FROM books
WHERE total_loan_days > 50;

-- Фінальна перевірка
SELECT id, title, copies_count, total_loan_days, genre, is_novel
FROM books
WHERE id = 2;
