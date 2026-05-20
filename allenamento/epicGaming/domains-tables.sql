begin transaction;

-- Creazione dei domini e dei tipi ENUM
create type GenereGioco as 
  enum('FPS', 'Sport', 'RPG', 'Strategia', 'Altro');

create domain PosInteger as integer check (value >= 0);
create domain StringaM as varchar(100);
create domain Soldi as real check (value >= 0);

-- Creazione dello schema relazionale grezzo
create table giocatore (
  id_giocatore PosInteger not null,
  username varchar(30) not null,
  nazione StringaM not null,
  primary key (id_giocatore),
  unique (username)
);

create table videogioco (
  id_gioco PosInteger not null,
  titolo StringaM not null,
  genere GenereGioco not null,
  costo_euro Soldi not null,
  primary key (id_gioco)
);

create table partita (
  id_partita PosInteger not null,
  id_giocatore PosInteger not null,
  id_gioco PosInteger not null,
  punteggio PosInteger not null,
  durata_minuti PosInteger not null,
  primary key (id_partita)
);

commit;
