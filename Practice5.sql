-- practice5.sql
USE companydb;

-- 1. Employees earning above average salary
SELECT Name, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);

-- 2. Departments having more than 1 employee
SELECT DeptID, COUNT(*) AS EmpCount
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 1;

-- 3. Employee(s) with the lowest salary
SELECT Name, Salary
FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees);

-- 4. List employees NOT assigned to any project
SELECT e.Name
FROM Employees e
WHERE e.EmpID NOT IN (SELECT EmpID FROM EmployeeProjects);

-- 5. Project with the highest budget
SELECT ProjectName, Budget
FROM Projects
WHERE Budget = (SELECT MAX(Budget) FROM Projects);

-- 6. Employees hired before 2022
SELECT Name, HireDate
FROM Employees
WHERE HireDate < '2022-01-01';

-- 7. Rank employees by salary within department (window function)
SELECT Name, DeptID, Salary,
       RANK() OVER (PARTITION BY DeptID ORDER BY Salary DESC) AS SalaryRank
FROM Employees;

SELECT Name, Salary
FROM Employees
ORDER BY Salary DESC;

SELECT *
FROM Employees
LIMIT 3;

SELECT COUNT(*)
FROM Employees;

SELECT Name
FROM Employees
WHERE DeptID IN (1, 2);

SELECT MAX(Salary)
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

select * from employees;

SELECT Name,
       Salary,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNo
FROM Employees;