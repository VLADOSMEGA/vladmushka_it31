sqlite> PRAGMA foreign_keys = ON;
sqlite> SELECT * FROM loans;
1|2|1|2026-09-01|2026-09-10
2|4|2|2026-09-02|2026-09-12
3|3|3|2026-09-03|2026-09-20
4|6|1|2026-09-04|2026-09-14
5|5|4|2026-09-05|
6|2|5|2026-09-06|2026-09-13
7|7|6|2026-09-07|
8|4|3|2026-09-08|
9|1|2|2026-09-09|2026-09-15
sqlite> SELECT COUNT(*) AS total_loans,
   ...>        COUNT(return_date) AS returned_loans
   ...> FROM loans;
9|6
sqlite> SELECT SUM(copies_count) AS total_copies,
   ...>        AVG(copies_count) AS average_copies
   ...> FROM books;
30|3.75
sqlite> SELECT MIN(issue_date) AS earliest_issue,
   ...>        MAX(issue_date) AS latest_issue
   ...> FROM loans;
2026-09-01|2026-09-09
sqlite> SELECT COUNT(*) AS total_loans,
   ...>        COUNT(return_date) AS returned_loans,
   ...>        MIN(issue_date) AS earliest_issue,
   ...>        MAX(issue_date) AS latest_issue,
   ...>        COUNT(DISTINCT reader_id) AS unique_readers
   ...> FROM loans;
9|6|2026-09-01|2026-09-09|6
sqlite> SELECT COUNT(*) AS loans_for_book_2,
   ...>        COUNT(return_date) AS returned_for_book_2
   ...> FROM loans
   ...> WHERE book_id = 2;
2|2
sqlite> 
