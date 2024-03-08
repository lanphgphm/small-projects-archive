USE master;
ALTER DATABASE CourseRating SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE if exists CourseRating;


use master; 
create database CourseRating;
use CourseRating;

---------------------------------------------------
--------- create table and primary keys -----------
---------------------------------------------------

create table student(
    studentID char(5) primary key, 
    studentName nvarchar(50) not null, 
    schoolEmail varchar(50) not null, 
    cohortID int not null, 
);

create table cohort(
    cohortID int primary key, 
    cohortName nvarchar(50) not null, 
    startYear int not null, 
    endYear int not null, 
);

create table major(
    majorID varchar(5) primary key, 
    majorName nvarchar(50) not null, 
);

create table declaration(
    declarationID char(5) primary key,
    declarationType char(5) check (declarationType in ('Major', 'Minor')),
    majorID varchar(5) not null,
    studentID char(5) not null,
);

create table courseCategory(
    categoryID varchar(5) primary key, 
    categoryName nvarchar(50) not null,
);

create table course(
    courseID varchar(10) primary key,
    courseName nvarchar(150) not null,
    categoryID varchar(5),
);

create table professor(
    professorID char(5) primary key,
    professorName nvarchar(50) not null,
);

create table semester(
    semesterID char(5) primary key,
    semesterName nvarchar(50) not null,
    startDate date not null,
    endDate date not null,
);


create table courseOffering(
    offeringID char(6) primary key,
    courseID varchar(10) not null,
    professorID char(5) not null,
    semesterID char(5) not null,
);

create table enrollment(
    enrollmentID char(6) primary key,
    enrollmentType nvarchar(10)check (enrollmentType in ('Enrolled', 'RP', 'Audit')),
    gradeType nvarchar(20) check (gradeType in ('Letter', 'P/NP', 'Audit')),
    studentID char(5) not null,
    offeringID char(6) not null,
);

create table review (
    reviewID varchar(10) primary key, 
    informativeRating int check (informativeRating between 1 and 5),
    difficultyRating int check (difficultyRating between 1 and 5),
    reviewContent nvarchar(1000) not null,
    publishedDate date not null,
    enrollmentID char(6) not null,
);

create table reviewHistory(
    reviewHistoryID varchar(10) primary key,
    oldInformativeRating int check (oldInformativeRating between 1 and 5),
    oldDifficultyRating int check (oldDifficultyRating between 1 and 5),
    oldReviewContent nvarchar(1000) not null,
    oldPublishedDate date not null,
    reviewID varchar(10) not null,
);

---------------------------------------------------
------------- create foreign keys -----------------
---------------------------------------------------

--- make cohortID foreign key in student table
alter table student add constraint fk_student_cohortID foreign key (cohortID) references cohort(cohortID);

--- declaration table has foreign keys: majorID, studentID
alter table declaration add constraint fk_declaration_majorID foreign key (majorID) references major(majorID); 
alter table declaration add constraint fk_declaration_studentID foreign key (studentID) references student(studentID); 

--- course table has foreign keys: categoryID
alter table course add constraint fk_course_categoryID foreign key (categoryID) references courseCategory(categoryID);

--- courseOffering table has foreign keys: courseID, professorID, semesterID
alter table courseOffering add constraint fk_courseOffering_courseID foreign key (courseID) references course(courseID);
alter table courseOffering add constraint fk_courseOffering_professorID foreign key (professorID) references professor(professorID);
alter table courseOffering add constraint fk_courseOffering_semesterID foreign key (semesterID) references semester(semesterID);

--- enrollment table has foreign keys: studentID, offeringID
alter table enrollment add constraint fk_enrollment_studentID foreign key (studentID) references student(studentID);
alter table enrollment add constraint fk_enrollment_offeringID foreign key (offeringID) references courseOffering(offeringID);

--- review table has foreign keys: enrollmentID
alter table review add constraint fk_review_enrollmentID foreign key (enrollmentID) references enrollment(enrollmentID);

--- reviewHistory table has foreign keys: reviewID
alter table reviewHistory add constraint fk_reviewHistory_reviewID foreign key (reviewID) references review(reviewID);


---------------------------------------------------
------------- insert sample data ------------------
---------------------------------------------------
--- insert sample majors into major table 
insert into major values ('CS', 'Computer Science'); 
insert into major values ('MATH', 'Applied Mathematics'); 
insert into major values ('ENG', 'Human-centered Engineering'); 
insert into major values ('SOCI', 'Social Studies'); 
insert into major values ('ARTS', 'Arts and Media');
insert into major values ('HIST', 'History'); 
insert into major values ('VS', 'Vietnam Studies'); 
insert into major values ('IS', 'Integrated Science'); 
insert into major values ('PSY', 'Psychology'); 
insert into major values ('ECON', 'Economics');
insert into major values ('LIT', 'Literature');

--- insert sample cohorts into cohort table
insert into cohort values (23, 'co23', 2018, 2023);
insert into cohort values (24, 'co24', 2020, 2024);
insert into cohort values (25, 'co25', 2021, 2025);
insert into cohort values (26, 'co26', 2022, 2026);
insert into cohort values (27, 'co27', 2023, 2027);

--- insert sample data into courseCategory table 
insert into courseCategory values ('Core', 'Core Courses'); 
insert into courseCategory values ('E1', 'Arts & Literature');
insert into courseCategory values ('E2', 'Social Science & Economics');
insert into courseCategory values ('E3', 'Engineering & Integrated Science');
insert into courseCategory values ('E4', 'Mathematics & Computer Science');

--- insert sample data into semester table 
insert into semester values ('sem01', 'Fall 2018', '08/15/2018', '12/25/2018');
insert into semester values ('sem02', 'Spring 2019', '01/15/2019', '05/25/2019');
insert into semester values ('sem03', 'Fall 2019', '08/15/2019', '12/25/2019');
insert into semester values ('sem04', 'Spring 2020', '01/15/2020', '05/25/2020');
insert into semester values ('sem05', 'Fall 2020', '08/15/2020', '12/25/2020');
insert into semester values ('sem06', 'Spring 2021', '01/15/2021', '05/25/2021');
insert into semester values ('sem07', 'Fall 2021', '08/15/2021', '12/25/2021');
insert into semester values ('sem08', 'Spring 2022', '01/15/2022', '05/25/2022');
insert into semester values ('sem09', 'Fall 2022', '08/15/2022', '12/25/2022');
insert into semester values ('sem10', 'Spring 2023', '01/15/2023', '05/25/2023');


--- insert sample data into professor table 
insert into professor values ('p0001', N'Huỳnh Việt Linh');
insert into professor values ('p0002', N'Phan Thành Trung');
insert into professor values ('p0003', N'Trần Vĩnh Linh');
insert into professor values ('p0004', N'Phan Tuấn Ngọc');
insert into professor values ('p0005', N'Nguyễn Thị Lan');
insert into professor values ('p0006', N'Ian Kalman');

--- insert sample data into course table 
insert into course values ('CS101', 'Computer Science I', 'E4');
insert into course values ('CS302', 'Algorithms and Theory of Computing', NULL); 
insert into course values ('CS301', 'Software Engineering', NULL);
insert into course values ('CORE101', 'Global Humanities and Social Change', 'Core');
insert into course values ('ECON201', 'Econometrics', 'E2'); 
insert into course values ('PSY101', 'Introductory Psychology', 'E2');
insert into course values ('MATH101', 'Calculus', 'E4');

--- insert sample data into course offering table 
insert into courseOffering values ('off001', 'CS101', 'p0001', 'sem09');
insert into courseOffering values ('off002', 'CS302', 'p0001', 'sem09');
insert into courseOffering values ('off003', 'PSY101', 'p0005', 'sem10');
insert into courseOffering values ('off004', 'MATH101', 'p0003', 'sem07');
insert into courseOffering values ('off005', 'ECON201', 'p0004', 'sem08');


--- insert sample data into student table
insert into student values ('s0001', N'Phạm Lan Phương', 'phuong.pham@fulbright.edu', 25); 
insert into student values ('s0002', N'Lý Trang Tuyên', 'tuyen.ly@fulbright.edu', 23); 
insert into student values ('s0003', N'Nguyễn Hoàng Nhật Tân', 'tan.nguyen@fulbright.edu', 25);
insert into student values ('s0004', N'Vũ Thị Hồng Linh', 'linh.vu@fulbright.edu', 24); 
insert into student values ('s0005', N'Hoàng Dung Vũ Minh', 'minh.hoang@fulbright.edu', 25); 

--- insert sample data into declaration table 
insert into declaration values ('d0001', 'Major', 'CS', 's0001');
insert into declaration values ('d0002', 'Major', 'LIT', 's0002');
insert into declaration values ('d0003', 'Major', 'MATH', 's0003');
insert into declaration values ('d0004', 'Major', 'MATH', 's0004');
insert into declaration values ('d0005', 'Major', 'ECON', 's0005');

--- insert sample data into enrollment table 
insert into enrollment values ('e0001', 'Enrolled', 'Letter', 's0001', 'off001');
insert into enrollment values ('e0002', 'Enrolled', 'Letter', 's0001', 'off002');
insert into enrollment values ('e0003', 'Audit', 'Audit', 's0002', 'off003');
insert into enrollment values ('e0004', 'Enrolled', 'P/NP', 's0003', 'off004');
insert into enrollment values ('e0005', 'Enrolled', 'P/NP', 's0004', 'off005');
insert into enrollment values ('e0006', 'Enrolled', 'P/NP', 's0005', 'off001');

--- insert sample data into review table 
insert into review values ('r0001', 5, 3, 'instructor makes you code from terminal nice', '2023-11-05', 'e0001');
insert into review values ('r0002', 5, 5, 'haha turing machines go brrr', '2023-05-05', 'e0002');
insert into review values ('r0003', 5, 5, 'i love psychology', '2023-10-05', 'e0003');
insert into review values ('r0004', 1, 1, 'taylor swift did not, in fact, invent the taylor series', '2023-02-15', 'e0004');

--- insert sample data into reviewHistory table 
insert into reviewHistory values ('rh001', 5, 5, 'i love python', '2023-10-04', 'r0003');

