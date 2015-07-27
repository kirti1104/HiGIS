-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 27, 2015 at 05:10 PM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `higis_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `area`
--

CREATE TABLE IF NOT EXISTS `area` (
  `area_id` int(11) NOT NULL,
  `name_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `area`
--

INSERT INTO `area` (`area_id`, `name_id`) VALUES
(2, 1),
(12, 1),
(1, 2),
(3, 3),
(4, 4),
(5, 4),
(11, 5),
(7, 6),
(8, 6),
(9, 6),
(10, 6),
(6, 7),
(13, 8);

-- --------------------------------------------------------

--
-- Table structure for table `change`
--

CREATE TABLE IF NOT EXISTS `change` (
  `change_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `change`
--

INSERT INTO `change` (`change_id`, `event_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7);

-- --------------------------------------------------------

--
-- Table structure for table `change_on_area`
--

CREATE TABLE IF NOT EXISTS `change_on_area` (
  `change_on_area_id` int(11) NOT NULL,
  `change_id` int(11) NOT NULL,
  `old_area_id` int(11) NOT NULL,
  `new_area_id` int(11) NOT NULL,
  `descendent` tinyint(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `change_on_area`
--

INSERT INTO `change_on_area` (`change_on_area_id`, `change_id`, `old_area_id`, `new_area_id`, `descendent`) VALUES
(1, 1, 2, 7, 1),
(2, 2, 7, 8, 1),
(3, 3, 8, 9, 1),
(4, 4, 9, 10, 1),
(5, 5, 1, 11, 1),
(6, 6, 4, 5, 1),
(7, 6, 4, 6, 1),
(8, 2, 3, 8, 1),
(9, 3, 8, 13, 1),
(10, 4, 9, 3, 1),
(11, 5, 13, 11, 1);

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `event_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `event_name` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_id`, `date`, `event_name`) VALUES
(1, '1933-01-30', 'From A to A2'),
(2, '1939-09-01', 'Annexation of C by A2'),
(3, '1945-04-08', 'A2 looses F'),
(4, '1945-04-08', 'C freed'),
(5, '1945-04-30', 'B unites with F and becomes B2'),
(6, '1419-01-01', 'E independent from D'),
(7, '1945-04-30', 'From A2 to A');

-- --------------------------------------------------------

--
-- Table structure for table `name`
--

CREATE TABLE IF NOT EXISTS `name` (
  `name_id` int(11) NOT NULL,
  `off_name_en` text NOT NULL,
  `short_name_en` text NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `name`
--

INSERT INTO `name` (`name_id`, `off_name_en`, `short_name_en`) VALUES
(1, 'A', 'A'),
(2, 'B', 'B'),
(3, 'C', 'C'),
(4, 'D', 'D'),
(5, 'B2', 'B2'),
(6, 'A2', 'A2'),
(7, 'E', 'E'),
(8, 'F', 'F');

-- --------------------------------------------------------

--
-- Table structure for table `point`
--

CREATE TABLE IF NOT EXISTS `point` (
  `point_id` int(11) NOT NULL,
  `lat` float NOT NULL,
  `lng` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `point`
--

INSERT INTO `point` (`point_id`, `lat`, `lng`) VALUES
(1, -24.3969, -13.2197),
(2, -17.7221, -8.83623),
(3, -8.55671, -7.93961),
(4, -0.387551, -13.0204),
(5, -0.586798, -24.5768),
(6, -4.47213, -36.0336),
(7, 2.80042, -30.1557),
(8, -17.4232, -31.6501),
(9, -18.1206, -46.9922),
(10, -14.833, -51.0768),
(11, 3.39816, -42.4095),
(12, -38.3443, -38.026),
(13, -34.3593, -27.3663),
(14, -30.6732, -19.9941),
(15, -15.5304, -23.8794),
(16, -0.586798, -50.479),
(17, -25.1939, -42.2102),
(18, -24.3969, -29.0599),
(19, -13.0398, -16.7065),
(20, -13.4383, -42.9076),
(21, -6.06611, -21.1896),
(22, -6.96273, -29.0599),
(23, 2.10305, -18.1013),
(24, 7.18387, -26.7685),
(25, 5.88876, -35.9339),
(26, -33.6199, -42.0219),
(27, -39.1989, -42.9185);

-- --------------------------------------------------------

--
-- Table structure for table `point_on_polyline`
--

CREATE TABLE IF NOT EXISTS `point_on_polyline` (
  `point_on_polyline_id` int(11) NOT NULL,
  `polyline_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  `point_index` int(10) unsigned NOT NULL COMMENT 'For ordering purposes'
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `point_on_polyline`
--

INSERT INTO `point_on_polyline` (`point_on_polyline_id`, `polyline_id`, `point_id`, `point_index`) VALUES
(1, 1, 3, 1),
(2, 1, 4, 2),
(3, 1, 23, 3),
(4, 1, 24, 4),
(5, 1, 7, 5),
(6, 2, 1, 3),
(7, 2, 14, 2),
(8, 2, 13, 1),
(9, 3, 3, 1),
(10, 3, 19, 2),
(11, 3, 15, 3),
(12, 4, 7, 1),
(13, 4, 22, 2),
(14, 5, 7, 1),
(15, 5, 25, 2),
(16, 5, 11, 3),
(17, 5, 16, 4),
(18, 6, 16, 1),
(19, 6, 10, 2),
(20, 6, 9, 3),
(21, 6, 20, 4),
(22, 6, 8, 5),
(23, 6, 17, 6),
(24, 6, 18, 7),
(25, 6, 13, 8),
(26, 7, 1, 1),
(28, 7, 15, 3),
(29, 8, 22, 3),
(30, 8, 6, 2),
(31, 8, 16, 1),
(32, 9, 1, 1),
(33, 9, 2, 2),
(34, 9, 3, 3),
(35, 10, 12, 1),
(36, 10, 26, 2),
(37, 10, 27, 3),
(38, 11, 22, 1),
(39, 11, 5, 2),
(40, 11, 21, 3),
(41, 11, 15, 4),
(42, 12, 22, 1),
(43, 12, 8, 2),
(44, 13, 8, 1),
(45, 13, 17, 2),
(46, 13, 18, 3),
(47, 13, 13, 4),
(48, 14, 8, 5),
(49, 14, 20, 4),
(50, 14, 9, 3),
(51, 14, 10, 2),
(52, 14, 16, 1);

-- --------------------------------------------------------

--
-- Table structure for table `polygon`
--

CREATE TABLE IF NOT EXISTS `polygon` (
  `polygon_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `polygon`
--

INSERT INTO `polygon` (`polygon_id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7);

-- --------------------------------------------------------

--
-- Table structure for table `polygon_in_area`
--

CREATE TABLE IF NOT EXISTS `polygon_in_area` (
  `polygon_in_area_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `polygon_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `polygon_in_area`
--

INSERT INTO `polygon_in_area` (`polygon_in_area_id`, `area_id`, `polygon_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 2, 5),
(4, 3, 3),
(5, 4, 4),
(6, 7, 2),
(7, 6, 7),
(8, 5, 6),
(9, 7, 5),
(10, 8, 2),
(11, 8, 3),
(12, 8, 5),
(13, 9, 2),
(14, 9, 3),
(15, 10, 2),
(16, 11, 1),
(17, 11, 5),
(18, 12, 2);

-- --------------------------------------------------------

--
-- Table structure for table `polyline`
--

CREATE TABLE IF NOT EXISTS `polyline` (
  `polyline_id` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `polyline`
--

INSERT INTO `polyline` (`polyline_id`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14);

-- --------------------------------------------------------

--
-- Table structure for table `polyline_on_polygon`
--

CREATE TABLE IF NOT EXISTS `polyline_on_polygon` (
  `polyline_on_polygon_id` int(11) NOT NULL,
  `polygon_id` int(11) NOT NULL,
  `polyline_id` int(11) NOT NULL,
  `polyline_index` int(11) NOT NULL COMMENT 'Ordering purposes'
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `polyline_on_polygon`
--

INSERT INTO `polyline_on_polygon` (`polyline_on_polygon_id`, `polygon_id`, `polyline_id`, `polyline_index`) VALUES
(1, 1, 7, 3),
(2, 1, 9, 1),
(3, 1, 3, 2),
(4, 2, 3, 4),
(5, 2, 1, 1),
(6, 2, 4, 2),
(7, 2, 11, 3),
(8, 3, 5, 1),
(9, 3, 8, 2),
(10, 3, 4, 3),
(11, 4, 6, 1),
(12, 4, 2, 2),
(13, 4, 7, 3),
(14, 4, 11, 4),
(15, 4, 8, 5),
(16, 5, 10, 1),
(17, 6, 2, 5),
(18, 6, 13, 4),
(19, 6, 12, 3),
(20, 6, 11, 2),
(21, 7, 12, 1),
(22, 7, 14, 3),
(23, 7, 8, 2),
(24, 6, 7, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`area_id`), ADD KEY `name_id` (`name_id`);

--
-- Indexes for table `change`
--
ALTER TABLE `change`
  ADD PRIMARY KEY (`change_id`), ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `change_on_area`
--
ALTER TABLE `change_on_area`
  ADD PRIMARY KEY (`change_on_area_id`), ADD KEY `change_id` (`change_id`), ADD KEY `old_area_id` (`old_area_id`), ADD KEY `new_area_id` (`new_area_id`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `name`
--
ALTER TABLE `name`
  ADD PRIMARY KEY (`name_id`);

--
-- Indexes for table `point`
--
ALTER TABLE `point`
  ADD PRIMARY KEY (`point_id`);

--
-- Indexes for table `point_on_polyline`
--
ALTER TABLE `point_on_polyline`
  ADD PRIMARY KEY (`point_on_polyline_id`), ADD KEY `polyline_id` (`polyline_id`), ADD KEY `point_id` (`point_id`);

--
-- Indexes for table `polygon`
--
ALTER TABLE `polygon`
  ADD PRIMARY KEY (`polygon_id`);

--
-- Indexes for table `polygon_in_area`
--
ALTER TABLE `polygon_in_area`
  ADD PRIMARY KEY (`polygon_in_area_id`), ADD KEY `area_id` (`area_id`), ADD KEY `polygon_id` (`polygon_id`);

--
-- Indexes for table `polyline`
--
ALTER TABLE `polyline`
  ADD PRIMARY KEY (`polyline_id`);

--
-- Indexes for table `polyline_on_polygon`
--
ALTER TABLE `polyline_on_polygon`
  ADD PRIMARY KEY (`polyline_on_polygon_id`), ADD KEY `polygon_id` (`polygon_id`), ADD KEY `polyline_id` (`polyline_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `area`
--
ALTER TABLE `area`
  MODIFY `area_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `change`
--
ALTER TABLE `change`
  MODIFY `change_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `change_on_area`
--
ALTER TABLE `change_on_area`
  MODIFY `change_on_area_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `name`
--
ALTER TABLE `name`
  MODIFY `name_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `point`
--
ALTER TABLE `point`
  MODIFY `point_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `point_on_polyline`
--
ALTER TABLE `point_on_polyline`
  MODIFY `point_on_polyline_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT for table `polygon`
--
ALTER TABLE `polygon`
  MODIFY `polygon_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `polygon_in_area`
--
ALTER TABLE `polygon_in_area`
  MODIFY `polygon_in_area_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `polyline`
--
ALTER TABLE `polyline`
  MODIFY `polyline_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `polyline_on_polygon`
--
ALTER TABLE `polyline_on_polygon`
  MODIFY `polyline_on_polygon_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `area`
--
ALTER TABLE `area`
ADD CONSTRAINT `area_ibfk_1` FOREIGN KEY (`name_id`) REFERENCES `name` (`name_id`);

--
-- Constraints for table `change`
--
ALTER TABLE `change`
ADD CONSTRAINT `change_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON UPDATE CASCADE;

--
-- Constraints for table `change_on_area`
--
ALTER TABLE `change_on_area`
ADD CONSTRAINT `change_on_area_ibfk_1` FOREIGN KEY (`change_id`) REFERENCES `change` (`change_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `change_on_area_ibfk_2` FOREIGN KEY (`old_area_id`) REFERENCES `area` (`area_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `change_on_area_ibfk_3` FOREIGN KEY (`new_area_id`) REFERENCES `area` (`area_id`) ON UPDATE CASCADE;

--
-- Constraints for table `point_on_polyline`
--
ALTER TABLE `point_on_polyline`
ADD CONSTRAINT `point_on_polyline_ibfk_1` FOREIGN KEY (`point_id`) REFERENCES `point` (`point_id`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `point_on_polyline_ibfk_2` FOREIGN KEY (`polyline_id`) REFERENCES `polyline` (`polyline_id`) ON DELETE CASCADE;

--
-- Constraints for table `polygon_in_area`
--
ALTER TABLE `polygon_in_area`
ADD CONSTRAINT `polygon_in_area_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `area` (`area_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `polygon_in_area_ibfk_2` FOREIGN KEY (`polygon_id`) REFERENCES `polygon` (`polygon_id`);

--
-- Constraints for table `polyline_on_polygon`
--
ALTER TABLE `polyline_on_polygon`
ADD CONSTRAINT `polyline_on_polygon_ibfk_1` FOREIGN KEY (`polygon_id`) REFERENCES `polygon` (`polygon_id`) ON UPDATE CASCADE,
ADD CONSTRAINT `polyline_on_polygon_ibfk_2` FOREIGN KEY (`polyline_id`) REFERENCES `polyline` (`polyline_id`) ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
