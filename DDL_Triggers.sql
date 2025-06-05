--Creating the Datbase for DDL Triggers
create database DDLTriggers;

use DDLTriggers;

--creating the Employee Tables
create table Employee(
	EmpID int identity(1,1) primary key,
	EmpName varchar(90),
	EmpSalary int,
	EmpEmail varchar(90)
);

insert into Employee values
('Arun',50000,'Arun@gmail.com'),
('Balaji',65000,'Balaji@gmail.com');

select * from Employee;

