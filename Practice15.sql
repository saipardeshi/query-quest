-- CREATE TABLES
CREATE TABLE Students6 (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    course_id INT
CREATE DATABASE IF NOT EXISTS Practice6DB;
USE Practice6DB;

CREATE TABLE Courses6 (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

-- INSERT VALUES
INSERT INTO Courses6 (course_id, course_name) VALUES
(1, 'Java'),
(2, 'Python'),
(3, 'SQL');

INSERT INTO Students6 (student_id, name, course_id) VALUES
(101, 'Harry', 1),
(102, 'Aman', 2),
(103, 'Riya', 1),
(104, 'Zoya', 3),
(105, 'Kunal', NULL);

-- SELECT with INNER JOIN
SELECT Students6.name, Courses6.course_name
FROM Students6
INNER JOIN Courses6 ON Students6.course_id = Courses6.course_id;

-- SELECT with LEFT JOIN (shows students even without a course)
SELECT Students6.name, Courses6.course_name
FROM Students6
LEFT JOIN Courses6 ON Students6.course_id = Courses6.course_id;

-- DELETE a specific row
DELETE FROM Students6 WHERE student_id = 105;

-- TRUNCATE (removes all rows, keeps table structure)
TRUNCATE TABLE Courses6;

-- DROP (removes table completely)
DROP TABLE Students6;