begin transaction;

set constraints all deferred;



INSERT INTO Aeroporto(codice, nome) VALUES
('JFK'	,'JFK Airport'),
('FCO'	,'Aeroporto di Roma Fiumicino'),
('CIA'	,'Aeroporto di Roma Ciampino'),
('CDG'	,'Charles de Gaulle, Aeroport de Paris'),
('HTR'	,'Heathrow Airport, London');


INSERT INTO ArrPart(codice, comp, arrivo, partenza) VALUES
('132',	'MagicFly',		'FCO',	'JFK'),
('263',	'Caimanair',	'FCO',	'CIA'),
('534',	'Apitalia',		'JFK',	'CIA'),
('1265','Apitalia',		'CIA',	'FCO'),
('24',	'Apitalia',		'FCO',	'JFK'),
('133',	'MagicFly',		'CDG',	'HTR'),
('264',	'Caimanair',	'HTR',	'CDG'),
('535',	'Apitalia',		'FCO',	'HTR'),
('134',	'MagicFly',		'JFK',	'FCO'),
('265',	'Caimanair',	'JFK',	'FCO'),
('536',	'Apitalia',		'JFK',	'FCO');


INSERT INTO Compagnia(nome, annofondaz) VALUES
('Caimanair', '1954'),
('Apitalia', '1900'),
('MagicFly', '1990');


INSERT INTO LuogoAeroporto(aeroporto, citta, nazione) VALUES
('JFK',	'New York',	'USA'),
('FCO',	'Roma',		'Italy'),
('CIA',	'Roma',		'Italy'),
('CDG',	'Paris',	'France'),
('HTR',	'London',	'United Kingdom');


INSERT INTO Volo(codice, comp, durataMinuti) VALUES
('132',	'MagicFly',		'600'),
('263',	'Caimanair',	'382'),
('534',	'Apitalia',		'432'),
('1265','Apitalia',		'382'),
('24',	'Apitalia',		'599'),
('133',	'MagicFly',		'60'),
('264',	'Caimanair',	'60'),
('535',	'Apitalia',		'150'),
('134',	'MagicFly',		'600'),
('265',	'Caimanair',	'601'),
('536',	'Apitalia',		'599');


commit;