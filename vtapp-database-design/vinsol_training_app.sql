mysql> CREATE DATABASE vtapp_design;
Query OK, 1 row affected (0.06 sec)

mysql> use vtapp_design;
Database changed

mysql> CREATE TABLE users(
    -> id INT AUTO_INCREMENT,
    -> user_name VARCHAR(30),
    -> admin boolean,
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.22 sec)

mysql> CREATE TABLE tracks(
    -> id INT AUTO_INCREMENT,
    -> track_name VARCHAR(30),
    -> track_owner INT NOT NULL,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(track_owner) REFERENCES users(id)
    -> );
Query OK, 0 rows affected (0.34 sec)

mysql> CREATE TABLE exercise_and_tasks(
    -> id INT AUTO_INCREMENT,
    -> user_id INT NOT NULL,
    -> task_name VARCHAR(30),
    -> track_id INT NOT NULL,
    -> assigned_by INT NOT NULL,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(track_id) REFERENCES tracks(id),
    -> FOREIGN KEY (user_id) REFERENCES users(id),
    -> FOREIGN KEY (assigned_by) REFERENCES users(id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE track_reviewer(
    -> id INT AUTO_INCREMENT,
    -> track_id INT NOT NULL,
    -> user_id INT NOT NULL,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(track_id) REFERENCES tracks(id),
    -> FOREIGN KEY(user_id) REFERENCES users(id)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> CREATE TABLE track_runner(
    -> id INT AUTO_INCREMENT,
    -> user_id INT NOT NULL,
    -> track_id INT NOT NULL,
    -> track_reviewer_id INT NOT NULL,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(user_id) REFERENCES users(id),
    -> FOREIGN KEY(track_id) REFERENCES tracks(id),
    -> FOREIGN KEY(track_reviewer_id) REFERENCES track_reviewer(id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> ALTER TABLE track_runner
    -> DROP COLUMN track_reviewer_id;
Query OK, 0 rows affected (0.24 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE track_reviewer
    -> ADD COLUMN track_reviewer_id INT NOT NULL;
Query OK, 0 rows affected (0.70 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE track_reviewer
    -> ADD FOREIGN KEY (track_reviewer_id)
    -> REFERENCES users(id);
Query OK, 0 rows affected (0.09 sec)
Records: 0  Duplicates: 0  Warnings: 0


-- Inserting Values

mysql> INSERT INTO users(user_name, admin)
    -> VALUES ('Manik Juneja', true),
    -> ('Akhil Bansal', true),
    -> ('Jatin Baweja', false),
    -> ('Tanmay Sinha', false),
    -> ('Vishwas Malhotra', false),
    -> ('Manish Rawat', false);
Query OK, 6 rows affected (0.03 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> INSERT INTO tracks(track_name, track_owner)
    -> VALUES ('MySQL', 2),
    -> ('PHP', 4),
    -> ('JavaScript', 3),
    -> ('JQuery', 1),
    -> ('HTML', 2),
    -> ('CSS', 3),
    -> ('Ruby', 4);
Query OK, 7 rows affected (0.00 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO exercise_and_tasks(task_name, track_id, user_id, assigned_by)
    -> VALUES ('Do this', 3, 6, 4),
    -> ('Do that', 1, 4, 3),
    -> ('Do example', 5, 3, 2),
    -> ('Do this study track', 4, 5, 1),
    -> ('Do everything', 6, 5, 2);
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO track_reviewer(track_id, user_id, track_reviewer_id)
    -> VALUES(1,5,2),
    -> (3,6,1),
    -> (5,5,3),
    -> (7,5,4);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO track_runner(user_id, track_id)
    -> VALUES (5,5),
    -> (6,7),
    -> (5,6),
    -> (6,4);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

-- Output
mysql> SELECT * FROM users;
+----+------------------+-------+
| id | user_name        | admin |
+----+------------------+-------+
|  1 | Manik Juneja     |     1 |
|  2 | Akhil Bansal     |     1 |
|  3 | Jatin Baweja     |     0 |
|  4 | Tanmay Sinha     |     0 |
|  5 | Vishwas Malhotra |     0 |
|  6 | Manish Rawat     |     0 |
+----+------------------+-------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM tracks;
+----+------------+-------------+
| id | track_name | track_owner |
+----+------------+-------------+
|  1 | MySQL      |           2 |
|  2 | PHP        |           4 |
|  3 | JavaScript |           3 |
|  4 | JQuery     |           1 |
|  5 | HTML       |           2 |
|  6 | CSS        |           3 |
|  7 | Ruby       |           4 |
+----+------------+-------------+
7 rows in set (0.00 sec)

mysql> SELECT * FROM exercise_and_tasks;
+----+---------+---------------------+----------+-------------+
| id | user_id | task_name           | track_id | assigned_by |
+----+---------+---------------------+----------+-------------+
|  1 |       6 | Do this             |        3 |           4 |
|  2 |       4 | Do that             |        1 |           3 |
|  3 |       3 | Do example          |        5 |           2 |
|  4 |       5 | Do this study track |        4 |           1 |
|  5 |       5 | Do everything       |        6 |           2 |
+----+---------+---------------------+----------+-------------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM track_reviewer;
+----+----------+---------+-------------------+
| id | track_id | user_id | track_reviewer_id |
+----+----------+---------+-------------------+
|  1 |        1 |       5 |                 2 |
|  2 |        3 |       6 |                 1 |
|  3 |        5 |       5 |                 3 |
|  4 |        7 |       5 |                 4 |
+----+----------+---------+-------------------+
4 rows in set (0.00 sec)

mysql> SELECT * FROM track_runner;
+----+---------+----------+
| id | user_id | track_id |
+----+---------+----------+
|  1 |       5 |        5 |
|  2 |       6 |        7 |
|  3 |       5 |        6 |
|  4 |       6 |        4 |
+----+---------+----------+
4 rows in set (0.00 sec)
