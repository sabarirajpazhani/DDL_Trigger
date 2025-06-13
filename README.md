# DDL Trigger Questions

## 1. Prevent Table Dropping

## Create a database scoped DDL trigger that prevents anyone from dropping tables in the database

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

## Write a DDL trigger that captures every CREATE TABLE event in the database and logs it into a table named DDL_Log with details like the user name, event type, and timestamp.

![image](https://github.com/user-attachments/assets/95d7dcc6-786f-4400-be02-67901ae892ad)

## 3. Alert When Schema Changes

## Create a DDL trigger that logs whenever a schema is created, altered, or dropped. Include the schema name and the user who made the change.

![image](https://github.com/user-attachments/assets/b8905bc4-c0ee-4a27-bc07-7ad22af91ad6)



