Oracle Database architecture

https://docs.oracle.com/database/121/CNCPT/intro.htm#CNCPT914

- USER
- ROLE

## DATABASE

An Oracle database consists of one or more logical storage units called tablespaces, which collectively store all of the database's data.

## TABLESPACE

the primary logical database structures of any Oracle database

Oracle stores data logically in tablespaces and physically in datafiles associated with the corresponding tablespace

To check all the tablespaces in the DB:
```sql
select tablespace_name, status, contents from user_tablespaces
```

https://docs.oracle.com/cd/B19306_01/server.102/b14220/physical.htm

- QUOTA
- SCHEMA

Essentially the same as user, but new versions of Oracle (18c+) allow userless schema creation.

- PRIVILEGE
