-- practice6
-- views + update/delete with join

use companydb;

-- view 1 : emp with dept name
drop view if exists EmpDeptView;
create view EmpDeptView as
select e.EmpID, e.Name, e.Salary, d.DeptName
from Employees e
join departments d on e.DeptID = d.DeptID;

select * from EmpDeptView;
select * from EmpDeptView where DeptName = 'IT';

-- view 2 : project team
drop view if exists ProjectTeamView;
create view ProjectTeamView as
select p.ProjectName, e.Name as EmployeeName, ep.Role
from EmployeeProjects ep
join Employees e on ep.EmpID = e.EmpID
join Projects p on ep.ProjectID = p.ProjectID;

select * from ProjectTeamView;

-- give 10% raise to IT dept
update Employees e
join departments d on e.DeptID = d.DeptID
set e.Salary = e.Salary * 1.10
where d.DeptName = 'IT';

select Name, Salary from Employees where DeptID = 1;

-- remove sales employees earning below 52000
-- delete project record first (fk constraint)
delete ep
from EmployeeProjects ep
join Employees e on ep.EmpID = e.EmpID
join departments d on e.DeptID = d.DeptID
where d.DeptName = 'Sales' and e.Salary < 52000;

delete e
from Employees e
join departments d on e.DeptID = d.DeptID
where d.DeptName = 'Sales' and e.Salary < 52000;

select * from Employees;
select * from EmployeeProjects;

-- cleanup
drop view if exists ProjectTeamView;