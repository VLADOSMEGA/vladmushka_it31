-- Практична робота №20
-- Створення та застосування Views у PostgreSQL
-- База даних: library_db

-- УВАГА: файл містить журнал виконаних команд і результатів.
-- Не запускайте весь файл повторно на вже заповненій базі.

-- =========================================
-- Завдання 1. Звичайне подання-фільтр
-- =========================================

CREATE OR REPLACE VIEW active_loans AS
SELECT book_id, reader_id, issue_date, return_date
FROM loans
WHERE return_date IS NULL;

SELECT * FROM active_loans;

-- Результат: 4 активні позики (ID 5, 7, 8, 10).

-- =========================================
-- Завдання 2. Автоматичне оновлення VIEW
-- =========================================

SELECT COUNT(*) FROM active_loans;
-- Результат: 4.

INSERT INTO loans (book_id, reader_id, issue_date, return_date)
VALUES (1, 1, '2026-11-26', NULL);

SELECT COUNT(*) FROM active_loans;
-- Результат: 5. Новий рядок з'явився автоматично.

-- =========================================
-- Завдання 3. Запис через просте подання
-- =========================================

INSERT INTO active_loans (book_id, reader_id, issue_date)
VALUES (3, 2, '2026-11-26');

SELECT * FROM loans ORDER BY id DESC LIMIT 2;

-- Результат: INSERT 0 1.
-- Створено запис ID 14.
-- return_date отримав NULL, оскільки колонку не вказано.

-- =========================================
-- Завдання 4. Матеріалізоване подання
-- =========================================

CREATE MATERIALIZED VIEW active_loans_mat AS
SELECT book_id, reader_id, issue_date, return_date
FROM loans
WHERE return_date IS NULL;

SELECT COUNT(*) FROM active_loans_mat;
-- Результат: 6.

INSERT INTO loans (book_id, reader_id, issue_date, return_date)
VALUES (2, 3, '2026-11-26', NULL);

-- Повторна вставка створила зайвий запис ID 16.
-- Його видалено, залишено запис ID 15.

DELETE FROM loans WHERE id = 16;

SELECT COUNT(*) FROM active_loans;
-- Результат: 7.

SELECT COUNT(*) FROM active_loans_mat;
-- Результат: 6. Матеріалізоване подання ще не оновлене.

REFRESH MATERIALIZED VIEW active_loans_mat;

SELECT COUNT(*) FROM active_loans_mat;
-- Результат: 7.

-- =========================================
-- Завдання 5. CREATE OR REPLACE VIEW
-- =========================================

CREATE OR REPLACE VIEW active_loans AS
SELECT book_id, reader_id, issue_date, return_date, id
FROM loans
WHERE return_date IS NULL;

SELECT * FROM active_loans;
-- Результат: додано колонку id без видалення подання.

-- =========================================
-- Завдання 6. Подання з JOIN
-- =========================================

CREATE VIEW loans_with_books AS
SELECT l.id, l.book_id, l.reader_id, l.issue_date, l.return_date, b.title
FROM loans l
JOIN books b ON l.book_id = b.id;

INSERT INTO loans_with_books (book_id, reader_id, issue_date)
VALUES (1, 1, '2026-11-26');

-- Результат: помилка SQLSTATE 55000.
-- Подання з JOIN не підтримує автоматичний INSERT.

-- WITH CHECK OPTION

CREATE OR REPLACE VIEW active_loans AS
SELECT book_id, reader_id, issue_date, return_date, id
FROM loans
WHERE return_date IS NULL
WITH CHECK OPTION;

-- Вставка, яка відповідає умові WHERE:

INSERT INTO active_loans (book_id, reader_id, issue_date, return_date)
VALUES (1, 1, '2026-11-26', NULL);

-- Результат: INSERT 0 1. Успішно.

-- Вставка, яка не відповідає умові WHERE:

INSERT INTO active_loans (book_id, reader_id, issue_date, return_date)
VALUES (2, 2, '2026-11-26', '2026-11-27');

-- Результат: помилка SQLSTATE 44000.
-- WITH CHECK OPTION заборонив вставку.

-- =========================================
-- Підсумкова перевірка
-- =========================================

SELECT 'active_loans' AS view_name, COUNT(*) FROM active_loans
UNION ALL
SELECT 'active_loans_mat', COUNT(*) FROM active_loans_mat;

-- Результат:
-- active_loans     = 8
-- active_loans_mat = 7
-- Матеріалізоване подання потребує REFRESH.

