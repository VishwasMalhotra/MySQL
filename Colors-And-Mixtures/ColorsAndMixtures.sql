mysql> CREATE DATABASE colors_and_mixtures;
Query OK, 1 row affected (0.01 sec)

mysql> use colors_and_mixtures;
Database changed
mysql> CREATE TABLE colors (
    -> id INT,
    -> `name` VARCHAR(30),
    -> density DECIMAL(2,2),
    -> PRIMARY KEY(id)
    -> );
Query OK, 0 rows affected (0.12 sec)

mysql> CREATE TABLE mixtures(
    -> id INT AUTO_INCREMENT,
    -> parent1_id INT,
    -> parent2_id INT,
    -> mix_id INT,
    -> mix_density DECIMAL(2,2),
    -> parent1_perc INT,
    -> parent2_perc INT,
    -> PRIMARY KEY(id),
    -> FOREIGN KEY(parent1_id) REFERENCES colors(id),
    -> FOREIGN KEY(parent2_id) REFERENCES colors(id),
    -> FOREIGN KEY(mix_id) REFERENCES colors(id)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO colors(id, `name`, density)
    -> VALUES (10, 'Red', 0.20),
    -> (11, 'Green', 0.30),
    -> (12, 'Blue', 0.40),
    -> (13, 'Yellow', 0.20),
    -> (14, 'Pink', 0.30),
    -> (15, 'Cyan', 0.40),
    -> (16, 'White', 0.28);
Query OK, 7 rows affected (0.03 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> INSERT INTO mixtures(parent1_id, parent2_id, mix_id, mix_density, parent1_perc, parent2_perc)
    -> VALUES(10,11,13,0.6,30,70),
    -> (10,12,14,0.5,50,50),
    -> (11,12,15,0.75,40,60),
    -> (10,13,16,0.28,80,20);
Query OK, 4 rows affected (0.00 sec)
Records: 4  Duplicates: 0  Warnings: 0

-- 1. Find the colors that can be clubbed with 'Red' and also name the resulting color.
mysql> SELECT first_table.name as "Combine With",
    -> second_Table.name as "Resulting Color"
    -> FROM mixtures JOIN colors first_table
    -> ON first_table.id=mixtures.parent2_id
    -> JOIN colors second_Table on second_Table.id=mixtures.mix_id
    -> WHERE mixtures.parent1_id
    -> =
    -> (SELECT id FROM colors WHERE name='Red');
+--------------+-----------------+
| Combine With | Resulting Color |
+--------------+-----------------+
| Green        | Yellow          |
| Blue         | Pink            |
| Yellow       | White           |
+--------------+-----------------+
3 rows in set (0.00 sec)

-- 2. Find mixtures that can be formed without 'Red'.
mysql> SELECT name FROM colors
    -> WHERE colors.id
    -> =
    -> (SELECT mix_id FROM mixtures
    -> WHERE (SELECT colors.id FROM colors WHERE colors.name = 'Red')
    -> NOT IN (parent1_id, parent1_id));
+------+
| name |
+------+
| Cyan |
+------+
1 row in set (0.00 sec)

-- 3. Find the mixtures that have one common parent.
-- Best Possible Output.
mysql> SELECT name AS "parent name",GROUP_CONCAT(mix_id SEPARATOR ' & ') AS "possible mixture"
    -> FROM mixtures
    -> JOIN colors
    -> ON mixtures.parent1_id=colors.id
    -> GROUP BY parent1_id
    -> UNION
    -> SELECT name AS "parent name",GROUP_CONCAT(mix_id SEPARATOR ' & ') AS "possible mixture"
    -> FROM mixtures
    -> JOIN colors
    -> ON mixtures.parent2_id=colors.id
    -> GROUP BY parent2_id;
+-------------+------------------+
| parent name | possible mixture |
+-------------+------------------+
| Red         | 13 & 14 & 16     |
| Green       | 15               |
| Green       | 13               |
| Blue        | 14 & 15          |
| Yellow      | 16               |
+-------------+------------------+
5 rows in set (0.00 sec)

-- 4. Find parent colors(as a couple) that give mix colors with density higher than the color density originally.
mysql> SELECT concat(parent1_id, ' & ', parent2_id) AS 'Parent Colors', mix_id, mix_density, density
    -> FROM mixtures JOIN colors
    -> ON mixtures.mix_id=colors.id
    -> WHERE mixtures.mix_density > colors.density;
+---------------+--------+-------------+---------+
| Parent Colors | mix_id | mix_density | density |
+---------------+--------+-------------+---------+
| 10 & 11       |     13 |        0.60 |    0.20 |
| 10 & 12       |     14 |        0.50 |    0.30 |
| 11 & 12       |     15 |        0.75 |    0.40 |
+---------------+--------+-------------+---------+
3 rows in set (0.00 sec)


-- 5. Calculate the total amount of color 'Red'(in kgs) needed to make a 1kg mix each for its possible mixtures(yellow,pink..).
mysql> SELECT SUM(mix_density) AS 'Amount' FROM mixtures WHERE parent1_id = 10;
+--------+
| Amount |
+--------+
|   1.38 |
+--------+
1 row in set (0.00 sec)