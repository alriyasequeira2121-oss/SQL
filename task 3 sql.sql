create database my_alriyas;
use my_alriyas;
create table students_table(
Student_ID int,
Name varchar(90),
Course varchar(80),
Age int,
Marks int,
City varchar(100)
);
select*from students_table;
insert into students_table values(21,'alriya','bcom',18,86,'mangalore'),(22,'aishwarya','BBA',19,60,'mangalore'),(23,'joshna','BCA',24,45,'kochi'),(24,'riya','bcom',18,80,'mangalore'),(25,'andrea','BBA',18,98,'mangalore');
select*from students_table;
update students_table
set Course='BCom (DA)' 
where Student_ID=3;
update students_table
set Age=20
where Student_ID=2;
update students_table
set Age=45
where Student_ID=25;
update students_table
set Course='bcom(AI)'
where Student_ID=21;
update students_table
set Marks=98
where Age=18;
select*from students_table;
delete from students_table where course='bcom';
delete from students_table where course='bba';
delete from students_table where marks=86;
delete from students_table where age=24;
delete from students_table where course='BCA';
select*from students_table;
