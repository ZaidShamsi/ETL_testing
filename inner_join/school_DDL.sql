create database school_db;
GO

use school_db;

create table student(
id int,
first_name nvarchar(30),
last_name nvarchar(30),
course_id int
);

create table course(
id int,
course_code nvarchar(10),
course_name nvarchar(100)
);