Q1: What do different columns in the output of EXPLAIN mean? What possible values can those have? What is the meaning of those values?

 a) id
The SELECT identifier
 b) select_type
The SELECT type
 c) table
The table for the output row
 d) partitions
The matching partitions
 e) type
The JOIN type
 f) possible_keys
The possible indexes to choose
 g) key
The index actually chosen
 h) key_len
The length of the chosen key
 i) ref
The columns compared to the index
 j) rows
Estimate of rows to be examined
 k) filtered
Percentage of rows filtered by table condition
 l) Extra
Additional information


Q2.1: The value under 'rows' column in the output of EXPLAIN query and SELECT query after it are same. What does it mean?

	It indicates that MySQL believes it must examine the number of rows in order to execute the query.

Q3- NA

Q4.
mysql> EXPLAIN SELECT employees.name FROM employees INNER JOIN departments ON employees.department_id=departments.id;
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------------+
| id | select_type | table       | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                                              |
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------------+
|  1 | SIMPLE      | departments | NULL       | index | PRIMARY       | PRIMARY | 4       | NULL |    3 |   100.00 | Using index                                        |
|  1 | SIMPLE      | employees   | NULL       | ALL   | department_id | NULL    | NULL    | NULL |    6 |    16.67 | Using where; Using join buffer (Block Nested Loop) |
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------------+
2 rows in set, 1 warning (0.00 sec)


mysql> EXPLAIN SELECT employees.name FROM employees WHERE employees.department_id IN (SELECT departments.id FROM departments);
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------------+
| id | select_type | table       | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra                                              |
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------------+
|  1 | SIMPLE      | departments | NULL       | index | PRIMARY       | PRIMARY | 4       | NULL |    3 |   100.00 | Using index                                        |
|  1 | SIMPLE      | employees   | NULL       | ALL   | department_id | NULL    | NULL    | NULL |    6 |    16.67 | Using where; Using join buffer (Block Nested Loop) |
+----+-------------+-------------+------------+-------+---------------+---------+---------+------+------+----------+----------------------------------------------------+
2 rows in set, 1 warning (0.02 sec)
