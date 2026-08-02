-- ===== SETUP: NEW DATABASE =====
CREATE DATABASE IF NOT EXISTS CaseWhenPracticeDB;
USE CaseWhenPracticeDB;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary INT,
    bonus INT
);

INSERT INTO employees VALUES
(1, 'Sai', 'Engineering', 60000, 5000),
(2, 'Priya', 'Engineering', 75000, NULL),
(3, 'Kabir', 'Engineering', 65000, 3000),
(4, 'Vikram', 'Marketing', 50000, NULL),
(5, 'Ananya', 'Marketing', 55000, 2000),
(6, 'Dev', 'HR', 40000, NULL);


-- ===== 1. Basic CASE WHEN =====
-- Categorize employees into salary bands
SELECT name, salary,
  CASE
    WHEN salary >= 65000 THEN 'High'
    WHEN salary >= 50000 THEN 'Medium'
    ELSE 'Low'
  END AS salary_band
FROM employees;


-- ===== 2. COALESCE — replace NULL with a default value =====
-- Employees with no bonus show 0 instead of NULL
SELECT name, salary, COALESCE(bonus, 0) AS bonus,
       salary + COALESCE(bonus, 0) AS total_pay
FROM employees;


-- ===== 3. IFNULL (MySQL shortcut, same idea as COALESCE with 2 args) =====
SELECT name, IFNULL(bonus, 'No Bonus') AS bonus_status
FROM employees;


-- ===== 4. CASE WHEN inside aggregate — conditional counting =====
-- Count how many employees fall in each salary band, without GROUP BY on band
SELECT
  SUM(CASE WHEN salary >= 65000 THEN 1 ELSE 0 END) AS high_count,
  SUM(CASE WHEN salary >= 50000 AND salary < 65000 THEN 1 ELSE 0 END) AS medium_count,
  SUM(CASE WHEN salary < 50000 THEN 1 ELSE 0 END) AS low_count
FROM employees;


-- ===== 5. CASE WHEN combined with GROUP BY =====
-- Count high/medium/low earners per department
SELECT dept,
  SUM(CASE WHEN salary >= 65000 THEN 1 ELSE 0 END) AS high,
  SUM(CASE WHEN salary >= 50000 AND salary < 65000 THEN 1 ELSE 0 END) AS medium,
  SUM(CASE WHEN salary < 50000 THEN 1 ELSE 0 END) AS low
FROM employees
GROUP BY dept;


-- ===== 6. NULLIF — turn a specific value into NULL =====
-- Useful to avoid divide-by-zero errors
SELECT name, bonus, NULLIF(bonus, 0) AS bonus_or_null
FROM employees;