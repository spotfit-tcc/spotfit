-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 27/10/2024 às 17:26
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
  `adm_user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_access`
--

CREATE TABLE `consulting_access` (
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `liked` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_benefit_professional`
--

CREATE TABLE `consulting_benefit_professional` (
  `consulting_benefit_id` int(11) NOT NULL,
  `consulting_professional_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_category`
--

CREATE TABLE `consulting_category` (
  `consulting_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `consulting_plan_benefit`
--

CREATE TABLE `consulting_plan_benefit` (
  `consulting_plans_id` int(11) NOT NULL,
  `id_beneficio_consultoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `professional` tinyint(1) DEFAULT NULL,
  `phone` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `user`
--

INSERT INTO `user` (`user_id`, `user_name`, `email`, `user_password`, `cpf_or_cnpj`, `profile_photo`, `professional`, `phone`) VALUES
(1, 'Gustavo ', 'gutiinacio@gmail.com', '$2y$10$I1LoTBKnJuAr9nUOp2xKgev/78oxJFgYs4EPv4NswU2owvOkiKGBe', '51882572890', 'download.jpg', NULL, '11983020691'),
(2, 'Gustavo ', 'gutiinacio@gmail.com', '$2y$10$r09ODrlfOW8lohowHJZDouiLOXTAi8TOzhsgIO3Tr6aV/9h74I8Z2', '51882572890', 'a.jpg', NULL, '11983020691'),
(3, 'admin', 'admin@teste.com', '$2y$10$OAXW5o8dlnk3T5Q9cYxLxu51LxWrUTnlxWRPFbgVeDzQUF4LbuuCC', '39658585132', '3965858513267170fdae3a198.80474028.jpg', NULL, '11991825452');

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
  ADD KEY `consulting_professional_id` (`consulting_professional_id`);

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
  ADD KEY `id_beneficio_consultoria` (`id_beneficio_consultoria`);

--
-- Índices de tabela `consulting_professional`
--
ALTER TABLE `consulting_professional`
  ADD PRIMARY KEY (`consulting_professional_id`),
  ADD KEY `consulting_id` (`consulting_id`);

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
  ADD KEY `consulting_professional_id` (`consulting_professional_id`),
  ADD KEY `profession_id` (`profession_id`),
  ADD KEY `register_type_id` (`register_type_id`);

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
  MODIFY `consulting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consulting_benefit`
--
ALTER TABLE `consulting_benefit`
  MODIFY `consulting_benefit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consulting_comment`
--
ALTER TABLE `consulting_comment`
  MODIFY `id_consulting_comment` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consulting_image`
--
ALTER TABLE `consulting_image`
  MODIFY `consulting_image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consulting_plan`
--
ALTER TABLE `consulting_plan`
  MODIFY `consulting_plans_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consulting_professional`
--
ALTER TABLE `consulting_professional`
  MODIFY `consulting_professional_id` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `professional_register_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `register_type`
--
ALTER TABLE `register_type`
  MODIFY `register_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  ADD CONSTRAINT `consulting_plan_benefit_ibfk_1` FOREIGN KEY (`consulting_plans_id`) REFERENCES `consulting_plan` (`consulting_plans_id`),
  ADD CONSTRAINT `consulting_plan_benefit_ibfk_2` FOREIGN KEY (`id_beneficio_consultoria`) REFERENCES `consulting_benefit` (`consulting_benefit_id`);

--
-- Restrições para tabelas `consulting_professional`
--
ALTER TABLE `consulting_professional`
  ADD CONSTRAINT `consulting_professional_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`);

--
-- Restrições para tabelas `professional_register`
--
ALTER TABLE `professional_register`
  ADD CONSTRAINT `consulting_professional_id_FK_consulting_professional` FOREIGN KEY (`consulting_professional_id`) REFERENCES `consulting_professional` (`consulting_professional_id`),
  ADD CONSTRAINT `professional_register_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `profession` (`profession_id`),
  ADD CONSTRAINT `professional_register_ibfk_3` FOREIGN KEY (`register_type_id`) REFERENCES `register_type` (`register_type_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
