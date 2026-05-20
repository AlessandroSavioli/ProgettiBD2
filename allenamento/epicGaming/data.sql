begin transaction;

-- Rinvio dei vincoli per permettere inserimenti massivi senza errori di ordinamento
set constraints all deferred;

-- Popolamento tabella giocatore
insert into giocatore (id_giocatore, username, nazione) values
('1', 'AlphaGamer',   'Italy'),
('2', 'ShadowNinja',  'Italy'),
('3', 'CyberPunk99',  'France'),
('4', 'Kraken_US',    'United States'),
('5', 'SushiMaster',  'Japan');

-- Popolamento tabella videogioco
insert into videogioco (id_gioco, titolo, genere, costo_euro) values
('10', 'Call of Duty',   'FPS',   '69.99'),
('20', 'Fifa 26',        'Sport', '79.99'),
('30', 'Elden Ring',     'RPG',   '59.99'),
('40', 'Cyberpunk 2077', 'RPG',   '49.99');

-- Popolamento tabella partita
insert into partita (id_partita, id_giocatore, id_gioco, punteggio, durata_minuti) values
('0', '1', '10', '1500', '45'),
('1', '1', '30', '2500', '120'),
('2', '2', '30', '1800', '90'),
('3', '3', '40', '3100', '65'),
('4', '4', '20', '500',  '15'),
('5', '5', '10', '1200', '30');

commit;
