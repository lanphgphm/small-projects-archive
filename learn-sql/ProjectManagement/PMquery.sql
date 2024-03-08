use ProjectManagement; 
go 

---------- BASIC QUERIES 
-- 1. Find employees working in a department with ID 4.
select * from employee 
where employee_id = 4; 

-- 2. Find employees with a salary above 30,000.
select * from employee 
where salary > 30000;

-- 3. Find employees with a salary above 25,000 in a department with ID 4 or employees with
-- a salary above 30,000 in a department with ID 5.
select * from employee 
where ((salary > 25000) and (department_id = 4)) or ((salary > 30000) and (department_id = 5)); 

-- 4. Provide the full names of employees in Ho Chi Minh City.
select lastname, middlename, firstname from employee 
where houseaddress like '%HCM%';

-- 5. Provide the full names of employees whose last names start with the leLer 'N.'
select lastname, middlename, firstname from employee 
where lastname like 'N%'; 

-- 6. Provide the birthdate and address of the employee Dinh Tien Toi.
select birthday, houseaddress from employee
where lastname=N'Đinh' and middlename=N'Tiến' and firstname=N'Tới';

-- 7. Provide employees born before the year 1975.
select * from employee 
where birthday < '1975-01-01'; 

-- 8. Provide employees born before April 30, 1975.
select * from employee 
where birthday < '1975-04-30'; 

-- 9. Provide employees born before April 30, 1975, or living in Ho Chi Minh City, or working in room number 4.
select * from employee 
where (birthday < '1975-04-30') or (houseaddress like '%Ho Chi Minh City"') or (department_id=4); 

---------- QUERIES USING JOIN 
-- 10. For each department, provide the department name and location.
select department_name, location_name from department 
inner join location_department on department.department_id = location_department.department_id;

-- 11. Find the names of department heads for each department.
select lastname, middlename, firstname from employee 
inner join department 
on employee.employee_id = department.department_head;

-- 12. Find PROJECTNAME, PROJECT_ID, PROJECTLOCATION, DEPARTMENT,
-- DEPARTMENT_NAME, DEPARTMENT_ID, DEPARTMENT_HEAD, APPOINTMENT_DATE.
select * from  project 
inner join department on department.department_id = project.department; 

-- 13. Find the names and addresses of all employees in the "Research" department.
select lastname, middlename, firstname, houseaddress from employee 
inner join department on employee.department_id = department.department_id 
where department_name = 'Research'; 

-- 14. Find the names of female employees and the names of their relatives.
select lastname, firstname, middlename, familymembername from employee e 
left join familymember f on e.EMPLOYEE_ID =f.EMPLOYEE_ID 
where e.GENDER = 'Female'; 

-- 15. For every project in "Ha Noi," list the project code (PROJECT_ID), the department code in
-- charge of the project (DEPARTMENT_ID), the name of the department head (LASTNAME,
-- MIDDLENAME, FIRSTNAME), as well as their address (HOUSEADDRESS) and date of birth (BIRTHDAY).
select p.project_id, d.DEPARTMENT_ID, 
concat(e.lastname, ' ', e.middlename, ' ', e.firstname) as fullname, 
e.houseaddress, e.birthday from project p
left join DEPARTMENT d on p.DEPARTMENT = d.DEPARTMENT_ID 
left join employee e on e.EMPLOYEE_ID = d.DEPARTMENT_HEAD 
where p.PROJECTLOCATION = N'Hà Nội'; 

-- 16. For each employee, provide the employee's name and the name of their direct supervisor.
select concat(employee.lastname, ' ', employee.middlename, ' ', employee.firstname) as emFullName,
concat(employee2.lastname, ' ', employee2.middlename, ' ', employee2.firstname) as directManaFullName
from employee
inner join employee as employee2 on employee.employee_id = employee2.linemanager_id;

-- 17. For each employee, provide the employee's name and the name of the department
-- head of the department where the employee works.
select concat(employee.lastname, ' ', employee.middlename, ' ', employee.firstname) as emFullName, 
department.department_name, 
(select concat(employee.lastname, ' ', employee.middlename, ' ', employee.firstname)
    from employee where employee.employee_id = department.department_head) as deptHeadName
from employee left join department on employee.department_id = department.department_id; 


-- 18. Find the names of employees in department 5 who are involved in the project "Product X"
-- and are directly managed by "Nguyen Thanh Tung."
select * from employee e 
left join assignment a on e.employee_id = a.employee_id 
left join project p on p.project_id = a.project_id
where p.projectname=N'Project X' 
and e.department_id=5
and e.linemanager_id = 
(select employee_id from employee 
 where lastname=N'Nguyễn' and middlename=N'Thanh' and firstname=N'Tùng')

-- 19. Provide the full name of the employee (LASTNAME, MIDDLENAME, FIRSTNAME) and the
-- names of the projects that the employee is involved in, if any.
select concat(lastname, ' ', MIDDLENAME, ' ', FIRSTNAME) as fullname,
p.PROJECTNAME from EMPLOYEE e 
left join [ASSIGNMENT] a on a.EMPLOYEE_ID = e.EMPLOYEE_ID 
left join PROJECT p on p.PROJECT_ID = a.PROJECT_ID ;

---------- GROUPING QUERIES 
-- 20. For each project, list the project name (PROJECTNAME) and the total number of hours
-- worked per week by all employees participating in that project.
select projectname, sum(duration) as totalHour from PROJECT p
left join [ASSIGNMENT] a on a.PROJECT_ID = p.PROJECT_ID 
group by p.PROJECTNAME ;

-- 21. For each employee, provide the employee's full name and the number of relatives they have.
select concat(e.lastname, ' ', e.middlename, ' ', e.firstname) as empfullname, 
(select count(*) from familymember where FAMILYMEMBER.EMPLOYEE_ID=e.employee_id) as numRelatives
from EMPLOYEE e;

-- 22. For each department, list the department name (DEPARTMENT_NAME) and the average
-- salary of employees working for that department.
select d.DEPARTMENT_NAME, avg(e.SALARY) as avgdeptSalary
from EMPLOYEE e 
left join DEPARTMENT d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
group by d.DEPARTMENT_NAME;

-- 23. The average salary of all female employees.
select avg(salary) as avgFemalePay from EMPLOYEE e 
where e.gender = 'Female';

-- 24. For departments with an average salary above 30,000, list the department name and the
-- number of employees in that department.
select * from 
(select department.department_name, avg(employee.salary) as avgDeptSalary, 
count(employee.EMPLOYEE_ID) as numEmployee
from DEPARTMENT 
right join EMPLOYEE  on employee.DEPARTMENT_ID = department.DEPARTMENT_ID
group by department.DEPARTMENT_NAME) as deptSalary
where avgDeptSalary > 30000;

-- 25. Provide the number of projects each employee is involved in.
select e.EMPLOYEE_ID, count(p.PROJECT_ID) as numActiveProject from EMPLOYEE e 
left join project p on p.DEPARTMENT = e.DEPARTMENT_ID
group by e.EMPLOYEE_ID ;


----------- NESTED QUERIES 
-- 26. Provide a list of project codes (PROJECT_ID) where either the workforce has the last
-- name (LASTNAME) 'Dinh' or the project is led by a department head with the last name
-- (LASTNAME) 'Dinh'.
-- going from innermost to outermost 
select PROJECT_ID from project 
where PROJECT_ID  in 
(select project_id from [assignment] where [assignment].EMPLOYEE_ID =
(select employee.EMPLOYEE_ID from employee where employee.lastname = N'Đinh'))
or project_id in
(select project_id from project 
left join department on project.DEPARTMENT = department.DEPARTMENT_ID
where department.DEPARTMENT_HEAD = 
(select employee.EMPLOYEE_ID from employee where employee.lastname = N'Đinh'));

-- 27. List the names of employees (LASTNAME, MIDDLENAME, FIRSTNAME) who have more
-- than 2 relatives.
--select EMPLOYEE_ID from familymember group by EMPLOYEE_ID having count(*) > 2;
--cai nay select * thi sai nhung select employee_id thi dung? 
select 
	concat(e.lastname, ' ', e.middlename, ' ', e.firstname) as empwithmorethan2rela
from EMPLOYEE e 
where EMPLOYEE_ID in (
	select EMPLOYEE_ID 
	from familymember 
	group by EMPLOYEE_ID 
	having count(*) > 2
);

-- 28. List the names of employees (LASTNAME, MIDDLENAME, FIRSTNAME) who have no
-- relatives. --> people with no relatives will not have entries in the 
-- family member table : D the more you know my guy 
select concat(e.lastname, ' ', e.middlename, ' ', e.firstname) as empwithnorela
from EMPLOYEE e 
where EMPLOYEE_ID not in 
(select EMPLOYEE_ID from FAMILYMEMBER);

-- 29. List the names of department heads (LASTNAME, MIDDLENAME, FIRSTNAME) who have
-- at least one relative.
select concat(lastname, ' ', middlename, ' ', firstname) as empwithatleast1rela 
from EMPLOYEE where EMPLOYEE_ID in 
(select employee_id from FAMILYMEMBER group by EMPLOYEE_ID having count(*) > 1);
--------------------------------------____________________---------------------
----------------------------what does this part do & why can't i do without it?

-- 30. Find the last names (HONV) of department heads who are not married.
select lastname 
from employee 
where employee_id in (
	select department_head 
	from department 
	where DEPARTMENT_HEAD not in (
		select employee_id 
		from familymember 
		where familymember.relationship='Spouse'
	)
);

-- 31. Provide the names of employees (LASTNAME, MIDDLENAME, FIRSTNAME) with a salary
-- above the average salary of the "Research" department.
select concat(e1.lastname, ' ', e1.middlename, ' ', e1.firstname) as fullname
from EMPLOYEE e1 
where e1.SALARY > (
	select avg(e.SALARY) as avgDeptSalary
	from employee e
	left join department d on e.DEPARTMENT_ID =d.DEPARTMENT_ID 
	group by DEPARTMENT_NAME 
	having DEPARTMENT_NAME = 'Research'
);

-- 32. Provide the department name and the names of department heads for the department
-- with the most employees.
-- nen join = id (primary key) chu ko nen join = name nhu nay 
-- am lucky that the names are unique too :) 
select top 1 
	concat(e2.lastname, ' ', e2.middlename, ' ', e2.firstname) as fullname, 
	department_name, 
	deptMemberNum
from EMPLOYEE e2 
inner join (
	select 
		d2.department_name, 
		deptMemberCount.deptMemberNum, 
		d2.DEPARTMENT_HEAD 
	from (
		select 
			d.DEPARTMENT_NAME, 
			count(*) as deptMemberNum 
		from DEPARTMENT d 
		right join EMPLOYEE e on d.DEPARTMENT_ID = e.DEPARTMENT_ID 
		group by d.DEPARTMENT_NAME) as deptMemberCount
		inner join DEPARTMENT d2 
		on d2.DEPARTMENT_NAME = deptMemberCount.department_name) as dpt
	on e2.EMPLOYEE_ID = dpt.department_head
order by deptMemberNum desc;

-- 33. Provide a list of project codes that employees with code 009 have not worked on.
-- 34. Provide a list of job Stles in the project Product X' that employees with code 009 have
-- not worked on.
-- 35. Find the full names (HONV, TENLOT, TENNV) and addresses (DCHI) of employees working
-- on a project in 'TP HCM' but whose department is not located in the city of 'TP HCM'.
-- 36. Generalizing quesSon 16, ﬁnd the full names and addresses of employees working on a
-- project in one city but whose department is not located in the same city.

----------- DIVISION QUERIES 
-- 37. List the employees (LASTNAME, MIDDLENAME, FIRSTNAME) working on all projects of
-- the company.
-- 38. List the employees (LASTNAME, MIDDLENAME, FIRSTNAME) assigned to all projects led
-- by department number 4.
-- 39. Find the employees (LASTNAME, MIDDLENAME, FIRSTNAME) assigned to all projects
-- that employee Dinh Ba Tien works on.
-- 40. Provide the employees assigned to all tasks in the project “Product X.”