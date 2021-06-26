# Database User managament

References:

https://blogs.oracle.com/sql/how-to-create-users-grant-them-privileges-and-remove-them-in-oracle-database

## Preparations

To manage users we need to login as e.g. SYS user with SYSDBA role:

```
$ sqlplus sys@//localhost:1521/XE as SYSDBA
```

we also need to set alter the session:
```sql
SQL> alter session set "_ORACLE_SCRIPT"=true;
```

## List exising users

```sql
select username from all_users order by username;
select * from all_users order by created DESC;
```

## Delete user

```sql
drop user <username> cascade;
```

## Create user

```sql
create user <username> identified by <password>;
```

This will create the user, but it will not allow him to login. For that we need to add:

```sql
grant create session to <username>;
```

We can create a user and allow him to login at the same time:
```sql
grant create session to <username> identified by <password>;
```

Alternatively we can use the CONNECT role:

```sql
grant CONNECT to poke_reader;
```

#### CONNECT vs CREATE SESSION

"Beginning in Oracle Database 10g Release 2 (10.2), the CONNECT role has only the CREATE SESSION privilege, all other privileges are removed."

## Basic entity-related privileges

```sql
grant create table
    , create view
    , create procedure
    , create sequence
    to <username>;
```

With `create table` the user will be able to create and access his tables, but he will not be able to insert data yet. We need to set a quota on the user's default tablespace.

Find the default tablespace:
```sql
select username, default_tablespace from dba_users where username=<username>;
-- Example result: <username>, USERS
```

Allow unlimited quota:
```sql
alter user <username> quota unlimited on users;
```

Alternatively, you can grant unlimited quota on ALL tablespaces:
```sql
grant unlimited tablespace to poke_reader;
```
## Table-based privileges

```sql
grant select, insert, update, delete on data_owner.customers to app_user;
```

Example:
```
grant read on data_owner.customers to report_user_1;
```

"Note the grant of read instead of select. This is a new privilege in Oracle Database 12c. Granting select allows users to lock tables. Read doesn't. So you should give this privilege to read-only users instead of select."

## Check privileges granted to users

https://stackoverflow.com/questions/15066408/how-to-find-the-privileges-and-roles-granted-to-a-user-in-oracle/15066503

### Granted System Privileges

```sql
select * from dba_sys_privs where grantee = <username>;
```

Examples: `CREATE_SESSION`, `CREATE_TABLE`

### Other privileges

```sql
-- granted roles:
select * from dba_role_privs where grantee = <username>;

-- privileges granted directly to user
select * from dba_tab_privs where grantee = <username>;

-- privileges granted to role granted to user:
select *
  from dba_tab_privs
 where grantee in (select granted_role
                     from dba_role_privs
                    where grantee = <username>);

-- your permissions
select * from USER_ROLE_PRIVS where USERNAME= USER;
select * from USER_TAB_PRIVS where Grantee = USER;
select * from USER_SYS_PRIVS where USERNAME = USER;

-- granted role permissions
select * from ROLE_ROLE_PRIVS where ROLE IN (select granted_role from USER_ROLE_PRIVS where USERNAME= USER);
select * from ROLE_TAB_PRIVS  where ROLE IN (select granted_role from USER_ROLE_PRIVS where USERNAME= USER);
select * from ROLE_SYS_PRIVS  where ROLE IN (select granted_role from USER_ROLE_PRIVS where USERNAME= USER);
```