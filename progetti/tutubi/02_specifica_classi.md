## SPECIFICA DELLE CLASSI

### Classe Utente

```text
	[V.Utente.no_valutazione_video_proprio]
		Sia v:Video tale che (this, v):ute_vid, allora:
			- non può esistere il link (this,v):valutazione.

	[V.Utente.valutazione_solo_se_visualizzato]
		Sia v:Video tale che esiste il link (this, v):Valutazione, allora:
			deve esistere almeno un oggetto vis:Visualizzazione tale che:
				- (this, vis):ute_vis
				- (vis, v):vid_vis

	[V.Utente.no_valutazione_video_censurato]
		Sia v:Video di classe più specifica VideoCensurato, allora:
			- non può esistere un link (this, v):valutazione.istante >=  v.istante_censura

	[V.Utente.valutazione_video_pubblicato]
		Sia v:Video tale che (this, v):valutazione, deve essere:
			- (this, v):valutazione.istante >= v.pubblicazione

	[V.Utente.valutazione_dopo_registrazione]
		Per ogni v:Video tale che (this, v):valutazione, deve essere:
			- this.iscrizione <= (this,v):valutazione.istante

	[V.Utente.visualizzazione_dopo_registrazione]
		Per ogni vis:Visualizzazione tale che (this, vis):ute_vis, deve essere:
			- this.iscrizione <= vis.istante
```

### Classe Visualizzazione

```text
	[V.Visualizzazione.dopo_pubblicazione_video]
		Sia v:Video tale che (v, this):vid_vis, deve essere:
			- v.pubblicazione <= this.istante

	[V.Visualizzazione.no_video_censurato]
		Sia v:Video di classe più specifica VideoCensurato, allora
			per ogni link (v, this):vid_vis deve valere:
				- this.istante < v.istante_censura

```

### Classe Commento

```text
	[V.Commento.dopo_visualizzazione]
		sia vis:Visualizzazione tale che (this, vis):comm_vis, deve essere:
			- this.istante >= vis.istante

	[V.Commento.non_dopo_censura]
		siano vis:Visualizzazione e vid:Video tali che:
			- (this, vis):comm_vis
			- (vid, vis):vid_vis

		se vid è di classe più specifica VideoCensurato, deve essere:
			- this.istante < vid.istante_censura
```

### Classe Playlist

```text
	[V.Playlist.no_video_censurati]
		sia v:Video di classe più specifica VideoCensurato, allora:
			- non può esistere il link (this, v):play_vid

	[V.Playlist.utente_iscritto]
		sia u:Utente tale che (this, u):play_ute, deve essere:
			- this.creazione >= u.iscrizione
```

### Classe Video

```text
	[V.Video.no_risposta_video_caricato_stesso_utente]
		per ogni v1:Video e v2:Video tali che
			(v1:risposta_a, v2:risposta):risposte

		Siano u1:Utente ed u2:Utente tali che:
			- (u1, v1):ute_vid
			- (u2, v2):ute_vid	

		allora deve essere u1 != u2
			
	[V.Video.no_risposta_se_stesso]
		per ogni v1:Video e v2:Video tali che 
			(v1:risposta_a, v2:risposta):risposte, allora:
				- v1 != v2
				
	[V.Video.risposte_non_simmetriche]
		per ogni v1:Video, v2:Video:
			se esiste il link (v1:risposta_a, v2:risposta):risposte, allora
			non deve esiste il link (v2:risposta_a, v1:risposta)
			
	[V.Video.no_cicli_risposta]
		le risposte non devono formare cicli  

	visualizzazioni(): Intero >= 0
		pre: 
			nessuna
		post:
			Sia V l'insieme di oggetti vis:Visualizzazione tale che:
				- (this, vis):vid_vis

			result = numero di elementi in V

	conta_risposte(): Intero >= 0
		pre:
			nessuna
		post:
			sia RISP l'insieme degli oggetti vid:Video tali che:
				- (this:risposta_a, vid:risposta):risposte

			result = il numero degli elementi in RISP

	valutazione_media(): Reale 0..5 
		pre:
			nessuna
		post:
			sia VAL l'insieme degli oggetti val:(u:Utente, this):valutazione

			se |VAL| > 0: 
				sia m = Sommatoria del val.valore per ogni elemento val in VAL / |VAL|
				result = m
			altrimenti:
				result = 0

	ha_valutazione(): Booleano
		pre:
			nessuna
		post:
			sia VAL l'insieme degli oggetti val:(u:Utente, this):valutazione

			se |VAL| = 0:
				result = false
			altrimenti: 
				result = true
```

### Classe VideoCensurato

```text
	[V.VideoCensurato.dopo_pubblicazione]
		deve essere:
			- this.pubblicazione <= this.istante_censura
```
