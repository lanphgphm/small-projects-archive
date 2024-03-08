-- Author:      Pham Lan Phuong 
-- Student ID:  210120 
-- Date:        2023-11-25

use CourseRating; 

---------------------------------------------------
-------------- sample queries  --------------------
---------------------------------------------------
-- 5 basic queries 
-- Q1: Select all students whose email ends with @fulbright.edu
select * from student where schoolEmail like '%@fulbright.edu';

-- Q2: Select all courses offered in semester 09
select * from courseOffering where semesterID = 'sem09';

--Q3: Select all Pass/No pass enrollments 
select * from enrollment where gradeType = 'P/NP';

--Q4: Select all course categories name at school 
select categoryName from courseCategory;

--Q5: select all reviews that has informativeRating at least 4 
select * from review where informativeRating >= 4;

-- 5 joining queries 
-- Q6: Select all students enrolled in CS101 
select e.studentID from enrollment e 
inner join courseOffering co on e.offeringID = co.offeringID
where co.courseID = 'CS101';

-- Q7: Select all students who declared major in math
select * from student s
inner join declaration d on d.studentID = s.studentID
where d.majorID = 'MATH';

-- Q8: Select all students and course names who enrolled for a letter grade 
select s.studentID, s.studentName, co.courseID from student s
inner join enrollment e on e.studentID = s.studentID
inner join courseOffering co on e.offeringID = co.offeringID
where e.gradeType='Letter';

-- Q9: select all students in cohort 24 
select * from student s
inner join cohort c on s.cohortID = c.cohortID
where c.cohortID = 24;

-- Q10: Select the review history of enrollmentID e0003
select * from reviewHistory rh 
inner join review r on rh.reviewID = r.reviewID
where r.enrollmentID = 'e0003';

-- 5 nested queries 
--Q11: Select all enrollments of students who started their school on 2021 
select * from enrollment e 
where e.studentID in (
    select s.studentID from student s 
    inner join cohort c on s.cohortID = c.cohortID
    where c.startYear = 2021);

--Q12: Select all professors who taught in semester 09
select * from professor p 
inner join courseOffering co on p.professorID = co.professorID
where co.semesterID in (
    select s.semesterID from semester s 
    where s.semesterID = 'sem09');

--Q13: Select all courses with students enrolled for a letter grade
select * from course c 
where c.courseID in (
    select co.courseID from courseOffering co 
    inner join enrollment e on co.offeringID = e.offeringID
    where e.gradeType = 'Letter');

--Q14: Select all reviews for courses offered by professor whose name has letter "L" 
select * from review r 
where r.enrollmentID in (
    select enrollmentID from enrollment e 
    where e.offeringID in (
        select co.offeringID from courseOffering co 
        inner join professor p on co.professorID = p.professorID
        where p.professorName like '%L%'));

--Q15: Select all reviews for students in cohort 25 
select * from review r 
where r.enrollmentID in (
    select enrollmentID from enrollment e 
    where e.studentID in (
        select s.studentID from student s 
        inner join cohort c on s.cohortID = c.cohortID
        where c.cohortID = 25));

-- 5 grouping queries 
--Q16: Find the average informative rating of all reviews 
select avg(informativeRating) from review;

--Q17: Find the average difficulty rating of all reviews
select avg(difficultyRating) from review;

--Q18: Find the number of students in each cohort 
select 
    s.cohortID, 
    count(*) as numberOfStudents 
from student s
group by s.cohortID;

--Q19: How many students are enrolled in each course? 
select 
    co.courseID, 
    count(*) as numberOfStudents 
from courseOffering co
inner join enrollment e on co.offeringID = e.offeringID
group by co.courseID;

--Q20: How many reviews are there for each course? 
select 
    co.courseID, 
    count(*) as numberOfReviews
from courseOffering co 
inner join enrollment e on co.offeringID = e.offeringID
inner join review r on e.enrollmentID = r.enrollmentID
group by co.courseID;
