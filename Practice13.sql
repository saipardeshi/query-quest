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