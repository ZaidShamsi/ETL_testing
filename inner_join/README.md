# INNER JOIN

Usually, `INNER JOIN` is depicted as below:

![inner_join](https://github.com/ZaidShamsi/ETL_testing/assets/103277308/f46a3096-0395-49b0-818e-0f9a75451292)

But I find this picture deceiving.

Prima facie, it depicts that `INNER JOIN` will give the records that exists in both the tables, which is TRUE.

But the picture also creates a FALSE impression that the number of records that will get returned after executing the `INNER JOIN` will be less than any of the parent table. The truth is, count of records returned after executing the `INNER JOIN` can be less than, equal to or greater than the number of records present in any of the parent table.

## Let's break it down

For illustration purpose, consider a school database `school_db` that has `student` and `course` tables.

#### course table

| Field | Type |
| :----------- | :----------- |
| id | int |
| course_code | nvarchar(10) |
| course_name | nvarchar(100) |

```sql 
select * from course
```
|id|	course_code|	course_name|
|:---|:---|:---|
|1|	TRA|	Transfiguration|
|2|	DEF|	Defence against the dark arts|
|3|	HIS|	History of magic|

#### student table

| Field | Type |
| :----------- | :----------- |
| id | int |
| first_name | nvarchar(30) |
| last_name | nvarchar(30) |
| course_id | int |

```sql 
select * from student
```
|id|	first_name|	last_name|	course_id|
|:---|:---|:---|:---|
|1|	Harry|	Potter|	2|
|2|	Hermione|	Granger|	3|

Now, we are trying to find answer to the question, '**What courses are opt by each student?**' For this we apply inner join on these two tables.

```sql
select * from 
student 
inner join course
on student.course_id = course.id
```
|id|	first_name|	last_name|	course_id|	id|	course_code|	course_name|
|:---|:---|:---|:---|:---|:---|:---|
|1|	Harry|	Potter|	2|	2|	DEF|	Defence against the dark arts|
|2|	Hermione|	Granger|	3|	3|	HIS|	History of magic|

That's a lot of columns, we can modify our query to select the desired columns only

```sql
select 
'Student Name' = CONCAT(s.first_name, ' ', s.last_name),
'Course Name' = c.course_name
from 
student s
inner join course c
on s.course_id = c.id
```
|Student Name|	Course Name|
|:---|:---|
|Harry Potter|	Defence against the dark arts|
|Hermione Granger|	History of magic|

Now as can be observed from the output of these inner join queries, the count of records is not less than any of the parent table, but it is equal to the count of records present in the `student` table. The picture that depicts this relation is attached below

![inner_join_explained](https://github.com/ZaidShamsi/ETL_testing/assets/103277308/c90e32dc-cf27-410d-b5f8-694b4af42489)

Extending this discussion, what if we want to answer the question, '**What all courses are not opted by students?**'

```sql
select 
'Student Name' = CONCAT(s.first_name, ' ', s.last_name),
'Course Name' = c.course_name
from 
student s
inner join course c
on s.course_id <> c.id
```
|Student Name|	Course Name|
|:---|:---|
|Harry Potter|	Transfiguration|
|Harry Potter|	History of magic|
|Hermione Granger|	Transfiguration|
|Hermione Granger|	Defence against the dark arts|

So, Harry Potter has not opted for Transfiguration and History of magic. And Hermione Granger has not opted for Transfiguration and Defence against the dark arts.

If looked closely, stacking the output of inner join `on s.course_id = c.id` and `on s.course_id <> c.id` gives the same result set as will be obtained when `CROSS JOIN` is applied between `student` and `course` tables.

```sql
select 
'Student Name' = CONCAT(s.first_name, ' ', s.last_name),
'Course Name' = c.course_name
from 
student s
cross join course c
```
|Student Name|	Course Name|
|:---|:---|
|Harry Potter|	Transfiguration|
|Harry Potter|	Defence against the dark arts|
|Harry Potter|	History of magic|
|Hermione Granger|	Transfiguration|
|Hermione Granger|	Defence against the dark arts|
|Hermione Granger|	History of magic|

More on `CROSS JOIN` in future :)
