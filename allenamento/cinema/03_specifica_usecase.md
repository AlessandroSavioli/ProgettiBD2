## DIAGRAMMA DEGLI USE-CASE
![Diagramma Use-Case cinema](cinema_uc.jpg)

## SPECIFICA DEGLI USE-CASE

### Use-Case Strumenti Vendita Biglietti

```text
vendi_biglietto(
	c: Cliente,
	cod: Intero > 0,
	p: Proiezione,
): Biglietto

	pre:
		non deve esistere b':Biglietto tale che b'.codice = cod

		p.posti_disp() deve essere >= 1
	post:
		viene creato e restituito un nuovo oggetto result:Biglietto tale che:
			- result.codice = cod

		vengono creati i seguenti link:
			- (c, result):clien_bigl
			- (p, result):proi_bigl
```
			
