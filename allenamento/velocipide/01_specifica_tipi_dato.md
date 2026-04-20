---
title: "VELOCIPIDE"
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
![Diagramma Classi velocipide](velocipide.jpg)
	
## SPECIFICA DEI TIPI DI DATO
	
- CF
[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]

- Indirizzo
(Via: Stringa, Civico: Intero > 0, CAP: [0-9]{5})
