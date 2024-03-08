GO
USE master;
ALTER DATABASE ProjectManagement SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE ProjectManagement;
GO

use master;
GO
create database ProjectManagement
GO
use ProjectManagement
go
-----------------------------------------------------------
-- Step 1 1 : INSERT TABLE AND PRIMARY KEYS
-----------------------------------------------------------
create table DEPARTMENT 
(
	DEPARTMENT_NAME 	nvarchar(30),
	DEPARTMENT_ID 	int NOT NULL,
	DEPARTMENT_HEAD 	char(9),
	APPOINTMENT_DATE 	datetime,
	primary key (DEPARTMENT_ID)
)

create table EMPLOYEE 
(
	LASTNAME 	nvarchar(30),
	MIDDLENAME 	nvarchar(30),
	FIRSTNAME 	nvarchar(30),
	EMPLOYEE_ID 	char(9) NOT NULL,
	BIRTHDAY 	datetime,
	HOUSEADDRESS 	nvarchar(50),
	GENDER 	nchar(6),
	SALARY 	float,
	LINEMANAGER_ID 	char(9),
	DEPARTMENT_ID 	int,
	primary key (EMPLOYEE_ID)	
)

create table LOCATION_DEPARTMENT
(
	DEPARTMENT_ID 	int NOT NULL,
	LOCATION_NAME nvarchar(30) NOT NULL,
	primary key (DEPARTMENT_ID, LOCATION_NAME)
)
create table TASKS
(
	PROJECT_ID	int NOT NULL,
	TASK_NUMBER	int NOT NULL,
	TASK_NAME nvarchar(50),
	primary key (PROJECT_ID, TASK_NUMBER)
)

create table ASSIGNMENT 
(
	EMPLOYEE_ID	char(9) NOT NULL,
	PROJECT_ID 	int NOT NULL,
	TASK_NUMBER		int NOT NULL, 
	DURATION	decimal(5,1),
	primary key (EMPLOYEE_ID, PROJECT_ID, TASK_NUMBER)
)

create table FAMILYMEMBER 
(
	EMPLOYEE_ID char(9) NOT NULL,
	FAMILYMEMBERNAME 	nvarchar(30) NOT NULL,
	GENDER 	nchar(6),
	BIRTHDAY 	datetime,
	RELATIONSHIP 	nvarchar(16),
	primary key (EMPLOYEE_ID, FAMILYMEMBERNAME)
)

create table PROJECT 
(
	PROJECTNAME nvarchar(30),
	PROJECT_ID int NOT NULL,
	PROJECTLOCATION nvarchar(30),
	DEPARTMENT int,
	primary key (PROJECT_ID)
)

-----------------------------------------------------------
-- Step 2 : CREATE FOREIGNKEYS 
-----------------------------------------------------------
GO

alter table EMPLOYEE add constraint FK_EMPLOYEE_EMPLOYEE foreign key (LINEMANAGER_ID) references  EMPLOYEE(EMPLOYEE_ID)


alter table EMPLOYEE add constraint FK_EMPLOYEE_DEPARTMENT foreign key (DEPARTMENT_ID) references  DEPARTMENT(DEPARTMENT_ID)
-----------------------------------------------------------
alter table DEPARTMENT add constraint FK_DEPARTMENT_EMPLOYEE foreign key (DEPARTMENT_HEAD) references  EMPLOYEE(EMPLOYEE_ID)
-----------------------------------------------------------
alter table LOCATION_DEPARTMENT add constraint FK_LOCATION_DEPARTMENT_ID_DEPARTMENT foreign key (DEPARTMENT_ID) references  DEPARTMENT(DEPARTMENT_ID)
-----------------------------------------------------------
alter table ASSIGNMENT add constraint FK_ASSIGNMENT_EMPLOYEE foreign key (EMPLOYEE_ID) references  EMPLOYEE(EMPLOYEE_ID)
alter table ASSIGNMENT add constraint FK_ASSIGNMENT_TASKS foreign key (PROJECT_ID, TASK_NUMBER) references  TASKS(PROJECT_ID, TASK_NUMBER)
-----------------------------------------------------------
alter table TASKS add constraint FK_TASKS_PROJECT foreign key (PROJECT_ID) references  PROJECT(PROJECT_ID)
-----------------------------------------------------------
alter table FAMILYMEMBER add constraint FK_FAMILYMEMBER_EMPLOYEE foreign key (EMPLOYEE_ID) references  EMPLOYEE(EMPLOYEE_ID)
-----------------------------------------------------------
alter table PROJECT add constraint FK_PROJECT_DEPARTMENT foreign key (DEPARTMENT) references  DEPARTMENT(DEPARTMENT_ID)
----------------------------------------------------------
GO --- Test

---- 
-----------------------------------------------------------
-- Step  3 : INSERT DATA
-----------------------------------------------------------
--------------------INSERT DEPARTMENT----------------------

insert into DEPARTMENT
values(N'Research', 5, null, '05/22/1988')

insert into DEPARTMENT
values(N'Operation', 4, null, '01/01/1995')

insert into DEPARTMENT
values(N'Management', 1, null, '06/19/1981')
----------------- INSERT EMPLOYEE--------------------
insert into EMPLOYEE 
values (N'Đinh',N'Tiến',N'Tới','009','02/11/1960',
	N'119 Cống Quỳnh, Tp HCM',N'Male',30000,null,5)

insert into EMPLOYEE
values (N'Nguyễn',N'Thanh',N'Tùng','005','08/20/1962',
	N'222 Nguyễn Văn Cừ, Tp HCM',N'Male',40000,null,5)
insert into EMPLOYEE
values (N'Bùi',N'Ngọc',N'Hằng','007','3/11/1954',
	N'332 Nguyễn Thái Học, Tp HCM',N'Male',25000,null,4)

insert into EMPLOYEE
values (N'Lê',N'Quỳnh',N'Như','001','02/01/1967',
	N'291 Hồ Văn Huê,  Tp HCM',N'Female',43000,null,4)

insert into EMPLOYEE
values (N'Nguyễn',N'Mạnh',N'Hùng','004','03/04/1967',N'95 Bà Rịa, Vũng Tàu',N'Male',38000,null,5)

insert into EMPLOYEE
values (N'Trần',N'Thanh',N'Tâm','003','05/04/1957',N'34 Mai Thị Lựu, Tp HCM',N'Male',25000,null,5)

insert into EMPLOYEE
values (N'Trần',N'Hồng',N'Quang','008','09/01/1967',N'80 Lê Hồng Phong, Tp HCM',N'Male',25000,null,4)

insert into EMPLOYEE
values (N'Phạm',N'Văn',N'Vinh','006','01/01/1965',N'45 Trưng Vương, Hà Nội',N'Female',55000, null,	1)
----------------- UPDATE DEPARTMENT--------------------
update  DEPARTMENT
set DEPARTMENT_HEAD=N'005'
where DEPARTMENT_ID=5

update  DEPARTMENT
set DEPARTMENT_HEAD=N'008'
where DEPARTMENT_ID=4

update  DEPARTMENT
set DEPARTMENT_HEAD=N'006'
where DEPARTMENT_ID=1

----------------- UPDATE EMPLOYEE--------------------

update  EMPLOYEE set LINEMANAGER_ID='005' where EMPLOYEE_ID=N'009'

update  EMPLOYEE set LINEMANAGER_ID='006' where EMPLOYEE_ID=N'005'

update  EMPLOYEE set LINEMANAGER_ID='001' where EMPLOYEE_ID='007'

update  EMPLOYEE set LINEMANAGER_ID='006' where EMPLOYEE_ID='001'

update  EMPLOYEE set LINEMANAGER_ID='005' where EMPLOYEE_ID='004'

update  EMPLOYEE set LINEMANAGER_ID='005' where EMPLOYEE_ID='003'

update  EMPLOYEE set LINEMANAGER_ID='001' where EMPLOYEE_ID='008'
-----------------INSERT LOCATION_DEPARTMENT --------------------
insert into LOCATION_DEPARTMENT
values(1,N'TP HCM')

insert into LOCATION_DEPARTMENT
values(4,N'Hà Nội')

insert into LOCATION_DEPARTMENT
values(5,N'Vũng Tàu')

insert into LOCATION_DEPARTMENT
values(5,N'Nha Trang')

insert into LOCATION_DEPARTMENT
values(5,N'TP HCM')
----------------- INSERT FAMILYMEMBER--------------------
insert into FAMILYMEMBER
values('005', N'Trinh', N'Male', '04/05/1976', N'Daughter')

insert into FAMILYMEMBER
values('005', N'Khang', N'Male', '10/25/1973', N'Son')

insert into FAMILYMEMBER
values('005', N'Phương', N'Female', '05/03/1948', N'Spouse')

insert into FAMILYMEMBER
values('001', N'Minh', N'Male', '02/28/1932', N'Spouse')

insert into FAMILYMEMBER
values('009', N'Tiến', N'Male', '01/01/1978', N'Son')

insert into FAMILYMEMBER
values('009', N'Châu', N'Male', '12/30/1978', N'Son')

insert into FAMILYMEMBER
values('009', N'Phương', N'Female', '05/05/1957', N'Spouse')
----------------- INSERT PROJECT--------------------
insert into PROJECT
values(N'Project X', 1, N'Vũng Tàu', 5)

insert into PROJECT
values(N'Project Y', 2, N'Nha Trang', 5)

insert into PROJECT
values(N'Project Z', 3, N'TP HCM', 5)

insert into PROJECT
values(N'Computerization', 10, N'Hà Nội', 4)

insert into PROJECT
values(N'Build internet line', 20, N'TP HCM', 1)

insert into PROJECT
values(N'Education', 30, N'Hà Nội', 4)

----------------- INSERT TASKS--------------------
insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (1, 	1, 	N'Design product X')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (1, 	2, 	N'Test product  X')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (2, 	1, 	N'Produce product Y')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (2, 	2, 	N'Advertise product Y')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (3, 	1, 	N'Promotion on product Z')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (10, 	1, 	N'Computerization on salary')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (10, 	2, 	N'Computerization on Bussiness Department')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (20, 	1, 	N'Install internet line')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (30, 	1, 	N'Educate Marketing employees')

insert into TASKS (PROJECT_ID, TASK_NUMBER, TASK_NAME) 
values (30, 	2,	N'Educate designer specialists')

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('009',	1,	1,	32)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('009',	2,	2,	8)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('004',	3,	1,	40)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('003',	1,	2,	20.0)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('003',	2,	1,	20.0)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('008',	10,	1,	35)
----------------- INSERT ASSIGNMENT--------------------

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('008',	30,	2,	5)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('001',	30,	1,	20)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('001',	20,	1,	15)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('006',	20,	1,	30)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('005',	3,	1,	10)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('005',	10,	2,	10)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('005',	20,	1,	10)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('007',	30,	2,	30)

insert into ASSIGNMENT (EMPLOYEE_ID,PROJECT_ID,TASK_NUMBER,DURATION) 
values ('007',	10,	2,	10)

