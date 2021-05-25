-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Mag 24, 2021 alle 23:18
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `MHM`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `impiegato`
--

CREATE TABLE `impiegato` (
  `id` int(6) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `livello` int(1) NOT NULL,
  `direzione` int(2) NOT NULL,
  `username` varchar(13) NOT NULL,
  `password` varchar(60) NOT NULL,
  `gender` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `impiegato`
--

INSERT INTO `impiegato` (`id`, `nome`, `cognome`, `livello`, `direzione`, `username`, `password`, `gender`) VALUES
(1, 'Vincenzo', 'Falsaperla', 5, 1, 'vinc63fa', 'vince.63', 'uomo'),
(2, 'Alice', 'Occhiale', 6, 4, 'albe96oc', 'alber.96', 'donna'),
(3, 'Giuseppe', 'Andolfo', 7, 2, 'gius69an', 'giuse.69', 'uomo'),
(4, 'Salvo', 'Amato', 6, 3, 'salv82am', 'salvo.82', 'privato'),
(5, 'Agata', 'Manno', 5, 5, 'salv78ma', 'salvo.78', 'donna'),
(28, 'Renato', 'Castro', 4, 3, 'rena3cast', '$2y$10$T36Ie5zHL99rEvjG9FsQc.YQUaIrHfJHRlsQXn2dMVB6gKSFbzFDe', 'Uomo'),
(29, 'Armida', 'Mannino', 4, 2, 'armi2mann', '$2y$10$9YRK1zHx.uAcouV.sybjQOuNlCJP7HPoHGgFAiFJgbUFfrX5hoMBy', 'Privato'),
(47, 'Irene', 'Castro', 4, 2, 'iren2cast', '$2y$10$V5uu6V4bg9pE5vGuwG5IfeQSjg8YHjTv/tZycDWooh2o73Yz.DEq6', 'Donna'),
(48, 'Giovanna', 'Raciti', 4, 1, 'giov1raci', '$2y$10$8owiYKD2qFhEjn5SJ1Evn.2VrE6GLxEjDTw7N5kkoYZwBDkuuvLMi', 'Donna');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `lav_cappe`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `lav_cappe` (
`serie` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `lav_forni`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `lav_forni` (
`serie` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `lav_impiantatori`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `lav_impiantatori` (
`serie` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `lav_lithografici`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `lav_lithografici` (
`serie` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `lav_lotto`
--

CREATE TABLE `lav_lotto` (
  `step` varchar(4) NOT NULL,
  `serie` varchar(6) NOT NULL,
  `id_macchinario` varchar(6) NOT NULL,
  `inizio` time(6) DEFAULT NULL,
  `fine` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `lav_lotto`
--

INSERT INTO `lav_lotto` (`step`, `serie`, `id_macchinario`, `inizio`, `fine`) VALUES
('0101', '329384', 'F1', '12:43:06.000000', NULL),
('0101', '438474', 'F3', '08:52:58.000000', '2020-12-18 12:33:58.000000'),
('1221', '948390', 'F3', NULL, '2020-12-18 06:47:06.000000'),
('6543', '948390', 'L7', '13:33:58.000000', NULL),
('8080', '329384', 'C8', '06:31:08.245000', '2020-12-18 07:40:08.811000');

--
-- Trigger `lav_lotto`
--
DELIMITER $$
CREATE TRIGGER `check_lav_lotto` BEFORE INSERT ON `lav_lotto` FOR EACH ROW BEGIN
IF new.serie NOT IN 
(
SELECT serie FROM lotto WHERE flag IS NULL
)
THEN signal Sqlstate '45000' 
SET message_text = 'Lotto bloccato';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `lav_pvd`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `lav_pvd` (
`serie` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `lotto`
--

CREATE TABLE `lotto` (
  `serie` varchar(6) NOT NULL,
  `prodotto` varchar(20) NOT NULL,
  `n_wfs` int(2) NOT NULL DEFAULT 24,
  `flag` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `lotto`
--

INSERT INTO `lotto` (`serie`, `prodotto`, `n_wfs`, `flag`) VALUES
('123456', 'RFSL', 24, NULL),
('2312M1', 'EUIO', 22, '7'),
('328473', 'EUIO', 24, NULL),
('329384', 'RFSL', 24, NULL),
('438474', 'MRGL', 24, NULL),
('454574', 'SSLL', 24, NULL),
('654321', 'EUIO', 24, NULL),
('743495', 'EUIO', 24, NULL),
('948390', 'SSLL', 24, NULL);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `l_rfsl`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `l_rfsl` (
`serie` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `macchinario`
--

CREATE TABLE `macchinario` (
  `id` varchar(6) NOT NULL,
  `commento` varchar(40) NOT NULL,
  `stato` varchar(20) DEFAULT NULL,
  `collocazione` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `macchinario`
--

INSERT INTO `macchinario` (`id`, `commento`, `stato`, `collocazione`) VALUES
('C8', 'stand-by', 'up', 'Cappe'),
('C9', 'stand-by', 'up', 'Cappe'),
('F1', 'produzione', 'up', 'Forni'),
('F2', 'problemi di spessore', 'down', 'Forni'),
('F3', 'produzione', 'up', 'Forni'),
('I4', 'produzione', 'up', 'Impiantatori'),
('I5', 'problemi camera 1', 'down', 'Forni'),
('L6', 'stand-by', 'up', 'Lithografici'),
('L7', 'stand-by', 'up', 'Lithografici'),
('M10', 'problemi di handling', 'down', 'PVD'),
('M11', 'problemi di deposizione', 'down', 'PVD');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `m_cappe`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `m_cappe` (
`ID` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `m_forni`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `m_forni` (
`ID` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `m_impiantatori`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `m_impiantatori` (
`ID` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `m_lithografici`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `m_lithografici` (
`ID` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `m_pvd`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `m_pvd` (
`ID` varchar(6)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `presenza`
--

CREATE TABLE `presenza` (
  `reparto` int(2) NOT NULL,
  `n_operatori` int(2) DEFAULT 52
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `presenza`
--

INSERT INTO `presenza` (`reparto`, `n_operatori`) VALUES
(1, 5),
(2, 6),
(3, 13),
(4, 12),
(5, 8);

-- --------------------------------------------------------

--
-- Struttura della tabella `processato`
--

CREATE TABLE `processato` (
  `step` varchar(4) NOT NULL,
  `serie` varchar(6) NOT NULL,
  `id_macchinario` varchar(6) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `processato`
--

INSERT INTO `processato` (`step`, `serie`, `id_macchinario`, `data`) VALUES
('1234', '2312M1', 'M10', '2020-12-02'),
('3399', '023343', 'C8', '2020-12-02'),
('5450', '328473', 'M11', '2020-08-14'),
('7999', '023343', 'F1', '2020-12-02'),
('8080', '123456', 'I4', '2020-01-23'),
('8080', '743495', 'M10', '2020-06-24');

-- --------------------------------------------------------

--
-- Struttura della tabella `reparto`
--

CREATE TABLE `reparto` (
  `id` int(2) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `n_operatori_tot` int(2) NOT NULL,
  `n_macchinari` int(2) NOT NULL,
  `live_target` int(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `reparto`
--

INSERT INTO `reparto` (`id`, `nome`, `n_operatori_tot`, `n_macchinari`, `live_target`) VALUES
(1, 'Forni', 10, 30, 0),
(2, 'Cappe', 6, 20, 36),
(3, 'PVD', 15, 35, 0),
(4, 'Impiantatori', 12, 22, 0),
(5, 'Lithografici', 9, 10, 0);

--
-- Trigger `reparto`
--
DELIMITER $$
CREATE TRIGGER `target_tot` AFTER UPDATE ON `reparto` FOR EACH ROW Begin
Call turno_odierno_proc (@ora);
Update storico_ach 
set target = target + new.live_target 
where id_reparto = (select id from reparto where live_target = new.live_target)
and data = curdate()
and orario = @ora;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `storico_ach`
--

CREATE TABLE `storico_ach` (
  `id` int(6) NOT NULL,
  `id_reparto` int(2) NOT NULL,
  `data` date NOT NULL,
  `orario` varchar(4) NOT NULL,
  `target` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `storico_ach`
--

INSERT INTO `storico_ach` (`id`, `id_reparto`, `data`, `orario`, `target`) VALUES
(1, 1, '2020-05-12', 'M', 90),
(2, 3, '2020-05-12', 'M', 103),
(3, 2, '2020-05-12', 'M', 77),
(4, 4, '2020-05-12', 'M', 88),
(5, 5, '2020-05-12', 'M', 100),
(6, 1, '2020-06-24', 'N', 97),
(7, 2, '2020-06-24', 'M', 100),
(8, 3, '2020-06-24', 'P', 98),
(9, 4, '2020-06-24', 'P', 82),
(10, 5, '2020-06-24', 'N', 102),
(11, 2, '2020-12-14', 'P', 120),
(12, 2, '2020-12-18', 'M', 91),
(13, 3, '2021-05-11', 'P', 99);

-- --------------------------------------------------------

--
-- Struttura della tabella `turno`
--

CREATE TABLE `turno` (
  `data` date NOT NULL,
  `orario` varchar(4) NOT NULL,
  `n_operatori` int(2) NOT NULL,
  `perc_presenze` int(3) NOT NULL,
  `responsabile` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `turno`
--

INSERT INTO `turno` (`data`, `orario`, `n_operatori`, `perc_presenze`, `responsabile`) VALUES
('2020-01-23', 'N', 26, 50, 3),
('2020-01-23', 'P', 49, 94, 1),
('2020-05-12', 'P', 22, 42, 5),
('2020-06-24', 'M', 44, 86, 2),
('2020-08-14', 'N', 15, 29, 2),
('2020-12-02', 'M', 52, 100, 1),
('2020-12-14', 'P', 50, 96, 3),
('2020-12-18', 'M', 26, 50, 1),
('2020-12-25', 'M', 10, 19, 4),
('2020-12-29', 'N', 26, 50, 3),
('2021-05-11', 'P', 39, 50, 28);

--
-- Trigger `turno`
--
DELIMITER $$
CREATE TRIGGER `check_covid` BEFORE INSERT ON `turno` FOR EACH ROW Begin
If new.perc_presenze > 60
Then signal Sqlstate '45000' set message_text = 'Presenze troppo elevate, rischio contagio';
End if;
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura per vista `lav_cappe`
--
DROP TABLE IF EXISTS `lav_cappe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`lav_cappe`  AS SELECT `mhm`.`lav_lotto`.`serie` AS `serie` FROM `mhm`.`lav_lotto` WHERE `mhm`.`lav_lotto`.`id_macchinario` in (select `m_cappe`.`ID` from `mhm`.`m_cappe`) ;

-- --------------------------------------------------------

--
-- Struttura per vista `lav_forni`
--
DROP TABLE IF EXISTS `lav_forni`;

CREATE ALGORITHM=UNDEFINED DEFINER=``@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`lav_forni`  AS SELECT `mhm`.`lav_lotto`.`serie` AS `serie` FROM `mhm`.`lav_lotto` WHERE `mhm`.`lav_lotto`.`id_macchinario` in (select `m_forni`.`ID` from `mhm`.`m_forni`) ;

-- --------------------------------------------------------

--
-- Struttura per vista `lav_impiantatori`
--
DROP TABLE IF EXISTS `lav_impiantatori`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`lav_impiantatori`  AS SELECT `mhm`.`lav_lotto`.`serie` AS `serie` FROM `mhm`.`lav_lotto` WHERE `mhm`.`lav_lotto`.`id_macchinario` in (select `m_impiantatori`.`ID` from `mhm`.`m_impiantatori`) ;

-- --------------------------------------------------------

--
-- Struttura per vista `lav_lithografici`
--
DROP TABLE IF EXISTS `lav_lithografici`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`lav_lithografici`  AS SELECT `mhm`.`lav_lotto`.`serie` AS `serie` FROM `mhm`.`lav_lotto` WHERE `mhm`.`lav_lotto`.`id_macchinario` in (select `m_lithografici`.`ID` from `mhm`.`m_lithografici`) ;

-- --------------------------------------------------------

--
-- Struttura per vista `lav_pvd`
--
DROP TABLE IF EXISTS `lav_pvd`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`lav_pvd`  AS SELECT `mhm`.`lav_lotto`.`serie` AS `serie` FROM `mhm`.`lav_lotto` WHERE `mhm`.`lav_lotto`.`id_macchinario` in (select `m_pvd`.`ID` from `mhm`.`m_pvd`) ;

-- --------------------------------------------------------

--
-- Struttura per vista `l_rfsl`
--
DROP TABLE IF EXISTS `l_rfsl`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`l_rfsl`  AS SELECT `mhm`.`lotto`.`serie` AS `serie` FROM `mhm`.`lotto` WHERE `mhm`.`lotto`.`prodotto` = 'rfsl' ;

-- --------------------------------------------------------

--
-- Struttura per vista `m_cappe`
--
DROP TABLE IF EXISTS `m_cappe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`m_cappe`  AS SELECT `mhm`.`macchinario`.`id` AS `ID` FROM `mhm`.`macchinario` WHERE `mhm`.`macchinario`.`collocazione` = 'cappe' ;

-- --------------------------------------------------------

--
-- Struttura per vista `m_forni`
--
DROP TABLE IF EXISTS `m_forni`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`m_forni`  AS SELECT `mhm`.`macchinario`.`id` AS `ID` FROM `mhm`.`macchinario` WHERE `mhm`.`macchinario`.`collocazione` = 'forni' ;

-- --------------------------------------------------------

--
-- Struttura per vista `m_impiantatori`
--
DROP TABLE IF EXISTS `m_impiantatori`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`m_impiantatori`  AS SELECT `mhm`.`macchinario`.`id` AS `ID` FROM `mhm`.`macchinario` WHERE `mhm`.`macchinario`.`collocazione` = 'impiantatori' ;

-- --------------------------------------------------------

--
-- Struttura per vista `m_lithografici`
--
DROP TABLE IF EXISTS `m_lithografici`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`m_lithografici`  AS SELECT `mhm`.`macchinario`.`id` AS `ID` FROM `mhm`.`macchinario` WHERE `mhm`.`macchinario`.`collocazione` = 'lithografici' ;

-- --------------------------------------------------------

--
-- Struttura per vista `m_pvd`
--
DROP TABLE IF EXISTS `m_pvd`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mhm`.`m_pvd`  AS SELECT `mhm`.`macchinario`.`id` AS `ID` FROM `mhm`.`macchinario` WHERE `mhm`.`macchinario`.`collocazione` = 'pvd' ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `impiegato`
--
ALTER TABLE `impiegato`
  ADD PRIMARY KEY (`id`),
  ADD KEY `direzione` (`direzione`);

--
-- Indici per le tabelle `lav_lotto`
--
ALTER TABLE `lav_lotto`
  ADD PRIMARY KEY (`step`,`serie`),
  ADD KEY `lav_lotto_ibfk_2` (`id_macchinario`),
  ADD KEY `lav_lotto_ibfk_1` (`serie`);

--
-- Indici per le tabelle `lotto`
--
ALTER TABLE `lotto`
  ADD PRIMARY KEY (`serie`);

--
-- Indici per le tabelle `macchinario`
--
ALTER TABLE `macchinario`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `presenza`
--
ALTER TABLE `presenza`
  ADD PRIMARY KEY (`reparto`);

--
-- Indici per le tabelle `processato`
--
ALTER TABLE `processato`
  ADD PRIMARY KEY (`step`,`serie`),
  ADD KEY `data` (`data`),
  ADD KEY `id_macchinario` (`id_macchinario`),
  ADD KEY `serie` (`serie`);

--
-- Indici per le tabelle `reparto`
--
ALTER TABLE `reparto`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `storico_ach`
--
ALTER TABLE `storico_ach`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data` (`data`),
  ADD KEY `id_reparto` (`id_reparto`) USING BTREE,
  ADD KEY `orario` (`orario`);

--
-- Indici per le tabelle `turno`
--
ALTER TABLE `turno`
  ADD PRIMARY KEY (`data`,`orario`),
  ADD KEY `responsabile` (`responsabile`),
  ADD KEY `orario` (`orario`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `impiegato`
--
ALTER TABLE `impiegato`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `impiegato`
--
ALTER TABLE `impiegato`
  ADD CONSTRAINT `impiegato_ibfk_1` FOREIGN KEY (`direzione`) REFERENCES `reparto` (`id`);

--
-- Limiti per la tabella `lav_lotto`
--
ALTER TABLE `lav_lotto`
  ADD CONSTRAINT `lav_lotto_ibfk_1` FOREIGN KEY (`serie`) REFERENCES `lotto` (`serie`) ON DELETE CASCADE,
  ADD CONSTRAINT `lav_lotto_ibfk_2` FOREIGN KEY (`id_macchinario`) REFERENCES `macchinario` (`id`);

--
-- Limiti per la tabella `presenza`
--
ALTER TABLE `presenza`
  ADD CONSTRAINT `presenza_ibfk_1` FOREIGN KEY (`reparto`) REFERENCES `reparto` (`id`);

--
-- Limiti per la tabella `processato`
--
ALTER TABLE `processato`
  ADD CONSTRAINT `processato_ibfk_2` FOREIGN KEY (`data`) REFERENCES `turno` (`data`),
  ADD CONSTRAINT `processato_ibfk_3` FOREIGN KEY (`id_macchinario`) REFERENCES `macchinario` (`id`);

--
-- Limiti per la tabella `storico_ach`
--
ALTER TABLE `storico_ach`
  ADD CONSTRAINT `storico_ach_ibfk_1` FOREIGN KEY (`id_reparto`) REFERENCES `reparto` (`id`),
  ADD CONSTRAINT `storico_ach_ibfk_2` FOREIGN KEY (`data`) REFERENCES `turno` (`data`),
  ADD CONSTRAINT `storico_ach_ibfk_3` FOREIGN KEY (`orario`) REFERENCES `turno` (`orario`);

--
-- Limiti per la tabella `turno`
--
ALTER TABLE `turno`
  ADD CONSTRAINT `turno_ibfk_1` FOREIGN KEY (`responsabile`) REFERENCES `impiegato` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
