CREATE DATABASE IF NOT EXISTS Practice2;
USE Practice2;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Course VARCHAR(50),
    Marks DECIMAL(5,2),
    AdmissionDate DATE
);

INSERT INTO Students VALUES
(1, 'Amit Sharma', 'CS', 85.50, '2023-06-15'),
(2, 'Priya Singh', 'IT', 78.25, '2023-07-01'),
(3, 'Rahul Verma', 'ECE', 91.00, '2023-06-20');
-- 1. Select all students
SELECT * FROM Students;

-- 2. Students in 'CS' course
SELECT * FROM Students WHERE Course = 'CS';

-- 3. Students with marks > 80
SELECT * FROM Students WHERE Marks > 80;

-- 4. Order by marks descending
SELECT * FROM Students ORDER BY Marks DESC;

-- 5. Count students per course
SELECT Course, COUNT(*) AS TotalStudents FROM Students GROUP BY Course;

-- 6. Average marks per course
SELECT Course, AVG(Marks) AS AvgMarks FROM Students GROUP BY Course;

-- 7. Update a student's marks
UPDATE Students SET Marks = 88.00 WHERE StudentID = 1;

-- 8. Delete a student
DELETE FROM Students WHERE StudentID = 3;

-- 9. Add a new column
ALTER TABLE Students ADD Email VARCHAR(100);

-- 10. Students admitted after a date
SELECT * FROM Students WHERE AdmissionDate > '2023-06-30';