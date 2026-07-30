USE GroupByPracticeDB;

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

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