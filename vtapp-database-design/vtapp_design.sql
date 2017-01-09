-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2017 at 06:27 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vtapp_design`
--

-- --------------------------------------------------------

--
-- Table structure for table `exercise_and_tasks`
--

CREATE TABLE `exercise_and_tasks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `task_name` varchar(30) DEFAULT NULL,
  `track_id` int(11) NOT NULL,
  `assigned_by` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `exercise_and_tasks`
--

INSERT INTO `exercise_and_tasks` (`id`, `user_id`, `task_name`, `track_id`, `assigned_by`) VALUES
(1, 6, 'Do this', 3, 4),
(2, 4, 'Do that', 1, 3),
(3, 3, 'Do example', 5, 2),
(4, 5, 'Do this study track', 4, 1),
(5, 5, 'Do everything', 6, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tracks`
--

CREATE TABLE `tracks` (
  `id` int(11) NOT NULL,
  `track_name` varchar(30) DEFAULT NULL,
  `track_owner` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tracks`
--

INSERT INTO `tracks` (`id`, `track_name`, `track_owner`) VALUES
(1, 'MySQL', 2),
(2, 'PHP', 4),
(3, 'JavaScript', 3),
(4, 'JQuery', 1),
(5, 'HTML', 2),
(6, 'CSS', 3),
(7, 'Ruby', 4);

-- --------------------------------------------------------

--
-- Table structure for table `track_reviewer`
--

CREATE TABLE `track_reviewer` (
  `id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `track_reviewer_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `track_reviewer`
--

INSERT INTO `track_reviewer` (`id`, `track_id`, `user_id`, `track_reviewer_id`) VALUES
(1, 1, 5, 2),
(2, 3, 6, 1),
(3, 5, 5, 3),
(4, 7, 5, 4);

-- --------------------------------------------------------

--
-- Table structure for table `track_runner`
--

CREATE TABLE `track_runner` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `track_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `track_runner`
--

INSERT INTO `track_runner` (`id`, `user_id`, `track_id`) VALUES
(1, 5, 5),
(2, 6, 7),
(3, 5, 6),
(4, 6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `user_name` varchar(30) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `user_name`, `admin`) VALUES
(1, 'Manik Juneja', 1),
(2, 'Akhil Bansal', 1),
(3, 'Jatin Baweja', 0),
(4, 'Tanmay Sinha', 0),
(5, 'Vishwas Malhotra', 0),
(6, 'Manish Rawat', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `exercise_and_tasks`
--
ALTER TABLE `exercise_and_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `track_id` (`track_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `assigned_by` (`assigned_by`);

--
-- Indexes for table `tracks`
--
ALTER TABLE `tracks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `track_owner` (`track_owner`);

--
-- Indexes for table `track_reviewer`
--
ALTER TABLE `track_reviewer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `track_id` (`track_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `track_reviewer_id` (`track_reviewer_id`);

--
-- Indexes for table `track_runner`
--
ALTER TABLE `track_runner`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `track_id` (`track_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `exercise_and_tasks`
--
ALTER TABLE `exercise_and_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `tracks`
--
ALTER TABLE `tracks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `track_reviewer`
--
ALTER TABLE `track_reviewer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `track_runner`
--
ALTER TABLE `track_runner`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
