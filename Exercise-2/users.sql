mysql> CREATE DATABASE vtapp;
Query OK, 1 row affected (0.03 sec)

mysql> CREATE USER 'vtapp_user' IDENTIFIED BY 'password123';
Query OK, 0 rows affected (0.12 sec)

mysql> GRANT ALL PRIVILEGES ON vtapp.* TO 'vtapp_user';
Query OK, 0 rows affected (0.08 sec)