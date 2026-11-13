sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> WHERE book_id = 7;
QUERY PLAN
`--SCAN loans
sqlite> CREATE INDEX idx_loans_book_id
   ...> ON loans(book_id);
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> WHERE book_id = 7;
QUERY PLAN
`--SEARCH loans USING INDEX idx_loans_book_id (book_id=?)
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> WHERE book_id = 7 AND reader_id = 1;
QUERY PLAN
`--SEARCH loans USING INDEX idx_loans_book_id (book_id=?)
sqlite> CREATE INDEX idx_loans_book_reader
   ...> ON loans(book_id, reader_id);
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> WHERE book_id = 7 AND reader_id = 1;
QUERY PLAN
`--SEARCH loans USING INDEX idx_loans_book_reader (book_id=? AND reader_id=?)
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> ORDER BY issue_date;
QUERY PLAN
|--SCAN loans
`--USE TEMP B-TREE FOR ORDER BY
sqlite> CREATE INDEX idx_loans_issue_date
   ...> ON loans(issue_date);
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> ORDER BY issue_date;
QUERY PLAN
`--SCAN loans USING INDEX idx_loans_issue_date
sqlite> DROP INDEX idx_loans_issue_date;
sqlite> EXPLAIN QUERY PLAN
   ...> SELECT *
   ...> FROM loans
   ...> ORDER BY issue_date;
QUERY PLAN
|--SCAN loans
`--USE TEMP B-TREE FOR ORDER BY
sqlite> SELECT name
   ...> FROM sqlite_master
   ...> WHERE type = 'index'
   ...> AND name = 'idx_loans_issue_date';
sqlite> 
