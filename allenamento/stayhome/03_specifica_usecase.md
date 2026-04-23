## DIAGRAMMA DEGLI USE-CASE
![Diagramma Use-Case stayhome](stayhome_uc.jpg)

## SPECIFICA DEGLI USE-CASE

- Use-Case Strumenti di ricerca

	ricerca_classica(): Alloggio[0..*]
		pre:
			nessuna
		post:
			sia ALLO l'insieme degli oggetti a:Alloggio tali che
			non esiste p:Prenotazione tale che:
				- (a, p):allo_pren
				- [p.inizio, p.fine] intersezione oggi != insieme vuoto

			result = ALLO

	ricerca_premium(): Alloggio[0..*]
		pre:
			nessuna
		post:
			sia ALLOPREM l'insieme degli oggetti a:AlloggioVerificato tali che
			non esiste p:Prenotazione tale che:
				- (a, p):allo_pren
				- [p.inizio, p.fine] intersezione oggi != insieme vuoto

- Use-Case Registrazione/Login

	nuovo_utente(n:Stringa, e:Stringa, d:NumDoc): Utente
		pre:
			non deve esistere u':Utente tale che:
				- u'.email = e
		post:
			viene creato e restituito un nuovo oggetto result:Utente tale che:
				- result.nome = n
				- result.email = e
				- result.documento = d
				
- Use-Case Strumenti prenotazioni

	prenota(a:Alloggio, i:Data, f:Data): Prenotazione
		pre:
			non deve esistere p':Prenotazione tale che:
				- (a, p'):allo_pren
				- [p'.inizio, p'.fine] intersezione [i, f] != insieme vuoto

			sia u:Guest l'istanza dell'attore che ha invocato lo use-case
			non deve esistere il link (a, u):allo_host
		post:
			viene creato e restituito un nuovo oggetto result:Prenotazione tale che:
				- result.inizio = i
				- result.fine = f
				- result.accettazione = adesso

			vengono creati i seguenti link:
				- (u, result):gues_pren
				- (a, result):allo_pren

	crea_recensione(p:Prenotazione, v:Intero 0..5, c:Stringa): Recensione
		pre:
			sia u:Guest l'istanza dell'attore che ha invocato lo use-case
			deve esistere il link (u, p):gues_pren

			p.fine <= oggi
		post:
			viene creato e restituito l'oggetto result:Recensione tale che:
				- result.voto = v
				- result.commento = c
				- result.istante = adesso

			vengono creati i seguenti link
				- (p, result):pren_rec

- Use-Case Strumenti alloggi

	nuovo_alloggio(t: Stringa, i:Indirizzo, p:Reale >= 0, v:Valuta): Alloggio
		pre:
			nessuna
		post:
			sia u:Host l'istanza dell'utente che ha invocato lo use-case

			viene creato e restituito l'oggetto result:Alloggio tale che:
				- result.titolo = t
				- result.indirizzo = i
				- result.prezzo_notte = p

			vengono creati i seguenti link:
				- (result, u):allo_host	
				- (result, v):allo_val

	rispondi_a_recensione(r:Recensione, risp:Stringa): RecensioneConRisposta
		pre: 
			sia u:Host l'istanza dell'utente che ha invocato lo use-case

			sia ALLO l'insieme degli oggetti a:Alloggio tali che:
				- (a, u):allo_host

			sia PREN l'insieme degli oggetti p:Prenotazioni tali che:
				- (a, p):allo_pren per un qualsiasi a in ALLO

			sia REC l'insieme degli oggetti r':Recensione tali che:
				- (p, r'):pren_rec per un qualsiasi p in PREN

			r deve essere in REC
		post:
			r viene reso di classe più specifica RecensioneConRisposta con:
				- r.risposta = risp
				- r.istante_risp = adesso
			e viene restituito

- Use-Case Strumenti verifica

	verifica_alloggio(a:Alloggio): AlloggioVerificato
		pre:
			a non deve già essere di classe più specifica AlloggioVerificato
		post:
			a viene reso di classe più specifica AlloggioVerificato con:
				- a.verifica = adesso
