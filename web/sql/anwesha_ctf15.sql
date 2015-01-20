-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2015 at 03:44 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";
CREATE USER 'ctf'@'localhost'; GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'ctf'@'localhost';
CREATE DATABASE IF NOT EXISTS anwesha_ctf15;
USE anwesha_ctf15;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `anwesha_ctf15`
--

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE IF NOT EXISTS `login` (
  `tname` varchar(20) NOT NULL,
  `pass` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `problem_info`
--

CREATE TABLE IF NOT EXISTS `problem_info` (
`pid` int(20) NOT NULL,
  `score` int(10) NOT NULL,
  `answer` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `timemanagement`
--

CREATE TABLE IF NOT EXISTS `timemanagement` (
  `tname` varchar(20) NOT NULL,
  `pid` int(20) NOT NULL,
  `open` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `finish` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_info`
--

CREATE TABLE IF NOT EXISTS `user_info` (
  `tname` varchar(20) NOT NULL COMMENT 'Team Name',
  `member1` varchar(20) NOT NULL COMMENT 'Member 1',
  `member2` varchar(20) DEFAULT NULL COMMENT 'Member 2',
  `member3` varchar(20) DEFAULT NULL COMMENT 'Member 3',
  `contact` varchar(10) DEFAULT NULL COMMENT 'Phone Number',
  `clg` varchar(50) NOT NULL COMMENT 'College Name',
  `email` varchar(50) NOT NULL COMMENT 'email'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_track`
--

CREATE TABLE IF NOT EXISTS `user_track` (
  `tname` varchar(20) NOT NULL,
  `p1` int(11) NOT NULL,
  `p2` int(11) NOT NULL,
  `p3` int(11) NOT NULL,
  `p4` int(11) NOT NULL,
  `p5` int(11) NOT NULL,
  `p6` int(11) NOT NULL,
  `p7` int(11) NOT NULL,
  `p8` int(11) NOT NULL,
  `p9` int(11) NOT NULL,
  `p10` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `login`
--
ALTER TABLE `login`
 ADD PRIMARY KEY (`tname`);

--
-- Indexes for table `problem_info`
--
ALTER TABLE `problem_info`
 ADD PRIMARY KEY (`pid`);

--
-- Indexes for table `user_info`
--
ALTER TABLE `user_info`
 ADD PRIMARY KEY (`tname`), ADD UNIQUE KEY `member1` (`member1`,`member2`,`member3`,`contact`);

--
-- Indexes for table `user_track`
--
ALTER TABLE `user_track`
 ADD PRIMARY KEY (`tname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `problem_info`
--
ALTER TABLE `problem_info`
MODIFY `pid` int(20) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `login`
--
ALTER TABLE `login`
ADD CONSTRAINT `login_ibfk_1` FOREIGN KEY (`tname`) REFERENCES `user_info` (`tname`);

--
-- Constraints for table `user_track`
--
ALTER TABLE `user_track`
ADD CONSTRAINT `user_track_ibfk_1` FOREIGN KEY (`tname`) REFERENCES `user_info` (`tname`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
