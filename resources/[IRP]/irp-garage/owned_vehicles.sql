--
-- Table structure for table `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `id` int(11) NOT NULL,
  `owner` varchar(30) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) NOT NULL DEFAULT '',
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `state` varchar(50) NOT NULL DEFAULT 'Out',
  `finance` int(32) NOT NULL DEFAULT 0,
  `financetimer` int(32) NOT NULL DEFAULT 0,
  `garage` varchar(200) DEFAULT 'A',
  `engine_damage` int(11) DEFAULT 1000,
  `body_damage` int(11) DEFAULT 1000,
  `lasthouse` int(11) DEFAULT 0,
  `properties` longtext DEFAULT NULL,
  `fuel` tinytext DEFAULT NULL,
  `modLivery` int(11) DEFAULT NULL,
  `brakes` int(11) DEFAULT 100,
  `axle` int(11) DEFAULT 100,
  `radiator` int(11) DEFAULT 100,
  `clutch` int(11) DEFAULT 100,
  `transmission` int(11) DEFAULT 100,
  `electronics` int(11) DEFAULT 100,
  `fuel_injector` int(11) DEFAULT 100,
  `fuel_tank` int(11) DEFAULT 100
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



--
-- Indexes for table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
