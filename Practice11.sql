CREATE DATABASE BankingDB;
USE BankingDB;

CREATE TABLE Branches
(
BranchID INT PRIMARY KEY,
BranchName VARCHAR(50),
City VARCHAR(50)
);

INSERT INTO Branches VALUES
(1,'Pune Main','Pune'),
(2,'Mumbai Central','Mumbai'),
(3,'Nashik Branch','Nashik'),
(4,'Nagpur Branch','Nagpur'),
(5,'Delhi Branch','Delhi');

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50),
    BranchID INT,
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);

INSERT INTO Customers VALUES
(101,'Rahul Sharma',25,'Male','Pune',1),
(102,'Priya Patil',30,'Female','Mumbai',2),
(103,'Amit Joshi',42,'Male','Nashik',3),
(104,'Sneha Kulkarni',27,'Female','Nagpur',4),
(105,'Rohan Deshmukh',35,'Male','Pune',1),
(106,'Anjali More',24,'Female','Pune',1),
(107,'Vikas Jadhav',38,'Male','Delhi',5),
(108,'Neha Shinde',29,'Female','Mumbai',2),
(109,'Karan Pawar',33,'Male','Pune',1),
(110,'Pooja Patil',26,'Female','Nagpur',4);


CREATE TABLE Accounts
(
    AccountID INT PRIMARY KEY,
    CustomerID INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(12,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Accounts VALUES
(1001,101,'Savings',75000),
(1002,102,'Current',120000),
(1003,103,'Savings',45000),
(1004,104,'Savings',90000),
(1005,105,'Current',150000),
(1006,106,'Savings',35000),
(1007,107,'Current',180000),
(1008,108,'Savings',80000),
(1009,109,'Savings',60000),
(1010,110,'Current',95000);


CREATE TABLE Transactions
(
    TransactionID INT PRIMARY KEY,
    AccountID INT,
    TransactionType VARCHAR(20),
    Amount DECIMAL(10,2),
    TransactionDate DATE,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

INSERT INTO Transactions VALUES
(1,1001,'Deposit',10000,'2026-01-05'),
(2,1001,'Withdraw',5000,'2026-01-08'),
(3,1002,'Deposit',20000,'2026-01-10'),
(4,1003,'Deposit',15000,'2026-01-12'),
(5,1004,'Withdraw',7000,'2026-01-15'),
(6,1005,'Deposit',30000,'2026-01-18'),
(7,1006,'Deposit',5000,'2026-01-20'),
(8,1007,'Withdraw',10000,'2026-01-22'),
(9,1008,'Deposit',12000,'2026-01-24'),
(10,1009,'Deposit',8000,'2026-01-25'),
(11,1010,'Withdraw',6000,'2026-01-28'),
(12,1005,'Withdraw',12000,'2026-02-01'),
(13,1001,'Deposit',7000,'2026-02-03'),
(14,1002,'Withdraw',15000,'2026-02-05'),
(15,1007,'Deposit',25000,'2026-02-08');

SELECT BranchID, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY BranchID
HAVING COUNT(*) > 1;

SELECT AccountType, AVG(Balance) AS AverageBalance
FROM Accounts
GROUP BY AccountType
HAVING AVG(Balance) > 80000;

SELECT BranchID, AVG(Age) AS AverageAge
FROM Customers
GROUP BY BranchID
HAVING AVG(Age) > 30;

SELECT AccountType, SUM(Balance) AS TotalBalance
FROM Accounts
GROUP BY AccountType
HAVING SUM(Balance) > 250000;

SELECT BranchID, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY BranchID
HAVING COUNT(*) = 1;