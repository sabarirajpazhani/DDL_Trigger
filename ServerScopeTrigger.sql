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

create login userLogin with password = 'password@1234';