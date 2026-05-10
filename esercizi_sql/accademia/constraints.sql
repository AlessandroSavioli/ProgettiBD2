begin transaction;

CREATE FUNCTION V_WP_Date_Progetto_Date() RETURNS trigger AS $V_WP_Date_Progetto_Date$
declare
  progettoInizio date;
  progettoFine date;
begin
  select inizio into progettoInizio 
  from Progetto 
  where id = new.progetto;
  if new.inizio < progettoInizio then
    raise exception 'Il progetto comincia il %', progettoInizio;
  end if;
  select fine into progettoFine 
  from Progetto 
  where id = new.progetto;
  if new.fine > progettoFine then
    raise exception 'Il progetto finisce il %', progettoFine;
  end if;
  return new;
end;
$V_WP_Date_Progetto_Date$ language plpgsql;

CREATE TRIGGER WP_dates_within_project_date 
BEFORE INSERT OR UPDATE ON WP 
FOR EACH ROW EXECUTE PROCEDURE V_WP_Date_Progetto_Date();



CREATE FUNCTION V_AttProgetto_Data_WP_Date() RETURNS trigger AS $V_AttProgetto_Data_WP_Date$
declare
  wpInizio date;
  wpFine date;
begin
  select inizio into wpInizio 
  from WP 
  where wp.progetto = new.progetto and wp.id = new.wp;
  if new.giorno < wpInizio then
    raise exception 'Errore nell''inserimento o modifica nella tabella AttivitaProgetto (ennupla con valore per il campo id = %): il valore dell''attributo giorno e'' %, mentre il WP comincia il %', new.id, new.giorno, wpInizio;
  end if;
  select fine into wpFine 
  from WP 
  where wp.progetto = new.progetto and wp.id = new.wp;
  if new.giorno > wpFine then
    raise exception 'Errore nell''inserimento o modifica nella tabella AttivitaProgetto (ennupla con valore per il campo id = %): il valore dell''attributo giorno e'' %, mentre il WP termina il %', new.id, new.giorno, wpFine;
  end if;
  return new;
end;
$V_AttProgetto_Data_WP_Date$ language plpgsql;

CREATE TRIGGER AttProgetto_Data_WP_Date 
BEFORE INSERT OR UPDATE ON AttivitaProgetto 
FOR EACH ROW EXECUTE PROCEDURE V_AttProgetto_Data_WP_Date();

commit;