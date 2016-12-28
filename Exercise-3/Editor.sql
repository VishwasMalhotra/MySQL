mysql> CREATE DATABASE editor_choice;
Query OK, 1 row affected (0.00 sec)

mysql> use editor_choice;
Database changed

-- 1. Manage(create, update, delete) categories, articles, comments, and users.

mysql> CREATE TABLE users (
    -> id INT AUTO_INCREMENT,
    -> user_name VARCHAR(30),
    -> user_type VARCHAR(10),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.10 sec)

mysql> CREATE TABLE categories (
    -> id INT AUTO_INCREMENT,
    -> category VARCHAR(30),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE articles (
    -> id INT AUTO_INCREMENT,
    -> content TEXT,
    -> user_id INT,
    -> categories_id INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(user_id) REFERENCES users(id),
    -> FOREIGN KEY(categories_id) REFERENCES categories(id)
    -> );
Query OK, 0 rows affected (0.15 sec)

mysql> CREATE TABLE comments (
    -> id INT AUTO_INCREMENT,
    -> user_comment TEXT,
    -> user_id INT,
    -> article_id INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(user_id) REFERENCES users(id),
    -> FOREIGN KEY(article_id) REFERENCES articles(id)
    -> );
Query OK, 0 rows affected (0.18 sec)

mysql> INSERT INTO users (user_name, user_type)
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

mysql> INSERT INTO categories (category)
    -> VALUES ('Music'),
    -> ('Sports'),
    -> ('Movies'),
    -> ('News');
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO articles (content, user_id, categories_id)
    -> VALUES ('Hello, This is an article.', 3, 1),
    -> ('Hello, This is an article.', 1, 2),
    -> ('Hello, This is an article.', 8, 3),
    -> ('Hello, This is an article.', 5, 4),
    -> ('Hello, This is an article.', 6, 4),
    -> ('Hello, This is an article.', 7, 3),
    -> ('Hello, This is an article.', 2, 2),
    -> ('Hello, This is an article.', 3, 1),
    -> ('Hello, This is an article.', 3, 2),
    -> ('Hello, This is an article.', 5, 3),
    -> ('Hello, This is an article.', 7, 4),
    -> ('Hello, This is an article.', 6, 1),
    -> ('Hello, This is an article.', 4, 2),
    -> ('Hello, This is an article.', 9, 2),
    -> ('Hello, This is an article.', 10, 3),
    -> ('Hello, This is an article.', 10, 4),
    -> ('Hello, This is an article.', 8, 3),
    -> ('Hello, This is an article.', 9, 4),
    -> ('Hello, This is an article.', 2, 1),
    -> ('Hello, This is an article.', 6, 4),
    -> ('Hello, This is an article.', 5, 1);
Query OK, 21 rows affected (0.00 sec)
Records: 21  Duplicates: 0  Warnings: 0

mysql> INSERT INTO comments(user_comment, user_id, article_id)
    -> VALUES ('Hi, This is comment.', 3, 2),
    -> ('Hi, This is comment.', 4, 1),
    -> ('Hi, This is comment.', 5, 8),
    -> ('Hi, This is comment.', 3, 20),
    -> ('Hi, This is comment.', 7, 1),
    -> ('Hi, This is comment.', 8, 3),
    -> ('Hi, This is comment.', 9, 3),
    -> ('Hi, This is comment.', 10, 6),
    -> ('Hi, This is comment.', 1, 10),
    -> ('Hi, This is comment.', 1, 15);
Query OK, 10 rows affected (0.00 sec)
Records: 10  Duplicates: 0  Warnings: 0

-- 2. Select all articles whose author's name is user3 (Do this exercise using variable also).
mysql> SELECT content, user_name, user_id
    -> FROM articles JOIN users
    -> ON articles.user_id = users.id
    -> WHERE user_name= 'user3';
+----------------------------+-----------+---------+
| content                    | user_name | user_id |
+----------------------------+-----------+---------+
| Hello, This is an article. | user3     |       3 |
| Hello, This is an article. | user3     |       3 |
| Hello, This is an article. | user3     |       3 |
+----------------------------+-----------+---------+
3 rows in set (0.00 sec)

--3. For all the articles being selected above, select all the articles and also the comments associated with those articles in a single query.
mysql> SELECT content, user_comment AS 'Comments by User'
    -> FROM articles LEFT JOIN comments
    -> ON articles.id = comments.article_id
    -> WHERE articles.user_id = 3;
+----------------------------+----------------------+
| content                    | Comments by User     |
+----------------------------+----------------------+
| Hello, This is an article. | Hi, This is comment. |
| Hello, This is an article. | Hi, This is comment. |
| Hello, This is an article. | Hi, This is comment. |
| Hello, This is an article. | NULL                 |
+----------------------------+----------------------+
4 rows in set (0.00 sec)


-- 3. Using subquery.
mysql> SELECT content, user_comment AS 'Comments by User'
    -> FROM articles LEFT JOIN comments
    -> ON articles.id = comments.article_id
    -> WHERE articles.user_id = (SELECT id FROM users WHERE user_name = 'user3');
+----------------------------+----------------------+
| content                    | Comments by User     |
+----------------------------+----------------------+
| Hello, This is an article. | Hi, This is comment. |
| Hello, This is an article. | Hi, This is comment. |
| Hello, This is an article. | Hi, This is comment. |
| Hello, This is an article. | NULL                 |
+----------------------------+----------------------+
4 rows in set (0.00 sec)

--4. Write a query to select all articles which do not have any comments.
mysql> SELECT content
    -> FROM articles LEFT JOIN comments
    -> ON articles.id = comments.article_id
    -> WHERE user_comment IS NULL;
+----------------------------+
| content                    |
+----------------------------+
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
| Hello, This is an article. |
+----------------------------+
13 rows in set (0.00 sec)

-- 5. Write a query to select article which has maximum comments.
mysql> SELECT articles.id, content FROM articles
    -> JOIN comments ON articles.id=comments.article_id GROUP BY articles.id HAVING COUNT(comments.id) =
    -> (
    -> SELECT MAX(comment_count) FROM (
    -> SELECT article_id, COUNT(article_id) as comment_count FROM comments GROUP BY article_id
    -> ) AS X
    -> );
+----+----------------------------+
| id | content                    |
+----+----------------------------+
|  1 | Hello, This is an article. |
|  3 | Hello, This is an article. |
+----+----------------------------+
2 rows in set (0.00 sec)

--6. Write a query to select article which does not have more than one comment by the same user.
mysql> SELECT articles.id, content
    -> FROM articles JOIN comments
    -> ON articles.id=comments.article_id
    -> GROUP BY articles.id
    -> HAVING COUNT(comments.user_id) = COUNT(DISTINCT comments.user_id);
+----+----------------------------+
| id | content                    |
+----+----------------------------+
|  1 | Hello, This is an article. |
|  2 | Hello, This is an article. |
|  3 | Hello, This is an article. |
|  6 | Hello, This is an article. |
|  8 | Hello, This is an article. |
| 10 | Hello, This is an article. |
| 15 | Hello, This is an article. |
| 20 | Hello, This is an article. |
+----+----------------------------+
8 rows in set (0.00 sec)