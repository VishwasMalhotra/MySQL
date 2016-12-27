CREATE DATABASE exercise_one;

CREATE TABLE branch(
  bcode VARCHAR(5),
  librarian VARCHAR(30),
  address VARCHAR(50),
  PRIMARY KEY(bcode)
);

CREATE TABLE titles(
  title VARCHAR(50),
  author VARCHAR(30),
  publisher VARCHAR(30),
  PRIMARY KEY(title)
);

CREATE TABLE holdings(
  branch VARCHAR(5),
  title VARCHAR(50),
  `#copies` INT,
  PRIMARY KEY(branch, title),
  FOREIGN KEY(branch) REFERENCES branch(bcode),
  FOREIGN KEY(title) REFERENCES titles(title)
);

INSERT INTO branch
VALUES ('B1', 'John Smith', '24 Anglesea Rd'),
('B2', 'Mary Jones', '34 Pearse St'),
('B3', 'Francis Owens', 'Grange X');

INSERT INTO titles 
VALUES ('Susannah', 'Ann Brown', 'Macmillan'),
('How to Fish', 'Amy Fly', 'Stop Press'),
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('The Wife', 'Ann Brown', 'Macmillan');

INSERT INTO holdings 
VALUES ('B1', 'Susannah', 3),
('B1', 'How to Fish', 2),
('B1', 'A History of Dublin', 1),
('B2', 'How to Fish', 4),
('B2', 'Computers', 2),
('B2', 'The Wife', 3),
('B3', 'A History of Dublin', 1),
('B3', 'Computers', 4),
('B3', 'Susannah', 3),
('B3', 'The Wife', 1);

--(i) the names of all library books published by Macmillan. 
SELECT title FROM titles
WHERE publisher = 'Macmillan';

-- (ii) branches that hold any books by Ann Brown (using a nested subquery). 
SELECT DISTINCT branch FROM holdings
WHERE title IN
(SELECT title FROM titles WHERE author='Ann Brown');

-- (iii) branches that hold any books by Ann Brown (without using a nested subquery). 
SELECT DISTINCT branch FROM 
holdings JOIN titles USING(title)
WHERE author = 'Ann Brown';

--(iv) the total number of books held at each branch. 
SELECT branch,
SUM(`#copies`) AS 'Number of Books'
FROM holdings
GROUP BY branch;