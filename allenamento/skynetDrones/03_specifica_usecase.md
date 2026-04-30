## DIAGRAMMA DEGLI USE-CASE
![Diagramma Use-Case skynetDrones](skynetDrones_uc.jpg)

## SPECIFICA DEGLI USE-CASE

Use-Case Gestione missioni

	nuova_missione(p:Pilota, d:Drone, a:AreaDiIntervento, in:DataOra
					fi:DataOra, ore:1..24): Missione
		pre:
			EXISTS stato |
			stato_operativo(d, stato) and
			stato = disponibile and
			!EXISTS m2, i2, f2, pat, pesomax| 
			miss_pilo(m2, p) and
			inizio(m2, i2) and
			fine(m2, f2) and
			in <= f2 and fi >= i2 and
			patente(p, pat) and
			peso_max_kg(d, pesomax) and
			( (pesomax > 4 and pat = A1) or
			(pesomax > 25 and pat = A2) ) 
			
		post:
			il livello estensionale finale differisce da quello iniziale nel
			seguente modo:
				- nuovi elementi nel dominio: alpha
				- elementi eliminati dal dominio: nessuno
				- nuove ennuple:
					1. Missione(alpha)
					2. inizio(alpha, in)
					3. fine(alpha, fi)
					4. ore_di_volo_giornaliere(alpha, ore)
					5. miss_pilo(alpha, p)
					6. dro_miss(d, alpha)
					7. area_miss(a, alpha)
					8. stato_operativo(d, in uso)
				- ennuple rimosse:
					1. stato_operativo(d, disponibile)
				- valore di ritorno: alpha

	cancella_missione(m:Missione): 
		pre: 
			!EXISTS i |
			inizio(m, i) and
			i <= adesso
		post:
			EXISTS i, f, ore, p, d, a |
				inizio(m, i) and
				fine(m, f) and
				ore_volo_giornaliere(m, ore) and
				miss_pilo(m, p) and
				dro_miss(d, m) and
				area_miss(a, m)
					
			il livello estensionale differisce da quello iniziale come segue:
				- nuovi elementi nel dominio: nessuno
				- elementi eliminati dal dominio: m
				- nuove ennuple:
					1. stato_operativo(d, disponibile)
				- ennuple rimosse:
					1. missione(m)
					2. inizio(m, i)
					3. fine(m, f)
					4. ore_volo_giornaliere(m, ore)
					5. miss_pilo(m, p)
					6. dro_miss(d, m)
					7. area_miss(a, m)
					8. stato_operativo(d, in uso)
				- valore di ritorno: nessuno

Use-Case Statistiche

	efficienza_aree_pericolose(): Reale > 0
		pre:
			Mpericolose = {m | EXISTS a, grado |
								area_miss(a, m) and
								grado_rischio(a, grado) and
								grado = alto }

			P5missioniPericolose = {p | EXISTS m1, m2, m3, m4, m5 in Mpericolose |
											m1 != m2 and m1 != m3 and m1 != m4 and
											m1 != m5 and m2 != m3 and m2 != m4 and
											m2 != m5 and m3 != m4 and m3 != m5 and
											m4 != m5 and
											miss_pilo(m1, p) and miss_pilo(m2, p) and
											miss_pilo(m3, p) and miss_pilo(m4, p) and
											miss_pilo(m5, p)}
			|P5missioniPericolose| > 0								
		post:
			Mpericolose = {m | EXISTS a, grado |
								area_miss(a, m) and
								grado_rischio(a, grado) and
								grado = alto }
			
			P5missioniPericolose = {p | EXISTS m1, m2, m3, m4, m5 in Mpericolose |
											m1 != m2 and m1 != m3 and m1 != m4 and
											m1 != m5 and m2 != m3 and m2 != m4 and
											m2 != m5 and m3 != m4 and m3 != m5 and
											m4 != m5 and
											miss_pilo(m1, p) and miss_pilo(m2, p) and
											miss_pilo(m3, p) and miss_pilo(m4, p) and
											miss_pilo(m5, p)}

			non viene modificato il livello estensionale
			result deve soddisfare la seguente formula:
				result = Sommatoria per tutti gli ore_volo(p, valore) con p in 
							P5missioniPericolose di valore / |P5missioniPericolose|
			
			
