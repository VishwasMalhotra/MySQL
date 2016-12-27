$ mysqldump -u root -p example > example_DB_Dump.sql;

CREATE DATABASE restored;
$ mysql -u root -p restored < example_DB_Dump.sql