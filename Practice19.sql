-- ===== SETUP: NEW DATABASE =====
CREATE DATABASE IF NOT EXISTS CtePracticeDB;
USE CtePracticeDB;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary INT,
    manager_id INT
);

INSERT INTO employees VALUES
(1, 'Sai', 'Engineering', 60000, NULL),
(2, 'Priya', 'Engineering', 75000, 1),
(3, 'Kabir', 'Engineering', 65000, 1),
(4, 'Vikram', 'Marketing', 50000, NULL),
(5, 'Ananya', 'Marketing', 55000, 4),
(6, 'Dev', 'HR', 40000, NULL);


-- ===== 1. Basic CTE =====
-- Employees earning above their department's average salary
WITH dept_avg AS (
    SELECT dept, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY dept
)
SELECT e.name, e.dept, e.salary, d.avg_salary
FROM employees e
JOIN dept_avg d ON e.dept = d.dept
WHERE e.salary > d.avg_salary;


-- ===== 2. Multiple CTEs in one query =====
-- Highest paid employee per department, using two CTEs chained together
WITH ranked AS (
    SELECT name, dept, salary,
           RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS rnk
    FROM employees
),
top_earners AS (
    SELECT name, dept, salary FROM ranked WHERE rnk = 1
)
SELECT * FROM top_earners;


-- ===== 3. CTE replacing a nested subquery =====
-- Same logic as "subquery in FROM" but cleaner to read
WITH dept_totals AS (
    SELECT dept, SUM(salary) AS total_salary, COUNT(*) AS emp_count
    FROM employees
    GROUP BY dept
)
SELECT dept, total_salary, emp_count
FROM dept_totals
WHERE total_salary > 100000;


-- ===== 4. Recursive CTE =====
-- Build a manager -> employee hierarchy chain
WITH RECURSIVE org_chart AS (
    -- anchor: top-level managers (no manager themselves)
    SELECT id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    -- recursive: employees reporting to someone already in org_chart
    SELECT e.id, e.name, e.manager_id, oc.level + 1
    FROM employees e
    JOIN org_chart oc ON e.manager_id = oc.id
)
SELECT * FROM org_chart ORDER BY level, name;