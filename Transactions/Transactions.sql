mysql> CREATE DATABASE bank;
Query OK, 1 row affected (0.02 sec)

mysql> use bank;
Database changed

mysql> CREATE TABLE users(
    -> id INT AUTO_INCREMENT,
    -> `name` VARCHAR(30),
    -> email VARCHAR(30),
    -> account_no INT,
    -> PRIMARY KEY(id, account_no)
    -> );
Query OK, 0 rows affected (0.11 sec)

mysql> CREATE TABLE accounts(
    -> id INT AUTO_INCREMENT,
    -> bank_account_no INT,
    -> balance INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(bank_account_no) REFERENCES users(account_no)
    -> );
Query OK, 0 rows affected (0.14 sec)

mysql> INSERT INTO users (name, email, account_no)
    -> VALUES('userA', 'userA@xyz.com', 97171),
    -> ('userB', 'userB@abc.com', 99535);
Query OK, 2 rows affected (0.04 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql> INSERT INTO accounts (bank_account_no, balance)
    -> VALUES(97171, 25000),
    -> (99535, 18000);
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

-- i) userA is depositing Rs.1000 his account.
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts
    -> SET balance = balance + 1000
    -> WHERE bank_account_no = 97171;
Query OK, 1 row affected (0.02 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

--ii) userA is withdrawing Rs.500
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts
    -> SET balance = balance - 500
    -> WHERE bank_account_no = 97171;
Query OK, 1 row affected (0.07 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)

-- iii) userA is transferring Rs.200 to userB's account
mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> UPDATE accounts
    -> SET balance =(case when bank_account_no = 97171 then balance - 200
    ->               when bank_account_no = 99535 then balance + 200
    ->               end)
    -> WHERE bank_account_no IN (97171,99535);
Query OK, 2 rows affected (0.02 sec)
Rows matched: 2  Changed: 2  Warnings: 0

mysql> COMMIT;
Query OK, 0 rows affected (0.00 sec)