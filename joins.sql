CREATE DATABASE practice2;
USE practice2;

CREATE TABLE departments (
  id INT PRIMARY KEY AUTO_INCREMENT,
  dept_name VARCHAR(50)
);

CREATE TABLE employees (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50),
  dept_id INT,
  salary INT,
  FOREIGN KEY (dept_id) REFERENCES departments(id)
);

INSERT INTO departments (dept_name) VALUES
('Engineering'), ('Sales'), ('HR');

INSERT INTO employees (name, dept_id, salary) VALUES
('Sai', 1, 60000),
('Amit', 2, 45000),
('Riya', 1, 65000),
('Neha', 3, 50000),
('Karan', NULL, 40000);

-- INNER JOIN: only matched rows
SELECT employees.name, departments.dept_name
FROM employees
INNER JOIN departments ON employees.dept_id = departments.id;

-- LEFT JOIN: all employees, even unmatched (Karan has no dept)
SELECT employees.name, departments.dept_name
FROM employees
LEFT JOIN departments ON employees.dept_id = departments.id;

-- Aggregate with JOIN: avg salary per department
SELECT departments.dept_name, AVG(employees.salary) AS avg_salary
FROM employees
INNER JOIN departments ON employees.dept_id = departments.id
GROUP BY departments.dept_name;