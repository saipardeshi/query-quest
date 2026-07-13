CREATE DATABASE companydb;
USE companydb;

CREATE TABLE departments(
DeptID INT PRIMARY KEY,
DeptName VARCHAR(50)
);

CREATE TABLE Employees(
EmpID  INT PRIMARY KEY,
Name VARCHAR(50),
DeptID INT,
Salary DECIMAL(10,2),
HireDate DATE,
FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    Budget DECIMAL(10,2)
);

CREATE TABLE EmployeeProjects (
    EmpID INT,
    ProjectID INT,
    Role VARCHAR(50),
    FOREIGN KEY (EmpID) REFERENCES Employees(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

show databases;
INSERT INTO Departments VALUES
(1,'IT'),(2,'HR'),(3,'Sales');

INSERT INTO Employees VALUES
(101,'Amit',1,60000,'2022-01-10'),
(102,'Priya',1,65000,'2021-05-14'),
(103,'Rahul',2,45000,'2023-03-01'),
(104,'Sneha',3,50000,'2022-07-19'),
(105,'Karan',3,55000,'2020-11-23');

INSERT INTO Projects VALUES
(201,'Website Revamp',100000),
(202,'Payroll System',80000),
(203,'CRM Tool',120000);

INSERT INTO EmployeeProjects VALUES
(101,201,'Developer'),
(102,201,'Lead'),
(103,202,'Analyst'),
(104,203,'Sales Rep'),
(105,203,'Manager');

show databases;
use companydb;
SELECT e.Name, e.Salary, d.DeptName
FROM Employees e
INNER JOIN departments d ON e.DeptID = d.DeptID;

-- 1. INNER JOIN: employees with department name
SELECT e.Name, e.Salary, d.DeptName
FROM Employees e
INNER JOIN departments d ON e.DeptID = d.DeptID;

-- 2. LEFT JOIN: all employees, even if dept missing
SELECT e.Name, d.DeptName
FROM Employees e
LEFT JOIN departments d ON e.DeptID = d.DeptID;

-- 3. RIGHT JOIN: all departments, even if no employees
SELECT d.DeptName, e.Name
FROM Employees e
RIGHT JOIN departments d ON e.DeptID = d.DeptID;

-- 4. 3-table JOIN: employee + project + role
SELECT e.Name, p.ProjectName, ep.Role
FROM EmployeeProjects ep
JOIN Employees e ON ep.EmpID = e.EmpID
JOIN Projects p ON ep.ProjectID = p.ProjectID;
