# DDL Trigger Questions

## 1. Prevent Table Dropping

**Create a database scoped DDL trigger that prevents anyone from dropping tables in the database**

![image](https://github.com/user-attachments/assets/1717a806-e61f-409d-ae8b-0d337155bd69)

## XML-formatted data containing detailed information about the event that fired a trigger

```sql
<EVENT_INSTANCE>
  <EventType>DROP_TABLE</EventType>
  <PostTime>2025-06-12T23:10:00.000</PostTime>
  <ServerName>MyServer</ServerName>
  <LoginName>MyUser</LoginName>
  <UserName>dbo</UserName>
  <DatabaseName>MyDatabase</DatabaseName>
  <SchemaName>dbo</SchemaName>
  <ObjectName>Employee</ObjectName>
  <ObjectType>TABLE</ObjectType>
</EVENT_INSTANCE>
```

## 2. Log All Table Creation Events

**Write a DDL trigger that captures every CREATE TABLE event in the database and logs it into a table named DDL_Log with details like the user name, event type, and timestamp.**

![image](https://github.com/user-attachments/assets/95d7dcc6-786f-4400-be02-67901ae892ad)

## 3. Alert When Schema Changes

**Create a DDL trigger that logs whenever a schema is created, altered, or dropped. Include the schema name and the user who made the change.**

![image](https://github.com/user-attachments/assets/b8905bc4-c0ee-4a27-bc07-7ad22af91ad6)

## 4. Restrict Certain Users from Creating Procedures

**Write a DDL trigger that prevents specific users (e.g., 'test_user') from creating stored procedures in the database.**

![image](https://github.com/user-attachments/assets/9adae405-8f98-4671-9c81-4856fcf691fb)

## 5. Track Index Modifications

**Create a trigger that captures CREATE INDEX, DROP INDEX, or ALTER INDEX operations and logs them into an audit table.**

![image](https://github.com/user-attachments/assets/7c83a4b2-b221-4bb2-8849-2a24523a0418)

## 6. Log All View-Related DDL Events

**Write a DDL trigger that fires for any CREATE VIEW, ALTER VIEW, or DROP VIEW statements and inserts details into View_Changes_Log.**

![image](https://github.com/user-attachments/assets/32805d8f-efc2-48f1-8473-8d35688e267f)

## 7. Restrict Table Renaming

**Implement a trigger that blocks sp_rename if someone tries to rename a table in the database.**

![image](https://github.com/user-attachments/assets/9bfcdc1d-1286-4bf0-85f4-a4b5d2eb14ad)




