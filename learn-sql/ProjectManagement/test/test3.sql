-- Author: Pham Lan Phuong 
-- Student ID: 210120 
-- Test 2 

use ProjectManagement; 

-- Q1: Create stored procedure to insert a row into department table. Constraint: 
---- @DeptName unique 
---- @DeptHead must exist in Employee table 
---- @AppDate must be grater equal to current date 
go 
drop procedure if exists InsertDept; 
go 
create procedure InsertDept
    @DeptName nvarchar(50),
    @DeptID int, 
    @DeptHead char(9),
    @AppDate date 
as 
begin 
    if exists (select * from DEPARTMENT where DEPARTMENT_NAME = @DeptName)
    begin 
        raiserror('Department name must be unique. This name already existed.', 16, 1);
        return; 
    end; 

    if not exists (select * from EMPLOYEE where EMPLOYEE_ID = @DeptHead) 
    begin 
        raiserror('Department Head does not exist in Employee table', 16, 1); 
        return; 
    end; 

    if @AppDate < getdate() 
    begin 
        raiserror('Appointment date must be greater than or equal to current date', 16, 1);
        return; 
    end; 
    insert into Department values (@DeptName, @DeptID, @DeptHead, @AppDate); 
end;
go

begin transaction; 
exec InsertDept 'Production', 4, '943775543', '1988-01-10';
select * from department;
rollback; 


-- Q2: Write stored procedurte to update value of attribute DURATION in ASSIGNMENT table 
-- Constraint: 
---- Employee_ID must exists in employee table 
---- project_id must exists in project table 
---- duration must be at least 1 

go 
drop procedure if exists UpdateDurationAssignment; 
go 
create procedure UpdateDurationAssignment
    @EmpID char(9),
    @ProjID int, 
    @Duration int 
as 
begin 
    if not exists (select * from employee where employee_id = @EmpID)
    begin
        raiserror('Employyee does not exist', 16, 1);
        return; 
    end; 

    if not exists (select * from project where project_id = @ProjID)
    begin 
        raiserror('Project does not exist', 16, 1); 
        return; 
    end; 

    if @Duration < 1 
    begin 
        raiserror('Duration must be at least 1', 16, 1); 
        return; 
    end; 
    
    -- if all checks passed, update duration column in assignment table
    update assignment
    set duration = @Duration
    where employee_id = @EmpID and project_id = @ProjID;
end; 
go 

begin transaction; 
exec UpdateDurationAssignment '999887777', 10, 5; 
rollback; 

-- Q3: Write stored procedure to delete rows from project table where projectname='Project X'
-- Constraint: Make sure to clean other tables as well 
go 
drop procedure if exists deleteXentry; 
go 
create procedure deleteXentry 
    @projectName nvarchar(50)
as 
begin 
    -- check if project exists
    if not exists (select * from project where projectname=@projectName) begin
        raiserror('Project does not exist', 16, 1);
        return; 
    end; 

    -- if exist, delete fk before delete pk 
    declare @xid int; 
    select @xid = p.PROJECT_ID from PROJECT p 
    where p.PROJECTNAME = @projectName;
    -- fk: delete all rows with projectid = 1 in assignment table 
    delete from ASSIGNMENT 
    where ASSIGNMENT.PROJECT_ID = @xid;
    -- fk: delete all rows with projectid = 1 in task table 
    delete from TASKS
    where TASKS.PROJECT_ID = @xid; 

    -- pk: delete all rows with projectid = 1 in project table 
    delete from PROJECT 
    where project.PROJECT_ID = @xid; 
end; 
go 

begin transaction; 
exec deleteXentry @projectName='Project X'; 
select * from PROJECT; 
select * from ASSIGNMENT; 
select * from TASKS; 
rollback; 

-- Q4: Write trigger that prints 'An employee has been added' 
-- when an employee is inserted into employee table 

go 
drop trigger if exists employeeAddedAlert;
go 
create trigger employeeAddedAlert
on EMPLOYEE
after insert
as
begin
    print 'An employee has been added'; 
end;
go 

begin transaction;
insert into EMPLOYEE values ('Pham', 'Lan', 'Phuong', '000', '1990-01-01', 'Dist 7, TP HCM', 'Female', 30000, NULL, 4);
rollback; 
