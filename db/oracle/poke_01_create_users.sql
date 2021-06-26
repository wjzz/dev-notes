-- EXECUTE AS SYSDBA

alter session set "_oracle_script"=true;

-- poke_owner

grant create session to poke_owner identified by "poke_owner";
grant create table to poke_owner;
grant unlimited tablespace to poke_owner;

-- poke_api

grant create session to poke_api identified by "poke_api";

-- poke_reader

grant create session to poke_reader identified by "poke_reader";

-- verify the list of new users

select * from all_users where username like 'POKE_%' order by created desc;
