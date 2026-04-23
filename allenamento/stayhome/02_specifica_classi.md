## SPECIFICA DELLE CLASSI

- Classe Prenotazione
	[V.Prenotazione.no_inizio_dopo_fine]
		deve essere:
			this.inizio < this.fine

	[V.Prenotazione.no_accettazione_dopo_inizio]
		deve essere:
			this.accettazione < this.inizio

	costo_totale(): Reale >= 0
		pre:
			nessuna
		post:
			Sia a:Alloggio tale che:
				- (a, this):allo_pren

			sia notti = this.fine - this.inizio

			result = notti * a.prezzo_notte

- Classe Alloggio
	[V.Allogio.no_prenotazioni_accavallate]
		per ogni p:Prenotazione tale che (this, p):allo_pren
		non deve esistere p':Prenotazione tale che (this, p'):allo_pren tale che:
			- [p.inizio, p.fine] intersezione [p'.inizio, p'.fine] != insieme vuoto
			- p != p'

- Classe Recensione
	[V.Recensione.no_recensione_prima_fine_prenotazione]
		Sia p:Prenotazione tale che (p, this):pren_rec, allora:
			- p.fine <= this.istante

- Classe RecensioneConRisposta
	[V.RecensioneConRisposta.no_risposta_prima_recensione]
		per ogni oggetto this, deve essere:
			this.istante_risp >= this.istante
	
	
