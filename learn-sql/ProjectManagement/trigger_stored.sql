use ProjectManagement; 

-----------------------------
-- Simple Stored Procedures--
-----------------------------
-- 1. Write a stored procedure to print 'Hello'.
go 
drop procedure if exists printHello;
go
create procedure printHello 
as 
begin
    print 'Hello';
end;
go

exec printHello;

-- 2. Write a stored procedure to print 'Xin chào' (Vietnamese for 'Hello').
go 
drop procedure if exists printXinChao;
go 
create procedure printXinChao 
as 
begin 
    print N'Xin chào';
end;
go

exec printXinChao;

-- 3. Write a stored procedure to print 'Xin chào' + @yourName, where @yourName is an
-- input parameter representing your name.
go 
drop procedure if exists printXinChaoName;
go
create procedure printXinChaoName 
    @yourName nvarchar(50)
as 
begin 
    print N'Xin chào ' + @yourName;
end;
go 

exec printXinChaoName @yourName = N'Nguyễn Thị Thanh Thảo';


-- 4. Write a stored procedure to print 'Xin chào' + @ten, where @ten is an input parameter
-- representing your Vietnamese-accented name. Suggestions:
-- • Use Telex to type in Vietnamese.
-- • Unicode strings must start with N (e.g., N'Tiếng Việt').
-- • Use the cast function (cast(<expression> as <type>)) to convert <expression> to the <type>.
go 
create procedure printXinChaoTen 
    @ten nvarchar(50) 
as 
begin 
    print N'Xin chào ' + @ten;
end;
go 

exec printXinChaoTen @ten = N'Nguyễn Thị Thanh Thảo';


-- 5. Write a stored procedure that takes 2 numbers @s1, @s2 as input and prints their sum
-- @s1+@s2.
go 
create procedure printSum 
    @s1 int, 
    @s2 int 
as 
begin 
    print @s1 + @s2; 
end; 
go 

exec printSum @s1 = 40, @s2 = 2; 

-- 6. Write a stored procedure that takes 2 numbers @s1, @s2 as input and prints the sentence
-- 'Sum is : @tg' where @tg=@s1+@s2.
go 
drop procedure if exists printSumSentence;
go 
create procedure printSumSentence 
    @s1 int, 
    @s2 int
as 
begin 
    declare @tg int;
    set @tg = @s1 + @s2; 
    print N'Sum is: ' + cast(@tg as varchar(50)); 
end; 
go 

exec printSumSentence @s1 = 40, @s2 = 2;


-- 7. Write a stored procedure that takes 2 numbers @s1, @s2 as input, calculates their sum
-- @s1+@s2, and outputs it into the parameter @sumVal. Execute and print the value of
-- this parameter to verify.
go 
drop procedure if exists returnPrintSum;
go
create procedure returnPrintSum 
    @s1 int, 
    @s2 int, 
    @sumVal int output 
as 
begin 
    set @sumVal = @s1 + @s2; 
    print @sumVal; 
end; 
go 

exec returnPrintSum @s1 = 40, @s2 = 2, @sumVal = 0; 

-- 8. Write a stored procedure that takes 2 numbers @s1, @s2 as input, calculates their sum
-- @s1+@s2, and outputs it into the parameter @sumVal. Execute and print the value of
-- this parameter as 'Sum is : @tg' where @tg = @s1+@s2.
go 
drop procedure if exists returnPrintSum;
go
create procedure returnPrintSum 
    @s1 int, 
    @s2 int, 
    @sumVal int output 
as 
begin 
    set @sumVal = @s1 + @s2; 
    declare @tg varchar(50);
    set @tg = cast(@sumVal as varchar(50));
    print N'Sum is: ' + @tg; 
end; 
go 

exec returnPrintSum @s1 = 40, @s2 = 2, @sumVal = 0; 

-- 9. Write a stored procedure that takes 2 numbers @s1, @s2 as input and prints the
-- maximum of them.
go 
drop procedure if exists printMax; 
go 
create procedure printMax 
    @s1 int, 
    @s2 int 
as 
begin 
    declare @maxVal int; 
    set @maxVal = case 
        when @s1 > @s2 then @s1
        else @s2
    end;
    print @maxVal;
end; 

exec printMax @s1 = 40, @s2 = 2;

-- 10. Write a stored procedure that takes 2 numbers @s1, @s2 as input and prints the sentence
-- 'The maximum number of @s1 and @s2 is @max' where @s1, @s2, and @max are their
-- respective values.
go 
drop procedure if exists printMaxSentence;
go 
create procedure printMaxSentence 
    @s1 int, 
    @s2 int 
as 
begin 
    declare @max int; 
    set @max = case 
        when @s1 > @s2 then @s1
        else @s2 
    end; 
    print N'The maxnimum number of '+cast(@s1 as varchar(50))+' and '+cast(@s2 as varchar(50))+' is '+cast(@max as varchar(50));
end; 
go 

exec printMaxSentence @s1 = 40, @s2 = 2;

-- 11. Write a stored procedure that takes 2 numbers @s1, @s2 as input, determines their min
-- and max, and outputs them into the parameters @max, @min. Execute and print the
-- values of these parameters to verify.
go 
drop procedure if exists returnPrintMaxMin;
go 
create procedure returnPrintMaxMin 
    @s1 int, 
    @s2 int, 
    @max int output, 
    @min int output 
as 
begin 
    set @max = case 
        when @s1 > @s2 then @s1 else @s2 
    end; 
    set @min = case 
        when @s1 < @s2 then @s1 else @s2 
    end; 
    print 'Max is: ' + cast(@max as varchar(50));
    print 'Min is: ' + cast(@min as varchar(50));
end; 
go 

exec returnPrintMaxMin @s1 = 40, @s2 = 2, @max = 0, @min = 0;

--------------------------------
-- Stored procedure with loops--
--------------------------------
-- 12. Write a stored procedure that takes an integer @n as input and prints numbers from 1 to @n.
go 
drop procedure if exists print1ton;
go 
create procedure print1ton 
    @n int 
as 
begin 
    declare @i int; 
    set @i = 1; 
    while @i <= @n 
    begin 
        print cast(@i as varchar(50)) + ' '; 
        set @i = @i + 1; 
    end; 
end; 
go 

exec print1ton @n = 10;


-- 13. Write a stored procedure that takes an integer @n as input and prints the sum of even
-- numbers from 1 to @n.
go 
drop procedure if exists printSumEven;
go 
create procedure printSumEven 
    @n int 
as 
begin 
    declare @i int; 
    declare @sumEven int; 
    set @i = 1; 
    set @sumEven = 0; 
    while @i <= @n
        begin 
            if @i % 2 = 0
                set @sumEven = @sumEven + @i; 
            set @i = @i + 1; 
        end; 
    print @sumEven;
end; 
go 

exec printSumEven @n = 10;


-- 14. Write a stored procedure that takes an integer @n as input, then prints the sum and count
-- of even numbers from 1 to @n.
go 
drop procedure if exists printSumCountEven;
go 
create procedure printSumCountEven 
    @n int
as 
begin 
    declare @i int; 
    declare @sumEven int; 
    declare @countEven int; 
    set @i = 1; 
    set @sumEven = 0; 
    set @countEven = 0;
    while @i <= @n begin 
            if @i % 2 = 0 begin
                set @sumEven = @sumEven + @i; 
                set @countEven = @countEven + 1;
            end; 
            set @i = @i + 1; 
    end; 
    print cast(@countEven as varchar(50)) + ' even numbers, sum is: ' + cast(@sumEven as varchar(50));
end; 
go 

exec printSumCountEven @n = 10;

-- 15. Write a stored procedure that takes 2 numbers as input and prints their greatest common
-- divisor (GCD) using the following guidelines:
------ b1. Start by assuming a <= A.
------ b2. If A is divisible by a, then: (a,A) = aotherwise: (a,A) = (A%a,a) or (a,A) = (a,A-a)
------ b3. Repeat b1, b2 until the condition in b2 is satisfied.
go 
drop procedure if exists printGCD; 
go 
create procedure printGCD 
    @a int, 
    @b int 
as 
begin 
    declare @gcd int; 
    set @gcd = case 
        when @a > @b then @b else @a 
    end; 
    while @gcd > 0 begin 
        if @a % @gcd = 0 and @b % @gcd = 0 begin 
            print 'GCD is: ' + cast(@gcd as varchar(50)); 
            break; 
        end; 
        set @gcd = @gcd - 1; 
    end; 
end;
go 

exec printGCD @a = 48, @b = 8;

--- second way 
go 
drop procedure if exists printGCD2;
go 
create procedure printGCD2 
    @a int, 
    @b int
as 
begin 
    declare @temp int; 
    while @b != 0 begin 
        set @temp = @a % @b; 
        set @a = @b; 
        set @b = @temp; 
    end;
    print 'GCD is: ' + cast(@a as varchar(50));
end;
go 

exec printGCD2 @a = 48, @b = 8;

-- 16. Write a stored procedure that takes two integers @s1 and @s2 as input. Output the
-- greatest common divisor (GCD) of @s1 and @s2 to the parameter @gcd. Execute and
-- use the 'select' command to print the value of this parameter for verification in the format
-- 'Result: gcd(@s1,@s2) = @gcd', replacing @s1, @s2, and @gcd with their respective values.
-- Sumamry: Use a cursor to implement the Euclidean algorithm.
go 
drop procedure if exists printGCD3;
go
create procedure printGCD3 
    @s1 int, 
    @s2 int, 
    @gcd int output
as 
begin 
    declare @temp int; 
    declare @a int; 
    declare @b int; 
    set @a = case 
        when @s1 > @s2 then @s1 else @s2 
    end; 
    set @b = case 
        when @s1 < @s2 then @s1 else @s2 
    end; 
    while @b != 0 begin 
        set @temp = @a % @b; 
        set @a = @b; 
        set @b = @temp; 
    end;
    set @gcd = @a; 
    -- select @gcd;
end;
go 

declare @s1 int; 
declare @s2 int; 
set @s1 = 48; 
set @s2 = 8; 

declare @gcd int; 
exec printGCD3 @s1, @s2, @gcd = @gcd output;
select 'Result: gcd(48, 8) = ' + cast(@gcd as varchar(50));

-------------------------------------------
-------- Stored procedure with cursor------
-------------------------------------------
-- 17. Write a stored procedure with the following content: Use the 'print' command to display a
-- list of employee ids.
go 
drop procedure if exists printEmployeeIds;
go 
create procedure printEmployeeIds
as 
begin 
    -- use ProjectManagement; 
    declare @empID int; 
    declare emp_cursor cursor for
        select e.EMPLOYEE_ID from EMPLOYEE e;
    open emp_cursor; 
    fetch next from emp_cursor into @empID; 

    while @@fetch_status = 0 begin 
        print @empID;
        fetch next from emp_cursor into @empID;
    end; 

    close emp_cursor;
    deallocate emp_cursor; 
end; 
go 

exec printEmployeeIds;


-- 18. Write a stored procedure with the following content: Use the 'print' command to display a
-- list of employee ids and their first names.
go 
drop procedure if exists printEmpIDFname; 
go 
create procedure printEmpIDFname 
as 
begin 
    declare @empID int; 
    declare @fname nvarchar(50);
    declare emp_cursor cursor for
        select e.EMPLOYEE_ID, e.FIRSTNAME from EMPLOYEE e;

    open emp_cursor; 
    fetch next from emp_cursor into @empID, @fname; 
    while @@fetch_status = 0 begin 
        print cast(@empID as varchar(50)) + ' ' + @fname;
        fetch next from emp_cursor into @empID, @fname; 
    end; 
    close emp_cursor; 
    deallocate emp_cursor; 
end; 
go 

exec printEmpIDFname;

-----------------------------------
--------- Simple trigger ----------
-----------------------------------
-- -- general template to check a constraint 
-- IF EXISTS (SELECT 1 FROM FAMILYMEMBER WHERE Email = @Email)
-- BEGIN
--  -- Handle error
-- END
-- ELSE
-- BEGIN
--  -- Insert or update row
-- END
-- -- end template 


-- 19. Write a trigger that, when adding, editing the FAMILYMEMBER table, prints a notification:
-- 'A family member has been added'.
-- Suggestion: Check if the trigger has been created by using a block of commands to avoid
-- data modification:
-- begin transaction
--      insert, update, delete
-- rollback 
go 
drop trigger if exists printFamilyMemberAdded;
go 
create trigger printFamilyMemberAdded
on FAMILYMEMBER
after insert, update 
as 
begin 
    print 'A family member has been added';
end; 
go

-- check if trigger exists 
select * from sys.triggers where name = 'printFamilyMemberAdded';

-- test trigger 
begin transaction; 
insert into FAMILYMEMBER values('005', N'Linh', N'Female', '04/05/1999', N'Daughter'); 
rollback; 

-- Assuming the following update operations (enumerated from 20 to 29) are executed on the database. 
-- Identify all constraints that may be violated with each operation. 
--For each case, provide different approaches to ensure that those constraints are not violated.

-- 20. Insert row < 'Tuan', 'Minh', Tran', '943775543', '6/21/42', '23/65 Tran Binh Trong Q5, TP
-- HCM', ‘Male’, 58000, '888665555', 1> into EMPLOYEE table.
go
drop procedure if exists InsertEmployee;
go
-- create procedure to insert data into employee table 
CREATE PROCEDURE InsertEmployee
@first_name VARCHAR(50),
@last_name VARCHAR(50),
@middle_name VARCHAR(100),
@employee_id CHAR(9),
@birthdate DATE,
@address_info VARCHAR(100),
@gender VARCHAR(10),
@salary DECIMAL(10, 2),
@line_manager_id INT,
@department_id INT
As
BEGIN
    DECLARE @department_count INT;
    DECLARE @manager_count INT;

    DECLARE @Number INT;

    -- Check constraints before insertion
    SELECT @department_count=COUNT(*) FROM DEPARTMENT WHERE DEPARTMENT_ID = @department_id;
    SELECT @manager_count=COUNT(*) FROM EMPLOYEE WHERE EMPLOYEE_ID = @line_manager_id;

    IF @birthdate >= GETDATE()
        PRINT('Birthdate should be in the past');
    ELSE
    IF NOT (@gender IN ('Male', 'Female'))
        PRINT('Gender must be Male or Female');
    ELSE
    IF @salary > 50000
        PRINT('Salary should be less than or equal to 50000');
    ELSE
    IF @department_count = 0
        PRINT('Department ID does not exist');
    ELSE
    IF @manager_count = 0
        PRINT('Line Manager ID does not exist in the Employee table');
    ELSE
    -- Constraints are satisfied, proceed with insertion
    INSERT INTO EMPLOYEE (LASTNAME, MIDDLENAME, FIRSTNAME, EMPLOYEE_ID, BIRTHDAY, HOUSEADDRESS, GENDER, SALARY, LINEMANAGER_ID, DEPARTMENT_ID)
    VALUES (@last_name, @middle_name, @first_name, @employee_id , @birthdate, @address_info, @gender, @salary, @line_manager_id, @department_id);
END;
GO 

-- test procedure
exec InsertEmployee @first_name = 'Tuan', @last_name = 'Minh', @middle_name = 'Tran', @employee_id = '943775543', @birthdate = '6/21/42', @address_info = '23/65 Tran Binh Trong Q5, TPHCM', @gender = 'Male', @salary = 58000, @line_manager_id = '888665555', @department_id = 1;

-- 21. Insert row <'Project A', 4, ‘Vung Tau', 2> into PROJECT table.


-- 22. Insert row <’Production', 4, '943775543', '10/01/88’> into DEPARTMENT table.


-- 23. Insert row <'677678989',null, 40.0> into ASSIGNMENT table.


-- 24. Insert row <’453453453’, ‘Tien’, ‘Male’, ‘12/12/60’, ‘Spouse’> into FAMILYMEMBER table.


-- 25. Update ASSIGNMENT table, setting all rows where EMPLOYEE_ID = ‘333445555’ to 'Aoa'.
go
drop procedure if exists UpdateAssignment;
go
CREATE PROCEDURE UpdateAssignment
    @emp_id_to_update VARCHAR(20)
AS
begin 
    -- Check if the employee exists
    IF not exists (select * from EMPLOYEE where EMPLOYEE_ID = @emp_id_to_update)
        PRINT('Employee does not exist');
    ELSE
    -- Update rows in ASSIGNMENT table where EMPLOYEE_ID matches the provided value
    UPDATE ASSIGNMENT SET EMPLOYEE_ID = @emp_id_to_update;
end;
go 

-- test procedure
exec UpdateAssignment @emp_id_to_update = '333445555';

-- 26. Delete rows from EMPLOYEE table where EMPLOYEE_ID='987654321'.
go 
drop procedure if exists DeleteEmployeeById;
go
CREATE PROCEDURE DeleteEmployeeById
    @emp_id_to_delete VARCHAR(20)
AS
BEGIN
    DECLARE @is_line_manager INT;

    -- Check if the employee is a line manager
    SELECT @is_line_manager=COUNT(*) FROM EMPLOYEE WHERE LINEMANAGER_ID = @emp_id_to_delete;

    IF @is_line_manager > 0
        PRINT('Cannot delete. Employee is a line manager.')
    ELSE
    -- Delete rows from EMPLOYEE table where EMPLOYEE_ID matches the provided value
    DELETE FROM EMPLOYEE WHERE EMPLOYEE_ID = @emp_id_to_delete;
END; 
go 

-- test procedure
exec DeleteEmployeeById @emp_id_to_delete = '987654321';

-- 27. Delete rows from PROJECT table where PROJECTNAME= 'Project X'.
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
rollback; 

select * from PROJECT; 
-- 28. Update values in the attributes DEPARTMENT_HEAD, APPOINTMENT_DATE in
-- DEPARTMENT table where DEPARTMENT_ID= 5 to '123456789' and '01/10/88'.


-- 29. Update values in the attribute DURATION to 5 in ASSIGNMENT table where
-- EMPLOYEE_ID ='999887777' and PROJECT_ID= 10.
