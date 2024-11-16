-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16/11/2024 às 20:09
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `spotfit`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `category`
--

INSERT INTO `category` (`category_id`, `category_name`) VALUES
(1, 'Emagrecimento'),
(2, 'Hipertrofia'),
(3, 'Treinamento de atletas'),
(4, 'Saúde'),
(5, 'Pressão alta'),
(6, 'Obesidade'),
(7, 'Envelhecimento saudável'),
(8, 'Alta performance'),
(9, 'Funcional'),
(10, 'Calistenia'),
(11, 'Dança'),
(12, 'Crossfit'),
(13, 'Fisioterapia'),
(14, 'Yoga/Pilates');

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting`
--

CREATE TABLE `consulting` (
  `consulting_id` int(11) NOT NULL,
  `consulting_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `adm_user_id` int(11) DEFAULT NULL,
  `status` varchar(8) NOT NULL DEFAULT 'pending' COMMENT 'collection: pending, refused, accepted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting`
--

INSERT INTO `consulting` (`consulting_id`, `consulting_name`, `description`, `contact_email`, `contact_phone`, `adm_user_id`, `status`) VALUES
(1, 'Consultoria do Ademir', 'Consultoria do Ademir cuida da sua saúde e bem estar', 'contato.ademir@gmail.com', '11991825452', 3, 'pending'),
(2, 'Natan Personal', '', 'natan.personal@gmail.com', '123123123123', 4, 'pending'),
(3, 'Ana Eliza Yukimoto de Oliveira', 's', 'anaelizayuki@gmail.com', '11949417826', 11, 'pending'),
(4, 'Ana Eliza Yukimoto de Oliveira', 'q', 'anaelizayuki@gmail.com', '11949417826', 11, 'pending');

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_access`
--

CREATE TABLE `consulting_access` (
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `liked` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_access`
--

INSERT INTO `consulting_access` (`user_id`, `consulting_id`, `liked`) VALUES
(10, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_benefit`
--

CREATE TABLE `consulting_benefit` (
  `consulting_benefit_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `benefit` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_benefit`
--

INSERT INTO `consulting_benefit` (`consulting_benefit_id`, `consulting_id`, `benefit`, `description`, `icon`) VALUES
(25, 1, 'Prescrição de exercícios', 'Prescrição de exercícios', 'fa-solid fa-dumbbell'),
(26, 1, 'Acompanhamento de dores', 'Acompanhamento de dores', 'fa-solid fa-user-nurse'),
(27, 2, 'Treino periodizado', 'Treino periodizado', 'fa-solid fa-dumbbell'),
(28, 2, 'Dieta personalizada', 'Dieta personalizada', 'fa-solid fa-utensils'),
(29, 3, 'ANA ELIZA YUKIMOTO DE OLIVEIRA', 's', 'fa-solid fa-syringe'),
(30, 4, 'ANA ELIZA YUKIMOTO DE OLIVEIRA', 'qq', 'fa-solid fa-syringe');

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_benefit_professional`
--

CREATE TABLE `consulting_benefit_professional` (
  `consulting_benefit_id` int(11) NOT NULL,
  `consulting_professional_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_benefit_professional`
--

INSERT INTO `consulting_benefit_professional` (`consulting_benefit_id`, `consulting_professional_id`) VALUES
(25, 24),
(26, 23),
(26, 24),
(27, 25),
(28, 26),
(29, 27);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_category`
--

CREATE TABLE `consulting_category` (
  `consulting_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_category`
--

INSERT INTO `consulting_category` (`consulting_id`, `category_id`) VALUES
(1, 4),
(1, 14),
(2, 1),
(2, 2),
(3, 1),
(4, 2),
(4, 5),
(4, 13);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_comment`
--

CREATE TABLE `consulting_comment` (
  `id_consulting_comment` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `comment_type` varchar(50) DEFAULT NULL,
  `comment_text` text DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_comment`
--

INSERT INTO `consulting_comment` (`id_consulting_comment`, `user_id`, `consulting_id`, `comment_type`, `comment_text`, `rating`) VALUES
(1, 10, 1, 'nao sei', 'top', 5.0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_image`
--

CREATE TABLE `consulting_image` (
  `consulting_image_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `image_dir` varchar(255) DEFAULT NULL,
  `consulting_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_image`
--

INSERT INTO `consulting_image` (`consulting_image_id`, `description`, `image_dir`, `consulting_id`) VALUES
(5, 'foto-perfil-2.jpeg', '671ec53989ca60.02671578.jpeg', 1),
(6, 'foto-proa.jpg', '671ec539bdfa55.04428595.jpg', 1),
(7, 'Foto-perfil.jpeg', '671ec637c08336.24727239.jpeg', 1),
(8, 'rock pistola loko.jpeg', '671ec935efd201.90051686.jpeg', 2),
(9, 'fitDance.jpg', '6738008f9542d9.60472949.jpg', 3),
(10, 'fitDance.jpg', '673800bcda3b05.15782483.jpg', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_plan`
--

CREATE TABLE `consulting_plan` (
  `consulting_plans_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `plan` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `period` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_plan`
--

INSERT INTO `consulting_plan` (`consulting_plans_id`, `consulting_id`, `plan`, `price`, `description`, `period`) VALUES
(21, 1, 'Plano semestral completo', 500.00, 'Plano de 6 meses com todos os benefícios', '6'),
(22, 1, 'Plano anual completo', 1999.99, 'Plano de 1 ano com desconto mensal, incluso todos os benefícios', '12'),
(23, 2, 'Plano semestral completo', 659.99, 'Plano semestral completo', '6'),
(24, 2, 'Plano anual completo', 999.99, 'Plano anual completo', '12'),
(25, 3, 'ANA ELIZA YUKIMOTO DE OLIVEIRA', 111.00, 'aaa', '1'),
(26, 4, 'ANA ELIZA YUKIMOTO DE OLIVEIRA', 222.00, '2', '2');

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_plan_benefit`
--

CREATE TABLE `consulting_plan_benefit` (
  `consulting_plans_id` int(11) NOT NULL,
  `id_beneficio_consultoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_plan_benefit`
--

INSERT INTO `consulting_plan_benefit` (`consulting_plans_id`, `id_beneficio_consultoria`) VALUES
(21, 25),
(22, 25),
(22, 26),
(23, 27),
(23, 28),
(24, 27),
(24, 28),
(25, 29),
(26, 30);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_professional`
--

CREATE TABLE `consulting_professional` (
  `consulting_professional_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `consulting_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_professional`
--

INSERT INTO `consulting_professional` (`consulting_professional_id`, `name`, `instagram`, `phone`, `email`, `consulting_id`) VALUES
(23, 'Cleiton', '@cleiton', '56545465', '', 1),
(24, 'Samara', '@samara', '675534234', 'contato.samara@gmail.com', 1),
(25, 'Natan', '@natan', '1231231232', 'natan.personal@gmail.com', 2),
(26, 'Cleiton nutri', '@nutri_cleiton', '1231332123', '', 2),
(27, 'Ana Eliza Yukimoto de Oliveira', '', '11949417826', 'anaelizayuki@gmail.com', 3),
(28, 'Ana Eliza Yukimoto de Oliveira', '', '11949417826', 'anaelizayuki@gmail.com', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_schedules`
--

CREATE TABLE `consulting_schedules` (
  `schedule_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `reason` text NOT NULL,
  `contact_date` datetime NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `dismiss` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_schedules`
--

INSERT INTO `consulting_schedules` (`schedule_id`, `user_id`, `consulting_id`, `reason`, `contact_date`, `read`, `dismiss`) VALUES
(1, 4, 1, 'Quero agendaaaar', '2024-11-16 19:05:54', 0, 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_view`
--

CREATE TABLE `consulting_view` (
  `consulting_view_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `consulting_view`
--

INSERT INTO `consulting_view` (`consulting_view_id`, `user_id`, `consulting_id`, `time_stamp`) VALUES
(0, 5, 1, '2024-11-16 17:29:09'),
(1, 10, 1, '2024-11-15 19:44:54'),
(2, 10, 1, '2024-11-15 20:10:43'),
(3, 10, 1, '2024-11-15 20:10:50'),
(4, 10, 1, '2024-11-15 20:10:50'),
(5, 10, 1, '2024-11-15 20:11:06'),
(6, 10, 1, '2024-11-15 20:11:08'),
(7, 10, 1, '2024-11-15 20:11:11'),
(8, 10, 1, '2024-11-15 20:11:12'),
(9, 10, 1, '2024-11-15 21:22:36'),
(10, 10, 1, '2024-11-15 21:23:39'),
(11, 10, 2, '2024-11-15 21:23:42'),
(12, 10, 2, '2024-11-15 21:27:16'),
(13, 5, 1, '2024-11-15 22:26:44'),
(14, 5, 1, '2024-11-15 22:26:53'),
(15, 5, 1, '2024-11-15 22:28:50'),
(16, 5, 1, '2024-11-15 22:28:53'),
(17, 5, 1, '2024-11-15 22:29:00'),
(18, 5, 1, '2024-11-15 22:29:13'),
(19, 5, 1, '2024-11-15 22:31:11'),
(20, 5, 1, '2024-11-15 22:31:18'),
(21, 5, 1, '2024-11-15 22:31:59'),
(22, 5, 1, '2024-11-15 22:32:06'),
(23, 5, 1, '2024-11-15 22:33:51'),
(24, 5, 1, '2024-11-15 22:34:20'),
(25, 5, 1, '2024-11-15 22:34:46'),
(26, 5, 1, '2024-11-15 22:35:47'),
(27, 5, 1, '2024-11-15 22:35:56'),
(28, 5, 1, '2024-11-15 22:36:11'),
(29, 5, 1, '2024-11-15 22:38:07'),
(30, 5, 1, '2024-11-15 22:38:17'),
(31, 5, 1, '2024-11-15 22:39:39'),
(32, 5, 1, '2024-11-15 22:40:08'),
(33, 5, 1, '2024-11-15 22:40:16'),
(34, 5, 1, '2024-11-15 22:41:41'),
(35, 5, 1, '2024-11-15 22:41:49'),
(36, 5, 1, '2024-11-15 22:41:56'),
(37, 5, 1, '2024-11-15 22:43:48'),
(38, 5, 1, '2024-11-15 22:43:57'),
(39, 11, 1, '2024-11-15 22:46:33'),
(40, 11, 1, '2024-11-15 22:46:45'),
(41, 11, 1, '2024-11-15 22:55:46'),
(42, 11, 1, '2024-11-15 22:55:48'),
(43, 11, 1, '2024-11-15 22:56:44'),
(44, 11, 1, '2024-11-15 22:57:25'),
(45, 11, 1, '2024-11-15 22:58:07'),
(46, 11, 1, '2024-11-15 23:02:33'),
(47, 11, 1, '2024-11-15 23:04:22'),
(48, 11, 1, '2024-11-15 23:07:04'),
(49, 11, 1, '2024-11-15 23:09:53'),
(50, 11, 1, '2024-11-15 23:10:01'),
(51, 11, 1, '2024-11-15 23:11:43'),
(52, 11, 1, '2024-11-15 23:11:51'),
(53, 11, 1, '2024-11-15 23:19:48'),
(54, 11, 1, '2024-11-15 23:22:00'),
(55, 11, 1, '2024-11-15 23:22:10'),
(56, 11, 1, '2024-11-15 23:28:12'),
(57, 11, 1, '2024-11-16 00:01:42'),
(58, 11, 1, '2024-11-16 00:21:31'),
(59, 11, 1, '2024-11-16 00:23:00'),
(60, 11, 1, '2024-11-16 00:23:11'),
(61, 11, 1, '2024-11-16 00:23:37'),
(62, 11, 1, '2024-11-16 00:23:59'),
(63, 11, 1, '2024-11-16 00:24:18'),
(64, 11, 1, '2024-11-16 00:24:29'),
(65, 11, 1, '2024-11-16 00:24:32'),
(66, 11, 1, '2024-11-16 00:24:34'),
(67, 11, 1, '2024-11-16 00:24:58'),
(68, 11, 1, '2024-11-16 00:26:11'),
(69, 11, 1, '2024-11-16 00:26:44'),
(70, 11, 1, '2024-11-16 00:27:45'),
(71, 11, 1, '2024-11-16 00:29:26'),
(72, 11, 1, '2024-11-16 00:29:53'),
(73, 11, 1, '2024-11-16 00:30:15'),
(74, 11, 1, '2024-11-16 00:34:17'),
(75, 11, 1, '2024-11-16 00:34:42'),
(76, 11, 1, '2024-11-16 00:34:58'),
(77, 11, 1, '2024-11-16 00:35:52'),
(78, 11, 1, '2024-11-16 00:36:05'),
(79, 11, 1, '2024-11-16 00:36:56'),
(80, 11, 1, '2024-11-16 00:37:41'),
(81, 11, 1, '2024-11-16 00:37:50'),
(82, 11, 1, '2024-11-16 00:38:03'),
(83, 11, 1, '2024-11-16 00:38:22'),
(84, 11, 1, '2024-11-16 00:38:56'),
(85, 11, 1, '2024-11-16 00:39:20'),
(86, 11, 1, '2024-11-16 00:39:30'),
(87, 11, 1, '2024-11-16 00:39:41'),
(88, 11, 1, '2024-11-16 00:39:55'),
(89, 11, 1, '2024-11-16 00:40:15'),
(90, 11, 1, '2024-11-16 00:40:41'),
(91, 11, 1, '2024-11-16 00:41:15'),
(92, 11, 1, '2024-11-16 00:41:38'),
(93, 11, 1, '2024-11-16 00:41:56'),
(94, 11, 1, '2024-11-16 00:42:15'),
(95, 11, 1, '2024-11-16 00:42:27'),
(96, 11, 1, '2024-11-16 00:42:40'),
(97, 11, 1, '2024-11-16 00:42:50'),
(98, 11, 1, '2024-11-16 00:43:04'),
(99, 11, 1, '2024-11-16 00:43:13'),
(100, 11, 1, '2024-11-16 00:44:16'),
(101, 11, 1, '2024-11-16 00:44:28'),
(102, 11, 1, '2024-11-16 00:44:53'),
(103, 11, 1, '2024-11-16 00:45:09'),
(104, 11, 1, '2024-11-16 00:45:28'),
(105, 11, 1, '2024-11-16 00:45:45'),
(106, 11, 1, '2024-11-16 00:45:54'),
(107, 11, 1, '2024-11-16 00:46:09'),
(108, 11, 1, '2024-11-16 00:46:21'),
(109, 11, 1, '2024-11-16 00:47:04'),
(110, 11, 1, '2024-11-16 00:47:25'),
(111, 11, 1, '2024-11-16 00:48:47'),
(112, 11, 1, '2024-11-16 00:49:12'),
(113, 11, 1, '2024-11-16 00:49:28'),
(114, 11, 1, '2024-11-16 00:49:41'),
(115, 11, 1, '2024-11-16 00:50:23'),
(116, 11, 1, '2024-11-16 00:51:21'),
(117, 11, 1, '2024-11-16 00:51:46'),
(118, 11, 1, '2024-11-16 00:51:59'),
(119, 11, 1, '2024-11-16 00:52:13'),
(120, 11, 1, '2024-11-16 00:52:29'),
(121, 11, 1, '2024-11-16 00:52:53'),
(122, 11, 1, '2024-11-16 00:53:30'),
(123, 11, 1, '2024-11-16 00:53:40'),
(124, 11, 1, '2024-11-16 00:55:50'),
(125, 11, 1, '2024-11-16 00:56:08'),
(126, 11, 1, '2024-11-16 00:57:16'),
(127, 11, 1, '2024-11-16 00:57:30'),
(128, 11, 1, '2024-11-16 00:57:37'),
(129, 11, 1, '2024-11-16 00:58:09'),
(130, 11, 1, '2024-11-16 01:00:17'),
(131, 11, 1, '2024-11-16 01:04:08'),
(132, 11, 1, '2024-11-16 01:04:20'),
(133, 11, 1, '2024-11-16 01:06:22'),
(134, 11, 1, '2024-11-16 01:06:54'),
(135, 11, 1, '2024-11-16 01:07:06'),
(136, 11, 1, '2024-11-16 01:07:15'),
(137, 11, 1, '2024-11-16 01:07:31'),
(138, 11, 1, '2024-11-16 01:07:40'),
(139, 11, 1, '2024-11-16 01:07:55'),
(140, 11, 1, '2024-11-16 01:08:16'),
(141, 11, 1, '2024-11-16 01:08:56'),
(142, 11, 1, '2024-11-16 01:09:26'),
(143, 11, 1, '2024-11-16 01:10:24'),
(144, 11, 1, '2024-11-16 01:10:42'),
(145, 11, 1, '2024-11-16 01:10:51'),
(146, 11, 1, '2024-11-16 01:11:11'),
(147, 11, 1, '2024-11-16 01:12:06'),
(148, 11, 1, '2024-11-16 01:12:21'),
(149, 11, 1, '2024-11-16 01:12:47'),
(150, 11, 1, '2024-11-16 01:13:39'),
(151, 11, 1, '2024-11-16 01:13:44'),
(152, 11, 1, '2024-11-16 01:14:46'),
(153, 11, 1, '2024-11-16 01:14:54'),
(154, 11, 1, '2024-11-16 01:15:06'),
(155, 11, 1, '2024-11-16 01:16:01'),
(156, 11, 1, '2024-11-16 01:16:20'),
(157, 11, 1, '2024-11-16 01:18:13'),
(158, 11, 1, '2024-11-16 01:18:19'),
(159, 11, 1, '2024-11-16 01:18:48'),
(160, 11, 1, '2024-11-16 01:20:12'),
(161, 11, 1, '2024-11-16 01:30:19'),
(162, 11, 1, '2024-11-16 01:30:33'),
(163, 11, 1, '2024-11-16 01:30:42'),
(164, 11, 1, '2024-11-16 01:31:25'),
(165, 11, 1, '2024-11-16 01:31:37'),
(166, 11, 1, '2024-11-16 01:31:40'),
(167, 11, 1, '2024-11-16 01:31:55'),
(168, 11, 1, '2024-11-16 01:32:07'),
(169, 11, 1, '2024-11-16 01:32:15'),
(170, 11, 1, '2024-11-16 01:32:19'),
(171, 11, 1, '2024-11-16 01:47:51'),
(172, 11, 1, '2024-11-16 01:48:53'),
(173, 11, 1, '2024-11-16 01:49:20'),
(174, 11, 1, '2024-11-16 01:49:24'),
(175, 11, 2, '2024-11-16 01:49:33'),
(176, 11, 2, '2024-11-16 01:50:07'),
(177, 11, 1, '2024-11-16 01:50:12'),
(178, 11, 1, '2024-11-16 01:50:25'),
(179, 11, 1, '2024-11-16 01:50:31'),
(180, 11, 1, '2024-11-16 01:50:37'),
(181, 11, 1, '2024-11-16 01:51:00'),
(182, 11, 1, '2024-11-16 01:51:37'),
(183, 11, 1, '2024-11-16 01:52:47'),
(184, 11, 2, '2024-11-16 01:52:51'),
(185, 11, 2, '2024-11-16 01:53:40'),
(186, 11, 2, '2024-11-16 01:53:47'),
(187, 11, 2, '2024-11-16 01:54:10'),
(188, 11, 1, '2024-11-16 01:54:15'),
(189, 11, 1, '2024-11-16 01:55:12'),
(190, 11, 1, '2024-11-16 01:56:13'),
(191, 11, 1, '2024-11-16 01:58:08'),
(192, 11, 1, '2024-11-16 01:59:22'),
(193, 11, 1, '2024-11-16 01:59:29'),
(194, 11, 1, '2024-11-16 02:00:08'),
(195, 11, 1, '2024-11-16 02:00:29'),
(196, 11, 1, '2024-11-16 02:00:37'),
(197, 11, 1, '2024-11-16 02:00:58'),
(198, 11, 1, '2024-11-16 02:02:01'),
(199, 11, 1, '2024-11-16 02:02:43'),
(200, 11, 3, '2024-11-16 02:16:47'),
(201, 11, 4, '2024-11-16 02:17:33'),
(202, 5, 4, '2024-11-16 17:31:28'),
(203, 3, 1, '2024-11-16 18:02:58'),
(204, 3, 1, '2024-11-16 18:03:08'),
(205, 4, 1, '2024-11-16 18:03:14'),
(206, 4, 1, '2024-11-16 18:05:01');

-- --------------------------------------------------------

--
-- Estrutura para tabela `email_contact`
--

CREATE TABLE `email_contact` (
  `email_contact_id` int(11) NOT NULL,
  `person_name` varchar(255) NOT NULL,
  `person_email` varchar(255) NOT NULL,
  `message` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `profession`
--

CREATE TABLE `profession` (
  `profession_id` int(11) NOT NULL,
  `profession_name` varchar(100) NOT NULL,
  `profession_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profession`
--

INSERT INTO `profession` (`profession_id`, `profession_name`, `profession_description`) VALUES
(1, 'Educador físico', 'Especialista em exercícios e ao ensino da técnica correta'),
(2, 'Nutricionista', 'Especialista em saúde alimentar, cria planos de alimentação balanceados para promover bem-estar e nutrição'),
(3, 'Fisioterapeuta', 'Profissional que reabilita e previne lesões musculoesqueléticas por meio de exercícios, terapias e técnicas manuais'),
(4, 'Influenciador', 'Compartilha dicas de exercícios, nutrição e estilo de vida saudável para motivar seguidores'),
(5, 'Instrutor de Yoga/Pilates', 'Ensina técnicas de yoga ou pilates para melhorar flexibilidade, força, equilíbrio e relaxamento');

-- --------------------------------------------------------

--
-- Estrutura para tabela `professional_register`
--

CREATE TABLE `professional_register` (
  `professional_register_id` int(11) NOT NULL,
  `consulting_professional_id` int(11) DEFAULT NULL,
  `profession_id` int(11) DEFAULT NULL,
  `register_type_id` int(11) DEFAULT NULL,
  `register` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `professional_register`
--

INSERT INTO `professional_register` (`professional_register_id`, `consulting_professional_id`, `profession_id`, `register_type_id`, `register`) VALUES
(23, 23, 1, 1, '456234'),
(24, 24, 1, 1, '75645'),
(25, 25, 1, 1, '12312312'),
(26, 26, 2, 2, '32543435'),
(27, 27, 1, 1, 'aaaa'),
(28, 28, 1, 1, 'wwww');

-- --------------------------------------------------------

--
-- Estrutura para tabela `register_type`
--

CREATE TABLE `register_type` (
  `register_type_id` int(11) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `type_description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `register_type`
--

INSERT INTO `register_type` (`register_type_id`, `type_name`, `country`, `type_description`) VALUES
(1, 'CREF', 'Brasil', 'Conselho Regional de Educação Física; para atuar em avaliações e prescrições de exercícios'),
(2, 'CRN', 'Brasil', 'Conselho Regional de Nutrição; exige graduação em Nutrição e especialização esportiva'),
(3, 'CREFITO', 'Brasil', 'Conselho Regional de Fisioterapia e Terapia Ocupacional. É obrigatório para atuar legalmente na área'),
(4, 'CFN', 'Brasil', 'Conselho Federal que regulamenta e fiscaliza a atuação dos nutricionistas no Brasil'),
(5, 'CRM', 'Brasil', 'Conselho Regional de Medicina; regula, fiscaliza e habilita médicos para o exercício profissional no');

-- --------------------------------------------------------

--
-- Estrutura para tabela `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `cpf_or_cnpj` varchar(20) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `professional` tinyint(1) NOT NULL DEFAULT 0,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `email`, `user_password`, `cpf_or_cnpj`, `profile_photo`, `professional`, `phone`) VALUES
(1, 'Gustavo ', 'gutiinacio@gmail.com', '$2y$10$I1LoTBKnJuAr9nUOp2xKgev/78oxJFgYs4EPv4NswU2owvOkiKGBe', '51882572890', 'download.jpg', 0, '11983020691'),
(2, 'Gustavo ', 'gutiinacio@gmail.com', '$2y$10$r09ODrlfOW8lohowHJZDouiLOXTAi8TOzhsgIO3Tr6aV/9h74I8Z2', '51882572890', 'a.jpg', 0, '11983020691'),
(3, 'admin', 'admin@teste.com', '$2y$10$OAXW5o8dlnk3T5Q9cYxLxu51LxWrUTnlxWRPFbgVeDzQUF4LbuuCC', '39658585132', '3965858513267170fdae3a198.80474028.jpg', 1, '11991825452'),
(4, 'Natan Personal', 'natan.personal@gmail.com', '$2y$10$dtA1ac48uIkHVOSUrZW9Vebe3lCWwBR.W/9PhJgZda.f4tkt9XFPG', '31522433678', '31522433678671ec7369a8049.46876155.jpeg', 1, '5435433242'),
(5, 'Natan Consultor', 'natan.consultoria@gmail.com', '$2y$10$Jno4/KHIJISD5MT4ecnzKOdmqq.xM8A9zyGjsqaeDnvSdOnCxCPgS', '', NULL, 1, '11991825452'),
(10, 'admin', 'admin@spotfit.com', '$2y$10$FMz1gdZUA2lYQo3SBzd4weI7yNcyEFjtBgbE7XDGki48Gq823I4ri', '', NULL, 1, NULL),
(11, 'Ana ', 'anayukimoto.dev@gmail.com', '$2y$10$BO/P6riuaxqB6BRKWTtnbOkq8mkumwuKHm9LhZmKJcdROHbjb7NyS', '12076674047', '120766740476737cf3eecaf76.54732600.jpg', 1, '1158787878987');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`);

--
-- Índices de tabela `consulting`
--
ALTER TABLE `consulting`
  ADD PRIMARY KEY (`consulting_id`),
  ADD KEY `adm_user_id` (`adm_user_id`);

--
-- Índices de tabela `consulting_access`
--
ALTER TABLE `consulting_access`
  ADD PRIMARY KEY (`user_id`,`consulting_id`),
  ADD KEY `consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_benefit`
--
ALTER TABLE `consulting_benefit`
  ADD PRIMARY KEY (`consulting_benefit_id`),
  ADD KEY `consulting_benefit_FK_consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_benefit_professional`
--
ALTER TABLE `consulting_benefit_professional`
  ADD PRIMARY KEY (`consulting_benefit_id`,`consulting_professional_id`),
  ADD KEY `consulting_benefit_professional_FK_consulting_professional_id` (`consulting_professional_id`);

--
-- Índices de tabela `consulting_category`
--
ALTER TABLE `consulting_category`
  ADD PRIMARY KEY (`consulting_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Índices de tabela `consulting_comment`
--
ALTER TABLE `consulting_comment`
  ADD PRIMARY KEY (`id_consulting_comment`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_image`
--
ALTER TABLE `consulting_image`
  ADD PRIMARY KEY (`consulting_image_id`),
  ADD KEY `consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_plan`
--
ALTER TABLE `consulting_plan`
  ADD PRIMARY KEY (`consulting_plans_id`),
  ADD KEY `consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_plan_benefit`
--
ALTER TABLE `consulting_plan_benefit`
  ADD PRIMARY KEY (`consulting_plans_id`,`id_beneficio_consultoria`),
  ADD KEY `consulting_plan_benefit_FK_id_beneficio_consultoria` (`id_beneficio_consultoria`);

--
-- Índices de tabela `consulting_professional`
--
ALTER TABLE `consulting_professional`
  ADD PRIMARY KEY (`consulting_professional_id`),
  ADD KEY `consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_schedules`
--
ALTER TABLE `consulting_schedules`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `consulting_id` (`consulting_id`);

--
-- Índices de tabela `consulting_view`
--
ALTER TABLE `consulting_view`
  ADD PRIMARY KEY (`consulting_view_id`);

--
-- Índices de tabela `email_contact`
--
ALTER TABLE `email_contact`
  ADD PRIMARY KEY (`email_contact_id`);

--
-- Índices de tabela `profession`
--
ALTER TABLE `profession`
  ADD PRIMARY KEY (`profession_id`);

--
-- Índices de tabela `professional_register`
--
ALTER TABLE `professional_register`
  ADD PRIMARY KEY (`professional_register_id`),
  ADD KEY `profession_id` (`profession_id`),
  ADD KEY `register_type_id` (`register_type_id`),
  ADD KEY `professional_register_FK_consulting_professional_id` (`consulting_professional_id`);

--
-- Índices de tabela `register_type`
--
ALTER TABLE `register_type`
  ADD PRIMARY KEY (`register_type_id`);

--
-- Índices de tabela `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de tabela `consulting`
--
ALTER TABLE `consulting`
  MODIFY `consulting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `consulting_benefit`
--
ALTER TABLE `consulting_benefit`
  MODIFY `consulting_benefit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `consulting_comment`
--
ALTER TABLE `consulting_comment`
  MODIFY `id_consulting_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `consulting_image`
--
ALTER TABLE `consulting_image`
  MODIFY `consulting_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `consulting_plan`
--
ALTER TABLE `consulting_plan`
  MODIFY `consulting_plans_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `consulting_professional`
--
ALTER TABLE `consulting_professional`
  MODIFY `consulting_professional_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de tabela `consulting_schedules`
--
ALTER TABLE `consulting_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `consulting_view`
--
ALTER TABLE `consulting_view`
  MODIFY `consulting_view_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;

--
-- AUTO_INCREMENT de tabela `email_contact`
--
ALTER TABLE `email_contact`
  MODIFY `email_contact_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `profession`
--
ALTER TABLE `profession`
  MODIFY `profession_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `professional_register`
--
ALTER TABLE `professional_register`
  MODIFY `professional_register_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de tabela `register_type`
--
ALTER TABLE `register_type`
  MODIFY `register_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `consulting`
--
ALTER TABLE `consulting`
  ADD CONSTRAINT `consulting_ibfk_1` FOREIGN KEY (`adm_user_id`) REFERENCES `user` (`user_id`);

--
-- Restrições para tabelas `consulting_access`
--
ALTER TABLE `consulting_access`
  ADD CONSTRAINT `consulting_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `consulting_access_ibfk_2` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `consulting_benefit`
--
ALTER TABLE `consulting_benefit`
  ADD CONSTRAINT `consulting_benefit_FK_consulting_id` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `consulting_benefit_professional`
--
ALTER TABLE `consulting_benefit_professional`
  ADD CONSTRAINT `consulting_benefit_professional_FK_consulting_professional_id` FOREIGN KEY (`consulting_professional_id`) REFERENCES `consulting_professional` (`consulting_professional_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consulting_benefit_professional_ibfk_1` FOREIGN KEY (`consulting_benefit_id`) REFERENCES `consulting_benefit` (`consulting_benefit_id`),
  ADD CONSTRAINT `consulting_benefit_professional_ibfk_2` FOREIGN KEY (`consulting_professional_id`) REFERENCES `consulting_professional` (`consulting_professional_id`);

--
-- Restrições para tabelas `consulting_category`
--
ALTER TABLE `consulting_category`
  ADD CONSTRAINT `consulting_category_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`),
  ADD CONSTRAINT `consulting_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);

--
-- Restrições para tabelas `consulting_comment`
--
ALTER TABLE `consulting_comment`
  ADD CONSTRAINT `consulting_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `consulting_comment_ibfk_2` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `consulting_image`
--
ALTER TABLE `consulting_image`
  ADD CONSTRAINT `consulting_image_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `consulting_plan`
--
ALTER TABLE `consulting_plan`
  ADD CONSTRAINT `consulting_plan_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `consulting_plan_benefit`
--
ALTER TABLE `consulting_plan_benefit`
  ADD CONSTRAINT `consulting_plan_benefit_FK_consulting_plans_id` FOREIGN KEY (`consulting_plans_id`) REFERENCES `consulting_plan` (`consulting_plans_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consulting_plan_benefit_FK_id_beneficio_consultoria` FOREIGN KEY (`id_beneficio_consultoria`) REFERENCES `consulting_benefit` (`consulting_benefit_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `consulting_plan_benefit_ibfk_1` FOREIGN KEY (`consulting_plans_id`) REFERENCES `consulting_plan` (`consulting_plans_id`),
  ADD CONSTRAINT `consulting_plan_benefit_ibfk_2` FOREIGN KEY (`id_beneficio_consultoria`) REFERENCES `consulting_benefit` (`consulting_benefit_id`);

--
-- Restrições para tabelas `consulting_professional`
--
ALTER TABLE `consulting_professional`
  ADD CONSTRAINT `consulting_professional_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `consulting_schedules`
--
ALTER TABLE `consulting_schedules`
  ADD CONSTRAINT `consulting_schedules_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `consulting_schedules_ibfk_2` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `professional_register`
--
ALTER TABLE `professional_register`
  ADD CONSTRAINT `professional_register_FK_consulting_professional_id` FOREIGN KEY (`consulting_professional_id`) REFERENCES `consulting_professional` (`consulting_professional_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `professional_register_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `profession` (`profession_id`),
  ADD CONSTRAINT `professional_register_ibfk_3` FOREIGN KEY (`register_type_id`) REFERENCES `register_type` (`register_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
