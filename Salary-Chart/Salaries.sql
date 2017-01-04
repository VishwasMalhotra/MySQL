mysql> CREATE TABLE departments(
    -> id INT AUTO_INCREMENT,
    -> `name` VARCHAR(30),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.12 sec)

mysql> CREATE TABLE employees(
    -> id INT AUTO_INCREMENT,
    -> `name` VARCHAR(30),
    -> salary INT,
    -> department_id INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(department_id) REFERENCES departments(id)
    -> );
Query OK, 0 rows affected (0.08 sec)

mysql> CREATE TABLE commissions(
    -> id INT AUTO_INCREMENT,
    -> employee_id INT,
    -> commission_amount INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(employee_id) REFERENCES employees(id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO departments (name)
    -> VALUES ('Banking'),
    -> ('Insurance'),
    -> ('Services');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO employees (name, salary, department_id)
    -> VALUES ('Chris Gayle', 1000000, 1),
    -> ('Michael Clarke', 800000, 2),
    -> ('Rahul Dravid', 700000, 1),
    -> ('Ricky Pointing', 600000, 2),
    -> ('Albie Morkel', 650000, 2),
    -> ('Wasim Akram', 750000, 3);
Query OK, 6 rows affected (0.00 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> INSERT INTO commissions (employee_id, commission_amount)
    -> VALUES (1, 5000),
    -> (2, 3000),
    -> (3, 4000),
    -> (1, 4000),
    -> (2, 3000),
    -> (4, 2000),
    -> (5, 1000),
    -> (6, 5000);
Query OK, 8 rows affected (0.00 sec)
Records: 8  Duplicates: 0  Warnings: 0

-- i. Find the employee who gets the highest total commission.
mysql> SELECT name, sum(commission_amount) AS Commission
    -> FROM commissions JOIN employees
    -> ON commissions.employee_id=employees.id
    -> GROUP BY employee_id
    -> HAVING sum(commission_amount)
    -> =
    -> (SELECT DISTINCT (sum(commission_amount)) AS commission_sum
    -> FROM commissions JOIN employees
    -> ON commissions.employee_id=employees.id
    -> GROUP BY employee_id ORDER BY commission_sum DESC LIMIT 1);
+-------------+------------+
| name        | Commission |
+-------------+------------+
| Chris Gayle |       9000 |
+-------------+------------+
1 row in set (0.00 sec)

--ii. Find employee with 4th Highest salary from employee table.
mysql>  SELECT name
    ->  FROM employees WHERE salary =
    -> (SELECT DISTINCT salary
    -> FROM employees
    -> ORDER BY salary DESC limit 3,1);
+--------------+
| name         |
+--------------+
| Rahul Dravid |
+--------------+
1 row in set (0.00 sec)

--iii. Find department that is giving highest commission.
mysql> SELECT department_id
    -> FROM commissions JOIN employees
    -> ON commissions.employee_id=employees.id
    -> GROUP BY employee_id
    -> HAVING sum(commission_amount)
    -> =
    -> (SELECT DISTINCT (sum(commission_amount)) AS commission_sum
    -> FROM commissions JOIN employees
    -> ON commissions.employee_id=employees.id
    -> GROUP BY employee_id ORDER BY commission_sum DESC LIMIT 1);
+---------------+
| department_id |
+---------------+
|             1 |
+---------------+
1 row in set (0.00 sec)

--iv. Find employees getting commission more than 3000

mysql> SELECT concat(employees.name,' ', sum(commission_amount)) AS 'High Commissions'
    -> FROM commissions JOIN employees JOIN departments
    -> ON commissions.employee_id=employees.id && employees.department_id = departments.id
    -> GROUP BY employee_id
    -> HAVING sum(commission_amount) > 3000;
+---------------------+
| High Commissions    |
+---------------------+
| Chris Gayle 9000    |
| Michael Clarke 6000 |
| Rahul Dravid 4000   |
| Wasim Akram 5000    |
+---------------------+
4 rows in set (0.00 sec)