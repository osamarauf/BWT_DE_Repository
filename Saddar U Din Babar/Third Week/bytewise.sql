-- Task #3

show databases;



use bytewise;



create table employee 
(empNo int,empName varchar(30),
phone varchar(11),
address varchar(30));




insert into employee values

(1,'ABC','03480','Dadu'),

(2,'XYZ','03126','Jamshoro'),

(3,'DEF','0336','Hyderabad');



create table course 
(rollNo int,courseName varchar(10),
courseId int);



insert into course values


(77,'Maths',58),

(78,'Python',73),

(87,'DSA',34);




select s.name,ug.age from student s 
inner join ugstd ug on s.rollNo=ug.rollNo;





SELECT s.name, s.age,c.courseName
FROM student s 

LEFT OUTER JOIN course c ON s.rollNo = c.rollNo;



SELECT s.name, s.age,c.courseName,c.courseId


FROM student s

LEFT JOIN course c

ON s.rollNO = c.rollNO;





SELECT s.name, s.age,c.courseName,c.courseId

FROM student s

Right JOIN course c

ON s.rollNO = c.rollNO;




alter table course add column serialNo int first,
add column courseCode int after courseName;




insert into course (serialNo,courseCode) values

(1,1),(2,2),(3,3);




truncate table course;



insert into course values

(1,77,'Python',1,73),

(2,78,'DSA',2,58),

(3,87,'Maths',3,34);





SELECT c1.courseName AS "Course", c2.rollNo AS "assigned to"
FROM course c1

JOIN course c2 ON c1.serialNo = c2.courseCode;



 


select * from course cross join ugstd;
 
 


select * from masterstd left join ugstd 
 on masterstd.roll=ugstd.rollNO
 where ugstd.name="Azhar";




SELECT masterstd.*
FROM masterstd
RIGHT JOIN ugstd ON ugstd.rollNo = masterstd.roll
WHERE masterstd.roll IS NULL;


-- Task #4

select s.*,c.* from student s 
inner join course c on s.rollNo=c.rollNo;

SELECT student.*
FROM student
RIGHT JOIN course ON student.rollNo = course.rollNo
WHERE student.rollNo!=any (select rollNo from course group by rollNo);

select * from student;



-- 29 March 2023
-- task #5
-- • Single Row Sub Queries 

select * from student where rollNo=
(select rollNo from course where courseName = 'DSA' );

-- Multi Row Sub Queries
 select * from student where rollNo = any
 (select rollNo from course group By rollNo desc);
 
 -- nested sub queries
 select * from student where rollNo = any 
 ( select rollNo from course where serialNo=any
 (select empNo from employee group by empNo));
 
 -- corelated subqueries
 
 select * from student where rollNo IN 
 (
   select rollNo from course where courseId>70
 );

-- Task # 4

-- Write the following queries using Northwind DB:

-- 1 - Write a query to show a list of students and their departments.

select s.name, d.dname from student s, dept d where s.dno=d.dno;

-- 2 - Write a query to show a list of students and their obtained marks:

select s.name, r.obtMarks from student s, result r where s.rollNo=r.rollNo;

-- 3 - Write a query to show a list of students who have not taken any course yet.

select * from student where not rollNo in(select rollNo from course order by rollNo); 

-- 4 - Write a query to show a list of employees and their students on the basis of dept no also dept name
select e.empName as "Teacher",s.name as "Student Name",d.dname 
from employee e , student s,dept d where e.dno=s.dno and e.dno=d.dno;


-- Creating index


CREATE INDEX i
ON student (rollNo);



-- altering index


ALTER TABLE student
  DROP INDEX i,
  ADD INDEX j (name);
  
  

-- drop index
  

alter table student 
  drop index j;
  
  
  -- Task #6

-- 1 - Write a query to retrieve the names of all products that have been ordered more than 50 time.

SELECT Products.name
FROM Products
JOIN Orders ON Products.id = Orders.product_id
GROUP BY Products.id
HAVING COUNT(*) > 50;



-- 2 - Write a query to retrieve the names of all products that have been ordered at least once.

SELECT Products.name
FROM Products
JOIN Orders ON Products.id = Orders.product_id
GROUP BY Products.id;


-- 3 - Create a view that shows the total revenue generated by each category.


CREATE VIEW Category_Revenue AS
SELECT Categories.name AS category_name, SUM(Products.price * Order_Items.quantity) AS total_revenue
FROM Categories
JOIN Products ON Categories.id = Products.category_id
JOIN Order_Items ON Products.id = Order_Items.product_id
GROUP BY Categories.id;



