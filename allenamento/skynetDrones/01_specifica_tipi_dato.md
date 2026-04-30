---
title: "SKYNETDRONES"
mainfont: "Fira Mono" 
header-includes:
  - \usepackage{float}
  - \floatplacement{figure}{H}
  - \usepackage{titling}
  - \pretitle{\begin{center}\LARGE\bfseries}
  - \posttitle{\end{center}\vspace{-2em}}
  - \preauthor{}
  - \postauthor{}
  - \predate{}
  - \postdate{}
---	

	
## DIAGRAMMA DELLE CLASSI
![Diagramma Classi skynetDrones](skynetDrones.jpg)
	
## SPECIFICA DEI TIPI DI DATO
	
Batteria:
	Intero 0..100

StatoOp:
	{disponibile, in manutenzione, in uso}

Patente:
	{A1, A2, A3}

Coordinate:
	(gradiN: -90 .. 90,
	 primiN: -90 .. 90,
	 secondiN: Reale -90 .. 90,
	 [N],
	 gradiE: -180 .. 180,
	 primiE: -180 .. 180,
	 secondiE: Reale -180 .. 180,
	 [E])  
