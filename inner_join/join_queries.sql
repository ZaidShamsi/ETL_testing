-- inner join fetching all columns from each table
select * from 
student 
inner join course
on student.course_id = course.id

-- inner join fetching desired columns
select 
'Student Name' = CONCAT(s.first_name, ' ', s.last_name),
'Course Name' = c.course_name
from 
student s
inner join course c
on s.course_id = c.id

-- inner join with not equal to operaton in on clause
select 
'Student Name' = CONCAT(s.first_name, ' ', s.last_name),
'Course Name' = c.course_name
from 
student s
inner join course c
on s.course_id <> c.id

-- cross join
select 
'Student Name' = CONCAT(s.first_name, ' ', s.last_name),
'Course Name' = c.course_name
from 
student s
cross join course c

