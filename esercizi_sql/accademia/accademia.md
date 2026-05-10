<style>
    /* Cambia il font di tutto il testo normale */
    body {
        font-family: "Fira Mono", monospace;
        font-size: 16px;
    }

    /* Cambia il font dei titoli principali */
    h1, h2 {
        font-family: "Fira Mono", monospace;
    }

    h1 {
        text-align: center;      /* Centra il testo nella pagina */
        font-size: 36px;         /* Lo rende molto grande */
        font-weight: bold;       /* Lo mette in grassetto */
        margin-top: 40px;        /* Aggiunge spazio sopra */
        margin-bottom: 40px;     /* Aggiunge spazio sotto */
    }

    h2 {
        font-size: 22px;
        border-bottom: 1px solid #cccccc;
        font-weight: bold;      
        padding-bottom: 5px;
    }

    h3 {
        font-size: 18px;
        font-weight: bold;
        padding-bottom: 5px;
    }

    /* Cambia il font dentro i blocchi di codice SQL */
    code {
        font-family: "Fira Mono", monospace;
        font-size: 15px;
    }
</style>


# DATABASE ACCADEMIA

## Schema ER
![Diagramma ER del database](accademia.png)

<div style="page-break-after: always;"></div>

## Codice SQL
```sql
DROP DATABASE IF EXISTS accademia;

CREATE DATABASE accademia;

\c accademia;

CREATE TYPE strutturato AS enum (
    'Ricercatore', 
    'Professore Associato', 
    'Professore Ordinario'
);

CREATE TYPE lavoro_progetto AS enum (
    'Ricerca e Sviluppo', 
    'Dimostrazione', 
    'Management', 
    'Altro'
);

CREATE TYPE lavoro_non_progettuale as enum (
    'Didattica', 
    'Ricerca', 
    'Missione', 
    'Incontro Dipartimentale', 
    'Incontro Accademico', 
    'Altro'
);

CREATE TYPE causa_assenza AS enum (
    'Chiusura Universitaria', 
    'Maternita', 
    'Malattia'
);

CREATE DOMAIN pos_integer AS INTEGER 
    CHECK (VALUE >= 0);

CREATE DOMAIN stringa_m AS VARCHAR(100);

CREATE DOMAIN numero_ore AS INTEGER
    CHECK (VALUE >= 0 AND VALUE <= 8);

CREATE DOMAIN denaro AS REAL 
    CHECK (VALUE >= 0);






CREATE TABLE persona (
    id pos_integer NOT NULL,
    nome stringa_m NOT NULL,
    cognome stringa_m NOT NULL,
    posizione strutturato NOT NULL,
    stipendio denaro NOT NULL,

    PRIMARY KEY (id)
);

CREATE TABLE progetto (
    id pos_integer NOT NULL,
    nome stringa_m NOT NULL,
    inizio date NOT NULL,
    fine date NOT NULL,
    budget denaro NOT NULL,

    PRIMARY KEY (id),
    UNIQUE (nome),
    CHECK (fine > inizio)
);

CREATE TABLE wp (
    progetto pos_integer NOT NULL,
    id pos_integer NOT NULL,
    nome stringa_m NOT NULL,
    inizio date NOT NULL,
    fine date NOT NULL,

    PRIMARY KEY (progetto, id),
    UNIQUE (progetto, nome),
    FOREIGN KEY (progetto) REFERENCES progetto(id),
    CHECK (fine > inizio)
);

CREATE TABLE attivita_progetto (
    id pos_integer NOT NULL,
    persona pos_integer NOT NULL,
    progetto pos_integer NOT NULL,
    wp pos_integer NOT NULL,
    giorno date NOT NULL,
    tipo lavoro_progetto NOT NULL,
    oreDurata numero_ore NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (persona) REFERENCES persona(id),
    FOREIGN KEY (progetto, wp) REFERENCES wp(progetto, id)
);







CREATE TABLE attivita_non_progettuale (
    id pos_integer NOT NULL,
    persona pos_integer NOT NULL,
    tipo lavoro_non_progettuale NOT NULL,
    giorno date NOT NULL,
    ore_durata numero_ore NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (persona) REFERENCES persona(id)
);

CREATE TABLE assenza (
    id pos_integer NOT NULL,
    persona pos_integer NOT NULL,
    tipo causa_assenza NOT NULL,
    giorno date NOT NULL,

    PRIMARY KEY (id),
    UNIQUE (persona, giorno),
    FOREIGN KEY (persona) REFERENCES persona(id)
);
```

<div style="page-break-after: always;"></div>

## Query SQL

### Query su tabella singola

1. Quali sono i cognomi distinti di tutti gli strutturati?
```sql
SELECT DISTINCT cognome
FROM Persona
```

2. Quali sono i Ricercatori (con nome e cognome)?
```sql
SELECT id, nome, cognome
FROM Persona
WHERE posizione = 'Ricercatore'
```

3. Quali sono i Professori Associati il cui cognome comincia con la lettera ‘V’?
```sql
SELECT id, nome, cognome
FROM Persona
WHERE posizione = 'Professore Associato' AND cognome LIKE 'V%'
```

4. Quali sono i Professori (sia Associati che Ordinari) il cui cognome comincia con la lettera ‘V’?
```sql
SELECT id, nome, cognome
FROM Persona
WHERE (posizione = 'Professore Associato' OR 
       posizione = 'Professore Ordinario') AND cognome LIKE 'V%'
```	

5. Quali sono i Progetti già terminati alla data odierna?
```sql
SELECT *
FROM Progetto
WHERE fine <= CURRENT_DATE
```

<div style="page-break-after: always;"></div>

6. Quali sono i nomi di tutti i Progetti ordinati in ordine crescente di data di inizio?
```sql
SELECT id, nome
FROM Progetto
ORDER BY inizio ASC
```

7. Quali sono i nomi dei WP ordinati in ordine crescente (per nome)?
```sql
SELECT nome
FROM WP
ORDER BY nome asc
```

8. Quali sono (distinte) le cause di assenza di tutti gli strutturati?
```sql
SELECT DISTINCT tipo
FROM Assenza
```

9. Quali sono (distinte) le tipologie di attività di progetto di tutti gli strutturati?
```sql
SELECT DISTINCT tipo
FROM AttivitaProgetto
```
10. Quali sono i giorni distinti nei quali del personale ha effettuato attività non progettuali di tipo ‘Didattica’ ? Dare il risultato in ordine crescente.
```sql
SELECT DISTINCT giorno
FROM AttivitaNonProgettuale
WHERE tipo = 'Didattica'
ORDER BY giorno ASC
```

<div style="page-break-after: always;"></div>

### Query su tabelle multiple

1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’ ?
```sql
SELECT WP.nome, WP.inizio, WP.fine
FROM WP, Progetto
WHERE Progetto.nome = 'Pegasus' AND ( WP.progetto = Progetto.id )
```

2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome, Persona.posizione
FROM Persona, AttivitaProgetto, Progetto
WHERE (AttivitaProgetto.persona = Persona.id) AND 
      (AttivitaProgetto.progetto = Progetto.id) AND
      (Progetto.nome = 'Pegasus')
ORDER BY Persona.cognome DESC
```

3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di una attività nel progetto ‘Pegasus’ ?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome, Persona.posizione
FROM Persona, AttivitaProgetto AS ap1, 
     AttivitaProgetto AS ap2, Progetto
WHERE (ap1.id <> ap2.id) AND (Progetto.nome = 'Pegasus') AND 
      (Progetto.id = ap1.progetto AND Progetto.id = ap2.progetto) AND
      (Persona.id = ap1.persona AND Persona.id = ap2.persona)	
```

4. Quali sono il nome e il cognome dei Professori Ordinari che hanno fatto almeno una assenza per malattia?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome
FROM Persona, Assenza
WHERE Persona.posizione = 'Professore Ordinario' AND
      Assenza.tipo = 'Malattia' AND
      Assenza.persona = Persona.id
```

<div style="page-break-after: always;"></div>

5. Quali sono il nome e il cognome dei Professori Ordinari che hanno fatto più di una assenza per malattia?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome
FROM Persona, Assenza AS ass1, Assenza AS ass2
WHERE ass1.id <> ass2.id AND
      Persona.posizione = 'Professore Ordinario' AND
      (ass1.tipo = 'Malattia' AND ass2.tipo = 'Malattia') AND
      (ass1.persona = Persona.id AND ass2.persona = Persona.id)
```

6. Quali sono il nome e il cognome dei Ricercatori che hanno almeno un impegno per didattica?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome
FROM Persona, AttivitaNonProgettuale AS anp
WHERE Persona.posizione = 'Ricercatore' AND
      anp.tipo = 'Didattica' AND
      anp.persona = Persona.id
```

7. Quali sono il nome e il cognome dei Ricercatori che hanno più di un impegno per didattica?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome
FROM Persona, AttivitaNonProgettuale AS anp1,
     AttivitaNonProgettuale AS anp2
WHERE Persona.posizione = 'Ricercatore' AND
      anp1.id <> anp2.id AND
      anp1.tipo = 'Didattica' AND anp2.tipo = 'Didattica' AND
      anp1.persona = Persona.id AND anp2.persona = Persona.id
```

8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome
FROM Persona, AttivitaProgetto AS ap, AttivitaNonProgettuale AS anp
WHERE ap.giorno = anp.giorno AND
      persona.id = ap.persona AND
      persona.id = anp.persona
```

<div style="page-break-after: always;"></div>

9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di entrambe le attività.
```sql
SELECT DISTINCT Persona.nome, Persona.cognome, ap.giorno,
                Progetto.nome, ap.oreDurata, anp.tipo, anp.oreDurata 
FROM Persona, AttivitaProgetto AS ap, 
     AttivitaNonProgettuale AS anp, Progetto
WHERE ap.giorno = anp.giorno AND
      persona.id = ap.persona AND
      persona.id = anp.persona AND 
      Progetto.id = ap.progetto
```

10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?
```sql
SELECT DISTINCT Persona.nome, Persona.cognome
FROM Persona, Assenza, AttivitaProgetto AS ap
WHERE Assenza.giorno = ap.giorno AND 
      Assenza.persona = Persona.id AND
      ap.persona = Persona.id
```

11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, la causa di assenza e la durata in ore della attività progettuale.
```sql
SELECT Persona.nome, Persona.cognome, 
       Assenza.giorno, Assenza.tipo, 
       Progetto.nome, ap.oreDurata
FROM Persona, Assenza, AttivitaProgetto AS ap, Progetto
WHERE Assenza.giorno = ap.giorno AND
      Assenza.persona = Persona.id AND
      ap.persona = Persona.id AND
      ap.progetto = Progetto.id
```	

<div style="page-break-after: always;"></div>

12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?
```sql
SELECT DISTINCT wp1.nome 
FROM WP AS wp1, WP AS wp2
WHERE wp1.nome = wp2.nome AND
      wp1.progetto <> wp2.progetto
```