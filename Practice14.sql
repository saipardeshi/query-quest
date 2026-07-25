CREATE DATABASE IF NOT EXISTS JoinsPracticeDB;
USE JoinsPracticeDB;

CREATE TABLE departments (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    salary INT
);


CREATE TABLE projects (
    id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR'),
(4, 'Finance'); 

INSERT INTO employees VALUES
(1, 'Sai', 1, 60000),
(2, 'Priya', 1, 75000),
(3, 'Vikram', 2, 50000),
(4, 'Ananya', 2, 55000),
(5, 'Dev', NULL, 40000); 

INSERT INTO projects VALUES
(1, 'Website Revamp', 1),
(2, 'Ad Campaign', 3),
(3, 'App Launch', 2),
(4, 'Budget Review', 999); 

SELECT e.name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;

SELECT e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id;

SELECT e.name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
UNION
SELECT e.name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.id;

SELECT e1.name AS employee1, e2.name AS employee2, e1.dept_id
FROM employees e1
JOIN employees e2 ON e1.dept_id = e2.dept_id AND e1.id < e2.id;

SELECT e.name, d.dept_name
FROM employees e
CROSS JOIN departments d;

SELECT e.name, d.dept_name, p.project_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id
LEFT JOIN projects p ON p.emp_id = e.id;


SELECT p.project_name, e.name
FROM projects p
LEFT JOIN employees e ON p.emp_id = e.id
WHERE e.id IS NULL;