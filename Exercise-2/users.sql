CREATE DATABASE vtapp;
CREATE USER 'vtapp_user'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON *.* TO 'vtapp_user'@'localhost'
WITH GRANT OPTION;