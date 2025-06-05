use DDLTriggers;

/*1. Prevent Login Creation
Q: How would you prevent unauthorized users from creating new SQL Server logins at the server level?*/
create trigger trPreventLogin
on all server
for create_login
as
begin
	raiserror('Creating new logins is not allowed on this server.',16,1)
	rollback
end

DROP TRIGGER trPreventLogin ON ALL SERVER;

create login userLogin with password = 'password@1234';

/*2. Audit Login Activity
Q: How can you track who created, altered, or dropped SQL Server logins across the server?*/
create table master.dbo.AuditLogin(
	EventType varchar(80),
	ObjectType varchar(80),
	EventDate datetime,
	TriggerBy varchar(80)
);

drop table AuditLogin;

create trigger trAuditLogin
on all server
for create_login, drop_login, alter_login
as
begin
	declare @EventData xml = eventdata()
	insert into master.dbo.AuditLogin
	select
		@EventData.value('(/EVENT_INSTANCE/EventType)[1]','varchar(80)'),
		@EventData.value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(80)'),
		getdate(),
		SYSTEM_USER
end;

drop trigger trAuditLogin on all server;

CREATE LOGIN useLogin WITH PASSWORD = 'Initial@123';

alter login useLogin with password = 'Password@12345';

select * from AuditLogin;


/*3. Block Specific User from Dropping Logins
Q: How do you stop a specific user like admin1 from dropping server-level logins?*/
create trigger trBlockSpecificUser
on all server
for drop_login
as
begin
	
	if SYSTEM_USER= 'sa'
	begin
		raiserror('sa is not allowed to drop logins.',16,1)
		rollback
	end
end


drop login userLogin;
