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


/*4. Restrict Certain Users from Creating Procedures
Question:
Write a DDL trigger that prevents specific users (e.g., 'test_user') from creating stored procedures in the database.*/
create trigger trRestrictCreateProcedure
on database
for create_procedure
as
begin
	if SYSTEM_USER = 'sa'
	begin
		 RAISERROR('You are not allowed to create procedures.', 16, 1);
		 rollback
	end
end

create procedure spEmpSalaryUpdate
	@EmpID int,
	@EmpSalary int
as
begin
	update Employee
	set EmpSalary = @EmpSalary
	where EmpID = @EmpID
end

spEmpSalaryUpdate 1, 80000;


/*5. Track Index Modifications
Question:
Create a trigger that captures CREATE INDEX, DROP INDEX, or ALTER INDEX operations and logs them into an audit table.*/
create table Index_Log(
	EventType varchar(80),
	ObjectType varchar(80),
	EventTime datetime,
	TriggerBy varchar(40)
);

create trigger trIndexModification
on database
for create_index, drop_index, alter_index
as
begin
	declare @EventData xml = eventdata()
	insert into Index_Log
	select 
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(80)'),
		@EventData.value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(80)'),
		getdate(),
		SYSTEM_USER
end;

create index idx_Employee_Name
on Employee(EmpName);

select * from Index_Log;

/*6. Log All View-Related DDL Events
Question:
Write a DDL trigger that fires for any CREATE VIEW, ALTER VIEW, or DROP VIEW statements and inserts details into View_Changes_Log.*/
create table View_Changes_log(
	EventType varchar(80),
	ObjectType varchar(80),
	EventTime datetime,
	TriggerBy varchar(40)
);

create trigger trViewRelated
on database
for create_view, alter_view,drop_view
as
begin
	declare @EventData xml = eventdata()
	insert into View_Changes_log
	select 
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(80)'),
		@EventData.value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(80)'),
		getdate(),
	    SYSTEM_USER
end;

CREATE VIEW vwEmployee
as
select * from Employee where EmpSalary > 50000;

select * from View_Changes_log;


/*7. Restrict Table Renaming
Question:
Implement a trigger that blocks sp_rename if someone tries to rename a table in the database.*/
create trigger trRename
on database
for rename
as
begin
	declare @EventData xml = eventdata()
	if(@EventData.value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(60)')='TABLE')
	begin
		raiserror('Renaming tables is not allowed.', 16, 1)
		rollback
	end
end;

exec sp_rename 'Employees', 'Employee';

select * from Employees;

/*8. Monitor Function Creation
Question:
Create a DDL trigger that logs every CREATE FUNCTION operation, including the function name, user, and timestamp.*/
create table FuncitonCreationLog(
	FunctionName varchar(40),
	EventType varchar(80),
	ObjectType varchar(80),
	UserName varchar(80),
	EventTime datetime
);

create trigger trFunctionLog
on database
for create_function
as
begin
	declare @FunctionName varchar(40)
	declare @EventData xml = eventdata()
	insert into FuncitonCreationLog
	select 
		@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(40)'),
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(80)'),
		@EventData.value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(80)'),
		SYSTEM_USER,
		getdate()
end;

create function GetParticularEmployeeSalary(@EmpID int)
returns int
as
begin
	declare @Salary int
	select @Salary = EmpSalary from Employee where EmpID = @EmpID
	return @Salary
end;

select * from FuncitonCreationLog;
