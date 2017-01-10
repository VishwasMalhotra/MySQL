mysql> CREATE DATABASE exercise_3;
Query OK, 1 row affected (0.04 sec)

mysql> use exercise_3
Database changed

--1 a. Manage(create, update, delete) categories, articles, comments, and users
mysql> CREATE TABLE users (
    -> id INT AUTO_INCREMENT,
    -> `name` VARCHAR(30),
    -> type ENUM('admin', 'user'),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE to_delete (
    -> id INT,
    -> test VARCHAR(20),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE categories (
    -> id INT AUTO_INCREMENT,
    -> classification VARCHAR(30),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> CREATE TABLE articles (
    -> id INT AUTO_INCREMENT,
    -> content TEXT,
    -> user_id INT,
    -> categories_id INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(user_id) REFERENCES users(id),
    -> FOREIGN KEY(categories_id) REFERENCES categories(id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE comments (
    -> id INT AUTO_INCREMENT,
    -> `comment` TEXT,
    -> user_id INT,
    -> article_id INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(user_id) REFERENCES users(id),
    -> FOREIGN KEY(article_id) REFERENCES articles(id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO users (name, type)
    -> VALUES ('Rahul', 'admin'),
    -> ('Abhishek', 'user'),
    -> ('user3', 'user'),
    -> ('Mayank', 'admin'),
    -> ('Aditya', 'user'),
    -> ('Madhur', 'admin'),
    -> ('Parth', 'admin'),
    -> ('Rishi', 'user'),
    -> ('Ajit', 'admin'),
    -> ('Pankaj', 'user');
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> INSERT INTO categories (classification)
    -> VALUES ('Music'),
    -> ('Sports'),
    -> ('Movies'),
    -> ('News');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO articles (content, user_id, categories_id)
    -> VALUES ('John is a good boy.', 3, 1),
    -> ('John plays tennis.', 1, 2),
    -> ('He is smart.', 8, 3),
    -> ('Sherlock lives in london.', 5, 4),
    -> ('His address is 221B, Baker St.', 6, 4),
    -> ('Watson is his assistant.', 7, 3),
    -> ('This is another article.', 2, 2),
    -> ('Hi, how are you?', 3, 1),
    -> ('I am good.', 3, 2),
    -> ('What\'s up?', 5, 3),
    -> ('Where do you live?', 7, 4),
    -> ('I stay in Delhi.', 6, 1),
    -> ('Delhi is in India.', 4, 2),
    -> ('Global warming.', 9, 2),
    -> ('Another Article on Global Warming.', 10, 3),
    -> ('Hello, This is an article.', 10, 4),
    -> ('Article on X.', 8, 3),
    -> ('Article on Y.', 9, 4),
    -> ('Article on ABC.', 2, 1),
    -> ('Article on XYZ.', 6, 4),
    -> ('Hi, this is an article.', 5, 1);
Query OK, 21 rows affected (0.00 sec)
Records: 21  Duplicates: 0  Warnings: 0

mysql> INSERT INTO comments(`comment`, user_id, article_id)
    -> VALUES ('Good.', 3, 2),
    -> ('Great.', 4, 1),
    -> ('Nice.', 5, 8),
    -> ('Bad.', 3, 20),
    -> ('Better.', 7, 1),
    -> ('Worse.', 8, 3),
    -> ('Worst.', 9, 3),
    -> ('Perfect.', 10, 6),
    -> ('Ok.', 1, 10),
    -> ('Fine.', 1, 15);
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

-- 1 b. Update and Delete queries.
mysql> INSERT INTO users (name, type)
    -> VALUES ('testingUser', 'admin');
Query OK, 1 row affected (0.06 sec)

mysql> UPDATE users
    -> SET users.name = 'deletingUser'
    -> WHERE users.id = 11;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM users
    -> WHERE users.name = 'deletingUser';
Query OK, 1 row affected (0.00 sec)

-- Correction of: Lets avoid using column names which include the column's table name.
mysql> ALTER TABLE comments CHANGE comment `text` text;
Query OK, 0 rows affected (0.14 sec)
Records: 0  Duplicates: 0  Warnings: 0

--2 a. Select all articles whose author's name is user3.
mysql> SELECT content, name, user_id
    -> FROM articles JOIN users
    -> ON articles.user_id = users.id
    -> WHERE name= 'user3';
+---------------------+-------+---------+
| content             | name  | user_id |
+---------------------+-------+---------+
| John is a good boy. | user3 |       3 |
| Hi, how are you?    | user3 |       3 |
| I am good.          | user3 |       3 |
+---------------------+-------+---------+
3 rows in set (0.00 sec)

--2 b. Select all articles whose author's name is user3 using variable.
mysql> SET @thirdUser = 'user3';
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT content, name, user_id
    -> FROM articles JOIN users
    -> ON articles.user_id = users.id
    -> WHERE name = @thirdUser;
+---------------------+-------+---------+
| content             | name  | user_id |
+---------------------+-------+---------+
| John is a good boy. | user3 |       3 |
| Hi, how are you?    | user3 |       3 |
| I am good.          | user3 |       3 |
+---------------------+-------+---------+
3 rows in set (0.00 sec)

--3. For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query.
mysql> SELECT content, GROUP_CONCAT(text SEPARATOR ' & ') AS 'Comments by User'
    -> FROM articles JOIN users
    -> ON articles.user_id=users.id LEFT JOIN comments
    -> ON comments.article_id=articles.id
    -> WHERE users.name='user3'
    -> GROUP BY articles.content;
+---------------------+------------------+
| content             | Comments by User |
+---------------------+------------------+
| Hi, how are you?    | Nice.            |
| I am good.          | NULL             |
| John is a good boy. | Great. & Better. |
+---------------------+------------------+
3 rows in set (0.00 sec)


-- 3 b. Using subquery.
mysql> SELECT content, GROUP_CONCAT(text SEPARATOR ' & ') AS 'Comments by User'
    -> FROM articles LEFT JOIN comments
    -> ON articles.id = comments.article_id
    -> WHERE articles.user_id
    -> =
    -> (SELECT id FROM users WHERE name = 'user3')
    -> GROUP BY articles.content;
+---------------------+------------------+
| content             | Comments by User |
+---------------------+------------------+
| Hi, how are you?    | Nice.            |
| I am good.          | NULL             |
| John is a good boy. | Great. & Better. |
+---------------------+------------------+
3 rows in set (0.00 sec)

--4. Write a query to select all articles which do not have any comments.
mysql> SELECT content
    -> FROM articles LEFT JOIN comments
    -> ON articles.id = comments.article_id
    -> WHERE text IS NULL;
+--------------------------------+
| content                        |
+--------------------------------+
| Sherlock lives in london.      |
| His address is 221B, Baker St. |
| This is another article.       |
| I am good.                     |
| Where do you live?             |
| I stay in Delhi.               |
| Delhi is in India.             |
| Global warming.                |
| Hello, This is an article.     |
| Article on X.                  |
| Article on Y.                  |
| Article on ABC.                |
| Hi, this is an article.        |
+--------------------------------+
13 rows in set (0.00 sec)

-- 5. Write a query to select article which has maximum comments.
mysql> SELECT articles.id, content FROM articles
    -> JOIN comments ON articles.id=comments.article_id
    -> GROUP BY articles.id
    -> HAVING COUNT(comments.id)
    -> =
    -> (
    -> SELECT DISTINCT COUNT(article_id) AS 'max_comment'
    -> FROM comments
    -> GROUP BY article_id
    -> ORDER BY max_comment DESC
    -> LIMIT 1
    -> );
+----+---------------------+
| id | content             |
+----+---------------------+
|  1 | John is a good boy. |
|  3 | He is smart.        |
+----+---------------------+
2 rows in set (0.03 sec)

--6. Write a query to select article which does not have more than one comment by the same user.
mysql> SELECT articles.id, content
    -> FROM articles LEFT JOIN comments
    -> ON articles.id=comments.article_id
    -> GROUP BY articles.id
    -> HAVING COUNT(comments.user_id) = COUNT(DISTINCT comments.user_id);
+----+------------------------------------+
| id | content                            |
+----+------------------------------------+
|  1 | John is a good boy.                |
|  2 | John plays tennis.                 |
|  3 | He is smart.                       |
|  4 | Sherlock lives in london.          |
|  5 | His address is 221B, Baker St.     |
|  6 | Watson is his assistant.           |
|  7 | This is another article.           |
|  8 | Hi, how are you?                   |
|  9 | I am good.                         |
| 10 | What's up?                         |
| 11 | Where do you live?                 |
| 12 | I stay in Delhi.                   |
| 13 | Delhi is in India.                 |
| 14 | Global warming.                    |
| 15 | Another Article on Global Warming. |
| 16 | Hello, This is an article.         |
| 17 | Article on X.                      |
| 18 | Article on Y.                      |
| 19 | Article on ABC.                    |
| 20 | Article on XYZ.                    |
| 21 | Hi, this is an article.            |
+----+------------------------------------+
21 rows in set (0.00 sec)

