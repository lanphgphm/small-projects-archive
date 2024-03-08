-- Author: Pham Lan Phuong 
-- Student ID: 210120 
use CourseRating; 

------------------------------------------------------------------------
-- Basic constraint (similar to Question 19): 1 question and 1 answer --
------------------------------------------------------------------------

-- Question 1: Create a trigger that alerts "A student has been added!"
-- when a new student is added to the database.
go 
drop trigger if exists addStudentTrigger; 
go 
create trigger addStudentTrigger
on Student
after insert
as
begin 
    print 'A student has been added!'
end; 
go

begin transaction; 
insert into student values ('s0006', N'Hoàng Minh An', 'an.hoang@fulbright.edu', 25);
rollback; 

----------------------------------------------------------------------------------------
-- Advanced constraint (similar to Question 20-29) queries: 3 questions and 3 answers --
----------------------------------------------------------------------------------------

-- Question 2 (insert): Create a stored procedure to insert a review into table Review, 
-- check that the student is enrolled into the course. Check that the informativeRating 
-- and difficultyRating are between 1 and 5. Check that the reviewContent is not null.
-- If not, raise an error for each violation. 

-- Answer to Question 2: 
--"Msg 50000, Level 16, State 1, Procedure insertReview, Line 16
-- The difficulty rating must be between 1 and 5."
go 
drop procedure if exists insertReview;
go 
create procedure insertReview
    @studentID char(5), 
    @enrollmentID char(6), 
    @reviewID varchar(10), 
    @informativeRating int,
    @difficultyRating int,
    @reviewContent nvarchar(1000),
    @publishedDate date
as 
begin 
    if not exists (select * from enrollment where studentID = @studentID and enrollmentID = @enrollmentID)
        raiserror('This student is not enrolled into this course.', 16, 1); 
    if @informativeRating < 1 or @informativeRating > 5
        raiserror('The informative rating must be between 1 and 5.', 16, 1); 
    if @difficultyRating < 1 or @difficultyRating > 5
        raiserror('The difficulty rating must be between 1 and 5.', 16, 1); 
    if @reviewContent is null
        raiserror('The review content must not be null', 16, 1); 
    insert into Review values (@reviewID, @informativeRating, @difficultyRating, @reviewContent, @publishedDate, @enrollmentID); 
end;
go 

begin transaction; 
exec insertReview 's0001', 'e0001', 'r0005', 5, 9, N'Too difficult!', '2021-05-01';
rollback; 

-- Question 3 (update): Create a stored procedure to update a course offering in table 
-- CourseOffering, check that the semester ID is 'sem10'. Check that the
-- professor exists in professor table. If not, raise an error for each violation.

-- Answer to Question 3:
-- "Msg 50000, Level 16, State 1, Procedure updateCourseOffering, Line 9
-- This professor does not exist."
go 
drop procedure if exists updateCourseOffering;
go 
create procedure updateCourseOffering
    @courseOfferingID char(6), 
    @courseID varchar(10), 
    @professorID char(5), 
    @semesterID char(5)
as 
begin 
    if not exists (select * from professor where professorID = @professorID)
        raiserror('This professor does not exist.', 16, 1); 
    if @semesterID != 'sem10'
        raiserror('The semester ID must be sem10.', 16, 1); 
    update CourseOffering set courseID = @courseID, professorID = @professorID, semesterID = @semesterID where offeringID = @courseOfferingID; 
end;
go 

begin transaction; 
exec updateCourseOffering 'off001', 'MATH101', 'p0008', 'sem10';
rollback;

-- Question 4 (delete): Create a stored procedure to delete a review in table Review,
-- check that the review ID exists in table Review. If not, raise an error. 
-- Make sure to delete all the reviewHistory of the same reviewID if any.

-- Answer to Question 4 if the review does not exist:
-- "Msg 50000, Level 16, State 1, Procedure deleteReview, Line 6
-- This review cannot be deleted because it does not exist."

-- Answer to Question 4 if the review exists and has reviewHistory:
-- The entry is deleted from both review and reviewHistory tables.

go 
drop procedure if exists deleteReview;
go 
create procedure deleteReview
    @reviewID varchar(10)
as 
begin 
    if not exists (select * from review where reviewID = @reviewID)
        raiserror('This review cannot be deleted because it does not exist.', 16, 1); 
    delete from ReviewHistory where reviewID = @reviewID; 
    delete from Review where reviewID = @reviewID; 
end;
go 

begin transaction;
exec deleteReview 'r0003';
rollback; 

begin transaction; 
exec deleteReview 'r0009';
rollback; 