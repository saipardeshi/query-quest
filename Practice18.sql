-- ===== SETUP: NEW DATABASE =====
CREATE DATABASE IF NOT EXISTS WindowFnPracticeDB;
USE WindowFnPracticeDB;

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Sai', 'Engineering', 60000),
(2, 'Priya', 'Engineering', 75000),
(3, 'Kabir', 'Engineering', 65000),
(4, 'Vikram', 'Marketing', 50000),
(5, 'Ananya', 'Marketing', 55000),
(6, 'Dev', 'HR', 40000);


-- ===== 1. RANK() =====
-- Rank employees by salary within each department (ties get same rank, gaps after)
SELECT name, dept, salary,
       RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS rank_in_dept
FROM employees;


-- ===== 2. DENSE_RANK() =====
-- Same as RANK, but no gaps after ties
SELECT name, dept, salary,
       DENSE_RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS dense_rank_in_dept
FROM employees;


-- ===== 3. ROW_NUMBER() =====
-- Unique sequential number per row, even if salaries tie
SELECT name, dept, salary,
       ROW_NUMBER() OVER (PARTITION BY dept ORDER BY salary DESC) AS row_num
FROM employees;


-- ===== 4. Find top earner per department =====
-- Wrap window function in a subquery, filter rank = 1
SELECT name, dept, salary FROM (
    SELECT name, dept, salary,
           RANK() OVER (PARTITION BY dept ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 1;


-- ===== 5. Running total (cumulative salary) =====
SELECT name, dept, salary,
       SUM(salary) OVER (ORDER BY id) AS running_total
FROM employees;


-- ===== 6. Compare each employee's salary to department average =====
SELECT name, dept, salary,
       AVG(salary) OVER (PARTITION BY dept) AS dept_avg,
       salary - AVG(salary) OVER (PARTITION BY dept) AS diff_from_avg
FROM employees;