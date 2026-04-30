## SPECIFICA DELLE CLASSI

Classe Pilota
	[V.Pilota.no_missioni_contemporanee]
		!EXISTS m1, i1, f1, m2, i2, f2
		m1 != m2 and 
		inizio(m1, i1) and
		fine(m1, f1) and
		inizio(m2, i2) and 
		fine(m2, f2) and
		miss_pilo(m1, this) and
		miss_pilo(m2, this) and
		( (i1 <= i2 and i2  <= f1) or
		(i2 <= i1 and i1  <= f2) ) 

	[V.Pilota.no_missioni_con_drone_non_autorizzato]
		!EXISTS p, m, d, pmax
		patente(this, p) and
		miss_pilo(this, m) and
		dro_miss(d, m) and
		peso_max_kg(d, pmax) and
		(p = A1 and pmax > 4) or
		(p = A2 and pmax > 25)

	ore_volo_mensili(): Intero >= 0
		pre:
			nessuna
		post:
			M = {m | EXISTS i, f, di, df
						miss_pilo(m, this) and 
						inizio(m, i) and
						fine(m, f) and
						Data(i, di) and
						Data(f, df) and
						( di <= oggi and df >= oggi−30 )
						}
			result soddisfa la seguente formula:
			result = NON LO POSSIAMO SCRIVERE PERCHE' E' VERAMENTE DIFFICILE
				
	
Classe Missione

	[V.Missione.no_inizio_dopo_fine]
		!EXISTS i, f
		inizio(this, i) and
		fine(this, f) and
		i >= f

Classe Drone

	autonomia_residua(dist: Reale > 0): Booleano
		pre:
			nessuna
		post:
		result soddisfa la seguente formula:
			EXISTS batt |
				livello_batteria(this, batt) and
				result = (batt - 10)/dist >= 1
				
			
			
			
