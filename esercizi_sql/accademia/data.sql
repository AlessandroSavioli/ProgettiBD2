begin transaction;

set constraints all deferred;


INSERT INTO Persona(id, nome, cognome, posizione, stipendio)
VALUES
('0',	'Anna',		'Bianchi', 		'Ricercatore', 			'45500.30'),
('1',	'Mario',	'Rossi', 		'Ricercatore', 			'35500.00'),
('2',	'Barbara',	'Burso', 		'Ricercatore', 			'40442.50'),
('3',	'Gino',		'Spada', 		'Ricercatore', 			'35870.90'),
('4',	'Aurora',	'Bianchi', 		'Professore Associato', '43500.50'),
('5',	'Guido',	'Spensierato', 	'Professore Associato', '38221.00'),
('6',	'Consolata','Ferrari',	 	'Professore Associato', '29200.10'),
('7',	'Andrea',	'Verona', 		'Professore Associato', '39002.05'),
('8',	'Asia',		'Giordano', 	'Professore Ordinario', '45200.10'),
('9', 	'Carlo',	'Zante', 		'Professore Ordinario', '40230.00'),
('10', 	'Ginevra',	'Riva', 		'Professore Ordinario', '39955.00'),
('11', 	'Davide',	'Quadro', 		'Professore Ordinario', '36922.10'),
('12', 	'Dario',	'Basile', 		'Ricercatore', 			'42566.00'),
('13', 	'Silvia',	'Donati', 		'Professore Ordinario', '38005.00'),
('14', 	'Fiorella', 'Martino', 		'Professore Associato', '35544.50'),
('15', 	'Leonardo', 'Vitali', 		'Professore Ordinario', '38779.80'),
('16', 	'Paolo',	'Valentini', 	'Professore Associato', '39200.00'),
('17', 	'Emilio',	'Greco', 		'Professore Associato', '42020.00'),
('18', 	'Giulia',	'Costa', 		'Ricercatore', 			'40220.00'),
('19', 	'Elisa',	'Longo', 		'Professore Associato', '39001.00'),
('20', 	'Carla',	'Martinelli', 	'Ricercatore', 			'42030.20');


INSERT INTO Progetto(id, nome, inizio, fine, budget) VALUES
('0',	'Artemide',		'2000-01-01',	'2002-12-31',	'255000'),
('1',	'Pegasus',		'2012-01-01',	'2014-12-31',	'330000'),
('2',	'WineSharing',	'1999-01-01',	'2003-12-31',	'998000'),
('3',	'Simap',		'2010-02-01',	'2014-03-17',	'158000'),
('4',	'DropDiscovery','2010-09-13',	'2013-01-20',	'99000');


INSERT INTO WP(progetto, id, nome, inizio, fine) VALUES
('0',	'0',	'WP1',				'2000-01-01',	'2000-12-31'),
('0',	'1',	'WP2',				'2001-01-01',	'2001-12-31'),
('0',	'2',	'WP3',				'2002-01-01',	'2002-12-31'),
('1',	'0',	'WP1',				'2012-01-01',	'2012-12-31'),
('1',	'1',	'WP2',				'2012-01-01',	'2012-12-31'),
('1',	'2',	'WP3',				'2013-01-01',	'2013-12-31'),
('2',	'1',	'Main Activity',	'1999-01-01',	'2003-12-31'),
('3',	'0',	'State of the Art',	'2012-01-01',	'2012-12-31'),
('3',	'1',	'Main Research',	'2013-01-01',	'2013-12-31'),
('3',	'2',	'Dissemination',	'2014-01-01',	'2014-03-17');


INSERT INTO AttivitaProgetto(id, persona, progetto, wp, giorno, tipo, oreDurata)
VALUES
('0',	'0',	'1',	'0',	'2012-04-15',	'Ricerca e Sviluppo',	'8'),
('1',	'0',	'1',	'0',	'2012-04-16',	'Ricerca e Sviluppo',	'8'),
('2',	'0',	'1',	'0',	'2012-04-17',	'Ricerca e Sviluppo',	'8'),
('3',	'0',	'1',	'0',	'2012-04-18',	'Ricerca e Sviluppo',	'8'),
('4',	'8',	'1',	'2',	'2013-03-15',	'Dimostrazione',		'8'),
('5',	'10',	'1',	'0',	'2012-06-03',	'Ricerca e Sviluppo',	'8'),
('6',	'2',	'1',	'1',	'2012-04-22',	'Dimostrazione',		'7'),
('7',	'4',	'3',	'1',	'2013-01-19',	'Management',			'6'),
('8',	'11',	'3',	'2',	'2014-02-15',	'Altro',				'5'),
('9',	'0',	'3',	'2',	'2014-03-08',	'Ricerca e Sviluppo',	'6'),
('10',	'4',	'2',	'1',	'2000-01-19',	'Management',			'2');

INSERT INTO AttivitaNonProgettuale(id, persona, tipo, giorno, oreDurata) 
VALUES
('0',	'8',	'Incontro Dipartimentale',	'2011-06-01',	'4'),
('1',	'8',	'Didattica',				'2011-03-15',	'8'),
('2',	'8',	'Incontro Dipartimentale',	'2011-06-15',	'4'),
('3',	'2',	'Didattica',				'2014-04-01',	'4'),
('4',	'2',	'Didattica',				'2014-04-03',	'4'),
('5',	'1',	'Didattica',				'2014-04-03',	'8'),
('6',	'4',	'Incontro Accademico',		'2012-11-25',	'7'),
('7',	'7',	'Missione',					'2013-07-07',	'3'),
('8',	'5',	'Altro',					'2012-12-15',	'6'),
('9',	'0',	'Didattica',				'2012-04-18',	'4'),
('10',	'6',	'Didattica',				'2011-05-07',	'7');


INSERT INTO Assenza(id, persona, tipo, giorno) VALUES
('0',	'10',	'Malattia',				'2011-06-01'),
('1',	'10',	'Malattia',				'2011-06-02'),
('2',	'10',	'Malattia',				'2011-06-03'),
('3',	'10',	'Maternita',			'2011-06-04'),
('4',	'8',	'Malattia',				'2011-07-02'),
('5',	'19',	'Chiusura Universitaria','2013-06-29'),
('6',	'7',	'Malattia',				'2012-12-07'),
('7',	'0',	'Maternita',			'2013-10-27'),
('8',	'17',	'Chiusura Universitaria','2011-08-15'),
('9',	'15',	'Maternita',			'2010-12-12'),
('10',  '0',	'Malattia', 			'2012-04-18');


commit;