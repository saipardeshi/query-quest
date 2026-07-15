CREATE DATABASE practice;
USE practice;

CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  branch VARCHAR(50),
  marks INT
);

INSERT INTO students (name, branch, marks) VALUES
('Sai', 'Computer', 85),
('Amit', 'Mechanical', 70),
('Riya', 'Computer', 92);

SELECT * FROM students;

