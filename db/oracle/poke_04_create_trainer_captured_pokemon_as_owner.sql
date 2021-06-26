drop table trainer_captured_pokemon;

create table trainer_captured_pokemon
( trainer_id number
, pokemon_id number
, captured_timestamp timestamp
, constraint tcp_fk1 foreign key (trainer_id) references trainer(trainer_id)
, constraint tcp_fk2 foreign key (pokemon_id) references pokemon(pokemon_id)
);

-- poke_reader

grant read on poke_owner.trainer_captured_pokemon to poke_reader;

-- poke_api

grant select, insert, update, delete on poke_owner.trainer_captured_pokemon to poke_api;

-- TODO: add synonyms
