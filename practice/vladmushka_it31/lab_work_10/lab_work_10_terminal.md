sqlite> SELECT book_id, COUNT(*) AS loans_count
   ...> FROM loans
   ...> GROUP BY book_id
   ...> HAVING COUNT(*) > 1;
2|2
4|2
sqlite> SELECT book_id,
   ...>        MIN(issue_date) AS first_issue
   ...> FROM loans
   ...> GROUP BY book_id
   ...> HAVING MIN(issue_date) >= '2026-09-05';
1|2026-09-09
5|2026-09-05
7|2026-09-07
sqlite> SELECT book_id, COUNT(*) AS loans_count
   ...> FROM loans
   ...> WHERE issue_date >= '2026-09-02'
   ...> GROUP BY book_id
   ...> HAVING COUNT(*) >= 2;
4|2
sqlite> SELECT book_id, COUNT(*) AS loans_count
   ...> FROM loans
   ...> WHERE COUNT(*) > 1
   ...> GROUP BY book_id;
Parse error: misuse of aggregate: COUNT()
  book_id, COUNT(*) AS loans_count FROM loans WHERE COUNT(*) > 1 GROUP BY book_i
                                      error here ---^
sqlite> SELECT book_id, COUNT(*) AS loans_count
   ...> FROM loans
   ...> GROUP BY book_id
   ...> HAVING COUNT(*) > 1;
2|2
4|2
sqlite> SELECT books.id,
   ...>        books.title,
   ...>        COUNT(loans.id) AS loans_count
   ...> FROM books
   ...> LEFT JOIN loans ON loans.book_id = books.id
   ...> GROUP BY books.id
   ...> HAVING COUNT(loans.id) < 2;
1||1
3|Захар Беркут|1
5|Місто|1
6|Маленький принц|1
7|Невідома книга|1
8|Книга за замовчуванням|0
sqlite> 