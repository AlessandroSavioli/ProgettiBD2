## DIAGRAMMA DEGLI USE-CASE
![Diagramma Use-Case velocipide](velocipide_uc.jpg)

## SPECIFICA DEGLI USE-CASE

- Use-Case Strumenti noleggio

	inizia_noleggio(
		b:Bicicletta,
		s:Stazione
	): Noleggio
		pre:
			b.stato deve essere "disponibile"

			deve esistere il link (b, s):bic_staz

			sia u:Utente l'istanza dell'attore che ha invocato lo use-case, allora:
				- u.credito_residuo > 0
				- non deve esistere un link (n:Noleggio, u):nol_ute senza
				  il link (n, s:Stazione):fine				
		post:
			verrà creato e restituito un oggetto result:Noleggio, con
				- result.inizio = adesso
				- b.stato viene modificato in "in uso"

			verranno creat i seguenti link:
				- (result, u):nol_ute
				- (result, s):nol_staz_ritiro
				- (b, result):bic_nol

	fine_noleggio(s:Stazione):
		pre: 
			sia u:Utente l'istanza dell'attore che ha invocato lo use-case	

			deve esistere un link (n:Noleggio, u):nol_ute e,
			non deve esistere il link (n, x:Stazione):fine
	
			deve essere:
				s.spazio_rimanente() > 0		
			
		post:
			viene creato il seguente link:
				- termine:(n, s):fine con termine.orario = adesso

			sia b:Bicicletta per il quale esiste il link:
				- (b, n):bic_nol

			viene modificato b.stato in "disponibile"
				
			viene distrutto il seguente link:
				- (b, x:Stazione):bic_staz

			viene creato il seguente link: 
				- (b, s):bic_staz

			u.credito_residuo = u.credito_residuo - n.costo(tariffa)
				
			
- Use-Case Strumenti riparazione
	imposta_guasto(b:Bicicletta):
		pre:
			b.stato deve essere != "in uso"
		post:
			b.stato = "guasta"

	imposta_disponibile(b:Bicicletta):
		pre:
			b.stato deve essere = "guasta"
		post:
			b.stato = "disponibile"
			
