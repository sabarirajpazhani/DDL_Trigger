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

/*1. Prevent Table Dropping
Question:
Create a database scoped DDL trigger that prevents anyone from dropping tables in the database.*/
create trigger trPreventDropping
on database
for drop_table
as
begin
	print 'Dropping tables is not allowed'
	rollback
end

drop table Employee;

/*2. Log All Table Creation Events
Question:
Write a DDL trigger that captures every CREATE TABLE event in the database and logs it into a table named DDL_Log with details like the user name, event type, and timestamp.*/
create table DDL_Log(
	EventType varchar(80),
	ObjectName varchar(80),
	EventTime datetime,
	TriggerBy varchar(80)
);

create trigger trLogCreation
on database
for create_table
as
begin
	declare @EventData xml = eventdata()
	insert into DDL_Log
	select 
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(80)'),
		@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(80)'),
		getdate(),
		SYSTEM_USER
end;

create table EmpDepartment(	
	DepartmentID int primary key,
	DepartmentName varchar(60)
);

select * from DDL_Log;

select * from EmpDepartment;


/*3. Alert When Schema Changes
Question:
Create a DDL trigger that logs whenever a schema is created, altered, or dropped. Include the schema name and the user who made the change.*/
create trigger trAlertSchema
on database
for create_schema, alter_schema, drop_schema
as
begin
	declare @EventData xml = eventdata()
	insert into DDL_Log
	select 
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(80)'),
		@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(80)'),
		GETDATE(),
		SYSTEM_USER
end;

create schema Employyes;

select * from DDL_Log;
