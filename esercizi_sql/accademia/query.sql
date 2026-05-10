-- QUERY SU TABELLA SINGOLA

--1. Quali sono i cognomi distinti di tutti gli strutturati?

	SELECT DISTINCT cognome
	FROM Persona

--2. Quali sono i Ricercatori (con nome e cognome)?

	SELECT id, nome, cognome
	FROM Persona
	WHERE posizione = 'Ricercatore'

--3. Quali sono i Professori Associati il cui cognome comincia con la lettera ‘V’?

	SELECT id, nome, cognome
	FROM Persona
	WHERE posizione = 'Professore Associato' AND cognome LIKE 'V%'

--4. Quali sono i Professori (sia Associati che Ordinari) il cui cognome comincia con la
--lettera ‘V’?

	SELECT id, nome, cognome
	FROM Persona
	WHERE (posizione = 'Professore Associato' OR posizione = 'Professore Ordinario') AND cognome LIKE 'V%'
	
--5. Quali sono i Progetti già terminati alla data odierna?

	SELECT *
	FROM Progetto
	WHERE fine <= CURRENT_DATE
	
--6. Quali sono i nomi di tutti i Progetti ordinati in ordine crescente di data di inizio?

	SELECT id, nome
	FROM Progetto
	ORDER BY inizio ASC

--7. Quali sono i nomi dei WP ordinati in ordine crescente (per nome)?

	SELECT nome
	FROM WP
	ORDER BY nome asc
	
--8. Quali sono (distinte) le cause di assenza di tutti gli strutturati?

	SELECT DISTINCT tipo
	FROM Assenza
	
--9. Quali sono (distinte) le tipologie di attività di progetto di tutti gli strutturati?

	SELECT DISTINCT tipo
	FROM AttivitaProgetto

--10. Quali sono i giorni distinti nei quali del personale ha effettuato attività non pro-
--gettuali di tipo ‘Didattica’ ? Dare il risultato in ordine crescente.

	SELECT DISTINCT giorno
	FROM AttivitaNonProgettuale
	WHERE tipo = 'Didattica'
	ORDER BY giorno ASC


-- 	QUERY SU TABELLE MULTIPLE

--1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome
--‘Pegasus’ ?

	SELECT WP.nome, WP.inizio, WP.fine
	FROM WP, Progetto
	WHERE Progetto.nome = 'Pegasus' AND ( WP.progetto = Progetto.id )
	
--2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno
--una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?

	SELECT DISTINCT Persona.nome, Persona.cognome, Persona.posizione
	FROM Persona, AttivitaProgetto, Progetto
	WHERE (AttivitaProgetto.persona = Persona.id) AND 
		  (AttivitaProgetto.progetto = Progetto.id) AND
		  (Progetto.nome = 'Pegasus')
 	ORDER BY Persona.cognome DESC
 	
--3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
--una attività nel progetto ‘Pegasus’ ?

	SELECT DISTINCT Persona.nome, Persona.cognome, Persona.posizione
	FROM Persona, AttivitaProgetto AS ap1, AttivitaProgetto AS ap2, Progetto
	WHERE (ap1.id <> ap2.id) AND (Progetto.nome = 'Pegasus') AND 
		  (Progetto.id = ap1.progetto AND Progetto.id = ap2.progetto) AND
		  (Persona.id = ap1.persona AND Persona.id = ap2.persona)	

--4. Quali sono il nome e il cognome dei Professori Ordinari che hanno
--fatto almeno una assenza per malattia?

	SELECT DISTINCT Persona.nome, Persona.cognome
	FROM Persona, Assenza
	WHERE Persona.posizione = 'Professore Ordinario' AND
		  Assenza.tipo = 'Malattia' AND
		  Assenza.persona = Persona.id

--5. Quali sono il nome e il cognome dei Professori Ordinari che hanno
--fatto più di una assenza per malattia?

	SELECT DISTINCT Persona.nome, Persona.cognome
	FROM Persona, Assenza AS ass1, Assenza AS ass2
	WHERE ass1.id <> ass2.id AND
		  Persona.posizione = 'Professore Ordinario' AND
		  (ass1.tipo = 'Malattia' AND ass2.tipo = 'Malattia') AND
		  (ass1.persona = Persona.id AND ass2.persona = Persona.id)

--6. Quali sono il nome e il cognome dei Ricercatori che hanno almeno
--un impegno per didattica?

	SELECT DISTINCT Persona.nome, Persona.cognome
	FROM Persona, AttivitaNonProgettuale AS anp
	WHERE Persona.posizione = 'Ricercatore' AND
		  anp.tipo = 'Didattica' AND
		  anp.persona = Persona.id

--7. Quali sono il nome e il cognome dei Ricercatori che hanno più di un
--impegno per didattica?

	SELECT DISTINCT Persona.nome, Persona.cognome
	FROM Persona, AttivitaNonProgettuale AS anp1, AttivitaNonProgettuale AS anp2
	WHERE Persona.posizione = 'Ricercatore' AND
		  anp1.id <> anp2.id AND
		  anp1.tipo = 'Didattica' AND anp2.tipo = 'Didattica' AND
		  anp1.persona = Persona.id AND anp2.persona = Persona.id

--8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
--attività progettuali che attività non progettuali?

	SELECT DISTINCT Persona.nome, Persona.cognome
	FROM Persona, AttivitaProgetto AS ap, AttivitaNonProgettuale AS anp
	WHERE ap.giorno = anp.giorno AND
		  persona.id = ap.persona AND
		  persona.id = anp.persona

--9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
--attività progettuali che attività non progettuali? Si richiede anche di proiettare il
--giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
--entrambe le attività.

	SELECT DISTINCT Persona.nome, Persona.cognome, ap.giorno,
					Progetto.nome, ap.oreDurata, anp.tipo, anp.oreDurata 
	FROM Persona, AttivitaProgetto AS ap, AttivitaNonProgettuale AS anp,
		 Progetto
	WHERE ap.giorno = anp.giorno AND
		  persona.id = ap.persona AND
		  persona.id = anp.persona AND 
		  Progetto.id = ap.progetto

--10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
--assenti e hanno attività progettuali?

	SELECT DISTINCT Persona.nome, Persona.cognome
	FROM Persona, Assenza, AttivitaProgetto AS ap
	WHERE Assenza.giorno = ap.giorno AND 
		  Assenza.persona = Persona.id AND
		  ap.persona = Persona.id

--11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
--assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
--nome del progetto, la causa di assenza e la durata in ore della attività progettuale.

	SELECT Persona.nome, Persona.cognome, Assenza.giorno, Assenza.tipo, Progetto.nome, ap.oreDurata
	FROM Persona, Assenza, AttivitaProgetto AS ap, Progetto
	WHERE Assenza.giorno = ap.giorno AND
		  Assenza.persona = Persona.id AND
		  ap.persona = Persona.id AND
		  ap.progetto = Progetto.id
	

--12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?

	SELECT DISTINCT wp1.nome 
	FROM WP AS wp1, WP AS wp2
	WHERE wp1.nome = wp2.nome AND
	      wp1.progetto <> wp2.progetto
