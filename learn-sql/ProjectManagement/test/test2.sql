--- Student: Pham Lan Phuong 
--- Student ID: 210120 
--- Test 4

use ProjectManagement; 

--- Q1
select 
	a.EMPLOYEE_ID, 
	count(a.PROJECT_ID) as numberOfProjects
from [ASSIGNMENT] a 
group by a.EMPLOYEE_ID; 


--- Q2
select avg(e.SALARY) as avgToiSalary
from EMPLOYEE e 
where e.EMPLOYEE_ID in (
	select e2.EMPLOYEE_ID 
	from EMPLOYEE e2 
	where e2.FIRSTNAME = N'Tới'
)
group by e.EMPLOYEE_ID; 


--- Q3 
select distinct f.EMPLOYEE_ID 
from FAMILYMEMBER f;

--- Q4 
select d.DEPARTMENT_HEAD 
from DEPARTMENT d 
inner join EMPLOYEE e on e.EMPLOYEE_ID = d.DEPARTMENT_HEAD 
where e.SALARY > (
	select avg(e.SALARY)
	from DEPARTMENT d 
	inner join EMPLOYEE e on e.DEPARTMENT_ID = d.DEPARTMENT_ID 
	where d.DEPARTMENT_NAME = 'Research'
);

--- Q5 
select distinct 
	concat(e.LASTNAME, ' ', e.MIDDLENAME, ' ', e.FIRSTNAME) as fullname, 
	e.HOUSEADDRESS 
from EMPLOYEE e 
inner join [ASSIGNMENT] a on e.EMPLOYEE_ID = a.EMPLOYEE_ID
inner join PROJECT p on p.PROJECT_ID = a.PROJECT_ID 
inner join LOCATION_DEPARTMENT ld  on ld.DEPARTMENT_ID = e.DEPARTMENT_ID 
where p.PROJECTLOCATION like '%HCM%' and ld.LOCATION_NAME not like '%HCM%';

--- Q6 
select 
	count(*) as numberOfMaleEmpHCM
from EMPLOYEE e 
where (e.GENDER='Male') and (e.HOUSEADDRESS like '%HCM');

