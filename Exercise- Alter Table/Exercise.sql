--Create a table named "testing_table" with following fields:
CREATE TABLE testing_table (name VARCHAR(30) , contact_name VARCHAR(30) , roll_no CHARACTER(20));

--Delete column name
ALTER TABLE testing_table
DROP COLUMN name;

--rename contact_name to username
ALTER TABLE testing_table CHANGE contact_name username VARCHAR(30);

--Add two fields first_name, last_name
ALTER TABLE testing_table
ADD first_name VARCHAR(30),
ADD last_name VARCHAR(30);

--Also change the type of roll_no to integer
ALTER TABLE testing_table MODIFY roll_no int(5);