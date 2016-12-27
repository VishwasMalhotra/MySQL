CREATE DATABASE exercise_one;

CREATE TABLE tastes (
    name VARCHAR(30),
    filling VARCHAR(30),
    PRIMARY KEY (name, filling)
	);

CREATE TABLE locations (
    lname VARCHAR(30),
    phone INT,
    address VARCHAR(50),
    PRIMARY KEY (lname)
	);

CREATE TABLE sandwiches (
    location VARCHAR(30),
    bread VARCHAR(20),
    filling VARCHAR(30),
    price INT,
    PRIMARY KEY	(location, bread, filling),
    FOREIGN KEY (location) REFERENCES locations(lname)
    );

INSERT INTO tastes
VALUES ('Brown', 'Turkey'),
('Brown', 'Beef'),
('Brown', 'Ham'),
('Jones', 'Cheese'),
('Green', 'Beef'),
('Green', 'Turkey'),
('Green', 'Cheese');

INSERT INTO locations
VALUES ('Lincoln', 684523, 'Lincoln Place'),
('O\'Neill\'s',6742134, 'Pearse St'),
('Old Nag',7678132, 'Dame St'),
('Buttery',7023421, 'College St');

INSERT INTO sandwiches
VALUES ('Lincoln', 'Rye', 'Ham', 1.25),
('O\'Neill\'s', 'White', 'Cheese', 1.20),
('O\'Neill\'s', 'Whole', 'Ham', 1.25),
('Old Nag', 'Rye', 'Beef', 1.35),
('Buttery', 'White', 'Cheese', 1.00),
('O\'Neill\'s', 'White', 'Turkey', 1.35),
('Buttery', 'White', 'Ham', 1.10),
('Lincoln', 'Rye', 'Beef', 1.35),
('Lincoln', 'White', 'Ham', 1.30),
 ('Old Nag', 'Rye', 'Ham', 1.40);

--(i) places where Jones can eat (using a nested subquery). 
SELECT location FROM sandwiches
WHERE filling IN
(SELECT filling FROM tastes WHERE name = "Jones");

--(ii) places where Jones can eat (without using a nested subquery). 
SELECT location FROM sandwiches JOIN tastes USING (filling)
WHERE name = "Jones";

--(ii) for each location the number of people who can eat there.
SELECT location, COUNT(DISTINCT name) AS 'Number of People'
FROM sandwiches JOIN tastes USING (filling)
GROUP BY location;