## SPECIFICA DELLE CLASSI

### Classe Sala

```text
[V.Sala.mai_proiezioni_simultanee]
	per ogni p:Proiezione p2:Proiezione tale che p != p2 e (this, p):sala_proi e (this, p2):sala_proi:
		gli intervalli [p.inizio, p.fine()] e [p2.inizio, p2.fine()] devono essere disgiunti

[V.Sala.mai_overbooking]
	per ogni p:Proiezione tale che (this, p):sala_proi:
		Sia B l'insieme di oggetti b:Biglietto tali che (p, b):proi_bigl

		il numero di elementi in B deve essere sempre minore o uguale a this.capienza
```

### Classe Proiezione

```text
fine(): DataOra
	pre: 
		nessuna
	post:
		sia f:Film tale che (f, this):film_proi:
		result = this.inizio + f.durata_min

posti_disp(): Intero >= 0
	pre:
		nessuna
	post:
		sia s:Sala tale che (s, this):sala_proi

		sia B l'insieme di oggetti b:biglietto tali che (this, b):proi_bigl

		result = s.capienza - |B|
```

### Classe Persona

```text
età(): Intero >= 0
	pre:
		nessuna
	post:
		result = oggi - this.nascita
```
### Classe Biglietto

```text
prezzo(): Reale >= 0
	pre:
		nessuna
	post:
		sia c:Cliente tale che (c, this):clien_bigl
		sia p:Proiezione tale che (p, this):proi_bigl

		se c è anche di classe più specifica Dipendente:
			result = 0
		se c.età() > 65 o c.età() < 12:
			result = p.prezzo * 0,5
		altrimenti:
			result = p.prezzo
```
		
		
