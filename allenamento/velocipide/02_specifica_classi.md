## SPECIFICA DELLE CLASSI

- Classe Noleggio 
	[V.Noleggio.no_fine_prima_inizio]
		Sia termine:(this, s:Stazione):fine, allora:
			- non può mai essere termine.orario <= this.inizio

	costo(tariffa: Reale > 0): Reale >= 0
		pre:
			deve esistere un link del tipo (this, s:Stazione):fine
		post:
			sia termine:(this, s:Stazione):fine, allora:
				- minuti = (termine.orario - this.inizio)/60 

			result = minuti * (tariffa/60)

- Classe Stazione
	[V.Stazione.no_oltre_capacità_massima]
		sia B l'insieme degli oggetti b:Bicicletta tale che:
			- (b, this):bic_staz

		non deve mai essere che:
			- |B| > capacità_massima
			
	spazio_rimanente(): Intero >= 0
		pre:
			nessuna
		post:
			sia B l'insieme degli oggetti b:Bicicletta tale che:
				- (b, this):bic_staz

			result = this.capacità_massima - |B|
					
