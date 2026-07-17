Create database LargeDataSet;
use LargeDataSet;

Create table Teachers1(
Teacher1Name Varchar(50),
Teacher1Id int Primary key,
Email varchar(50),
Phone varchar(50) ,
Salary int
);

insert into Teachers1 values
('santosh',101,'S@gmail.com','9988998899',300000);

insert into Teachers1 values
('Priya', 102, 'priya@gmail.com', '9876543210', 45000),
('Rahul', 103, 'rahul@gmail.com', '9123456789', 50000),
('Sneha', 104, 'sneha@gmail.com', '9012345678', 55000),
('Amit', 105, 'amit@gmail.com', '9988776655', 60000),
('Neha', 106, 'neha@gmail.com', '8899776655', 48000),
('Vikas', 107, 'vikas@gmail.com', '7788996655', 52000),
('Pooja', 108, 'pooja@gmail.com', '9871234567', 47000),
('Rohit', 109, 'rohit@gmail.com', '9765432109', 65000),
('Anjali', 110, 'anjali@gmail.com', '9654321098', 58000),
('Karan', 111, 'karan@gmail.com', '9543210987', 62000),
('Meena', 112, 'meena@gmail.com', '9432109876', 43000),
('Suresh', 113, 'suresh@gmail.com', '9321098765', 70000),
('Kavita', 114, 'kavita@gmail.com', '9210987654', 54000),
('Nikhil', 115, 'nikhil@gmail.com', '9109876543', 56000),
('Riya', 116, 'riya@gmail.com', '9098765432', 49000),
('Akash', 117, 'akash@gmail.com', '8987654321', 61000),
('Komal', 118, 'komal@gmail.com', '8876543210', 53000),
('Deepak', 119, 'deepak@gmail.com', '8765432109', 68000),
('Shweta', 120, 'shweta@gmail.com', '8654321098', 51000);


Select * from Teachers1;

Select Teacher1Name ,Salary from Teachers1;
Select * from Teachers1 where Salary >50000;

Select * from Teachers1 where salary <50000;

Select * from Teachers1 where salary between 45000 and 60000;

Select * from Teachers1 where Teacher1Name like 'S%';

Select * from Teachers1 where Teacher1Name like '%a';

Select * from Teachers1 order by Teacher1Name desc;

Select  MAX(Salary) from Teachers1;

Select  Min(Salary) from Teachers1;

Select avg(salary) from Teachers1;

Select * from Teachers1 order by Teacher1Name asc;

show databases;
use largedataset;
