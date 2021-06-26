-- EXECUTE AS poke_owner

drop table trainer;

-- we use a rather new feature, auto increment without an explicit sequence

create table trainer (
    trainer_id number generated as identity primary key,
    name varchar2(50) not null unique
);

-- poke_reader

grant read on poke_owner.trainer to poke_reader;

-- poke_api

grant select, insert, update, delete on poke_owner.trainer to poke_api;

-- TODO: add synonyms
