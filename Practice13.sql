-- ===== SETUP =====
use Sqlmasterdb;
CREATE TABLE customers (
    id INTEGER PRIMARY KEY,
    name TEXT,
    city TEXT
);

CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product TEXT,
    amount REAL
);

INSERT INTO customers VALUES
(1, 'Aarav', 'Pune'),
(2, 'Isha', 'Mumbai'),
(3, 'Kabir', 'Nagpur'),
(4, 'Meera', 'Pune'),
(5, 'Rohan', 'Nashik');

INSERT INTO orders VALUES
(1, 1, 'Laptop', 55000),
(2, 1, 'Mouse', 500),
(3, 2, 'Keyboard', 1500),
(4, 3, 'Monitor', 12000),
(5, 4, 'Laptop', 60000),
(6, 2, 'Chair', 3000);


-- ===== 1. SUBQUERY =====
-- Customers who spent more than the average order amount
SELECT name FROM customers
WHERE id IN (
    SELECT customer_id FROM orders
    WHERE amount > (SELECT AVG(amount) FROM orders)
);


-- ===== 2. EXISTS =====
-- Customers who have at least one order above 50000
SELECT name FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.id AND o.amount > 50000
);


-- ===== 3. ANY (via IN, since SQLite has no ANY) =====
-- Customers who bought a Laptop
SELECT name FROM customers
WHERE id IN (SELECT customer_id FROM orders WHERE product = 'Laptop');


-- ===== 4. ALL (via MAX, since SQLite has no ALL) =====
-- Orders costlier than every Mouse order
SELECT product, amount FROM orders
WHERE amount > (SELECT MAX(amount) FROM orders WHERE product = 'Mouse');


-- ===== 5. UNION =====
-- Pune customers + Laptop buyers, duplicates removed
SELECT name FROM customers WHERE city = 'Pune'
UNION
SELECT name FROM customers WHERE id IN (SELECT customer_id FROM orders WHERE product = 'Laptop');


-- ===== 6. UNION ALL =====
-- Same as above but keeps duplicates
SELECT name FROM customers WHERE city = 'Pune'
UNION ALL
SELECT name FROM customers WHERE id IN (SELECT customer_id FROM orders WHERE product = 'Laptop');


-- ===== SETUP =====
USE Sqlmasterdb;

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(50)
);

CREATE TABLE marks (
    id INT PRIMARY KEY,
    student_id INT,
    subject VARCHAR(50),
    score INT,
    FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO students VALUES
(1, 'Sai', 'CSE'),
(2, 'Priya', 'IT'),
(3, 'Vikram', 'CSE'),
(4, 'Ananya', 'ECE'),
(5, 'Dev', 'IT');

INSERT INTO marks VALUES
(1, 1, 'DBMS', 85),
(2, 1, 'OS', 78),
(3, 2, 'DBMS', 92),
(4, 3, 'DBMS', 60),
(5, 4, 'OS', 55),
(6, 2, 'OS', 88);


-- ===== 1. SUBQUERY =====
-- Students who scored above the overall average score
SELECT name FROM students
WHERE id IN (
    SELECT student_id FROM marks
    WHERE score > (SELECT AVG(score) FROM marks)
);


-- ===== 2. EXISTS =====
-- Students who have at least one score above 90
SELECT name FROM students s
WHERE EXISTS (
    SELECT 1 FROM marks m
    WHERE m.student_id = s.id AND m.score > 90
);


-- ===== 3. ANY =====
-- Students who scored more than ANY CSE student's score
-- (i.e. beats at least one CSE student)
SELECT name, id FROM students
WHERE id IN (
    SELECT student_id FROM marks
    WHERE score > ANY (
        SELECT score FROM marks
        WHERE student_id IN (SELECT id FROM students WHERE branch = 'CSE')
    )
);


-- ===== 4. ALL =====
-- Students who scored more than ALL IT students
SELECT DISTINCT s.name FROM students s
JOIN marks m ON m.student_id = s.id
WHERE m.score > ALL (
    SELECT score FROM marks
    WHERE student_id IN (SELECT id FROM students WHERE branch = 'IT')
);


-- ===== 5. UNION =====
-- CSE students + anyone who scored above 85, no duplicates
SELECT name FROM students WHERE branch = 'CSE'
UNION
SELECT s.name FROM students s JOIN marks m ON m.student_id = s.id WHERE m.score > 85;


-- ===== 6. UNION ALL =====
SELECT name FROM students WHERE branch = 'CSE'
UNION ALL
SELECT s.name FROM students s JOIN marks m ON m.student_id = s.id WHERE m.score > 85;