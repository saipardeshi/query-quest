CREATE DATABASE sqlmasterdb;
USE sqlmasterdb;

CREATE TABLE Patients(
PatientsId INT PRIMARY KEY,
PatientsName VARCHAR(50),
Age INT,
Gender VARCHAR(10),
Phone VARCHAR(15),
Weight INT,
City VARCHAR(50)
);

CREATE TABLE Doctors(
DoctorId INT PRIMARY KEY,
DoctorName VARCHAR(100),
Specialization VARCHAR(100),
Experience INT,
Phone VARCHAR(50)
);

INSERT INTO Patients VALUES
(101,'Rahul Sharma', 25, 'Male','9876543210', 68, 'Pune'),
(102, 'Priya Patil', 30, 'Female', '9876543211', 55, 'Mumbai'),
(103, 'Amit Joshi', 42, 'Male','9876543212', 75, 'Nashik'),
(104, 'Sneha Kulkarni', 27, 'Female', '9876543213', 52, 'Nagpur'),
(105, 'Rohan Deshmukh', 35, 'Male', '9876543214', 80, 'Pune'),
(106,'Anjali More', 24, 'Female', '9876543215', 50, 'Satara'),
(107, 'Vikas Jadhav', 38, 'Male', '9876543216',72, 'Kolhapur'),
(108, 'Neha Shinde', 29, 'Female','9876543217', 58, 'Solapur'),
(109, 'Karan Pawar', 33, 'Male', '9876543218', 77, 'Aurangabad'),
(110, 'Poja Patil', 26, 'Female', '9876543219', 54, 'Sangli');

INSERT INTO Doctors VALUES
(201, 'Dr. Mehta', 'Cardiologist', 15, '9988776601'),
(202, 'Dr. Singh', 'Orthopedic', 10, '9988776602'),
(203, 'Dr. Shah', 'Neurologist', 18, '9988776603'),
(204, 'Dr. Patel', 'Dermatologist', 8, '9988776604'),
(205, 'Dr. Rao', 'General Physician', 12, '9988776605'),
(206, 'Dr. Kulkarni', 'Pediatrician', 9, '9988776606'),
(207, 'Dr. Joshi', 'ENT Specialist', 11, '9988776607'),
(208, 'Dr. Desai', 'Psychiatrist', 14, '9988776608'),
(209, 'Dr. Naik', 'Ophthalmologist', 13, '9988776609'),
(210, 'Dr. Patil', 'Gynecologist', 16, '9988776610');

SELECT * FROM Patients;
SELECT * FROM Doctors;
