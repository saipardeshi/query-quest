-- ===== SETUP: NEW DATABASE =====
CREATE DATABASE IF NOT EXISTS GroupByPracticeDB;
USE GroupByPracticeDB;

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

CREATE TABLE sales (
    id INT PRIMARY KEY,
    emp_id INT,
    amount INT,
    month VARCHAR(10)
);

INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Marketing'),
(3, 'HR');

INSERT INTO employees VALUES
(1, 'Sai', 1, 60000),
(2, 'Priya', 1, 75000),
(3, 'Vikram', 2, 50000),
(4, 'Ananya', 2, 55000),
(5, 'Dev', 3, 40000),
(6, 'Kabir', 1, 65000);

INSERT INTO sales VALUES
(1, 1, 20000, 'Jan'),
(2, 1, 15000, 'Feb'),
(3, 2, 30000, 'Jan'),
(4, 3, 10000, 'Jan'),
(5, 3, 12000, 'Feb'),
(6, 4, 8000, 'Jan'),
(7, 6, 25000, 'Jan'),
(8, 6, 22000, 'Feb');


-- ===== 1. Basic GROUP BY =====
-- Total salary per department
SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.dept_id = d.id
GROUP BY d.dept_name;


-- ===== 2. COUNT with GROUP BY =====
-- Number of employees per department
SELECT d.dept_name, COUNT(e.id) AS emp_count
FROM employees e
JOIN departments d ON e.dept_id = d.id
GROUP BY d.dept_name;


-- ===== 3. AVG with GROUP BY =====
-- Average salary per department
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.id
GROUP BY d.dept_name;


-- ===== 4. HAVING (filter after grouping) =====
-- Departments where total salary exceeds 100000
SELECT d.dept_name, SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d ON e.dept_id = d.id
GROUP BY d.dept_name
HAVING SUM(e.salary) > 100000;


-- ===== 5. WHERE + GROUP BY + HAVING together =====
-- Among employees earning above 45000, departments with more than 1 employee
SELECT d.dept_name, COUNT(e.id) AS emp_count
FROM employees e
JOIN departments d ON e.dept_id = d.id
WHERE e.salary > 45000
GROUP BY d.dept_name
HAVING COUNT(e.id) > 1;


-- ===== 6. GROUP BY with multiple columns =====
-- Total sales per employee per month
SELECT emp_id, month, SUM(amount) AS monthly_sales
FROM sales
GROUP BY emp_id, month
ORDER BY emp_id, month;


-- ===== 7. GROUP BY across 3 tables =====
-- Total sales per department
SELECT d.dept_name, SUM(s.amount) AS dept_sales
FROM sales s
JOIN employees e ON s.emp_id = e.id
JOIN departments d ON e.dept_id = d.id
GROUP BY d.dept_name;


-- ===== 8. HAVING with a computed condition =====
-- Employees whose total sales across both months exceed 30000
SELECT e.name, SUM(s.amount) AS total_sales
FROM sales s
JOIN employees e ON s.emp_id = e.id
GROUP BY e.name
HAVING SUM(s.amount) > 30000;