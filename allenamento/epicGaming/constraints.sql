begin transaction;

-- 1. Vincoli di Integrità Referenziale (Chiavi Esterne)
alter table partita
  add foreign key (id_giocatore) references giocatore(id_giocatore) deferrable;

alter table partita
  add foreign key (id_gioco) references videogioco(id_gioco) deferrable;


-- 2. Vincolo Procedurale tramite Trigger: Validazione della sessione di gioco
create function V_Partita_Durata_Minima() returns trigger as $V_Partita_Durata_Minima$
begin
  if new.durata_minuti <= 0 then
    raise exception 'Errore nell''inserimento della partita %: la durata deve essere superiore a 0 minuti.', new.id_partita;
  end if;
  return new;
end;
$V_Partita_Durata_Minima$ language plpgsql;

create trigger Partita_Durata_Minima
before insert or update on partita
for each row execute procedure V_Partita_Durata_Minima();

commit;
