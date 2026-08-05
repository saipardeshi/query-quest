-- one shot: db + table + data + practice queries

CREATE DATABASE IF NOT EXISTS LibraryDB2026;
USE LibraryDB2026;

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(50),
    Genre VARCHAR(30),
    Price DECIMAL(8,2),
    PublishedYear INT
);

INSERT INTO Books VALUES
(1,'The Silent Patient','Alex Michaelides','Thriller',399.00,2019),
(2,'Atomic Habits','James Clear','Self-Help',499.00,2018),
(3,'The Alchemist','Paulo Coelho','Fiction',299.00,1988),
(4,'Sapiens','Yuval Noah Harari','History',599.00,2011),
(5,'Ikigai','Hector Garcia','Self-Help',350.00,2016),
(6,'Rich Dad Poor Dad','Robert Kiyosaki','Finance',250.00,1997),
(7,'The Hobbit','J.R.R. Tolkien','Fantasy',450.00,1937);

-- 1. all books
SELECT * FROM Books;

-- 2. books published after 2010
SELECT * FROM Books WHERE PublishedYear > 2010;

-- 3. books under 400
SELECT * FROM Books WHERE Price < 400;

-- 4. sort by price descending
SELECT * FROM Books ORDER BY Price DESC;

-- 5. count books per genre
SELECT Genre, COUNT(*) AS TotalBooks FROM Books GROUP BY Genre;

-- 6. average price per genre
SELECT Genre, AVG(Price) AS AvgPrice FROM Books GROUP BY Genre;

-- 7. most expensive book
SELECT Title, Price FROM Books WHERE Price = (SELECT MAX(Price) FROM Books);

-- 8. update a book's price
UPDATE Books SET Price = 420.00 WHERE BookID = 1;

-- 9. delete a book
DELETE FROM Books WHERE BookID = 6;

-- 10. search by author name
SELECT * FROM Books WHERE Author LIKE '%Tolkien%';