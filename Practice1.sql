CREATE DATABASE Practice;
SHOW DATABASES;
USE Practice;
DROP DATABASE practice;

CREATE DATABASE Practice;
USE Practice;
CREATE TABLE students(
id INT,
name VARCHAR(50)
);
SHOW TABLES;
INSERT INTO students (id,name) values(1,"sai");
SHOW TABLEs;
SELECT * FROM students;
INSERT INTO students(id, name) values(2,"amit");
INSERT INTO students (id, name) values (3,"om");
SELECT name FROM students;
SELECT id from students;
SELECT id,name FROM students;
SELECT * FROM students
WHERE ID=2;

SELECT * FROM students
WHERE name="sai" ;

SELECT * FROM students
WHERE ID<3;

SELECT * FROM students
WHERE ID=2 AND NAME="SAI";