-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 15, 2026 at 08:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `university_stats`
--

-- --------------------------------------------------------

--
-- Table structure for table `academic_years`
--

CREATE TABLE `academic_years` (
  `id` int(11) NOT NULL,
  `label` varchar(20) DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `academic_years`
--

INSERT INTO `academic_years` (`id`, `label`, `is_current`) VALUES
(1, '2023/2024', 0),
(2, '2024/2025', 0),
(3, '2025/2026', 1);

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE `domains` (
  `id` int(11) NOT NULL,
  `name_ar` varchar(255) DEFAULT NULL,
  `name_fr` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `domains`
--

INSERT INTO `domains` (`id`, `name_ar`, `name_fr`) VALUES
(1, 'التنظيم الإداري للجامعة', 'Organisation administrative'),
(2, 'خارطة التكوين', 'Carte de formation'),
(3, 'التعليم والتكوين', 'Enseignement et formation'),
(4, 'مردودية التكوين في الدكتوراه', 'Efficacité formation doctorat'),
(5, 'البحث العلمي', 'Recherche scientifique'),
(6, 'التعاون والمرئية', 'Coopération et visibilité'),
(7, 'متابعة المتخرجين', 'Suivi des lauréats'),
(8, 'التكوين المتواصل', 'Formation continue'),
(9, 'الموارد البشرية', 'Ressources humaines'),
(10, 'ميزانية التسيير', 'Budget de fonctionnement'),
(11, 'ميزانية التجهيز', 'Budget d\'équipement'),
(12, 'تكلفة الطالب السنوية', 'Coût annuel étudiant'),
(13, 'ممتلكات الجامعة', 'Patrimoine universitaire'),
(14, 'ظروف الحياة داخل الجامعة', 'Conditions de vie'),
(15, 'الحوكمة والرقمنة', 'Gouvernance et digitalisation');

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770886035_145`
--

CREATE TABLE `dynamic_stat_1770886035_145` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `d` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770887434_883`
--

CREATE TABLE `dynamic_stat_1770887434_883` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `1` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770887435_577`
--

CREATE TABLE `dynamic_stat_1770887435_577` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `1` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770887435_922`
--

CREATE TABLE `dynamic_stat_1770887435_922` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `1` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770887466_380`
--

CREATE TABLE `dynamic_stat_1770887466_380` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `gf` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770888843_341`
--

CREATE TABLE `dynamic_stat_1770888843_341` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `a` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770888862_509`
--

CREATE TABLE `dynamic_stat_1770888862_509` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `a` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770890768_504`
--

CREATE TABLE `dynamic_stat_1770890768_504` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL,
  `ض` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770891169_772`
--

CREATE TABLE `dynamic_stat_1770891169_772` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `d` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770891341_930`
--

CREATE TABLE `dynamic_stat_1770891341_930` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `x` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770891723_875`
--

CREATE TABLE `dynamic_stat_1770891723_875` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770892022_166`
--

CREATE TABLE `dynamic_stat_1770892022_166` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `d` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770892377_792`
--

CREATE TABLE `dynamic_stat_1770892377_792` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `d` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770892580_400`
--

CREATE TABLE `dynamic_stat_1770892580_400` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `a` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770892762_351`
--

CREATE TABLE `dynamic_stat_1770892762_351` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `x` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770892769_275`
--

CREATE TABLE `dynamic_stat_1770892769_275` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `x` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893174_925`
--

CREATE TABLE `dynamic_stat_1770893174_925` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893176_778`
--

CREATE TABLE `dynamic_stat_1770893176_778` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893178_381`
--

CREATE TABLE `dynamic_stat_1770893178_381` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893178_531`
--

CREATE TABLE `dynamic_stat_1770893178_531` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893178_651`
--

CREATE TABLE `dynamic_stat_1770893178_651` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893178_831`
--

CREATE TABLE `dynamic_stat_1770893178_831` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893179_191`
--

CREATE TABLE `dynamic_stat_1770893179_191` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893179_858`
--

CREATE TABLE `dynamic_stat_1770893179_858` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893179_903`
--

CREATE TABLE `dynamic_stat_1770893179_903` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893180_424`
--

CREATE TABLE `dynamic_stat_1770893180_424` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893180_559`
--

CREATE TABLE `dynamic_stat_1770893180_559` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893180_792`
--

CREATE TABLE `dynamic_stat_1770893180_792` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893181_315`
--

CREATE TABLE `dynamic_stat_1770893181_315` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893181_322`
--

CREATE TABLE `dynamic_stat_1770893181_322` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893181_381`
--

CREATE TABLE `dynamic_stat_1770893181_381` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893181_531`
--

CREATE TABLE `dynamic_stat_1770893181_531` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893181_560`
--

CREATE TABLE `dynamic_stat_1770893181_560` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893182_393`
--

CREATE TABLE `dynamic_stat_1770893182_393` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893182_706`
--

CREATE TABLE `dynamic_stat_1770893182_706` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893182_799`
--

CREATE TABLE `dynamic_stat_1770893182_799` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893182_826`
--

CREATE TABLE `dynamic_stat_1770893182_826` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893182_961`
--

CREATE TABLE `dynamic_stat_1770893182_961` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893183_557`
--

CREATE TABLE `dynamic_stat_1770893183_557` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893183_597`
--

CREATE TABLE `dynamic_stat_1770893183_597` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893217_423`
--

CREATE TABLE `dynamic_stat_1770893217_423` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `1` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770893949_925`
--

CREATE TABLE `dynamic_stat_1770893949_925` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ghg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770895106_577`
--

CREATE TABLE `dynamic_stat_1770895106_577` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `hhh` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770895235_609`
--

CREATE TABLE `dynamic_stat_1770895235_609` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `uu` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770895368_820`
--

CREATE TABLE `dynamic_stat_1770895368_820` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `dfdf` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770895450_494`
--

CREATE TABLE `dynamic_stat_1770895450_494` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ghgh` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770896260_177`
--

CREATE TABLE `dynamic_stat_1770896260_177` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `fgfg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770896321_264`
--

CREATE TABLE `dynamic_stat_1770896321_264` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `fgfg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770896760_304`
--

CREATE TABLE `dynamic_stat_1770896760_304` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `fgfgf` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770897226_584`
--

CREATE TABLE `dynamic_stat_1770897226_584` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ghghg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770897693_408`
--

CREATE TABLE `dynamic_stat_1770897693_408` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ghghg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770897719_888`
--

CREATE TABLE `dynamic_stat_1770897719_888` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ghghg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770897838_386`
--

CREATE TABLE `dynamic_stat_1770897838_386` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ghghg` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770897888_531`
--

CREATE TABLE `dynamic_stat_1770897888_531` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `azz` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770897979_448`
--

CREATE TABLE `dynamic_stat_1770897979_448` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `re` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770898276_611`
--

CREATE TABLE `dynamic_stat_1770898276_611` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `ttt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770898763_811`
--

CREATE TABLE `dynamic_stat_1770898763_811` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `d` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770899088_252`
--

CREATE TABLE `dynamic_stat_1770899088_252` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `a` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_1770900188_877`
--

CREATE TABLE `dynamic_stat_1770900188_877` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `x` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_budget`
--

CREATE TABLE `dynamic_stat_budget` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `operating_budget` decimal(15,2) DEFAULT 0.00 COMMENT 'ميزانية التسيير',
  `consumption_rate` decimal(5,2) DEFAULT 0.00 COMMENT 'نسبة الاستهلاك',
  `equipment_budget` decimal(15,2) DEFAULT 0.00 COMMENT 'ميزانية التجهيز',
  `own_resources` decimal(15,2) DEFAULT 0.00 COMMENT 'الموارد الخاصة'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_budget`
--

INSERT INTO `dynamic_stat_budget` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `operating_budget`, `consumption_rate`, `equipment_budget`, `own_resources`) VALUES
(1, 5, 2025, 1, 1, '2026-02-08 12:32:25', 850000000.00, 78.50, 420000000.00, 125000000.00),
(2, 5, 2025, 2, 0, '2026-02-08 12:32:25', 850000000.00, 0.00, 420000000.00, 0.00),
(3, 13, 2025, 1, 1, '2026-02-08 12:32:25', 125000000.00, 82.30, 85000000.00, 15000000.00);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_campus_life`
--

CREATE TABLE `dynamic_stat_campus_life` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `scientific_clubs` int(11) DEFAULT 0 COMMENT 'النوادي العلمية',
  `cultural_associations` int(11) DEFAULT 0 COMMENT 'الجمعيات الثقافية',
  `sports_associations` int(11) DEFAULT 0 COMMENT 'الجمعيات الرياضية',
  `library_closing_time` varchar(10) DEFAULT NULL COMMENT 'وقت إغلاق المكتبة'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_campus_life`
--

INSERT INTO `dynamic_stat_campus_life` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `scientific_clubs`, `cultural_associations`, `sports_associations`, `library_closing_time`) VALUES
(1, 5, 2025, 1, 1, '2026-02-08 12:32:25', 18, 12, 15, '20:00'),
(2, 12, 2025, 1, 1, '2026-02-08 12:32:25', 5, 3, 4, '18:00');

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_continuing_edu`
--

CREATE TABLE `dynamic_stat_continuing_edu` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `training_offers_2019` int(11) DEFAULT 0 COMMENT 'عروض 2019',
  `training_offers_2020` int(11) DEFAULT 0 COMMENT 'عروض 2020',
  `continuing_edu_revenue` decimal(15,2) DEFAULT 0.00 COMMENT 'مداخيل التكوين'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_continuing_edu`
--

INSERT INTO `dynamic_stat_continuing_edu` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `training_offers_2019`, `training_offers_2020`, `continuing_edu_revenue`) VALUES
(1, 2, 2025, 1, 1, '2026-02-08 12:32:25', 25, 32, 12500000.00),
(2, 10, 2025, 1, 1, '2026-02-08 12:32:25', 8, 10, 3500000.00);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_cooperation`
--

CREATE TABLE `dynamic_stat_cooperation` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `intl_agreements_bilateral` int(11) DEFAULT 0 COMMENT 'الاتفاقيات الثنائية',
  `intl_agreements_multilateral` int(11) DEFAULT 0 COMMENT 'الاتفاقيات متعددة الأطراف',
  `national_agreements` int(11) DEFAULT 0 COMMENT 'الاتفاقيات الوطنية',
  `intl_conferences` int(11) DEFAULT 0 COMMENT 'التظاهرات الدولية',
  `economic_partnerships` int(11) DEFAULT 0 COMMENT 'شراكات اقتصادية'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_cooperation`
--

INSERT INTO `dynamic_stat_cooperation` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `intl_agreements_bilateral`, `intl_agreements_multilateral`, `national_agreements`, `intl_conferences`, `economic_partnerships`) VALUES
(1, 3, 2025, 1, 1, '2026-02-08 12:32:25', 25, 8, 45, 12, 18),
(2, 6, 2025, 1, 1, '2026-02-08 12:32:25', 8, 3, 15, 4, 5),
(3, 7, 2025, 1, 1, '2026-02-08 12:32:25', 6, 2, 12, 3, 4);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_governance`
--

CREATE TABLE `dynamic_stat_governance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `has_self_assessment` tinyint(1) DEFAULT 0 COMMENT 'تقييم ذاتي',
  `has_institution_project` tinyint(1) DEFAULT 0 COMMENT 'مشروع مؤسسة',
  `digital_procedures` int(11) DEFAULT 0 COMMENT 'إجراءات رقمية',
  `social_media_accounts` int(11) DEFAULT 0 COMMENT 'حسابات التواصل'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_governance`
--

INSERT INTO `dynamic_stat_governance` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `has_self_assessment`, `has_institution_project`, `digital_procedures`, `social_media_accounts`) VALUES
(1, 5, 2025, 1, 1, '2026-02-08 12:32:25', 1, 1, 15, 6),
(2, 1, 2025, 1, 1, '2026-02-08 12:32:25', 1, 1, 8, 4);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_graduates`
--

CREATE TABLE `dynamic_stat_graduates` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `license_employment_rate` decimal(5,2) DEFAULT 0.00 COMMENT 'نسبة توظيف الليسانس',
  `master_employment_rate` decimal(5,2) DEFAULT 0.00 COMMENT 'نسبة توظيف الماستر',
  `phd_employment_rate` decimal(5,2) DEFAULT 0.00 COMMENT 'نسبة توظيف الدكتوراه'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_graduates`
--

INSERT INTO `dynamic_stat_graduates` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `license_employment_rate`, `master_employment_rate`, `phd_employment_rate`) VALUES
(1, 3, 2025, 1, 1, '2026-02-08 12:32:25', 45.50, 68.25, 85.00),
(2, 2, 2025, 1, 1, '2026-02-08 12:32:25', 42.00, 65.00, 82.50);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_hr_employees`
--

CREATE TABLE `dynamic_stat_hr_employees` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `permanent_professors` int(11) DEFAULT 0 COMMENT 'عدد الأساتذة الدائمين',
  `contract_professors` int(11) DEFAULT 0 COMMENT 'عدد الأساتذة المتعاقدين',
  `admin_staff` int(11) DEFAULT 0 COMMENT 'عدد الموظفين الإداريين',
  `technical_staff` int(11) DEFAULT 0 COMMENT 'عدد الموظفين التقنيين'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_hr_employees`
--

INSERT INTO `dynamic_stat_hr_employees` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `permanent_professors`, `contract_professors`, `admin_staff`, `technical_staff`) VALUES
(1, 1, 2025, 1, 1, '2026-02-08 12:32:25', 529, 45, 350, 128),
(2, 6, 2025, 1, 1, '2026-02-08 12:32:25', 85, 12, 25, 8),
(3, 7, 2025, 1, 1, '2026-02-08 12:32:25', 72, 8, 20, 6),
(4, 8, 2025, 1, 1, '2026-02-08 12:32:25', 95, 15, 30, 10);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_infrastructure`
--

CREATE TABLE `dynamic_stat_infrastructure` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_area` decimal(10,2) DEFAULT 0.00 COMMENT 'المساحة الإجمالية',
  `built_area` decimal(10,2) DEFAULT 0.00 COMMENT 'المساحة المبنية',
  `teaching_seats` int(11) DEFAULT 0 COMMENT 'المقاعد البيداغوجية',
  `libraries` int(11) DEFAULT 0 COMMENT 'المكتبات',
  `labs` int(11) DEFAULT 0 COMMENT 'المخابر'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_infrastructure`
--

INSERT INTO `dynamic_stat_infrastructure` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `total_area`, `built_area`, `teaching_seats`, `libraries`, `labs`) VALUES
(1, 5, 2025, 1, 1, '2026-02-08 12:32:25', 125000.50, 78500.25, 8500, 7, 85),
(2, 15, 2025, 1, 1, '2026-02-08 12:32:25', 2500.00, 1800.00, 500, 1, 5);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_phd_performance`
--

CREATE TABLE `dynamic_stat_phd_performance` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `defenses_2018` int(11) DEFAULT 0 COMMENT 'مناقشات 2018',
  `defenses_2019` int(11) DEFAULT 0 COMMENT 'مناقشات 2019',
  `expected_defenses_2020` int(11) DEFAULT 0 COMMENT 'مناقشات متوقعة 2020',
  `delayed_phd_students` int(11) DEFAULT 0 COMMENT 'طلاب متأخرون',
  `cotutelle_students` int(11) DEFAULT 0 COMMENT 'طلاب الإشراف المشترك'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_phd_performance`
--

INSERT INTO `dynamic_stat_phd_performance` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `defenses_2018`, `defenses_2019`, `expected_defenses_2020`, `delayed_phd_students`, `cotutelle_students`) VALUES
(1, 3, 2025, 1, 1, '2026-02-08 12:32:25', 85, 95, 110, 45, 12),
(2, 7, 2025, 1, 1, '2026-02-08 12:32:25', 25, 28, 32, 8, 3);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_research`
--

CREATE TABLE `dynamic_stat_research` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `research_labs` int(11) DEFAULT 0 COMMENT 'عدد المخابر البحثية',
  `research_units` int(11) DEFAULT 0 COMMENT 'عدد وحدات البحث',
  `prfu_projects` int(11) DEFAULT 0 COMMENT 'مشاريع PRFU',
  `published_articles_a` int(11) DEFAULT 0 COMMENT 'مقالات مصنفة أ',
  `published_articles_b` int(11) DEFAULT 0 COMMENT 'مقالات مصنفة ب',
  `published_articles_c` int(11) DEFAULT 0 COMMENT 'مقالات مصنفة ج',
  `patents` int(11) DEFAULT 0 COMMENT 'براءات الاختراع'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_research`
--

INSERT INTO `dynamic_stat_research` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `research_labs`, `research_units`, `prfu_projects`, `published_articles_a`, `published_articles_b`, `published_articles_c`, `patents`) VALUES
(1, 3, 2025, 1, 1, '2026-02-08 12:32:25', 28, 15, 42, 156, 289, 425, 8),
(2, 7, 2025, 1, 1, '2026-02-08 12:32:25', 6, 3, 12, 45, 78, 120, 2),
(3, 8, 2025, 1, 1, '2026-02-08 12:32:25', 8, 4, 15, 52, 95, 140, 3);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_students`
--

CREATE TABLE `dynamic_stat_students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_students` int(11) DEFAULT 0 COMMENT 'إجمالي الطلاب',
  `license_students` int(11) DEFAULT 0 COMMENT 'طلاب الليسانس',
  `master_students` int(11) DEFAULT 0 COMMENT 'طلاب الماستر',
  `phd_students` int(11) DEFAULT 0 COMMENT 'طلاب الدكتوراه',
  `foreign_students` int(11) DEFAULT 0 COMMENT 'الطلاب الأجانب',
  `male_students` int(11) DEFAULT 0 COMMENT 'الطلاب الذكور',
  `female_students` int(11) DEFAULT 0 COMMENT 'الطالبات الإناث'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_students`
--

INSERT INTO `dynamic_stat_students` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `total_students`, `license_students`, `master_students`, `phd_students`, `foreign_students`, `male_students`, `female_students`) VALUES
(1, 1, 2025, 1, 1, '2026-02-08 12:32:25', 10820, 8500, 1800, 520, 320, 5800, 5020),
(2, 6, 2025, 1, 1, '2026-02-08 12:32:25', 2100, 1650, 350, 100, 45, 850, 1250),
(3, 7, 2025, 1, 1, '2026-02-08 12:32:25', 1850, 1450, 300, 100, 38, 720, 1130),
(4, 8, 2025, 1, 1, '2026-02-08 12:32:25', 2200, 1750, 350, 100, 52, 1250, 950);

-- --------------------------------------------------------

--
-- Table structure for table `dynamic_stat_training_map`
--

CREATE TABLE `dynamic_stat_training_map` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `is_completed` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `license_tracks` int(11) DEFAULT 0 COMMENT 'مسارات الليسانس',
  `master_tracks` int(11) DEFAULT 0 COMMENT 'مسارات الماستر',
  `phd_tracks` int(11) DEFAULT 0 COMMENT 'مسارات الدكتوراه',
  `specialized_master_tracks` int(11) DEFAULT 0 COMMENT 'مسارات الماستر التمهيني'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dynamic_stat_training_map`
--

INSERT INTO `dynamic_stat_training_map` (`id`, `user_id`, `stat_year`, `stat_period`, `is_completed`, `created_at`, `license_tracks`, `master_tracks`, `phd_tracks`, `specialized_master_tracks`) VALUES
(1, 2, 2025, 1, 1, '2026-02-08 12:32:25', 45, 28, 12, 8),
(2, 6, 2025, 1, 1, '2026-02-08 12:32:25', 12, 8, 3, 2),
(3, 7, 2025, 1, 1, '2026-02-08 12:32:25', 10, 6, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `file_exchanges`
--

CREATE TABLE `file_exchanges` (
  `id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_stat_1770886886_143`
--

CREATE TABLE `file_stat_1770886886_143` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_completed` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_stat_1770888919_852`
--

CREATE TABLE `file_stat_1770888919_852` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_completed` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `file_stat_1770891890_527`
--

CREATE TABLE `file_stat_1770891890_527` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_completed` tinyint(4) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `indicators`
--

CREATE TABLE `indicators` (
  `id` int(11) NOT NULL,
  `domain_id` int(11) DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `title_ar` text DEFAULT NULL,
  `data_type` varchar(20) DEFAULT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `chart_type` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `indicators`
--

INSERT INTO `indicators` (`id`, `domain_id`, `code`, `title_ar`, `data_type`, `unit`, `chart_type`) VALUES
(1, 1, '1', 'عدد الكليات', 'integer', 'كلية', 'bar'),
(2, 1, '2', 'عدد المعاهد', 'integer', 'معهد', 'bar'),
(3, 1, '3', 'عدد الأقسام', 'integer', 'قسم', 'bar'),
(4, 1, '4', 'عدد المجالس العلمية المنصَبة بقرار وزاري', 'integer', 'مجلس', 'bar'),
(5, 1, '5', 'عدد اللجان العلمية للأقسام المنصَبة بقرار وزاري', 'integer', 'لجنة', 'bar'),
(6, 1, '6', 'عدد مجالس الكليات والمعاهد المنصَبة بقرار وزاري', 'integer', 'مجلس', 'bar'),
(7, 1, '7', 'عدد دورات المجلس العلمي للجامعة المنعقدة في 2019', 'integer', 'دورة', 'line'),
(8, 1, '8', 'تاريخ نهاية عهدة مجلس الإدارة', 'date', NULL, NULL),
(9, 1, '9', 'عدد دورات مجلس الإدارة المنعقدة في 2019', 'integer', 'دورة', 'bar'),
(10, 1, '10', 'عدد اجتماعات اللجنة متساوية الأعضاء بعنوان 2019', 'integer', 'اجتماع', 'bar'),
(11, 2, '11', 'عدد مسارات التكوين في الليسانس', 'integer', 'مسار', 'bar'),
(12, 2, '12', 'عدد مسارات الليسانس التمهينية', 'integer', 'مسار', 'bar'),
(13, 2, '13', 'عدد مسارات التكوين في الماستر', 'integer', 'مسار', 'bar'),
(14, 2, '14', 'عدد مسارات الماستر التمهينية', 'integer', 'مسار', 'bar'),
(15, 2, '15', 'الميدان الأول المهيمن من حيث التعدادات الطلابية', 'text', NULL, 'pie'),
(16, 2, '16', 'الميدان الثاني المهيمن من حيث التعدادات الطلابية', 'text', NULL, 'pie'),
(17, 2, '17', 'الميدان الأقل تعدادًا من حيث الطلبة', 'text', NULL, 'pie'),
(18, 2, '18', 'الميدان الأول المهيمن من حيث تعدادات طلبة الدكتوراه', 'text', NULL, 'pie'),
(19, 2, '19', 'نسبة الطلبة المسجّلين في الدكتوراه الذين هم من خرّيجي الجامعة', 'decimal', '%', 'gauge'),
(20, 2, '20', 'عدد الطلبة الإجمالي المسجلين في السنة السابقة (2018/2019)', 'integer', 'طالب', 'bar'),
(21, 2, '21', 'عدد الطلبة الإجمالي المسجلين في السنة الحالية (2018/2019)', 'integer', 'طالب', 'bar'),
(22, 2, '22', 'عدد الطلبة في الليسانس', 'integer', 'طالب', 'bar'),
(23, 2, '23', 'عدد الطلبة في الماستر', 'integer', 'طالب', 'bar'),
(24, 2, '25', 'عدد الطلبة في الدكتوراه علوم', 'integer', 'طالب', 'bar'),
(25, 2, '26', 'نسبة الطلبة الأجانب المسجلين في الجامعة مقارنة بإجمالي الطلبة', 'decimal', '%', 'gauge'),
(26, 2, '27', 'معدل عدد الطلبة في كل ماستر مؤهل', 'decimal', 'طالب', 'line'),
(27, 3, '28', 'نسبة الانتقال من السنة الأولى إلى السنة الثانية ليسانس', 'decimal', '%', 'gauge'),
(28, 3, '29', 'نسبة الطلبة الذين يطلبون إعادة التوجيه بعد دراسة السنة الأولى ليسانس', 'decimal', '%', 'gauge'),
(29, 3, '30', 'نسبة النجاح في السنوات الثلاث (03) من الليسانس لدفعة 2016/2017-2018/2019', 'decimal', '%', 'gauge'),
(30, 3, '31', 'نسبة الطلبة الذين تخلّوا عن الدراسة لدفعة الليسانس 2016/2017-2018/2019', 'decimal', '%', 'gauge'),
(31, 3, '32', 'عدد الأسابيع المدرسة فعليًا بعنوان كل سداسي', 'integer', 'أسبوع', 'bar'),
(32, 3, '33', 'هل تملك الجامعة قائمة لمواضيع مذكرات التخرّج في الماستر معتمدة مسبقا', 'boolean', NULL, NULL),
(33, 3, '34', 'هل تملك الجامعة قائمة لمواضيع أطروحات الدكتوراه معتمدة مسبقا', 'boolean', NULL, NULL),
(34, 3, '35', 'ما هي آخر ساعة لوقف نشاط التدريس في اليوم؟', 'text', NULL, NULL),
(35, 3, '36', 'هل تقوم الجامعة بتقييم جدوى ومردودية عروض التكوين', 'boolean', NULL, NULL),
(36, 3, '37', 'هل تملك الجامعة مخطط تكوين استشرافي متعدّد السنوات في الماستر', 'boolean', NULL, NULL),
(37, 4, '38', 'هل تملك الجامعة مخطط تكوين استشرافي متعدّد السنوات في الدكتوراه', 'boolean', NULL, NULL),
(38, 4, '39', 'عدد مناقشات الدكتوراه في 2018', 'integer', 'مناقشة', 'bar'),
(39, 4, '40', 'عدد مناقشات الدكتوراه في 2019', 'integer', 'مناقشة', 'bar'),
(40, 4, '41', 'عدد المناقشات المنتظرة في 2020', 'integer', 'مناقشة', 'bar'),
(41, 4, '42', 'عدد طلبة الدكتوراه المتأخرين عن المناقشة (6 تسجيلات أو أكثر)', 'integer', 'طالب', 'bar'),
(42, 4, '43', 'عدد طلبة الدكتوراه علوم المتأخرين عن المناقشة (7 تسجيلات أو أكثر)', 'integer', 'طالب', 'bar'),
(43, 4, '44', 'العدد الإجمالي لأطروحات الدكتوراه التي يشرف عليها أساتذة الجامعة', 'integer', 'أطروحة', 'bar'),
(44, 4, '45', 'نسبة انخراط طلبة الماستر في مخابر البحث', 'decimal', '%', 'gauge'),
(45, 4, '46', 'نسبة انخراط طلبة الدكتوراه في مخابر البحث', 'decimal', '%', 'gauge'),
(46, 4, '47', 'نسبة طلبة الدكتوراه الذين يمارسون ساعات تدريس', 'decimal', '%', 'gauge'),
(47, 4, '48', 'عدد طلبة الدكتوراه المسجَلين ضمن الإشراف المشترك الدولي', 'integer', 'طالب', 'bar'),
(48, 4, '49', 'معدّل المدّة الفعلية لإنهاء أطروحة الدكتوراه منذ 2009', 'decimal', 'سنة', 'line'),
(49, 5, '50', 'هل للجامعة مخطط بحث متعدّد السنوات معتمد من طرف المجلس العلمي', 'boolean', NULL, NULL),
(50, 5, '51', 'اعتمادات الصندوق الوطني للبحث العلمي والتطوير التكنولوجي', 'decimal', 'دج', 'bar'),
(51, 5, '51a', 'اعتمادات التسيير', 'decimal', 'دج', 'bar'),
(52, 5, '51b', 'الرّصيد إلى غاية ديسمبر 2018', 'decimal', 'دج', 'bar'),
(53, 5, '51c', 'اعتمادات التجهيز', 'decimal', 'دج', 'bar'),
(54, 5, '51d', 'الرّصيد إلى غاية ديسمبر 2018', 'decimal', 'دج', 'bar'),
(55, 5, '52', 'عدد هياكل البحث الإجمالية', 'integer', 'هيكل', 'bar'),
(56, 5, '52a', 'عدد المخابر', 'integer', 'مخبر', 'bar'),
(57, 5, '52b', 'عدد الوحدات', 'integer', 'وحدة', 'bar'),
(58, 5, '53', 'عدد مشاريع البحث التكويني PRFU', 'integer', 'مشروع', 'bar'),
(59, 5, '54', 'عدد مشاريع البحث العلمي', 'integer', 'مشروع', 'bar'),
(60, 5, '55', 'عدد الأساتذة المنخرطين في مشاريع البحث العلمي', 'integer', 'أستاذ', 'bar'),
(61, 5, '56', 'عدد الأساتذة ذوي مصف الأستاذية المنخرطين في مشاريع البحث', 'integer', 'أستاذ', 'bar'),
(62, 5, '57', 'عدد المقالات العلمية المنشورة باسم أساتذة الجامعة', 'integer', 'مقالة', 'bar'),
(63, 5, '57a', 'عدد المقالات في المجلات المصنّفة أ', 'integer', 'مقالة', 'bar'),
(64, 5, '57b', 'عدد المقالات في المجلات المصنّفة ب', 'integer', 'مقالة', 'bar'),
(65, 5, '57c', 'عدد المقالات في المجلات المصنّفة ج', 'integer', 'مقالة', 'bar'),
(66, 5, '58', 'عدد المجلات العلمية', 'integer', 'مجلة', 'bar'),
(67, 5, '59', 'عدد براءات الاختراع', 'integer', 'براءة', 'bar'),
(68, 6, '61', 'عدد الاتفاقيات الدولية الثنائية', 'integer', 'اتفاقية', 'bar'),
(69, 6, '62', 'عدد الاتفاقيات الدولية متعدَدة الأطراف', 'integer', 'اتفاقية', 'bar'),
(70, 6, '63', 'عدد الاتفاقيات مع مؤسسات التّعليم والبحث الوطنية', 'integer', 'اتفاقية', 'bar'),
(71, 6, '64', 'عدد التّظاهرات العلمية الدولية', 'integer', 'تظاهرة', 'bar'),
(72, 6, '65', 'معدّل تكلفة التظاهرة العلمية الوطنية', 'decimal', 'دج', 'line'),
(73, 6, '66', 'معدل تكلفة التظاهرة العلمية الدولية', 'decimal', 'دج', 'line'),
(74, 6, '67', 'قيمة الاعتمادات من برامج التعاون الدولية', 'decimal', 'دج', 'bar'),
(75, 6, '68', 'نسبة طلبة الدكتوراه المستفيدين من تربصات قصيرة في الخارج', 'decimal', '%', 'gauge'),
(76, 6, '73', 'التصنيف الدولي Webometrics', 'integer', 'ترتيب', 'line'),
(77, 6, '75', 'عدد الاتفاقيات مع المؤسسات الاقتصادية', 'integer', 'اتفاقية', 'bar'),
(78, 7, '77', 'نسبة توظيف المتخرّجين من الجامعة في جوان 2018', 'decimal', '%', 'gauge'),
(79, 8, '78', 'عدد عروض التكوين المتواصل بعنوان سنة 2019', 'integer', 'عرض', 'bar'),
(80, 8, '79', 'نسبة مداخيل الجامعة من التكوين المتواصل', 'decimal', '%', 'gauge'),
(81, 9, '80', 'هل تملك الجامعة وثيقة مكتوبة لتطوير مواردها البشرية', 'boolean', NULL, NULL),
(82, 9, '81', 'عدد الأساتذة الباحثين الدّائمين الإجمالي', 'integer', 'أستاذ', 'bar'),
(83, 9, '82', 'نسبة الأساتذة الدائمين ذوي مصفّ الأستاذية', 'decimal', '%', 'gauge'),
(84, 9, '84', 'عدد الأساتذة الاستشفائيين الجامعيين', 'integer', 'أستاذ', 'bar'),
(85, 9, '86', 'عدد الأساتذة الأجانب', 'integer', 'أستاذ', 'bar'),
(86, 9, '87', 'عدد الأساتذة غير الدّائمين', 'integer', 'أستاذ', 'bar'),
(87, 9, '88', 'معدَل التأطير البيداغوجي العام', 'decimal', '%', 'gauge'),
(88, 9, '89', 'عدد الأساتذة المكلَفين بالتدريس في السنة الأولى ليسانس', 'integer', 'أستاذ', 'bar'),
(89, 9, '90', 'عدد المناصب العليا الإجمالي', 'integer', 'منصب', 'bar'),
(90, 9, '92', 'عدد المستخدمين الإداريين الإجمالي', 'integer', 'مستخدم', 'bar'),
(91, 9, '94', 'عدد الإداريين الحائزين على شهادة جامعية ليسانس أو أكثر', 'integer', 'مستخدم', 'bar'),
(92, 10, '97', 'الاعتمادات المالية المخصصة لسنة 2018', 'decimal', 'دج', 'bar'),
(93, 10, '97a', 'نسبة استهلاك ميزانية 2018', 'decimal', '%', 'gauge'),
(94, 10, '98', 'الاعتمادات المالية المخصصة لسنة 2019', 'decimal', 'دج', 'bar'),
(95, 10, '98a', 'نسبة الاستهلاك التقديرية لميزانية 2019', 'decimal', '%', 'gauge'),
(96, 10, '99', 'نسبة الموارد الخاصة للجامعة مقارنة بمواردها الإجمالية', 'decimal', '%', 'gauge'),
(97, 11, '102', 'عدد العمليات الاستثمارية المسجلة', 'integer', 'عملية', 'bar'),
(98, 11, '103', 'عدد العمليات المنتهية ماديا والتي ينبغي إقفالها ماليًا', 'integer', 'عملية', 'bar'),
(99, 11, '104', 'عدد العمليات الجاري إنجازها', 'integer', 'عملية', 'bar'),
(100, 11, '105', 'عدد العمليات المجمّدة', 'integer', 'عملية', 'bar'),
(101, 11, '106', 'الاعتمادات المالية المخصّصة لسنة 2018', 'decimal', 'دج', 'bar'),
(102, 11, '106a', 'نسبة الاستهلاك لسنة 2018', 'decimal', '%', 'gauge'),
(103, 11, '107', 'الاعتمادات المالية المخصّصة لسنة 2019', 'decimal', 'دج', 'bar'),
(104, 11, '107a', 'نسبة الالتزام المحاسبي حتى 31 أكتوبر 2019', 'decimal', '%', 'gauge'),
(105, 12, '109', 'تكلفة الطالب مقارنة بميزانية التسيير لسنة 2018', 'decimal', 'دج/طالب', 'line'),
(106, 12, '110', 'تكلفة الطالب السنوية مقارنة بميزانية الجامعة الإجمالية', 'decimal', 'دج/طالب', 'line'),
(107, 13, '112', 'عدد المواقع', 'integer', 'موقع', 'bar'),
(108, 13, '113', 'قدرات الاستقبال: عدد المقاعد البيداغوجية', 'integer', 'مقعد', 'bar'),
(109, 13, '114', 'المساحة الإجمالية للجامعة', 'decimal', 'متر مربع', 'bar'),
(110, 13, '114a', 'المساحة المبنية', 'decimal', 'متر مربع', 'bar'),
(111, 13, '115', 'القيمة الإدارية الكلية لممتلكات الجامعة', 'decimal', 'دج', 'bar'),
(112, 14, '119', 'عدد النوادي العلمية المعتمدة', 'integer', 'نادي', 'bar'),
(113, 14, '120', 'عدد الجمعيات الثقافية المعتمدة', 'integer', 'جمعية', 'bar'),
(114, 14, '121', 'عدد الجمعيات الرياضية المعتمدة', 'integer', 'جمعية', 'bar'),
(115, 14, '126', 'آخر ساعة لغلق أبواب المكتبة', 'text', NULL, NULL),
(116, 15, '129', 'هل أجرت الجامعة التقييم الذاتي على الميادين السبعة', 'boolean', NULL, NULL),
(117, 15, '135', 'هل يستعين مدير الجامعة برئيس ديوان', 'boolean', NULL, NULL),
(118, 15, '136', 'هل يؤدي الأساتذة شاغلوا المناصب العليا خدمة التدريس', 'boolean', NULL, NULL),
(119, 15, '137', 'هل تمسك إدارة الجامعة عناوين بريد الكتروني للأساتذة والمستخدمين والطلبة', 'boolean', NULL, NULL),
(120, 15, '138', 'معدل فترة تحيين محتوى الموقع الالكتروني', 'text', NULL, NULL),
(121, 15, '141', 'كم عدد اللقاءات التي نظمها مدير الجامعة مع ممثلي النقابات', 'integer', 'لقاء', 'bar'),
(122, 15, '143', 'هل تملك الجامعة حسابًا أو صفحة على مواقع التواصل الاجتماعي', 'boolean', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `indicator_values`
--

CREATE TABLE `indicator_values` (
  `id` int(11) NOT NULL,
  `indicator_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `academic_year_id` int(11) DEFAULT NULL,
  `value_numeric` double DEFAULT NULL,
  `value_text` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `stat_id` int(11) DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `subject` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `messages`
--

INSERT INTO `messages` (`id`, `sender_id`, `receiver_id`, `message`, `stat_id`, `is_read`, `created_at`, `subject`) VALUES
(1, 2, 1, 'ا', NULL, 1, '2026-02-09 08:07:09', 'احصاء و جرد '),
(2, 3, 1, 'يبيب', NULL, 1, '2026-02-12 08:54:23', 'احصاء و جرد ');

-- --------------------------------------------------------

--
-- Table structure for table `message_attachments`
--

CREATE TABLE `message_attachments` (
  `id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `message`, `is_read`, `created_at`) VALUES
(1, 6, 'تم إنشاء إحصائية جديدة: احصائيات المخابر البحثية . يرجى التعبئة.', 0, '2026-02-09 07:55:46'),
(2, 7, 'تم إنشاء إحصائية جديدة: احصائيات المخابر البحثية . يرجى التعبئة.', 0, '2026-02-09 07:55:46'),
(3, 8, 'تم إنشاء إحصائية جديدة: احصائيات المخابر البحثية . يرجى التعبئة.', 0, '2026-02-09 07:55:46'),
(4, 9, 'تم إنشاء إحصائية جديدة: احصائيات المخابر البحثية . يرجى التعبئة.', 0, '2026-02-09 07:55:46'),
(5, 10, 'تم إنشاء إحصائية جديدة: احصائيات المخابر البحثية . يرجى التعبئة.', 0, '2026-02-09 07:55:46'),
(6, 11, 'تم إنشاء إحصائية جديدة: احصائيات المخابر البحثية . يرجى التعبئة.', 0, '2026-02-09 07:55:46'),
(7, 6, 'تم إنشاء إحصائية جديدة: ملفات الاساتذة. يرجى التعبئة.', 0, '2026-02-09 08:42:44'),
(8, 12, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(9, 13, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(10, 14, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(11, 15, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(12, 16, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(13, 17, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(14, 18, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 11:22:01'),
(15, 12, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:06'),
(16, 13, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:06'),
(17, 12, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:07'),
(18, 13, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:07'),
(19, 12, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:07'),
(20, 13, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:07'),
(21, 12, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:07'),
(22, 13, 'تم إنشاء إحصائية جديدة: محمد100. يرجى التعبئة.', 0, '2026-02-10 11:24:07'),
(23, 12, 'تم إنشاء إحصائية ملفات جديدة: محمد. يرجى رفع الملفات المطلوبة.', 0, '2026-02-10 12:23:34'),
(24, 14, 'تم إنشاء إحصائية جديدة: محمد. يرجى التعبئة.', 0, '2026-02-10 12:25:29'),
(25, 12, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(26, 13, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(27, 14, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(28, 15, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(29, 16, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(30, 17, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(31, 18, 'تم إنشاء إحصائية جديدة: 5555. يرجى التعبئة.', 0, '2026-02-10 12:29:34'),
(32, 12, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(33, 13, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(34, 14, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(35, 15, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(36, 16, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(37, 17, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(38, 18, 'تم إنشاء إحصائية جديدة: y. يرجى التعبئة.', 0, '2026-02-10 12:40:34'),
(39, 12, 'تم إنشاء إحصائية جديدة: h. يرجى التعبئة.', 0, '2026-02-10 12:41:08'),
(40, 12, 'تم توجيه إحصائية ملفات جديدة لك: الف', 0, '2026-02-12 07:49:51'),
(41, 12, 'تم إنشاء إحصائية جديدة: الف55. يرجى التعبئة.', 0, '2026-02-12 07:51:14'),
(42, 34, 'تم إنشاء إحصائية جديدة: احصائيات الاساتذة k. يرجى التعبئة.', 0, '2026-02-12 08:00:31'),
(43, 35, 'تم إنشاء إحصائية جديدة: احصائيات الاساتذة k. يرجى التعبئة.', 0, '2026-02-12 08:00:31'),
(44, 3, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 08:47:15'),
(45, 5, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(46, 30, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(47, 26, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(48, 23, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(49, 29, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(50, 31, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(51, 33, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(52, 36, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(53, 24, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(54, 34, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(55, 35, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(56, 28, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(57, 25, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(58, 21, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(59, 19, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(60, 20, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(61, 27, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(62, 32, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(63, 22, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(64, 6, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(65, 11, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(66, 9, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(67, 10, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(68, 8, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(69, 7, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(70, 14, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(71, 15, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(72, 17, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(73, 18, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(74, 12, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(75, 13, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(76, 16, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(77, 4, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(78, 2, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(79, 3, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الطلبة', 0, '2026-02-12 09:01:26'),
(80, 12, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:34'),
(81, 13, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:34'),
(82, 14, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:34'),
(83, 15, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:34'),
(84, 16, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:34'),
(85, 12, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(86, 13, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(87, 14, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(88, 15, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(89, 16, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(90, 12, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(91, 13, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(92, 14, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(93, 15, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(94, 16, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 100. يرجى التعبئة.', 0, '2026-02-12 09:10:35'),
(95, 12, 'تم إنشاء إحصائية جديدة: محمد550. يرجى التعبئة.', 0, '2026-02-12 09:11:06'),
(96, 13, 'تم إنشاء إحصائية جديدة: محمد550. يرجى التعبئة.', 0, '2026-02-12 09:11:06'),
(97, 14, 'تم إنشاء إحصائية جديدة: محمد550. يرجى التعبئة.', 0, '2026-02-12 09:11:06'),
(98, 12, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(99, 13, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(100, 14, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(101, 15, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(102, 16, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(103, 17, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(104, 18, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:03'),
(105, 12, 'تم إنشاء إحصائية جديدة: الف fhx. يرجى التعبئة.', 0, '2026-02-12 09:34:22'),
(106, 12, 'تم توجيه إحصائية ملفات جديدة لك: الفghhhh', 0, '2026-02-12 09:35:19'),
(107, 6, 'تم إنشاء إحصائية جديدة: محمد000. يرجى التعبئة.', 0, '2026-02-12 10:00:46'),
(108, 7, 'تم إنشاء إحصائية جديدة: محمد000. يرجى التعبئة.', 0, '2026-02-12 10:00:46'),
(109, 8, 'تم إنشاء إحصائية جديدة: محمد000. يرجى التعبئة.', 0, '2026-02-12 10:00:46'),
(110, 9, 'تم إنشاء إحصائية جديدة: محمد000. يرجى التعبئة.', 0, '2026-02-12 10:00:46'),
(111, 10, 'تم إنشاء إحصائية جديدة: محمد000. يرجى التعبئة.', 0, '2026-02-12 10:00:46'),
(112, 11, 'تم إنشاء إحصائية جديدة: محمد000. يرجى التعبئة.', 0, '2026-02-12 10:00:46'),
(113, 6, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 10:06:08'),
(114, 7, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 10:06:08'),
(115, 8, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 10:06:08'),
(116, 9, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 10:06:08'),
(117, 10, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 10:06:08'),
(118, 11, 'تم إنشاء إحصائية جديدة: الف. يرجى التعبئة.', 0, '2026-02-12 10:06:08'),
(119, 6, 'تم إنشاء إحصائية جديدة: احصاء الموظفين حسبالنوعاا. يرجى التعبئة.', 0, '2026-02-12 10:12:49'),
(120, 7, 'تم إنشاء إحصائية جديدة: احصاء الموظفين حسبالنوعاا. يرجى التعبئة.', 0, '2026-02-12 10:12:49'),
(121, 8, 'تم إنشاء إحصائية جديدة: احصاء الموظفين حسبالنوعاا. يرجى التعبئة.', 0, '2026-02-12 10:12:49'),
(122, 9, 'تم إنشاء إحصائية جديدة: احصاء الموظفين حسبالنوعاا. يرجى التعبئة.', 0, '2026-02-12 10:12:49'),
(123, 10, 'تم إنشاء إحصائية جديدة: احصاء الموظفين حسبالنوعاا. يرجى التعبئة.', 0, '2026-02-12 10:12:49'),
(124, 11, 'تم إنشاء إحصائية جديدة: احصاء الموظفين حسبالنوعاا. يرجى التعبئة.', 0, '2026-02-12 10:12:49'),
(125, 6, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 10:15:41'),
(126, 7, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 10:15:41'),
(127, 8, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 10:15:41'),
(128, 9, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 10:15:41'),
(129, 10, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 10:15:41'),
(130, 11, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 10:15:41'),
(131, 6, 'تم إنشاء إحصائية جديدة: الففففففف. يرجى التعبئة.', 0, '2026-02-12 10:22:03'),
(132, 6, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الاساتذة11', 0, '2026-02-12 10:24:50'),
(133, 7, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الاساتذة11', 0, '2026-02-12 10:24:50'),
(134, 8, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الاساتذة11', 0, '2026-02-12 10:24:50'),
(135, 9, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الاساتذة11', 0, '2026-02-12 10:24:50'),
(136, 10, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الاساتذة11', 0, '2026-02-12 10:24:50'),
(137, 11, 'تم توجيه إحصائية ملفات جديدة لك: ملفات الاساتذة11', 0, '2026-02-12 10:24:50'),
(138, 6, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:27:02'),
(139, 7, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:27:02'),
(140, 8, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:27:02'),
(141, 9, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:27:02'),
(142, 10, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:27:02'),
(143, 6, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:32:57'),
(144, 7, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:32:57'),
(145, 8, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:32:57'),
(146, 9, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:32:57'),
(147, 10, 'تم إنشاء إحصائية جديدة: ملفات الطلبة نخ. يرجى التعبئة.', 0, '2026-02-12 10:32:57'),
(148, 6, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 44. يرجى التعبئة.', 0, '2026-02-12 10:36:20'),
(149, 7, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 44. يرجى التعبئة.', 0, '2026-02-12 10:36:20'),
(150, 8, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 44. يرجى التعبئة.', 0, '2026-02-12 10:36:20'),
(151, 9, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 44. يرجى التعبئة.', 0, '2026-02-12 10:36:20'),
(152, 10, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 44. يرجى التعبئة.', 0, '2026-02-12 10:36:20'),
(153, 11, 'تم إنشاء إحصائية جديدة: ملفات الطلبة 44. يرجى التعبئة.', 0, '2026-02-12 10:36:20'),
(154, 6, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:22'),
(155, 7, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:22'),
(156, 8, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:22'),
(157, 9, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:22'),
(158, 10, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:22'),
(159, 11, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:22'),
(160, 6, 'تم إنشاء إحصائية جديدة: ملفات الطلبة قفففف. يرجى التعبئة.', 0, '2026-02-12 10:39:29'),
(161, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:14'),
(162, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:14'),
(163, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:14'),
(164, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:14'),
(165, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:16'),
(166, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:16'),
(167, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:16'),
(168, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:16'),
(169, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(170, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(171, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(172, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(173, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(174, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(175, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(176, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(177, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(178, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(179, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(180, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(181, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(182, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(183, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(184, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:18'),
(185, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(186, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(187, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(188, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(189, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(190, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(191, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(192, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(193, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(194, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(195, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(196, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:19'),
(197, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(198, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(199, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(200, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(201, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(202, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(203, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(204, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(205, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(206, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(207, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(208, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:20'),
(209, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(210, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(211, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(212, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(213, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(214, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(215, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(216, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(217, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(218, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(219, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(220, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(221, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(222, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(223, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(224, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(225, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(226, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(227, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(228, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:21'),
(229, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(230, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(231, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(232, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(233, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(234, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(235, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(236, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(237, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(238, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(239, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(240, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(241, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(242, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(243, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(244, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(245, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(246, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(247, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(248, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:22'),
(249, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(250, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(251, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(252, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(253, 2, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(254, 3, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(255, 4, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(256, 5, 'تم إنشاء إحصائية جديدة: محمد400. يرجى التعبئة.', 0, '2026-02-12 10:46:23'),
(257, 5, 'تم إنشاء إحصائية جديدة: محمد550. يرجى التعبئة.', 0, '2026-02-12 10:46:57'),
(258, 12, 'تم إنشاء إحصائية جديدة: احصائيات الاساتذة oo. يرجى التعبئة.', 0, '2026-02-12 10:59:09'),
(259, 12, 'تم إنشاء إحصائية جديدة: hhhhhh. يرجى التعبئة.', 0, '2026-02-12 11:18:26'),
(260, 12, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(261, 13, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(262, 14, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(263, 15, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(264, 16, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(265, 17, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(266, 18, 'تم إنشاء إحصائية جديدة: uuu. يرجى التعبئة.', 0, '2026-02-12 11:20:35'),
(267, 12, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(268, 13, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(269, 14, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(270, 15, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(271, 16, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(272, 17, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(273, 18, 'تم إنشاء إحصائية جديدة: dfdf. يرجى التعبئة.', 0, '2026-02-12 11:22:48'),
(274, 12, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:37:40'),
(275, 12, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(276, 13, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(277, 14, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(278, 15, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(279, 16, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(280, 17, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(281, 18, 'تم إنشاء إحصائية جديدة: gfg. يرجى التعبئة.', 0, '2026-02-12 11:38:41'),
(282, 12, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(283, 13, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(284, 14, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(285, 15, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(286, 16, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(287, 17, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(288, 18, 'تم إنشاء إحصائية جديدة: gfgfg. يرجى التعبئة.', 0, '2026-02-12 11:46:00'),
(289, 12, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(290, 13, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(291, 14, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(292, 15, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(293, 16, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(294, 17, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(295, 18, 'تم إنشاء إحصائية جديدة: hghghgh. يرجى التعبئة.', 0, '2026-02-12 11:53:46'),
(296, 5, 'تم إنشاء إحصائية جديدة: الف140. يرجى التعبئة.', 0, '2026-02-12 12:01:33'),
(297, 5, 'تم إنشاء إحصائية جديدة: الف140. يرجى التعبئة.', 0, '2026-02-12 12:01:59'),
(298, 5, 'تم إنشاء إحصائية جديدة: الف140. يرجى التعبئة.', 0, '2026-02-12 12:03:58'),
(299, 2, 'تم إنشاء إحصائية جديدة: محمد ففففففففففففففففففففففففف. يرجى التعبئة.', 0, '2026-02-12 12:04:48'),
(300, 3, 'تم إنشاء إحصائية جديدة: محمد ففففففففففففففففففففففففف. يرجى التعبئة.', 0, '2026-02-12 12:04:48'),
(301, 4, 'تم إنشاء إحصائية جديدة: محمد ففففففففففففففففففففففففف. يرجى التعبئة.', 0, '2026-02-12 12:04:48'),
(302, 5, 'تم إنشاء إحصائية جديدة: محمد ففففففففففففففففففففففففف. يرجى التعبئة.', 0, '2026-02-12 12:04:48'),
(303, 12, 'تم إنشاء إحصائية جديدة: rt. يرجى التعبئة.', 0, '2026-02-12 12:06:19'),
(304, 12, 'تم إنشاء إحصائية جديدة: rtttt. يرجى التعبئة.', 0, '2026-02-12 12:11:16'),
(305, 2, 'تم إنشاء إحصائية جديدة: اختبار. يرجى التعبئة.', 0, '2026-02-12 12:19:23'),
(306, 3, 'تم إنشاء إحصائية جديدة: اختبار. يرجى التعبئة.', 0, '2026-02-12 12:19:23'),
(307, 4, 'تم إنشاء إحصائية جديدة: اختبار. يرجى التعبئة.', 0, '2026-02-12 12:19:23'),
(308, 5, 'تم إنشاء إحصائية جديدة: اختبار. يرجى التعبئة.', 0, '2026-02-12 12:19:23'),
(309, 2, 'تم إنشاء إحصائية جديدة: ملفات الطلبة . يرجى التعبئة.', 0, '2026-02-12 12:24:48'),
(310, 3, 'تم إنشاء إحصائية جديدة: ملفات الطلبة . يرجى التعبئة.', 0, '2026-02-12 12:24:48'),
(311, 4, 'تم إنشاء إحصائية جديدة: ملفات الطلبة . يرجى التعبئة.', 0, '2026-02-12 12:24:48'),
(312, 5, 'تم إنشاء إحصائية جديدة: ملفات الطلبة . يرجى التعبئة.', 0, '2026-02-12 12:24:48'),
(313, 5, 'تم إنشاء إحصائية جديدة: ملفات الطلبة ن. يرجى التعبئة.', 0, '2026-02-12 12:43:08');

-- --------------------------------------------------------

--
-- Table structure for table `stat_assignments`
--

CREATE TABLE `stat_assignments` (
  `id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stat_assignments`
--

INSERT INTO `stat_assignments` (`id`, `stat_id`, `user_id`, `assigned_at`) VALUES
(12, 29, 34, '2026-02-12 08:00:31'),
(13, 29, 35, '2026-02-12 08:00:31'),
(14, 30, 3, '2026-02-12 08:47:15'),
(15, 32, 12, '2026-02-12 09:10:34'),
(16, 32, 13, '2026-02-12 09:10:34'),
(17, 32, 14, '2026-02-12 09:10:34'),
(18, 32, 15, '2026-02-12 09:10:34'),
(19, 32, 16, '2026-02-12 09:10:34'),
(20, 33, 12, '2026-02-12 09:10:35'),
(21, 33, 13, '2026-02-12 09:10:35'),
(22, 33, 14, '2026-02-12 09:10:35'),
(23, 33, 15, '2026-02-12 09:10:35'),
(24, 33, 16, '2026-02-12 09:10:35'),
(25, 34, 12, '2026-02-12 09:10:35'),
(26, 34, 13, '2026-02-12 09:10:35'),
(27, 34, 14, '2026-02-12 09:10:35'),
(28, 34, 15, '2026-02-12 09:10:35'),
(29, 34, 16, '2026-02-12 09:10:35'),
(30, 37, 12, '2026-02-12 09:34:22'),
(31, 38, 12, '2026-02-12 09:35:19'),
(32, 43, 6, '2026-02-12 10:22:03'),
(33, 45, 6, '2026-02-12 10:27:02'),
(34, 45, 7, '2026-02-12 10:27:02'),
(35, 45, 8, '2026-02-12 10:27:02'),
(36, 45, 9, '2026-02-12 10:27:02'),
(37, 45, 10, '2026-02-12 10:27:02'),
(38, 46, 6, '2026-02-12 10:32:57'),
(39, 46, 7, '2026-02-12 10:32:57'),
(40, 46, 8, '2026-02-12 10:32:57'),
(41, 46, 9, '2026-02-12 10:32:57'),
(42, 46, 10, '2026-02-12 10:32:57'),
(43, 49, 6, '2026-02-12 10:39:29'),
(44, 74, 5, '2026-02-12 10:46:57'),
(45, 75, 12, '2026-02-12 10:59:09'),
(46, 76, 12, '2026-02-12 11:18:26'),
(47, 80, 12, '2026-02-12 11:37:40'),
(48, 84, 5, '2026-02-12 12:01:33'),
(49, 85, 5, '2026-02-12 12:01:59'),
(50, 86, 5, '2026-02-12 12:03:58'),
(51, 88, 12, '2026-02-12 12:06:19'),
(52, 89, 12, '2026-02-12 12:11:16'),
(53, 92, 5, '2026-02-12 12:43:08');

-- --------------------------------------------------------

--
-- Table structure for table `stat_columns`
--

CREATE TABLE `stat_columns` (
  `id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `column_name` varchar(50) NOT NULL,
  `column_label` varchar(100) NOT NULL,
  `data_type` enum('string','number','boolean','text','integer','decimal','date','file','image') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stat_columns`
--

INSERT INTO `stat_columns` (`id`, `stat_id`, `column_name`, `column_label`, `data_type`) VALUES
(1, 1, 'permanent_professors', 'عدد الأساتذة الدائمين', 'integer'),
(2, 1, 'contract_professors', 'عدد الأساتذة المتعاقدين', 'integer'),
(3, 1, 'admin_staff', 'عدد الموظفين الإداريين', 'integer'),
(4, 1, 'technical_staff', 'عدد الموظفين التقنيين', 'integer'),
(5, 2, 'total_students', 'إجمالي الطلاب', 'integer'),
(6, 2, 'license_students', 'طلاب الليسانس', 'integer'),
(7, 2, 'master_students', 'طلاب الماستر', 'integer'),
(8, 2, 'phd_students', 'طلاب الدكتوراه', 'integer'),
(9, 2, 'foreign_students', 'الطلاب الأجانب', 'integer'),
(10, 2, 'male_students', 'الطلاب الذكور', 'integer'),
(11, 2, 'female_students', 'الطالبات الإناث', 'integer'),
(12, 3, 'research_labs', 'عدد المخابر البحثية', 'integer'),
(13, 3, 'research_units', 'عدد وحدات البحث', 'integer'),
(14, 3, 'prfu_projects', 'مشاريع PRFU', 'integer'),
(15, 3, 'published_articles_a', 'مقالات مصنفة أ', 'integer'),
(16, 3, 'published_articles_b', 'مقالات مصنفة ب', 'integer'),
(17, 3, 'published_articles_c', 'مقالات مصنفة ج', 'integer'),
(18, 3, 'patents', 'براءات الاختراع', 'integer'),
(19, 4, 'operating_budget', 'ميزانية التسيير', 'decimal'),
(20, 4, 'consumption_rate', 'نسبة الاستهلاك', 'decimal'),
(21, 4, 'equipment_budget', 'ميزانية التجهيز', 'decimal'),
(22, 4, 'own_resources', 'الموارد الخاصة', 'decimal'),
(23, 5, 'intl_agreements_bilateral', 'الاتفاقيات الثنائية', 'integer'),
(24, 5, 'intl_agreements_multilateral', 'الاتفاقيات متعددة الأطراف', 'integer'),
(25, 5, 'national_agreements', 'الاتفاقيات الوطنية', 'integer'),
(26, 5, 'intl_conferences', 'التظاهرات الدولية', 'integer'),
(27, 5, 'economic_partnerships', 'شراكات اقتصادية', 'integer'),
(28, 6, 'total_area', 'المساحة الإجمالية', 'decimal'),
(29, 6, 'built_area', 'المساحة المبنية', 'decimal'),
(30, 6, 'teaching_seats', 'المقاعد البيداغوجية', 'integer'),
(31, 6, 'libraries', 'المكتبات', 'integer'),
(32, 6, 'labs', 'المخابر', 'integer'),
(33, 7, 'license_tracks', 'مسارات الليسانس', 'integer'),
(34, 7, 'master_tracks', 'مسارات الماستر', 'integer'),
(35, 7, 'phd_tracks', 'مسارات الدكتوراه', 'integer'),
(36, 7, 'specialized_master_tracks', 'مسارات الماستر التمهيني', 'integer'),
(37, 8, 'defenses_2018', 'مناقشات 2018', 'integer'),
(38, 8, 'defenses_2019', 'مناقشات 2019', 'integer'),
(39, 8, 'expected_defenses_2020', 'مناقشات متوقعة 2020', 'integer'),
(40, 8, 'delayed_phd_students', 'طلاب متأخرون', 'integer'),
(41, 8, 'cotutelle_students', 'طلاب الإشراف المشترك', 'integer'),
(42, 9, 'has_self_assessment', 'تقييم ذاتي', 'boolean'),
(43, 9, 'has_institution_project', 'مشروع مؤسسة', 'boolean'),
(44, 9, 'digital_procedures', 'إجراءات رقمية', 'integer'),
(45, 9, 'social_media_accounts', 'حسابات التواصل', 'integer'),
(46, 10, 'scientific_clubs', 'النوادي العلمية', 'integer'),
(47, 10, 'cultural_associations', 'الجمعيات الثقافية', 'integer'),
(48, 10, 'sports_associations', 'الجمعيات الرياضية', 'integer'),
(49, 10, 'library_closing_time', 'وقت إغلاق المكتبة', 'string'),
(50, 11, 'training_offers_2019', 'عروض 2019', 'integer'),
(51, 11, 'training_offers_2020', 'عروض 2020', 'integer'),
(52, 11, 'continuing_edu_revenue', 'مداخيل التكوين', 'decimal'),
(53, 12, 'license_employment_rate', 'نسبة توظيف الليسانس', 'decimal'),
(54, 12, 'master_employment_rate', 'نسبة توظيف الماستر', 'decimal'),
(55, 12, 'phd_employment_rate', 'نسبة توظيف الدكتوراه h', 'decimal'),
(71, 30, 'd', 'مهندس دولة  ', 'string'),
(72, 32, '1', 'gfg', 'string'),
(73, 33, '1', 'gfg', 'string'),
(74, 34, '1', 'gfg', 'string'),
(75, 35, 'gf', 'gfg', 'string'),
(76, 36, 'a', 'h', 'string'),
(77, 37, 'a', 'h', 'string'),
(79, 40, 'aa', 'h', 'string'),
(80, 40, 'ض', 'hت', 'string'),
(81, 41, 'd', 'انثى', 'string'),
(82, 42, 'x', 'عدد 1', 'string'),
(83, 43, 'aa', 'مهندس دولة  ', 'string'),
(84, 45, 'd', 'ملف1', 'string'),
(85, 46, 'd', 'ملف1', 'string'),
(86, 47, 'a', 'h', 'string'),
(87, 48, 'x', 'انثى', 'string'),
(88, 49, 'x', 'انثى', 'string'),
(89, 50, 'aa', 'عدد 1', 'string'),
(90, 51, 'aa', 'عدد 1', 'string'),
(91, 52, 'aa', 'عدد 1', 'string'),
(92, 53, 'aa', 'عدد 1', 'string'),
(93, 54, 'aa', 'عدد 1', 'string'),
(94, 55, 'aa', 'عدد 1', 'string'),
(95, 56, 'aa', 'عدد 1', 'string'),
(96, 57, 'aa', 'عدد 1', 'string'),
(97, 58, 'aa', 'عدد 1', 'string'),
(98, 59, 'aa', 'عدد 1', 'string'),
(99, 60, 'aa', 'عدد 1', 'string'),
(100, 61, 'aa', 'عدد 1', 'string'),
(101, 62, 'aa', 'عدد 1', 'string'),
(102, 63, 'aa', 'عدد 1', 'string'),
(103, 64, 'aa', 'عدد 1', 'string'),
(104, 65, 'aa', 'عدد 1', 'string'),
(105, 66, 'aa', 'عدد 1', 'string'),
(106, 67, 'aa', 'عدد 1', 'string'),
(107, 68, 'aa', 'عدد 1', 'string'),
(108, 69, 'aa', 'عدد 1', 'string'),
(109, 70, 'aa', 'عدد 1', 'string'),
(110, 71, 'aa', 'عدد 1', 'string'),
(111, 72, 'aa', 'عدد 1', 'string'),
(112, 73, 'aa', 'عدد 1', 'string'),
(113, 74, '1', 'ملف1', 'string'),
(114, 75, 'ghg', 'ghg', 'string'),
(115, 76, 'hhh', 'hhhh', 'string'),
(116, 77, 'uu', 'uu', 'string'),
(117, 78, 'dfdf', 'fdfd', 'string'),
(118, 79, 'ghgh', 'hghgh', 'string'),
(119, 80, 'fgfg', 'fgfg', 'string'),
(120, 81, 'fgfg', 'fgfg', 'string'),
(121, 82, 'fgfgf', 'fgfg', 'string'),
(122, 83, 'ghghg', 'ghgh', 'string'),
(123, 84, 'ghghg', 'hghgh', 'string'),
(124, 85, 'ghghg', 'hghgh', 'string'),
(125, 86, 'ghghg', 'hghgh', 'string'),
(126, 87, 'azz', 'h', 'string'),
(127, 88, 're', 'rt', 'string'),
(128, 89, 'ttt', 'ttt', 'string'),
(129, 90, 'd', 'عدد', 'integer'),
(130, 91, 'a', 'مهندس دولة  ', 'string'),
(131, 92, 'x', 'عدد 1', 'string');

-- --------------------------------------------------------

--
-- Table structure for table `stat_definitions`
--

CREATE TABLE `stat_definitions` (
  `id` int(11) NOT NULL,
  `creator_id` int(11) NOT NULL,
  `stat_name` varchar(100) NOT NULL,
  `stat_type` enum('monthly','six_months','yearly','file_exchange') NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `parent_stat_id` int(11) DEFAULT NULL,
  `target_type` enum('all_subordinates','specific_users') DEFAULT 'all_subordinates'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stat_definitions`
--

INSERT INTO `stat_definitions` (`id`, `creator_id`, `stat_name`, `stat_type`, `table_name`, `created_at`, `parent_stat_id`, `target_type`) VALUES
(1, 1, 'إحصائيات الموارد البشرية', 'yearly', 'dynamic_stat_hr_employees', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(2, 1, 'إحصائيات الطلاب', 'yearly', 'dynamic_stat_students', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(3, 3, 'إحصائيات البحث العلمي', 'yearly', 'dynamic_stat_research', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(4, 5, 'إحصائيات الميزانية', 'six_months', 'dynamic_stat_budget', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(5, 3, 'إحصائيات التعاون الدولي', 'yearly', 'dynamic_stat_cooperation', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(6, 5, 'إحصائيات البنية التحتية', 'yearly', 'dynamic_stat_infrastructure', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(7, 2, 'إحصائيات خارطة التكوين', 'yearly', 'dynamic_stat_training_map', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(8, 3, 'إحصائيات مردودية الدكتوراه', 'yearly', 'dynamic_stat_phd_performance', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(9, 5, 'إحصائيات الحوكمة والرقمنة', 'yearly', 'dynamic_stat_governance', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(10, 5, 'إحصائيات ظروف الحياة الجامعية', 'yearly', 'dynamic_stat_campus_life', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(11, 2, 'إحصائيات التكوين المتواصل', 'yearly', 'dynamic_stat_continuing_edu', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(12, 3, 'إحصائيات متابعة المتخرجين', 'yearly', 'dynamic_stat_graduates', '2026-02-08 12:32:25', NULL, 'all_subordinates'),
(13, 2, 'احصائيات المخابر البحثية ', 'yearly', 'dynamic_stat_1770623746_674', '2026-02-09 07:55:46', NULL, 'all_subordinates'),
(29, 11, 'احصائيات الاساتذة k', 'monthly', 'dynamic_stat_1770883231_677', '2026-02-12 08:00:31', NULL, 'specific_users'),
(30, 1, 'الف', 'yearly', 'dynamic_stat_1770886035_145', '2026-02-12 08:47:15', NULL, 'specific_users'),
(31, 1, 'ملفات الطلبة', 'file_exchange', 'file_stat_1770886886_143', '2026-02-12 09:01:26', NULL, 'all_subordinates'),
(32, 5, 'ملفات الطلبة 100', 'yearly', 'dynamic_stat_1770887434_883', '2026-02-12 09:10:34', NULL, 'specific_users'),
(33, 5, 'ملفات الطلبة 100', 'yearly', 'dynamic_stat_1770887435_922', '2026-02-12 09:10:35', NULL, 'specific_users'),
(34, 5, 'ملفات الطلبة 100', 'yearly', 'dynamic_stat_1770887435_577', '2026-02-12 09:10:35', NULL, 'specific_users'),
(35, 5, 'محمد550', 'monthly', 'dynamic_stat_1770887466_380', '2026-02-12 09:11:06', NULL, 'all_subordinates'),
(36, 5, 'الف fhx', 'yearly', 'dynamic_stat_1770888843_341', '2026-02-12 09:34:03', NULL, 'all_subordinates'),
(37, 5, 'الف fhx', 'yearly', 'dynamic_stat_1770888862_509', '2026-02-12 09:34:22', NULL, 'specific_users'),
(38, 5, 'الفghhhh', 'file_exchange', 'file_stat_1770888919_852', '2026-02-12 09:35:19', NULL, 'specific_users'),
(40, 2, 'الف', 'six_months', 'dynamic_stat_1770890768_504', '2026-02-12 10:06:08', NULL, 'all_subordinates'),
(41, 2, 'احصاء الموظفين حسبالنوعاا', 'monthly', 'dynamic_stat_1770891169_772', '2026-02-12 10:12:49', NULL, 'all_subordinates'),
(42, 2, 'ملفات الطلبة ن', 'monthly', 'dynamic_stat_1770891341_930', '2026-02-12 10:15:41', NULL, 'all_subordinates'),
(43, 2, 'الففففففف', 'monthly', 'dynamic_stat_1770891723_875', '2026-02-12 10:22:03', NULL, 'specific_users'),
(44, 2, 'ملفات الاساتذة11', 'file_exchange', 'file_stat_1770891890_527', '2026-02-12 10:24:50', NULL, 'all_subordinates'),
(45, 2, 'ملفات الطلبة نخ', 'monthly', 'dynamic_stat_1770892022_166', '2026-02-12 10:27:02', NULL, 'specific_users'),
(46, 2, 'ملفات الطلبة نخ', 'monthly', 'dynamic_stat_1770892377_792', '2026-02-12 10:32:57', NULL, 'specific_users'),
(47, 2, 'ملفات الطلبة 44', 'yearly', 'dynamic_stat_1770892580_400', '2026-02-12 10:36:20', NULL, 'all_subordinates'),
(48, 2, 'ملفات الطلبة قفففف', 'monthly', 'dynamic_stat_1770892762_351', '2026-02-12 10:39:22', NULL, 'all_subordinates'),
(49, 2, 'ملفات الطلبة قفففف', 'monthly', 'dynamic_stat_1770892769_275', '2026-02-12 10:39:29', NULL, 'specific_users'),
(50, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893174_925', '2026-02-12 10:46:14', NULL, ''),
(51, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893176_778', '2026-02-12 10:46:16', NULL, ''),
(52, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893178_531', '2026-02-12 10:46:18', NULL, ''),
(53, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893178_831', '2026-02-12 10:46:18', NULL, ''),
(54, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893178_381', '2026-02-12 10:46:18', NULL, ''),
(55, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893178_651', '2026-02-12 10:46:18', NULL, ''),
(56, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893179_191', '2026-02-12 10:46:19', NULL, ''),
(57, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893179_903', '2026-02-12 10:46:19', NULL, ''),
(58, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893179_858', '2026-02-12 10:46:19', NULL, ''),
(59, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893180_424', '2026-02-12 10:46:20', NULL, ''),
(60, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893180_559', '2026-02-12 10:46:20', NULL, ''),
(61, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893180_792', '2026-02-12 10:46:20', NULL, ''),
(62, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893181_560', '2026-02-12 10:46:21', NULL, ''),
(63, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893181_381', '2026-02-12 10:46:21', NULL, ''),
(64, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893181_531', '2026-02-12 10:46:21', NULL, ''),
(65, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893181_315', '2026-02-12 10:46:21', NULL, ''),
(66, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893181_322', '2026-02-12 10:46:21', NULL, ''),
(67, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893182_799', '2026-02-12 10:46:22', NULL, ''),
(68, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893182_706', '2026-02-12 10:46:22', NULL, ''),
(69, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893182_393', '2026-02-12 10:46:22', NULL, ''),
(70, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893182_826', '2026-02-12 10:46:22', NULL, ''),
(71, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893182_961', '2026-02-12 10:46:22', NULL, ''),
(72, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893183_597', '2026-02-12 10:46:23', NULL, ''),
(73, 1, 'محمد400', 'monthly', 'dynamic_stat_1770893183_557', '2026-02-12 10:46:23', NULL, ''),
(74, 1, 'محمد550', 'yearly', 'dynamic_stat_1770893217_423', '2026-02-12 10:46:57', NULL, 'specific_users'),
(75, 5, 'احصائيات الاساتذة oo', 'yearly', 'dynamic_stat_1770893949_925', '2026-02-12 10:59:09', NULL, 'specific_users'),
(76, 5, 'hhhhhh', 'yearly', 'dynamic_stat_1770895106_577', '2026-02-12 11:18:26', NULL, 'specific_users'),
(77, 5, 'uuu', 'yearly', 'dynamic_stat_1770895235_609', '2026-02-12 11:20:35', NULL, 'all_subordinates'),
(78, 5, 'dfdf', 'yearly', 'dynamic_stat_1770895368_820', '2026-02-12 11:22:48', NULL, 'all_subordinates'),
(79, 5, 'ghgh', 'yearly', 'dynamic_stat_1770895450_494', '2026-02-12 11:24:10', NULL, 'specific_users'),
(80, 5, 'gfg', 'yearly', 'dynamic_stat_1770896260_177', '2026-02-12 11:37:40', NULL, 'specific_users'),
(81, 5, 'gfg', 'yearly', 'dynamic_stat_1770896321_264', '2026-02-12 11:38:41', NULL, 'all_subordinates'),
(82, 5, 'gfgfg', 'yearly', 'dynamic_stat_1770896760_304', '2026-02-12 11:46:00', NULL, 'all_subordinates'),
(83, 5, 'hghghgh', 'yearly', 'dynamic_stat_1770897226_584', '2026-02-12 11:53:46', NULL, 'all_subordinates'),
(84, 1, 'الف140', 'yearly', 'dynamic_stat_1770897693_408', '2026-02-12 12:01:33', NULL, 'specific_users'),
(85, 1, 'الف140', 'yearly', 'dynamic_stat_1770897719_888', '2026-02-12 12:01:59', NULL, 'specific_users'),
(86, 1, 'الف140', 'yearly', 'dynamic_stat_1770897838_386', '2026-02-12 12:03:58', NULL, 'specific_users'),
(87, 1, 'محمد ففففففففففففففففففففففففف', 'yearly', 'dynamic_stat_1770897888_531', '2026-02-12 12:04:48', NULL, 'all_subordinates'),
(88, 5, 'rt', 'monthly', 'dynamic_stat_1770897979_448', '2026-02-12 12:06:19', NULL, 'specific_users'),
(89, 5, 'rtttt', 'yearly', 'dynamic_stat_1770898276_611', '2026-02-12 12:11:16', 1, 'specific_users'),
(90, 1, 'اختبار', 'monthly', 'dynamic_stat_1770898763_811', '2026-02-12 12:19:23', NULL, 'all_subordinates'),
(91, 1, 'ملفات الطلبة ', 'monthly', 'dynamic_stat_1770899088_252', '2026-02-12 12:24:48', NULL, 'all_subordinates'),
(92, 1, 'ملفات الطلبة ن', 'yearly', 'dynamic_stat_1770900188_877', '2026-02-12 12:43:08', NULL, 'specific_users');

-- --------------------------------------------------------

--
-- Table structure for table `stat_edit_history`
--

CREATE TABLE `stat_edit_history` (
  `id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `record_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `old_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_data`)),
  `new_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_data`)),
  `edited_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stat_files`
--

CREATE TABLE `stat_files` (
  `id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `stat_year` int(11) NOT NULL,
  `stat_period` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stat_submissions`
--

CREATE TABLE `stat_submissions` (
  `id` int(11) NOT NULL,
  `stat_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` enum('pending','completed') DEFAULT 'pending',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_finalized` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stat_submissions`
--

INSERT INTO `stat_submissions` (`id`, `stat_id`, `user_id`, `status`, `submitted_at`, `updated_at`, `is_finalized`) VALUES
(38, 29, 34, 'pending', NULL, '2026-02-12 08:00:31', 0),
(39, 29, 35, 'pending', NULL, '2026-02-12 08:00:31', 0),
(40, 29, 11, 'completed', '2026-02-12 08:01:09', '2026-02-12 08:01:09', 0),
(41, 30, 3, 'pending', NULL, '2026-02-12 08:47:15', 0),
(42, 31, 5, 'pending', NULL, '2026-02-12 09:01:26', 0),
(43, 31, 30, 'pending', NULL, '2026-02-12 09:01:26', 0),
(44, 31, 26, 'pending', NULL, '2026-02-12 09:01:26', 0),
(45, 31, 23, 'pending', NULL, '2026-02-12 09:01:26', 0),
(46, 31, 29, 'pending', NULL, '2026-02-12 09:01:26', 0),
(47, 31, 31, 'pending', NULL, '2026-02-12 09:01:26', 0),
(48, 31, 33, 'pending', NULL, '2026-02-12 09:01:26', 0),
(49, 31, 36, 'pending', NULL, '2026-02-12 09:01:26', 0),
(50, 31, 24, 'pending', NULL, '2026-02-12 09:01:26', 0),
(51, 31, 34, 'pending', NULL, '2026-02-12 09:01:26', 0),
(52, 31, 35, 'pending', NULL, '2026-02-12 09:01:26', 0),
(53, 31, 28, 'pending', NULL, '2026-02-12 09:01:26', 0),
(54, 31, 25, 'pending', NULL, '2026-02-12 09:01:26', 0),
(55, 31, 21, 'pending', NULL, '2026-02-12 09:01:26', 0),
(56, 31, 19, 'pending', NULL, '2026-02-12 09:01:26', 0),
(57, 31, 20, 'pending', NULL, '2026-02-12 09:01:26', 0),
(58, 31, 27, 'pending', NULL, '2026-02-12 09:01:26', 0),
(59, 31, 32, 'pending', NULL, '2026-02-12 09:01:26', 0),
(60, 31, 22, 'pending', NULL, '2026-02-12 09:01:26', 0),
(61, 31, 6, 'pending', NULL, '2026-02-12 09:01:26', 0),
(62, 31, 11, 'pending', NULL, '2026-02-12 09:01:26', 0),
(63, 31, 9, 'pending', NULL, '2026-02-12 09:01:26', 0),
(64, 31, 10, 'pending', NULL, '2026-02-12 09:01:26', 0),
(65, 31, 8, 'pending', NULL, '2026-02-12 09:01:26', 0),
(66, 31, 7, 'pending', NULL, '2026-02-12 09:01:26', 0),
(67, 31, 14, 'pending', NULL, '2026-02-12 09:01:26', 0),
(68, 31, 15, 'pending', NULL, '2026-02-12 09:01:26', 0),
(69, 31, 17, 'pending', NULL, '2026-02-12 09:01:26', 0),
(70, 31, 18, 'pending', NULL, '2026-02-12 09:01:26', 0),
(71, 31, 12, 'pending', NULL, '2026-02-12 09:01:26', 0),
(72, 31, 13, 'pending', NULL, '2026-02-12 09:01:26', 0),
(73, 31, 16, 'pending', NULL, '2026-02-12 09:01:26', 0),
(74, 31, 4, 'pending', NULL, '2026-02-12 09:01:26', 0),
(75, 31, 2, 'pending', NULL, '2026-02-12 09:01:26', 0),
(76, 31, 3, 'pending', NULL, '2026-02-12 09:01:26', 0),
(77, 32, 12, 'pending', NULL, '2026-02-12 09:10:34', 0),
(78, 32, 13, 'pending', NULL, '2026-02-12 09:10:34', 0),
(79, 32, 14, 'pending', NULL, '2026-02-12 09:10:34', 0),
(80, 32, 15, 'pending', NULL, '2026-02-12 09:10:34', 0),
(81, 32, 16, 'pending', NULL, '2026-02-12 09:10:34', 0),
(82, 33, 12, 'pending', NULL, '2026-02-12 09:10:35', 0),
(83, 33, 13, 'pending', NULL, '2026-02-12 09:10:35', 0),
(84, 33, 14, 'pending', NULL, '2026-02-12 09:10:35', 0),
(85, 33, 15, 'pending', NULL, '2026-02-12 09:10:35', 0),
(86, 33, 16, 'pending', NULL, '2026-02-12 09:10:35', 0),
(87, 34, 12, 'pending', NULL, '2026-02-12 09:10:35', 0),
(88, 34, 13, 'pending', NULL, '2026-02-12 09:10:35', 0),
(89, 34, 14, 'pending', NULL, '2026-02-12 09:10:35', 0),
(90, 34, 15, 'pending', NULL, '2026-02-12 09:10:35', 0),
(91, 34, 16, 'pending', NULL, '2026-02-12 09:10:35', 0),
(92, 35, 12, 'pending', NULL, '2026-02-12 09:11:06', 0),
(93, 35, 13, 'pending', NULL, '2026-02-12 09:11:06', 0),
(94, 35, 14, 'pending', NULL, '2026-02-12 09:11:06', 0),
(95, 36, 12, 'pending', NULL, '2026-02-12 09:34:03', 0),
(96, 36, 13, 'pending', NULL, '2026-02-12 09:34:03', 0),
(97, 36, 14, 'pending', NULL, '2026-02-12 09:34:03', 0),
(98, 36, 15, 'pending', NULL, '2026-02-12 09:34:03', 0),
(99, 36, 16, 'pending', NULL, '2026-02-12 09:34:03', 0),
(100, 36, 17, 'pending', NULL, '2026-02-12 09:34:03', 0),
(101, 36, 18, 'pending', NULL, '2026-02-12 09:34:03', 0),
(102, 37, 12, 'pending', NULL, '2026-02-12 09:34:22', 0),
(103, 38, 12, 'pending', NULL, '2026-02-12 09:35:19', 0),
(110, 40, 6, 'pending', NULL, '2026-02-12 10:06:08', 0),
(111, 40, 7, 'pending', NULL, '2026-02-12 10:06:08', 0),
(112, 40, 8, 'pending', NULL, '2026-02-12 10:06:08', 0),
(113, 40, 9, 'pending', NULL, '2026-02-12 10:06:08', 0),
(114, 40, 10, 'pending', NULL, '2026-02-12 10:06:08', 0),
(115, 40, 11, 'pending', NULL, '2026-02-12 10:06:08', 0),
(116, 41, 6, 'pending', NULL, '2026-02-12 10:12:49', 0),
(117, 41, 7, 'pending', NULL, '2026-02-12 10:12:49', 0),
(118, 41, 8, 'pending', NULL, '2026-02-12 10:12:49', 0),
(119, 41, 9, 'pending', NULL, '2026-02-12 10:12:49', 0),
(120, 41, 10, 'pending', NULL, '2026-02-12 10:12:49', 0),
(121, 41, 11, 'pending', NULL, '2026-02-12 10:12:49', 0),
(122, 42, 6, 'pending', NULL, '2026-02-12 10:15:41', 0),
(123, 42, 7, 'pending', NULL, '2026-02-12 10:15:41', 0),
(124, 42, 8, 'pending', NULL, '2026-02-12 10:15:41', 0),
(125, 42, 9, 'pending', NULL, '2026-02-12 10:15:41', 0),
(126, 42, 10, 'pending', NULL, '2026-02-12 10:15:41', 0),
(127, 42, 11, 'pending', NULL, '2026-02-12 10:15:41', 0),
(128, 43, 6, 'pending', NULL, '2026-02-12 10:22:03', 0),
(129, 44, 6, 'pending', NULL, '2026-02-12 10:24:50', 0),
(130, 44, 7, 'pending', NULL, '2026-02-12 10:24:50', 0),
(131, 44, 8, 'pending', NULL, '2026-02-12 10:24:50', 0),
(132, 44, 9, 'pending', NULL, '2026-02-12 10:24:50', 0),
(133, 44, 10, 'pending', NULL, '2026-02-12 10:24:50', 0),
(134, 44, 11, 'pending', NULL, '2026-02-12 10:24:50', 0),
(135, 45, 6, 'pending', NULL, '2026-02-12 10:27:02', 0),
(136, 45, 7, 'pending', NULL, '2026-02-12 10:27:02', 0),
(137, 45, 8, 'pending', NULL, '2026-02-12 10:27:02', 0),
(138, 45, 9, 'pending', NULL, '2026-02-12 10:27:02', 0),
(139, 45, 10, 'pending', NULL, '2026-02-12 10:27:02', 0),
(140, 46, 6, 'pending', NULL, '2026-02-12 10:32:57', 0),
(141, 46, 7, 'pending', NULL, '2026-02-12 10:32:57', 0),
(142, 46, 8, 'pending', NULL, '2026-02-12 10:32:57', 0),
(143, 46, 9, 'pending', NULL, '2026-02-12 10:32:57', 0),
(144, 46, 10, 'pending', NULL, '2026-02-12 10:32:57', 0),
(145, 47, 6, 'pending', NULL, '2026-02-12 10:36:20', 0),
(146, 47, 7, 'pending', NULL, '2026-02-12 10:36:20', 0),
(147, 47, 8, 'pending', NULL, '2026-02-12 10:36:20', 0),
(148, 47, 9, 'pending', NULL, '2026-02-12 10:36:20', 0),
(149, 47, 10, 'pending', NULL, '2026-02-12 10:36:20', 0),
(150, 47, 11, 'pending', NULL, '2026-02-12 10:36:20', 0),
(151, 48, 6, 'pending', NULL, '2026-02-12 10:39:22', 0),
(152, 48, 7, 'pending', NULL, '2026-02-12 10:39:22', 0),
(153, 48, 8, 'pending', NULL, '2026-02-12 10:39:22', 0),
(154, 48, 9, 'pending', NULL, '2026-02-12 10:39:22', 0),
(155, 48, 10, 'pending', NULL, '2026-02-12 10:39:22', 0),
(156, 48, 11, 'pending', NULL, '2026-02-12 10:39:22', 0),
(157, 49, 6, 'pending', NULL, '2026-02-12 10:39:29', 0),
(158, 50, 2, 'pending', NULL, '2026-02-12 10:46:14', 0),
(159, 50, 3, 'pending', NULL, '2026-02-12 10:46:14', 0),
(160, 50, 4, 'pending', NULL, '2026-02-12 10:46:14', 0),
(161, 50, 5, 'pending', NULL, '2026-02-12 10:46:14', 0),
(162, 51, 2, 'pending', NULL, '2026-02-12 10:46:16', 0),
(163, 51, 3, 'pending', NULL, '2026-02-12 10:46:16', 0),
(164, 51, 4, 'pending', NULL, '2026-02-12 10:46:16', 0),
(165, 51, 5, 'pending', NULL, '2026-02-12 10:46:16', 0),
(166, 52, 2, 'pending', NULL, '2026-02-12 10:46:18', 0),
(167, 52, 3, 'pending', NULL, '2026-02-12 10:46:18', 0),
(168, 52, 4, 'pending', NULL, '2026-02-12 10:46:18', 0),
(169, 52, 5, 'pending', NULL, '2026-02-12 10:46:18', 0),
(170, 53, 2, 'pending', NULL, '2026-02-12 10:46:18', 0),
(171, 53, 3, 'pending', NULL, '2026-02-12 10:46:18', 0),
(172, 53, 4, 'pending', NULL, '2026-02-12 10:46:18', 0),
(173, 53, 5, 'pending', NULL, '2026-02-12 10:46:18', 0),
(174, 54, 2, 'pending', NULL, '2026-02-12 10:46:18', 0),
(175, 54, 3, 'pending', NULL, '2026-02-12 10:46:18', 0),
(176, 54, 4, 'pending', NULL, '2026-02-12 10:46:18', 0),
(177, 54, 5, 'pending', NULL, '2026-02-12 10:46:18', 0),
(178, 55, 2, 'pending', NULL, '2026-02-12 10:46:18', 0),
(179, 55, 3, 'pending', NULL, '2026-02-12 10:46:18', 0),
(180, 55, 4, 'pending', NULL, '2026-02-12 10:46:18', 0),
(181, 55, 5, 'pending', NULL, '2026-02-12 10:46:18', 0),
(182, 56, 2, 'pending', NULL, '2026-02-12 10:46:19', 0),
(183, 56, 3, 'pending', NULL, '2026-02-12 10:46:19', 0),
(184, 56, 4, 'pending', NULL, '2026-02-12 10:46:19', 0),
(185, 56, 5, 'pending', NULL, '2026-02-12 10:46:19', 0),
(186, 57, 2, 'pending', NULL, '2026-02-12 10:46:19', 0),
(187, 57, 3, 'pending', NULL, '2026-02-12 10:46:19', 0),
(188, 57, 4, 'pending', NULL, '2026-02-12 10:46:19', 0),
(189, 57, 5, 'pending', NULL, '2026-02-12 10:46:19', 0),
(190, 58, 2, 'pending', NULL, '2026-02-12 10:46:19', 0),
(191, 58, 3, 'pending', NULL, '2026-02-12 10:46:19', 0),
(192, 58, 4, 'pending', NULL, '2026-02-12 10:46:19', 0),
(193, 58, 5, 'pending', NULL, '2026-02-12 10:46:19', 0),
(194, 59, 2, 'pending', NULL, '2026-02-12 10:46:20', 0),
(195, 59, 3, 'pending', NULL, '2026-02-12 10:46:20', 0),
(196, 59, 4, 'pending', NULL, '2026-02-12 10:46:20', 0),
(197, 59, 5, 'pending', NULL, '2026-02-12 10:46:20', 0),
(198, 60, 2, 'pending', NULL, '2026-02-12 10:46:20', 0),
(199, 60, 3, 'pending', NULL, '2026-02-12 10:46:20', 0),
(200, 60, 4, 'pending', NULL, '2026-02-12 10:46:20', 0),
(201, 60, 5, 'pending', NULL, '2026-02-12 10:46:20', 0),
(202, 61, 2, 'pending', NULL, '2026-02-12 10:46:20', 0),
(203, 61, 3, 'pending', NULL, '2026-02-12 10:46:20', 0),
(204, 61, 4, 'pending', NULL, '2026-02-12 10:46:20', 0),
(205, 61, 5, 'pending', NULL, '2026-02-12 10:46:20', 0),
(206, 62, 2, 'pending', NULL, '2026-02-12 10:46:21', 0),
(207, 62, 3, 'pending', NULL, '2026-02-12 10:46:21', 0),
(208, 62, 4, 'pending', NULL, '2026-02-12 10:46:21', 0),
(209, 62, 5, 'pending', NULL, '2026-02-12 10:46:21', 0),
(210, 63, 2, 'pending', NULL, '2026-02-12 10:46:21', 0),
(211, 63, 3, 'pending', NULL, '2026-02-12 10:46:21', 0),
(212, 63, 4, 'pending', NULL, '2026-02-12 10:46:21', 0),
(213, 63, 5, 'pending', NULL, '2026-02-12 10:46:21', 0),
(214, 64, 2, 'pending', NULL, '2026-02-12 10:46:21', 0),
(215, 64, 3, 'pending', NULL, '2026-02-12 10:46:21', 0),
(216, 64, 4, 'pending', NULL, '2026-02-12 10:46:21', 0),
(217, 64, 5, 'pending', NULL, '2026-02-12 10:46:21', 0),
(218, 65, 2, 'pending', NULL, '2026-02-12 10:46:21', 0),
(219, 65, 3, 'pending', NULL, '2026-02-12 10:46:21', 0),
(220, 65, 4, 'pending', NULL, '2026-02-12 10:46:21', 0),
(221, 65, 5, 'pending', NULL, '2026-02-12 10:46:21', 0),
(222, 66, 2, 'pending', NULL, '2026-02-12 10:46:21', 0),
(223, 66, 3, 'pending', NULL, '2026-02-12 10:46:21', 0),
(224, 66, 4, 'pending', NULL, '2026-02-12 10:46:21', 0),
(225, 66, 5, 'pending', NULL, '2026-02-12 10:46:21', 0),
(226, 67, 2, 'pending', NULL, '2026-02-12 10:46:22', 0),
(227, 67, 3, 'pending', NULL, '2026-02-12 10:46:22', 0),
(228, 67, 4, 'pending', NULL, '2026-02-12 10:46:22', 0),
(229, 67, 5, 'pending', NULL, '2026-02-12 10:46:22', 0),
(230, 68, 2, 'pending', NULL, '2026-02-12 10:46:22', 0),
(231, 68, 3, 'pending', NULL, '2026-02-12 10:46:22', 0),
(232, 68, 4, 'pending', NULL, '2026-02-12 10:46:22', 0),
(233, 68, 5, 'pending', NULL, '2026-02-12 10:46:22', 0),
(234, 69, 2, 'pending', NULL, '2026-02-12 10:46:22', 0),
(235, 69, 3, 'pending', NULL, '2026-02-12 10:46:22', 0),
(236, 69, 4, 'pending', NULL, '2026-02-12 10:46:22', 0),
(237, 69, 5, 'pending', NULL, '2026-02-12 10:46:22', 0),
(238, 70, 2, 'pending', NULL, '2026-02-12 10:46:22', 0),
(239, 70, 3, 'pending', NULL, '2026-02-12 10:46:22', 0),
(240, 70, 4, 'pending', NULL, '2026-02-12 10:46:22', 0),
(241, 70, 5, 'pending', NULL, '2026-02-12 10:46:22', 0),
(242, 71, 2, 'pending', NULL, '2026-02-12 10:46:22', 0),
(243, 71, 3, 'pending', NULL, '2026-02-12 10:46:22', 0),
(244, 71, 4, 'pending', NULL, '2026-02-12 10:46:22', 0),
(245, 71, 5, 'pending', NULL, '2026-02-12 10:46:22', 0),
(246, 72, 2, 'pending', NULL, '2026-02-12 10:46:23', 0),
(247, 72, 3, 'pending', NULL, '2026-02-12 10:46:23', 0),
(248, 72, 4, 'pending', NULL, '2026-02-12 10:46:23', 0),
(249, 72, 5, 'pending', NULL, '2026-02-12 10:46:23', 0),
(250, 73, 2, 'pending', NULL, '2026-02-12 10:46:23', 0),
(251, 73, 3, 'pending', NULL, '2026-02-12 10:46:23', 0),
(252, 73, 4, 'pending', NULL, '2026-02-12 10:46:23', 0),
(253, 73, 5, 'pending', NULL, '2026-02-12 10:46:23', 0),
(254, 74, 5, 'pending', NULL, '2026-02-12 10:46:57', 0),
(255, 75, 12, 'pending', NULL, '2026-02-12 10:59:09', 0),
(256, 76, 12, 'pending', NULL, '2026-02-12 11:18:26', 0),
(257, 77, 12, 'pending', NULL, '2026-02-12 11:20:35', 0),
(258, 77, 13, 'pending', NULL, '2026-02-12 11:20:35', 0),
(259, 77, 14, 'pending', NULL, '2026-02-12 11:20:35', 0),
(260, 77, 15, 'pending', NULL, '2026-02-12 11:20:35', 0),
(261, 77, 16, 'pending', NULL, '2026-02-12 11:20:35', 0),
(262, 77, 17, 'pending', NULL, '2026-02-12 11:20:35', 0),
(263, 77, 18, 'pending', NULL, '2026-02-12 11:20:35', 0),
(264, 78, 12, 'pending', NULL, '2026-02-12 11:22:48', 0),
(265, 78, 13, 'pending', NULL, '2026-02-12 11:22:48', 0),
(266, 78, 14, 'pending', NULL, '2026-02-12 11:22:48', 0),
(267, 78, 15, 'pending', NULL, '2026-02-12 11:22:48', 0),
(268, 78, 16, 'pending', NULL, '2026-02-12 11:22:48', 0),
(269, 78, 17, 'pending', NULL, '2026-02-12 11:22:48', 0),
(270, 78, 18, 'pending', NULL, '2026-02-12 11:22:48', 0),
(271, 80, 12, 'pending', NULL, '2026-02-12 11:37:40', 0),
(272, 81, 12, 'pending', NULL, '2026-02-12 11:38:41', 0),
(273, 81, 13, 'pending', NULL, '2026-02-12 11:38:41', 0),
(274, 81, 14, 'pending', NULL, '2026-02-12 11:38:41', 0),
(275, 81, 15, 'pending', NULL, '2026-02-12 11:38:41', 0),
(276, 81, 16, 'pending', NULL, '2026-02-12 11:38:41', 0),
(277, 81, 17, 'pending', NULL, '2026-02-12 11:38:41', 0),
(278, 81, 18, 'pending', NULL, '2026-02-12 11:38:41', 0),
(279, 82, 12, 'pending', NULL, '2026-02-12 11:46:00', 0),
(280, 82, 13, 'pending', NULL, '2026-02-12 11:46:00', 0),
(281, 82, 14, 'pending', NULL, '2026-02-12 11:46:00', 0),
(282, 82, 15, 'pending', NULL, '2026-02-12 11:46:00', 0),
(283, 82, 16, 'pending', NULL, '2026-02-12 11:46:00', 0),
(284, 82, 17, 'pending', NULL, '2026-02-12 11:46:00', 0),
(285, 82, 18, 'pending', NULL, '2026-02-12 11:46:00', 0),
(286, 83, 12, 'pending', NULL, '2026-02-12 11:53:46', 0),
(287, 83, 13, 'pending', NULL, '2026-02-12 11:53:46', 0),
(288, 83, 14, 'pending', NULL, '2026-02-12 11:53:46', 0),
(289, 83, 15, 'pending', NULL, '2026-02-12 11:53:46', 0),
(290, 83, 16, 'pending', NULL, '2026-02-12 11:53:46', 0),
(291, 83, 17, 'pending', NULL, '2026-02-12 11:53:46', 0),
(292, 83, 18, 'pending', NULL, '2026-02-12 11:53:46', 0),
(293, 84, 5, 'pending', NULL, '2026-02-12 12:01:33', 0),
(294, 85, 5, 'pending', NULL, '2026-02-12 12:01:59', 0),
(295, 86, 5, 'pending', NULL, '2026-02-12 12:03:58', 0),
(296, 87, 2, 'pending', NULL, '2026-02-12 12:04:48', 0),
(297, 87, 3, 'pending', NULL, '2026-02-12 12:04:48', 0),
(298, 87, 4, 'pending', NULL, '2026-02-12 12:04:48', 0),
(299, 87, 5, 'pending', NULL, '2026-02-12 12:04:48', 0),
(300, 88, 12, 'pending', NULL, '2026-02-12 12:06:19', 0),
(301, 89, 12, 'pending', NULL, '2026-02-12 12:11:16', 0),
(302, 90, 2, 'pending', NULL, '2026-02-12 12:19:23', 0),
(303, 90, 3, 'pending', NULL, '2026-02-12 12:19:23', 0),
(304, 90, 4, 'pending', NULL, '2026-02-12 12:19:23', 0),
(305, 90, 5, 'pending', NULL, '2026-02-12 12:19:23', 0),
(306, 91, 2, 'pending', NULL, '2026-02-12 12:24:48', 0),
(307, 91, 3, 'pending', NULL, '2026-02-12 12:24:48', 0),
(308, 91, 4, 'pending', NULL, '2026-02-12 12:24:48', 0),
(309, 91, 5, 'pending', NULL, '2026-02-12 12:24:48', 0),
(310, 92, 5, 'pending', NULL, '2026-02-12 12:43:08', 0);

-- --------------------------------------------------------

--
-- Table structure for table `structures`
--

CREATE TABLE `structures` (
  `id` int(11) NOT NULL,
  `name_ar` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `structures`
--

INSERT INTO `structures` (`id`, `name_ar`, `type`, `parent_id`) VALUES
(1, 'المديرية', 'rectorat', NULL),
(2, 'ن.م للدراسات في التدرج', 'vice_rectorat', 1),
(3, 'ن.م لما بعد التدرج والبحث العلمي', 'vice_rectorat', 1),
(4, 'ن.م للتنمية والاستشراف', 'vice_rectorat', 1),
(5, 'الأمانة العامة', 'secretariat', 1),
(6, 'كلية الآداب واللغات', 'faculty', 2),
(7, 'كلية علوم الطبيعة والحياة', 'faculty', 2),
(8, 'كلية العلوم والتكنولوجيا', 'faculty', 2),
(9, 'كلية الرياضيات والإعلام الآلي', 'faculty', 2),
(10, 'كلية العلوم الاقتصادية', 'faculty', 2),
(11, 'كلية الحقوق', 'faculty', 2),
(12, 'قسم اللغة العربية', 'department', 6),
(13, 'قسم اللغة الفرنسية', 'department', 6),
(14, 'قسم اللغة الإنجليزية', 'department', 6),
(15, 'قسم علوم الطبيعة والحياة', 'department', 7),
(16, 'قسم التكنولوجيا الحيوية', 'department', 7),
(17, 'قسم الفيزياء', 'department', 8),
(18, 'قسم الكيمياء', 'department', 8),
(19, 'قسم الإلكترونيك', 'department', 8),
(20, 'قسم الميكانيك', 'department', 8),
(21, 'قسم الرياضيات', 'department', 9),
(22, 'قسم الإعلام الآلي', 'department', 9),
(23, 'قسم العلوم الاقتصادية', 'department', 10),
(24, 'قسم علوم التسيير', 'department', 10),
(25, 'قسم القانون الخاص', 'department', 11),
(26, 'قسم القانون العام', 'department', 11);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `role_level` int(11) NOT NULL COMMENT '1:مدير، 2:نائب/أمين عام، 3:عميد/مدير مصلحة، 4:رئيس قسم',
  `parent_id` int(11) DEFAULT NULL,
  `structure_type` varchar(50) DEFAULT NULL COMMENT 'نوع الهيكل: rectorat, vice_rectorat, secretariat, faculty, department, service',
  `structure_name` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `full_name`, `email`, `phone`, `role_level`, `parent_id`, `structure_type`, `structure_name`, `is_active`, `created_at`) VALUES
(1, 'directeur', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير الجامعة', 'directeur@univ-mila.dz', '031.45.00.45', 1, NULL, 'rectorat', 'المديرية', 1, '2026-02-08 12:32:24'),
(2, 'vice_pedagogie', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'نائب مدير الجامعة للدراسات في التدرج والتكوين المتواصل', 'vice.pedagogie@univ-mila.dz', '031.45.00.46', 2, 1, 'vice_rectorat', 'ن.م للدراسات في التدرج والتكوين المتواصل', 1, '2026-02-08 12:32:24'),
(3, 'vice_postgrad', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'نائب مدير الجامعة لما بعد التدرج والبحث العلمي', 'vice.postgrad@univ-mila.dz', '031.45.00.47', 2, 1, 'vice_rectorat', 'ن.م لما بعد التدرج والبحث العلمي', 1, '2026-02-08 12:32:24'),
(4, 'vice_developpement', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'نائب مدير الجامعة للتنمية والاستشراف والتوجيه', 'vice.dev@univ-mila.dz', '031.45.00.48', 2, 1, 'vice_rectorat', 'ن.م للتنمية والاستشراف والتوجيه', 1, '2026-02-08 12:32:24'),
(5, 'secretaire_general', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'الأمين العام للجامعة', 'sg@univ-mila.dz', '031.45.00.03', 2, 1, 'secretariat', 'الأمانة العامة', 1, '2026-02-08 12:32:24'),
(6, 'doyen_lettres', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'عميد كلية الآداب واللغات', 'doyen.lettres@univ-mila.dz', '031.45.01.01', 3, 2, 'faculty', 'كلية الآداب واللغات', 1, '2026-02-08 12:32:24'),
(7, 'doyen_snvt', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'عميد كلية علوم الطبيعة والحياة', 'doyen.snvt@univ-mila.dz', '031.45.02.02', 3, 2, 'faculty', 'كلية علوم الطبيعة والحياة', 1, '2026-02-08 12:32:24'),
(8, 'doyen_st', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'عميد كلية العلوم والتكنولوجيا', 'doyen.st@univ-mila.dz', '031.45.03.03', 3, 2, 'faculty', 'كلية العلوم والتكنولوجيا', 1, '2026-02-08 12:32:24'),
(9, 'doyen_mi', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'عميد كلية الرياضيات والإعلام الآلي', 'doyen.mi@univ-mila.dz', '031.45.04.04', 3, 2, 'faculty', 'كلية الرياضيات والإعلام الآلي', 1, '2026-02-08 12:32:24'),
(10, 'doyen_eco', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'عميد كلية العلوم الاقتصادية والتجارية وعلوم التسيير', 'doyen.eco@univ-mila.dz', '031.45.05.05', 3, 2, 'faculty', 'كلية العلوم الاقتصادية والتجارية وعلوم التسيير', 1, '2026-02-08 12:32:24'),
(11, 'doyen_droit', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'عميد كلية الحقوق', 'doyen.droit@univ-mila.dz', '031.45.06.06', 3, 2, 'faculty', 'كلية الحقوق', 1, '2026-02-08 12:32:24'),
(12, 'directeur_personnel', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير مصلحة المستخدمين والتكوين', 'drh@univ-mila.dz', '031.45.00.10', 3, 5, 'service', 'مصلحة المستخدمين والتكوين', 1, '2026-02-08 12:32:24'),
(13, 'directeur_finance', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير مصلحة الميزانية والمحاسبة', 'finance@univ-mila.dz', '031.45.00.11', 3, 5, 'service', 'مصلحة الميزانية والمحاسبة', 1, '2026-02-08 12:32:24'),
(14, 'directeur_technique', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير المصالح التقنية المشتركة', 'tech@univ-mila.dz', '031.45.00.12', 3, 5, 'service', 'المصالح التقنية المشتركة', 1, '2026-02-08 12:32:24'),
(15, 'directeur_bibliotheque', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير المكتبة المركزية', 'bib@univ-mila.dz', '031.45.00.13', 3, 5, 'service', 'المكتبة المركزية', 1, '2026-02-08 12:32:24'),
(16, 'directeur_medecine', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير وحدة الطب الوقائي', 'medecine@univ-mila.dz', '031.45.00.14', 3, 5, 'service', 'وحدة الطب الوقائي', 1, '2026-02-08 12:32:24'),
(17, 'directeur_qhse', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير خلية ضمان الجودة', 'qhse@univ-mila.dz', '031.45.00.15', 3, 5, 'service', 'خلية ضمان الجودة', 1, '2026-02-08 12:32:24'),
(18, 'directeur_entrepreneuriat', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'مدير دار المقاولاتية', 'entrep@univ-mila.dz', '031.45.00.16', 3, 5, 'service', 'دار المقاولاتية', 1, '2026-02-08 12:32:24'),
(19, 'chef_arabe', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم اللغة العربية وآدابها', 'chef.arabe@univ-mila.dz', '031.45.01.10', 4, 6, 'department', 'قسم اللغة العربية', 1, '2026-02-08 12:32:24'),
(20, 'chef_francais', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم اللغة الفرنسية', 'chef.francais@univ-mila.dz', '031.45.01.11', 4, 6, 'department', 'قسم اللغة الفرنسية', 1, '2026-02-08 12:32:24'),
(21, 'chef_anglais', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم اللغة الإنجليزية', 'chef.anglais@univ-mila.dz', '031.45.01.12', 4, 6, 'department', 'قسم اللغة الإنجليزية', 1, '2026-02-08 12:32:24'),
(22, 'chef_biologie', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم علوم الطبيعة والحياة', 'chef.biologie@univ-mila.dz', '031.45.02.10', 4, 7, 'department', 'قسم علوم الطبيعة والحياة', 1, '2026-02-08 12:32:24'),
(23, 'chef_biotech', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم التكنولوجيا الحيوية', 'chef.biotech@univ-mila.dz', '031.45.02.11', 4, 7, 'department', 'قسم التكنولوجيا الحيوية', 1, '2026-02-08 12:32:24'),
(24, 'chef_physique', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الفيزياء', 'chef.physique@univ-mila.dz', '031.45.03.10', 4, 8, 'department', 'قسم الفيزياء', 1, '2026-02-08 12:32:24'),
(25, 'chef_chimie', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الكيمياء', 'chef.chimie@univ-mila.dz', '031.45.03.11', 4, 8, 'department', 'قسم الكيمياء', 1, '2026-02-08 12:32:24'),
(26, 'chef_electronique', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الإلكترونيك', 'chef.electronique@univ-mila.dz', '031.45.03.12', 4, 8, 'department', 'قسم الإلكترونيك', 1, '2026-02-08 12:32:24'),
(27, 'chef_mecanique', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الميكانيك', 'chef.mecanique@univ-mila.dz', '031.45.03.13', 4, 8, 'department', 'قسم الميكانيك', 1, '2026-02-08 12:32:24'),
(28, 'chef_electrotech', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الكهروتقنية', 'chef.electrotech@univ-mila.dz', '031.45.03.14', 4, 8, 'department', 'قسم الكهروتقنية', 1, '2026-02-08 12:32:24'),
(29, 'chef_math', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الرياضيات', 'chef.math@univ-mila.dz', '031.45.04.10', 4, 9, 'department', 'قسم الرياضيات', 1, '2026-02-08 12:32:24'),
(30, 'chef_info', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم الإعلام الآلي', 'chef.info@univ-mila.dz', '031.45.04.11', 4, 9, 'department', 'قسم الإعلام الآلي', 1, '2026-02-08 12:32:24'),
(31, 'chef_economie', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم العلوم الاقتصادية', 'chef.economie@univ-mila.dz', '031.45.05.10', 4, 10, 'department', 'قسم العلوم الاقتصادية', 1, '2026-02-08 12:32:24'),
(32, 'chef_gestion', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم علوم التسيير', 'chef.gestion@univ-mila.dz', '031.45.05.11', 4, 10, 'department', 'قسم علوم التسيير', 1, '2026-02-08 12:32:24'),
(33, 'chef_commerce', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم العلوم التجارية', 'chef.commerce@univ-mila.dz', '031.45.05.12', 4, 10, 'department', 'قسم العلوم التجارية', 1, '2026-02-08 12:32:24'),
(34, 'chef_droit_priv', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم القانون الخاص', 'chef.droit.priv@univ-mila.dz', '031.45.06.10', 4, 11, 'department', 'قسم القانون الخاص', 1, '2026-02-08 12:32:24'),
(35, 'chef_droit_pub', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم القانون العام', 'chef.droit.pub@univ-mila.dz', '031.45.06.11', 4, 11, 'department', 'قسم القانون العام', 1, '2026-02-08 12:32:24'),
(36, 'chef_sc_pol', '$2y$10$JTNMy9X51MyZuuEOpVzJAOXmIEUj01O/HS9QFqKUpxTtvDnKG5O/2', 'رئيس قسم العلوم السياسية', 'chef.sc.pol@univ-mila.dz', '031.45.06.12', 4, 11, 'department', 'قسم العلوم السياسية', 1, '2026-02-08 12:32:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `academic_years`
--
ALTER TABLE `academic_years`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dynamic_stat_1770886035_145`
--
ALTER TABLE `dynamic_stat_1770886035_145`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770887434_883`
--
ALTER TABLE `dynamic_stat_1770887434_883`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770887435_577`
--
ALTER TABLE `dynamic_stat_1770887435_577`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770887435_922`
--
ALTER TABLE `dynamic_stat_1770887435_922`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770887466_380`
--
ALTER TABLE `dynamic_stat_1770887466_380`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770888843_341`
--
ALTER TABLE `dynamic_stat_1770888843_341`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770888862_509`
--
ALTER TABLE `dynamic_stat_1770888862_509`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770890768_504`
--
ALTER TABLE `dynamic_stat_1770890768_504`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770891169_772`
--
ALTER TABLE `dynamic_stat_1770891169_772`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770891341_930`
--
ALTER TABLE `dynamic_stat_1770891341_930`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770891723_875`
--
ALTER TABLE `dynamic_stat_1770891723_875`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770892022_166`
--
ALTER TABLE `dynamic_stat_1770892022_166`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770892377_792`
--
ALTER TABLE `dynamic_stat_1770892377_792`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770892580_400`
--
ALTER TABLE `dynamic_stat_1770892580_400`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770892762_351`
--
ALTER TABLE `dynamic_stat_1770892762_351`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770892769_275`
--
ALTER TABLE `dynamic_stat_1770892769_275`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893174_925`
--
ALTER TABLE `dynamic_stat_1770893174_925`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893176_778`
--
ALTER TABLE `dynamic_stat_1770893176_778`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893178_381`
--
ALTER TABLE `dynamic_stat_1770893178_381`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893178_531`
--
ALTER TABLE `dynamic_stat_1770893178_531`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893178_651`
--
ALTER TABLE `dynamic_stat_1770893178_651`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893178_831`
--
ALTER TABLE `dynamic_stat_1770893178_831`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893179_191`
--
ALTER TABLE `dynamic_stat_1770893179_191`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893179_858`
--
ALTER TABLE `dynamic_stat_1770893179_858`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893179_903`
--
ALTER TABLE `dynamic_stat_1770893179_903`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893180_424`
--
ALTER TABLE `dynamic_stat_1770893180_424`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893180_559`
--
ALTER TABLE `dynamic_stat_1770893180_559`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893180_792`
--
ALTER TABLE `dynamic_stat_1770893180_792`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893181_315`
--
ALTER TABLE `dynamic_stat_1770893181_315`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893181_322`
--
ALTER TABLE `dynamic_stat_1770893181_322`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893181_381`
--
ALTER TABLE `dynamic_stat_1770893181_381`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893181_531`
--
ALTER TABLE `dynamic_stat_1770893181_531`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893181_560`
--
ALTER TABLE `dynamic_stat_1770893181_560`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893182_393`
--
ALTER TABLE `dynamic_stat_1770893182_393`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893182_706`
--
ALTER TABLE `dynamic_stat_1770893182_706`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893182_799`
--
ALTER TABLE `dynamic_stat_1770893182_799`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893182_826`
--
ALTER TABLE `dynamic_stat_1770893182_826`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893182_961`
--
ALTER TABLE `dynamic_stat_1770893182_961`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893183_557`
--
ALTER TABLE `dynamic_stat_1770893183_557`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893183_597`
--
ALTER TABLE `dynamic_stat_1770893183_597`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893217_423`
--
ALTER TABLE `dynamic_stat_1770893217_423`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770893949_925`
--
ALTER TABLE `dynamic_stat_1770893949_925`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770895106_577`
--
ALTER TABLE `dynamic_stat_1770895106_577`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770895235_609`
--
ALTER TABLE `dynamic_stat_1770895235_609`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770895368_820`
--
ALTER TABLE `dynamic_stat_1770895368_820`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770895450_494`
--
ALTER TABLE `dynamic_stat_1770895450_494`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770896260_177`
--
ALTER TABLE `dynamic_stat_1770896260_177`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770896321_264`
--
ALTER TABLE `dynamic_stat_1770896321_264`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770896760_304`
--
ALTER TABLE `dynamic_stat_1770896760_304`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770897226_584`
--
ALTER TABLE `dynamic_stat_1770897226_584`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770897693_408`
--
ALTER TABLE `dynamic_stat_1770897693_408`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770897719_888`
--
ALTER TABLE `dynamic_stat_1770897719_888`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770897838_386`
--
ALTER TABLE `dynamic_stat_1770897838_386`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770897888_531`
--
ALTER TABLE `dynamic_stat_1770897888_531`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770897979_448`
--
ALTER TABLE `dynamic_stat_1770897979_448`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770898276_611`
--
ALTER TABLE `dynamic_stat_1770898276_611`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770898763_811`
--
ALTER TABLE `dynamic_stat_1770898763_811`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770899088_252`
--
ALTER TABLE `dynamic_stat_1770899088_252`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_1770900188_877`
--
ALTER TABLE `dynamic_stat_1770900188_877`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_budget`
--
ALTER TABLE `dynamic_stat_budget`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_campus_life`
--
ALTER TABLE `dynamic_stat_campus_life`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_continuing_edu`
--
ALTER TABLE `dynamic_stat_continuing_edu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_cooperation`
--
ALTER TABLE `dynamic_stat_cooperation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_governance`
--
ALTER TABLE `dynamic_stat_governance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_graduates`
--
ALTER TABLE `dynamic_stat_graduates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_hr_employees`
--
ALTER TABLE `dynamic_stat_hr_employees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_infrastructure`
--
ALTER TABLE `dynamic_stat_infrastructure`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_phd_performance`
--
ALTER TABLE `dynamic_stat_phd_performance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_research`
--
ALTER TABLE `dynamic_stat_research`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_students`
--
ALTER TABLE `dynamic_stat_students`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `dynamic_stat_training_map`
--
ALTER TABLE `dynamic_stat_training_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `file_exchanges`
--
ALTER TABLE `file_exchanges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stat_id` (`stat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `file_stat_1770886886_143`
--
ALTER TABLE `file_stat_1770886886_143`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `stat_year` (`stat_year`,`stat_period`);

--
-- Indexes for table `file_stat_1770888919_852`
--
ALTER TABLE `file_stat_1770888919_852`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `stat_year` (`stat_year`,`stat_period`);

--
-- Indexes for table `file_stat_1770891890_527`
--
ALTER TABLE `file_stat_1770891890_527`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `stat_year` (`stat_year`,`stat_period`);

--
-- Indexes for table `indicators`
--
ALTER TABLE `indicators`
  ADD PRIMARY KEY (`id`),
  ADD KEY `domain_id` (`domain_id`);

--
-- Indexes for table `indicator_values`
--
ALTER TABLE `indicator_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `indicator_id` (`indicator_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `academic_year_id` (`academic_year_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `message_attachments`
--
ALTER TABLE `message_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_id` (`message_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `stat_assignments`
--
ALTER TABLE `stat_assignments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_assignment` (`stat_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `stat_columns`
--
ALTER TABLE `stat_columns`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stat_id` (`stat_id`);

--
-- Indexes for table `stat_definitions`
--
ALTER TABLE `stat_definitions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `table_name` (`table_name`),
  ADD KEY `creator_id` (`creator_id`),
  ADD KEY `parent_stat_id` (`parent_stat_id`);

--
-- Indexes for table `stat_edit_history`
--
ALTER TABLE `stat_edit_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stat_id` (`stat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `stat_files`
--
ALTER TABLE `stat_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `stat_id` (`stat_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `stat_submissions`
--
ALTER TABLE `stat_submissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_submission` (`stat_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `structures`
--
ALTER TABLE `structures`
  ADD PRIMARY KEY (`id`),
  ADD KEY `struct_parent_fk` (`parent_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `role_level` (`role_level`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `academic_years`
--
ALTER TABLE `academic_years`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `domains`
--
ALTER TABLE `domains`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770886035_145`
--
ALTER TABLE `dynamic_stat_1770886035_145`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770887434_883`
--
ALTER TABLE `dynamic_stat_1770887434_883`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770887435_577`
--
ALTER TABLE `dynamic_stat_1770887435_577`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770887435_922`
--
ALTER TABLE `dynamic_stat_1770887435_922`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770887466_380`
--
ALTER TABLE `dynamic_stat_1770887466_380`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770888843_341`
--
ALTER TABLE `dynamic_stat_1770888843_341`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770888862_509`
--
ALTER TABLE `dynamic_stat_1770888862_509`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770890768_504`
--
ALTER TABLE `dynamic_stat_1770890768_504`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770891169_772`
--
ALTER TABLE `dynamic_stat_1770891169_772`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770891341_930`
--
ALTER TABLE `dynamic_stat_1770891341_930`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770891723_875`
--
ALTER TABLE `dynamic_stat_1770891723_875`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770892022_166`
--
ALTER TABLE `dynamic_stat_1770892022_166`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770892377_792`
--
ALTER TABLE `dynamic_stat_1770892377_792`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770892580_400`
--
ALTER TABLE `dynamic_stat_1770892580_400`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770892762_351`
--
ALTER TABLE `dynamic_stat_1770892762_351`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770892769_275`
--
ALTER TABLE `dynamic_stat_1770892769_275`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893174_925`
--
ALTER TABLE `dynamic_stat_1770893174_925`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893176_778`
--
ALTER TABLE `dynamic_stat_1770893176_778`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893178_381`
--
ALTER TABLE `dynamic_stat_1770893178_381`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893178_531`
--
ALTER TABLE `dynamic_stat_1770893178_531`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893178_651`
--
ALTER TABLE `dynamic_stat_1770893178_651`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893178_831`
--
ALTER TABLE `dynamic_stat_1770893178_831`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893179_191`
--
ALTER TABLE `dynamic_stat_1770893179_191`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893179_858`
--
ALTER TABLE `dynamic_stat_1770893179_858`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893179_903`
--
ALTER TABLE `dynamic_stat_1770893179_903`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893180_424`
--
ALTER TABLE `dynamic_stat_1770893180_424`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893180_559`
--
ALTER TABLE `dynamic_stat_1770893180_559`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893180_792`
--
ALTER TABLE `dynamic_stat_1770893180_792`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893181_315`
--
ALTER TABLE `dynamic_stat_1770893181_315`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893181_322`
--
ALTER TABLE `dynamic_stat_1770893181_322`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893181_381`
--
ALTER TABLE `dynamic_stat_1770893181_381`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893181_531`
--
ALTER TABLE `dynamic_stat_1770893181_531`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893181_560`
--
ALTER TABLE `dynamic_stat_1770893181_560`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893182_393`
--
ALTER TABLE `dynamic_stat_1770893182_393`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893182_706`
--
ALTER TABLE `dynamic_stat_1770893182_706`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893182_799`
--
ALTER TABLE `dynamic_stat_1770893182_799`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893182_826`
--
ALTER TABLE `dynamic_stat_1770893182_826`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893182_961`
--
ALTER TABLE `dynamic_stat_1770893182_961`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893183_557`
--
ALTER TABLE `dynamic_stat_1770893183_557`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893183_597`
--
ALTER TABLE `dynamic_stat_1770893183_597`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893217_423`
--
ALTER TABLE `dynamic_stat_1770893217_423`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770893949_925`
--
ALTER TABLE `dynamic_stat_1770893949_925`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770895106_577`
--
ALTER TABLE `dynamic_stat_1770895106_577`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770895235_609`
--
ALTER TABLE `dynamic_stat_1770895235_609`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770895368_820`
--
ALTER TABLE `dynamic_stat_1770895368_820`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770895450_494`
--
ALTER TABLE `dynamic_stat_1770895450_494`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770896260_177`
--
ALTER TABLE `dynamic_stat_1770896260_177`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770896321_264`
--
ALTER TABLE `dynamic_stat_1770896321_264`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770896760_304`
--
ALTER TABLE `dynamic_stat_1770896760_304`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770897226_584`
--
ALTER TABLE `dynamic_stat_1770897226_584`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770897693_408`
--
ALTER TABLE `dynamic_stat_1770897693_408`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770897719_888`
--
ALTER TABLE `dynamic_stat_1770897719_888`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770897838_386`
--
ALTER TABLE `dynamic_stat_1770897838_386`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770897888_531`
--
ALTER TABLE `dynamic_stat_1770897888_531`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770897979_448`
--
ALTER TABLE `dynamic_stat_1770897979_448`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770898276_611`
--
ALTER TABLE `dynamic_stat_1770898276_611`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770898763_811`
--
ALTER TABLE `dynamic_stat_1770898763_811`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770899088_252`
--
ALTER TABLE `dynamic_stat_1770899088_252`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_1770900188_877`
--
ALTER TABLE `dynamic_stat_1770900188_877`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `dynamic_stat_budget`
--
ALTER TABLE `dynamic_stat_budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dynamic_stat_campus_life`
--
ALTER TABLE `dynamic_stat_campus_life`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dynamic_stat_continuing_edu`
--
ALTER TABLE `dynamic_stat_continuing_edu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dynamic_stat_cooperation`
--
ALTER TABLE `dynamic_stat_cooperation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dynamic_stat_governance`
--
ALTER TABLE `dynamic_stat_governance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dynamic_stat_graduates`
--
ALTER TABLE `dynamic_stat_graduates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dynamic_stat_hr_employees`
--
ALTER TABLE `dynamic_stat_hr_employees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `dynamic_stat_infrastructure`
--
ALTER TABLE `dynamic_stat_infrastructure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dynamic_stat_phd_performance`
--
ALTER TABLE `dynamic_stat_phd_performance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `dynamic_stat_research`
--
ALTER TABLE `dynamic_stat_research`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dynamic_stat_students`
--
ALTER TABLE `dynamic_stat_students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `dynamic_stat_training_map`
--
ALTER TABLE `dynamic_stat_training_map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `file_exchanges`
--
ALTER TABLE `file_exchanges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_stat_1770886886_143`
--
ALTER TABLE `file_stat_1770886886_143`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_stat_1770888919_852`
--
ALTER TABLE `file_stat_1770888919_852`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `file_stat_1770891890_527`
--
ALTER TABLE `file_stat_1770891890_527`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `indicators`
--
ALTER TABLE `indicators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT for table `indicator_values`
--
ALTER TABLE `indicator_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `message_attachments`
--
ALTER TABLE `message_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=314;

--
-- AUTO_INCREMENT for table `stat_assignments`
--
ALTER TABLE `stat_assignments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `stat_columns`
--
ALTER TABLE `stat_columns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=132;

--
-- AUTO_INCREMENT for table `stat_definitions`
--
ALTER TABLE `stat_definitions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT for table `stat_edit_history`
--
ALTER TABLE `stat_edit_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stat_files`
--
ALTER TABLE `stat_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stat_submissions`
--
ALTER TABLE `stat_submissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=311;

--
-- AUTO_INCREMENT for table `structures`
--
ALTER TABLE `structures`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `audit_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770886035_145`
--
ALTER TABLE `dynamic_stat_1770886035_145`
  ADD CONSTRAINT `dynamic_stat_1770886035_145_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770887434_883`
--
ALTER TABLE `dynamic_stat_1770887434_883`
  ADD CONSTRAINT `dynamic_stat_1770887434_883_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `dynamic_stat_1770887435_577`
--
ALTER TABLE `dynamic_stat_1770887435_577`
  ADD CONSTRAINT `dynamic_stat_1770887435_577_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `dynamic_stat_1770887435_922`
--
ALTER TABLE `dynamic_stat_1770887435_922`
  ADD CONSTRAINT `dynamic_stat_1770887435_922_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `dynamic_stat_1770887466_380`
--
ALTER TABLE `dynamic_stat_1770887466_380`
  ADD CONSTRAINT `dynamic_stat_1770887466_380_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `dynamic_stat_1770888843_341`
--
ALTER TABLE `dynamic_stat_1770888843_341`
  ADD CONSTRAINT `dynamic_stat_1770888843_341_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770888862_509`
--
ALTER TABLE `dynamic_stat_1770888862_509`
  ADD CONSTRAINT `dynamic_stat_1770888862_509_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770890768_504`
--
ALTER TABLE `dynamic_stat_1770890768_504`
  ADD CONSTRAINT `dynamic_stat_1770890768_504_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770891169_772`
--
ALTER TABLE `dynamic_stat_1770891169_772`
  ADD CONSTRAINT `dynamic_stat_1770891169_772_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770891341_930`
--
ALTER TABLE `dynamic_stat_1770891341_930`
  ADD CONSTRAINT `dynamic_stat_1770891341_930_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770891723_875`
--
ALTER TABLE `dynamic_stat_1770891723_875`
  ADD CONSTRAINT `dynamic_stat_1770891723_875_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770892022_166`
--
ALTER TABLE `dynamic_stat_1770892022_166`
  ADD CONSTRAINT `dynamic_stat_1770892022_166_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770892377_792`
--
ALTER TABLE `dynamic_stat_1770892377_792`
  ADD CONSTRAINT `dynamic_stat_1770892377_792_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770892580_400`
--
ALTER TABLE `dynamic_stat_1770892580_400`
  ADD CONSTRAINT `dynamic_stat_1770892580_400_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770892762_351`
--
ALTER TABLE `dynamic_stat_1770892762_351`
  ADD CONSTRAINT `dynamic_stat_1770892762_351_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770892769_275`
--
ALTER TABLE `dynamic_stat_1770892769_275`
  ADD CONSTRAINT `dynamic_stat_1770892769_275_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893174_925`
--
ALTER TABLE `dynamic_stat_1770893174_925`
  ADD CONSTRAINT `dynamic_stat_1770893174_925_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893176_778`
--
ALTER TABLE `dynamic_stat_1770893176_778`
  ADD CONSTRAINT `dynamic_stat_1770893176_778_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893178_381`
--
ALTER TABLE `dynamic_stat_1770893178_381`
  ADD CONSTRAINT `dynamic_stat_1770893178_381_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893178_531`
--
ALTER TABLE `dynamic_stat_1770893178_531`
  ADD CONSTRAINT `dynamic_stat_1770893178_531_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893178_651`
--
ALTER TABLE `dynamic_stat_1770893178_651`
  ADD CONSTRAINT `dynamic_stat_1770893178_651_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893178_831`
--
ALTER TABLE `dynamic_stat_1770893178_831`
  ADD CONSTRAINT `dynamic_stat_1770893178_831_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893179_191`
--
ALTER TABLE `dynamic_stat_1770893179_191`
  ADD CONSTRAINT `dynamic_stat_1770893179_191_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893179_858`
--
ALTER TABLE `dynamic_stat_1770893179_858`
  ADD CONSTRAINT `dynamic_stat_1770893179_858_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893179_903`
--
ALTER TABLE `dynamic_stat_1770893179_903`
  ADD CONSTRAINT `dynamic_stat_1770893179_903_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893180_424`
--
ALTER TABLE `dynamic_stat_1770893180_424`
  ADD CONSTRAINT `dynamic_stat_1770893180_424_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893180_559`
--
ALTER TABLE `dynamic_stat_1770893180_559`
  ADD CONSTRAINT `dynamic_stat_1770893180_559_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893180_792`
--
ALTER TABLE `dynamic_stat_1770893180_792`
  ADD CONSTRAINT `dynamic_stat_1770893180_792_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893181_315`
--
ALTER TABLE `dynamic_stat_1770893181_315`
  ADD CONSTRAINT `dynamic_stat_1770893181_315_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893181_322`
--
ALTER TABLE `dynamic_stat_1770893181_322`
  ADD CONSTRAINT `dynamic_stat_1770893181_322_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893181_381`
--
ALTER TABLE `dynamic_stat_1770893181_381`
  ADD CONSTRAINT `dynamic_stat_1770893181_381_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893181_531`
--
ALTER TABLE `dynamic_stat_1770893181_531`
  ADD CONSTRAINT `dynamic_stat_1770893181_531_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893181_560`
--
ALTER TABLE `dynamic_stat_1770893181_560`
  ADD CONSTRAINT `dynamic_stat_1770893181_560_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893182_393`
--
ALTER TABLE `dynamic_stat_1770893182_393`
  ADD CONSTRAINT `dynamic_stat_1770893182_393_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893182_706`
--
ALTER TABLE `dynamic_stat_1770893182_706`
  ADD CONSTRAINT `dynamic_stat_1770893182_706_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893182_799`
--
ALTER TABLE `dynamic_stat_1770893182_799`
  ADD CONSTRAINT `dynamic_stat_1770893182_799_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893182_826`
--
ALTER TABLE `dynamic_stat_1770893182_826`
  ADD CONSTRAINT `dynamic_stat_1770893182_826_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893182_961`
--
ALTER TABLE `dynamic_stat_1770893182_961`
  ADD CONSTRAINT `dynamic_stat_1770893182_961_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893183_557`
--
ALTER TABLE `dynamic_stat_1770893183_557`
  ADD CONSTRAINT `dynamic_stat_1770893183_557_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893183_597`
--
ALTER TABLE `dynamic_stat_1770893183_597`
  ADD CONSTRAINT `dynamic_stat_1770893183_597_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893217_423`
--
ALTER TABLE `dynamic_stat_1770893217_423`
  ADD CONSTRAINT `dynamic_stat_1770893217_423_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770893949_925`
--
ALTER TABLE `dynamic_stat_1770893949_925`
  ADD CONSTRAINT `dynamic_stat_1770893949_925_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770895106_577`
--
ALTER TABLE `dynamic_stat_1770895106_577`
  ADD CONSTRAINT `dynamic_stat_1770895106_577_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770895235_609`
--
ALTER TABLE `dynamic_stat_1770895235_609`
  ADD CONSTRAINT `dynamic_stat_1770895235_609_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770895368_820`
--
ALTER TABLE `dynamic_stat_1770895368_820`
  ADD CONSTRAINT `dynamic_stat_1770895368_820_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770895450_494`
--
ALTER TABLE `dynamic_stat_1770895450_494`
  ADD CONSTRAINT `dynamic_stat_1770895450_494_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770896260_177`
--
ALTER TABLE `dynamic_stat_1770896260_177`
  ADD CONSTRAINT `dynamic_stat_1770896260_177_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770896321_264`
--
ALTER TABLE `dynamic_stat_1770896321_264`
  ADD CONSTRAINT `dynamic_stat_1770896321_264_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770896760_304`
--
ALTER TABLE `dynamic_stat_1770896760_304`
  ADD CONSTRAINT `dynamic_stat_1770896760_304_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770897226_584`
--
ALTER TABLE `dynamic_stat_1770897226_584`
  ADD CONSTRAINT `dynamic_stat_1770897226_584_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770897693_408`
--
ALTER TABLE `dynamic_stat_1770897693_408`
  ADD CONSTRAINT `dynamic_stat_1770897693_408_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770897719_888`
--
ALTER TABLE `dynamic_stat_1770897719_888`
  ADD CONSTRAINT `dynamic_stat_1770897719_888_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770897838_386`
--
ALTER TABLE `dynamic_stat_1770897838_386`
  ADD CONSTRAINT `dynamic_stat_1770897838_386_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770897888_531`
--
ALTER TABLE `dynamic_stat_1770897888_531`
  ADD CONSTRAINT `dynamic_stat_1770897888_531_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770897979_448`
--
ALTER TABLE `dynamic_stat_1770897979_448`
  ADD CONSTRAINT `dynamic_stat_1770897979_448_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770898276_611`
--
ALTER TABLE `dynamic_stat_1770898276_611`
  ADD CONSTRAINT `dynamic_stat_1770898276_611_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770898763_811`
--
ALTER TABLE `dynamic_stat_1770898763_811`
  ADD CONSTRAINT `dynamic_stat_1770898763_811_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770899088_252`
--
ALTER TABLE `dynamic_stat_1770899088_252`
  ADD CONSTRAINT `dynamic_stat_1770899088_252_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `dynamic_stat_1770900188_877`
--
ALTER TABLE `dynamic_stat_1770900188_877`
  ADD CONSTRAINT `dynamic_stat_1770900188_877_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `file_exchanges`
--
ALTER TABLE `file_exchanges`
  ADD CONSTRAINT `fe_stat_fk` FOREIGN KEY (`stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fe_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `file_stat_1770886886_143`
--
ALTER TABLE `file_stat_1770886886_143`
  ADD CONSTRAINT `file_stat_1770886886_143_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `file_stat_1770888919_852`
--
ALTER TABLE `file_stat_1770888919_852`
  ADD CONSTRAINT `file_stat_1770888919_852_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `file_stat_1770891890_527`
--
ALTER TABLE `file_stat_1770891890_527`
  ADD CONSTRAINT `file_stat_1770891890_527_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `indicators`
--
ALTER TABLE `indicators`
  ADD CONSTRAINT `ind_domain_fk` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `indicator_values`
--
ALTER TABLE `indicator_values`
  ADD CONSTRAINT `iv_indicator_fk` FOREIGN KEY (`indicator_id`) REFERENCES `indicators` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `iv_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `iv_year_fk` FOREIGN KEY (`academic_year_id`) REFERENCES `academic_years` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `msg_receiver_fk` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `msg_sender_fk` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `message_attachments`
--
ALTER TABLE `message_attachments`
  ADD CONSTRAINT `ma_msg_fk` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notif_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stat_assignments`
--
ALTER TABLE `stat_assignments`
  ADD CONSTRAINT `stat_assignments_ibfk_1` FOREIGN KEY (`stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stat_assignments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stat_columns`
--
ALTER TABLE `stat_columns`
  ADD CONSTRAINT `sc_stat_fk` FOREIGN KEY (`stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stat_definitions`
--
ALTER TABLE `stat_definitions`
  ADD CONSTRAINT `sd_creator_fk` FOREIGN KEY (`creator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sd_parent_fk` FOREIGN KEY (`parent_stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `stat_edit_history`
--
ALTER TABLE `stat_edit_history`
  ADD CONSTRAINT `stat_edit_history_ibfk_1` FOREIGN KEY (`stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `stat_edit_history_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stat_files`
--
ALTER TABLE `stat_files`
  ADD CONSTRAINT `sf_stat_fk` FOREIGN KEY (`stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `sf_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `stat_submissions`
--
ALTER TABLE `stat_submissions`
  ADD CONSTRAINT `ss_stat_fk` FOREIGN KEY (`stat_id`) REFERENCES `stat_definitions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ss_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `structures`
--
ALTER TABLE `structures`
  ADD CONSTRAINT `struct_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `structures` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
