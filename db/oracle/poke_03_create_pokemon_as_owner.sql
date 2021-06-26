-- EXECUTE AS poke_owner

drop table pokemon;

create table pokemon (
    pokemon_id number primary key,
    name varchar2(50) not null unique,
    description varchar2(255)
);

-- poke_reader

grant read on poke_owner.pokemon to poke_reader;

-- poke_api

grant select, insert, update, delete on poke_owner.pokemon to poke_api;

-- TODO: add synonyms
