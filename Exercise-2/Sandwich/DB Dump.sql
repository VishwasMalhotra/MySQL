-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 27, 2016 at 08:18 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `exercise_one`
--

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `lname` varchar(30) NOT NULL,
  `phone` int(11) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`lname`, `phone`, `address`) VALUES
('Lincoln', 684523, 'Lincoln Place'),
('O\'Neill\'s', 6742134, 'Pearse St'),
('Old Nag', 7678132, 'Dame St'),
('Buttery', 7023421, 'College St');

-- --------------------------------------------------------

--
-- Table structure for table `sandwiches`
--

CREATE TABLE `sandwiches` (
  `location` varchar(30) NOT NULL,
  `bread` varchar(20) NOT NULL,
  `filling` varchar(30) NOT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sandwiches`
--

INSERT INTO `sandwiches` (`location`, `bread`, `filling`, `price`) VALUES
('Lincoln', 'Rye', 'Ham', 1),
('O\'Neill\'s', 'White', 'Cheese', 1),
('O\'Neill\'s', 'Whole', 'Ham', 1),
('Old Nag', 'Rye', 'Beef', 1),
('Buttery', 'White', 'Cheese', 1),
('O\'Neill\'s', 'White', 'Turkey', 1),
('Buttery', 'White', 'Ham', 1),
('Lincoln', 'Rye', 'Beef', 1),
('Lincoln', 'White', 'Ham', 1),
('Old Nag', 'Rye', 'Ham', 1);

-- --------------------------------------------------------

--
-- Table structure for table `tastes`
--

CREATE TABLE `tastes` (
  `name` varchar(30) NOT NULL,
  `filling` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tastes`
--

INSERT INTO `tastes` (`name`, `filling`) VALUES
('Brown', 'Beef'),
('Brown', 'Ham'),
('Brown', 'Turkey'),
('Green', 'Beef'),
('Green', 'Cheese'),
('Green', 'Turkey'),
('Jones', 'Cheese');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`lname`);

--
-- Indexes for table `sandwiches`
--
ALTER TABLE `sandwiches`
  ADD PRIMARY KEY (`location`,`bread`,`filling`);

--
-- Indexes for table `tastes`
--
ALTER TABLE `tastes`
  ADD PRIMARY KEY (`name`,`filling`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
