-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 19/11/2024 às 03:10
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
(1, 'Consultoria Fit', 'Especializada em fitness e bem-estar, essa consultoria oferece planos de treino personalizados e orientação para atingir objetivos de saúde e condicionamento físico. Seus serviços incluem avaliação física, treinamento funcional e acompanhamento remoto. O ambiente é acolhedor, com profissionais qualificados focados em criar rotinas eficazes e práticas para seus clientes.', 'contato@fitconsult.com', '112457854965', 1, 'accepted'),
(2, 'Gestão Pessoal Pro', 'Essa consultoria ajuda clientes a organizarem suas rotinas e otimizarem seu tempo para maior produtividade. Oferece suporte em planejamento diário, gerenciamento de tarefas e desenvolvimento de habilidades interpessoais. Ideal para profissionais buscando equilíbrio entre vida pessoal e carreira.', 'gestao@pessoalpro.com', '11777777777', 2, 'accepted'),
(3, 'Carreira Fitness Estratégica', 'Consultoria focada no desenvolvimento de profissionais que buscam crescimento e transição de carreira. Seus serviços incluem elaboração de currículos, treinamento para entrevistas e coaching de liderança. A equipe é formada por coaches certificados e especialistas em recrutamento.', 'carreira@estrategica.com', '6655225555', 5, 'accepted'),
(4, 'Vida Ativa 360°', 'Consultoria voltada para quem deseja adotar um estilo de vida mais ativo e equilibrado. Oferece suporte completo, incluindo treinamento físico, acompanhamento nutricional e orientações sobre bem-estar mental.', 'contato@vidaativa360.com', '(11) 98476-1234', 8, 'accepted'),
(5, 'Brand Booster', 'Uma consultoria voltada para empreendedores e empresas que desejam alavancar sua marca no ambiente digital. Oferece estratégias criativas e soluções práticas para crescer nas redes sociais.', 'contato@brandbooster.com', '(41) 99888-7766', 8, 'pending'),
(6, 'Nutri e Vida', 'Focada em nutrição prática e acessível, essa consultoria auxilia no desenvolvimento de hábitos alimentares saudáveis. Ideal para pessoas com agendas apertadas que buscam resultados reais.', 'suporte@nutrievida.com', '(21) 99988-5566', 10, 'accepted'),
(7, 'Gestão de Rotinas Plus', 'Especializada em otimização de tempo e gestão de tarefas, essa consultoria é ideal para profissionais sobrecarregados que buscam mais produtividade e organização.', 'contato@gestaoplus.com', '(31) 91234-5678', 1, 'pending'),
(8, 'CrossFit Power', 'Uma consultoria para quem deseja treinar intensamente, superar limites e conquistar resultados rápidos. A CrossFit Power oferece treinos funcionais de alta intensidade com suporte técnico especializado.', 'contato@crossfitpower.com', '(41) 99888-7766', 3, 'accepted'),
(9, 'Zumba Vibes', 'Focada em equilíbrio e harmonia, a Yoga Essence oferece práticas para relaxamento, fortalecimento corporal e conexão espiritual. Ideal para iniciantes e praticantes avançados.', 'contato@yogaessence.com', 'contato@yogaessence.', 2, 'accepted'),
(10, ' Zumba Vibes', 'A Zumba Vibes é perfeita para quem deseja entrar em forma de maneira divertida e energizante. As aulas combinam dança e exercícios aeróbicos ao som de músicas contagiantes.', 'contato@zumbavibes.com', '115487985598', 5, 'accepted'),
(11, 'Golpe ', 'Não caia em golpe da internet.', 'golpe@gmail.com', '13456748977', 11, 'pending');

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

--
-- Despejando dados para a tabela `consulting_benefit`
--

INSERT INTO `consulting_benefit` (`consulting_benefit_id`, `consulting_id`, `benefit`, `description`, `icon`) VALUES
(1, 1, 'Treinamento Personalizado', 'Planos de treino adaptados ao nível de condicionamento físico e aos objetivos pessoais do cliente, garantindo resultados consistentes e saudáveis.', 'fa-solid fa-dumbbell'),
(2, 1, ' Acompanhamento por Profissionais Certificados', 'Supervisão contínua por personal trainers especializados, com foco em segurança e eficácia durante os exercícios.', 'fa-solid fa-syringe'),
(3, 2, 'Planejamento Personalizado', 'Criação de cronogramas diários e semanais ajustados às prioridades e metas do cliente, otimizando o uso do tempo.', 'fa-solid fa-receipt'),
(4, 2, 'Mentoria em Habilidades Organizacionais', 'Desenvolvimento de habilidades práticas, como gestão de tarefas, definição de prioridades e manutenção do foco.', 'fa-solid fa-heart'),
(5, 3, 'Coaching de Carreira', 'Sessões individuais para definir objetivos profissionais claros e traçar planos fitness estratégicos para alcançá-los.', 'fa-solid fa-person-walking'),
(6, 3, 'Planos Alimentares Personalizados', 'Cardápios criados por nutricionistas qualificados, levando em conta restrições alimentares e preferências individuais.', 'fa-solid fa-receipt'),
(7, 3, 'Avaliação Corporal Completa', 'Análise detalhada de composição corporal, incluindo IMC, porcentagem de gordura e massa magra, para acompanhar a evolução dos resultados.', 'fa-solid fa-syringe'),
(8, 4, 'Treinamento funcional personalizado', 'Treinos adaptados às necessidades individuais, com foco em fortalecer o corpo e melhorar a resistência física.', 'fa-solid fa-dumbbell'),
(9, 4, 'Plano nutricional balanceado', 'Orientações alimentares baseadas em metas específicas, como emagrecimento, ganho de massa muscular ou melhora da saúde geral.', 'fa-solid fa-receipt'),
(10, 4, 'Técnicas de controle de estresse', 'Sessões para ajudar no controle de estresse e ansiedade, promovendo maior equilíbrio mental.', 'fa-solid fa-heart'),
(11, 5, 'Estratégias de branding inovadoras', 'Desenvolvimento de identidade de marca que se destaca no mercado, com storytelling personalizado.', 'fa-solid fa-heart'),
(12, 6, 'Receitas Rápidas e Saborosas', 'Sugestões práticas para refeições equilibradas, ideais para pessoas com pouco tempo para cozinhar.', 'fa-solid fa-receipt'),
(13, 6, 'Avaliação de Intolerâncias Alimentares', 'Identificação de possíveis restrições alimentares e adaptações nos cardápios para atender às necessidades específicas.', 'fa-solid fa-utensils'),
(14, 7, 'Mentoria em Gestão de Tempo', 'Orientações personalizadas para priorizar tarefas e otimizar a produtividade no dia a dia.\r\n', 'fa-solid fa-heart'),
(15, 7, 'Ferramentas de Organização Digital', 'Acesso a aplicativos e métodos modernos para gerenciar projetos e compromissos.\r\n', 'fa-solid fa-heart'),
(16, 8, 'Treinos Funcionais de Alta Intensidade', 'Programas variados que trabalham força, resistência, agilidade e coordenação.\r\n', 'fa-solid fa-dumbbell'),
(17, 8, 'Resultados Rápidos', 'Melhoras notáveis na performance física e composição corporal em poucas semanas.\r\n', 'fa-solid fa-dumbbell'),
(18, 8, 'Acompanhamento Especializado', 'Treinadores certificados que garantem segurança e eficiência nos exercícios.\r\n', 'fa-solid fa-heart'),
(19, 9, 'Equilíbrio Corpo e Mente', 'Práticas que promovem relaxamento, foco e controle emocional.\r\n', 'fa-solid fa-heart'),
(20, 9, 'Fortalecimento Muscular', 'Posturas que tonificam o corpo enquanto aumentam a flexibilidade.\r\n', 'fa-solid fa-dumbbell'),
(21, 9, 'Técnicas de Respiração e Meditação', 'Métodos para controlar o estresse e melhorar a qualidade do sono.\r\n', 'fa-solid fa-heart'),
(22, 10, 'Aulas Dinâmicas e Divertidas', 'Coreografias simples e envolventes, adaptadas para todos os níveis de condicionamento físico.\r\n', 'fa-solid fa-heart'),
(23, 11, 'Golpe a vista', '....', 'fa-solid fa-syringe');

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
(1, 1),
(3, 2),
(3, 3),
(4, 3),
(5, 4),
(6, 4),
(7, 4),
(8, 5),
(10, 5),
(11, 6),
(12, 7),
(13, 7),
(14, 8),
(15, 8),
(16, 9),
(17, 9),
(18, 9),
(19, 10),
(20, 10),
(21, 10),
(22, 11),
(22, 12),
(23, 13);

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
(1, 1),
(1, 3),
(1, 4),
(1, 12),
(1, 13),
(2, 1),
(2, 3),
(2, 4),
(2, 8),
(3, 1),
(3, 2),
(3, 4),
(3, 8),
(3, 9),
(4, 1),
(4, 3),
(4, 4),
(4, 7),
(4, 9),
(4, 13),
(5, 4),
(6, 1),
(6, 2),
(6, 3),
(6, 4),
(6, 5),
(6, 6),
(6, 7),
(6, 8),
(6, 9),
(6, 13),
(7, 4),
(8, 1),
(8, 2),
(8, 3),
(8, 4),
(8, 6),
(8, 12),
(9, 1),
(9, 14),
(10, 4),
(10, 9),
(10, 11),
(11, 1),
(11, 5),
(11, 8),
(11, 9),
(11, 13),
(11, 14);

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
(1, 4, 1, 'nao sei', 'Treinamentos incríveis e totalmente personalizados! Em apenas dois meses, já notei uma grande diferença na minha disposição e na forma física. Recomendo demais!', 5.0),
(3, 6, 2, 'nao sei', 'Gostei da estratégia proposta, mas achei o custo um pouco alto. No entanto, os resultados foram bons.', 5.0),
(4, 7, 3, 'nao sei', 'A Camila foi incrível no meu processo de transição de carreira. Consegui me recolocar no mercado fitness, mas sinto que ainda falta algo.', 4.0),
(5, 2, 10, 'nao sei', 'As aulas são incríveis! A energia dos instrutores é contagiante, e eu realmente sinto que estou me divertindo enquanto me exercito. Perdi peso sem perceber!', 5.0),
(6, 2, 8, 'nao sei', 'Os treinos são desafiadores e motivadores. Nunca imaginei que pudesse superar tantos limites!', 5.0),
(7, 5, 9, 'nao sei', 'Gostei muito das aulas, mas às vezes as turmas ficam um pouco cheias.', 4.0);

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
(1, 'Captura de tela 2024-11-17 211904.png', '673a8b92c6a240.68427774.png', 1),
(2, 'unnamed2.png', '673a9fa7e9efc5.30502243.png', 2),
(3, 'unnamed3.png', '673aa2b09a51b1.96255576.png', 3),
(4, 'vida.png', '673be38d437238.21330791.png', 4),
(5, 'Booster.png', '673be5301a6c18.06752250.png', 5),
(6, 'nutri.png', '673be8970a4dd0.37971229.png', 6),
(7, 'unnamed (1).png', '673beb031663f1.89142985.png', 7),
(8, 'unnamed (2).png', '673bedcb15f4f8.60367543.png', 8),
(9, 'unnamed (3).png', '673bef1d255f83.19255086.png', 9),
(10, 'unnamed (4).png', '673bf036cd5814.67468100.png', 10),
(11, 'golpe_10-10-25.jpg', '673bf1d2a85200.83365482.jpg', 11);

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
(1, 1, 'Plano Fitness Premium', 1520.00, 'Acesso exclusivo a treinos personalizados, acompanhamento semanal e orientações sobre alongamento e recuperação muscular. Ideal para quem busca resultados rápidos e sustentáveis.', '12'),
(2, 1, 'Plano Fitness Básico', 550.00, 'Acompanhamento semanal e orientações sobre alongamento e recuperação muscular', '6'),
(3, 2, 'Gestão Pessoal Essencial', 350.00, 'Programa para organização de rotinas.', '3'),
(4, 2, 'Gestão Pessoal Pro', 730.50, 'Programa para organização de rotinas, aumento de produtividade.', '6'),
(5, 2, 'Gestão Pessoal Premium', 1200.00, 'Programa completo para organização de rotinas, aumento de produtividade e equilíbrio entre vida pessoal e profissional.', '12'),
(6, 3, 'Nutrição Equilibrada', 180.00, 'Plano alimentar personalizado para atingir seus objetivos nutricionais, seja emagrecimento, ganho de massa muscular ou reeducação alimentar.', '1'),
(7, 3, 'Carreira Estratégica Plus', 400.00, 'Coaching especializado para transição ou desenvolvimento de carreira fitness, com foco em competências comportamentais e networking.', '3'),
(8, 3, 'Avaliaçã Corporal Completa', 100.00, 'Avaliação corpotal completa com orientações sobre alongamento e recuperação muscular.', '1'),
(9, 4, 'Plano Básico', 150.00, 'Treinamento funcional em grupo (2x por semana).\r\nAcesso a planos alimentares gerais.\r\nOrientações básicas sobre exercícios em casa.', '1'),
(10, 4, 'Plano Intermediário', 280.00, 'Treinamento funcional personalizado (3x por semana).\r\nPlano alimentar ajustado às metas individuais.\r\nSessões mensais de mindfulness em grupo.', '3'),
(11, 4, 'Plano Premium', 500.00, 'Treinamento funcional VIP com acompanhamento semanal.\r\nPlano nutricional detalhado e revisado mensalmente.\r\nSessões semanais de mindfulness individual.', '6'),
(12, 5, 'Plano Crescimento', 300.00, 'Análise inicial da marca e concorrência.\r\nCriação de 3 posts para redes sociais.\r\nEstratégias básicas de engajamento.', '3'),
(13, 6, 'Plano EssenciaL', 160.00, 'Consulta inicial com avaliação nutricional, cardápios básicos para reeducação alimentar e acesso a um grupo exclusivo de dicas semanais.', '1'),
(14, 6, 'Plano Avançado', 260.00, 'Avaliação mensal da evolução nutricional,  cardápios personalizados para cada fase do plano e suporte via WhatsApp para dúvidas rápidas.\r\n', '3'),
(15, 6, 'Plano Familiar', 400.00, 'Consultas para até 4 membros da família, receitas práticas para refeições em grupo e suporte contínuo e revisões quinzenais.\r\n', '6'),
(16, 7, 'Plano Master', 16500.00, 'Sessões semanais de acompanhamento.\r\nRevisão e otimização de processos rotineiros.\r\nFerramentas exclusivas e suporte contínuo.', '6'),
(17, 8, 'Plano Iniciante', 180.00, '2 treinos semanais.\r\nIntrodução às técnicas básicas de CrossFit.\r\nMonitoramento inicial de desempenho.', '1'),
(18, 8, 'Plano Performance', 450.00, '3 treinos semanais com acompanhamento individual.\r\nWorkshops mensais sobre alimentação e técnicas de recuperação.\r\nAcesso a desafios e competições internas.', '3'),
(19, 8, 'Plano Elite', 800.00, 'Treinos ilimitados.\r\nSessões exclusivas de força e condicionamento avançado.\r\nConsultoria contínua com nutricionistas e fisioterapeutas parceiros.', '6'),
(20, 9, 'Plano Essencial', 120.00, '2 aulas semanais de yoga.\r\nAcesso a técnicas de respiração e meditação guiada.\r\nGrupo de prática online.', '1'),
(21, 9, 'Plano Plenitude', 550.00, 'Aulas diárias de yoga (presenciais e online).\r\nWorkshops de autoconhecimento trimestrais.\r\nSuporte contínuo com instrutores especializados.', '6'),
(22, 10, 'Zumba', 250.00, '3 aulas presenciais por semana.\r\nGrupo exclusivo no WhatsApp para suporte e dicas.\r\nEventos temáticos mensais.', '3'),
(23, 11, 'Plano Máximo', 10000.00, 'Não caia em fake news.', '12');

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
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 3),
(5, 4),
(6, 6),
(7, 5),
(8, 7),
(9, 8),
(10, 8),
(10, 10),
(11, 8),
(11, 9),
(11, 10),
(12, 11),
(13, 12),
(14, 12),
(14, 13),
(15, 12),
(15, 13),
(16, 14),
(16, 15),
(17, 16),
(18, 16),
(18, 18),
(19, 16),
(19, 17),
(19, 18),
(20, 19),
(21, 19),
(21, 20),
(21, 21),
(22, 22),
(23, 23);

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
(1, 'Rafael Nogueira', '@rafaelnutri', '(21) 99876-5432', 'rafaelnogueira@gmail.com', 1),
(2, 'Bianca Mendes', '@biancamendes_coach', '(31) 98765-4321', 'bianca.mendes@gestaopro.com', 2),
(3, 'Luiz Silva', '@luiz_official', '11949419827', 'luiz.silva@gestaopro.com', 2),
(4, 'Camila Santos', '@camila_santos_carreira', '(51) 97654-3210', 'camilasantos@carreiraestrategica.com', 3),
(5, 'João ', '@joao.ativa360', '11874596853', 'joao@vidaativa360.com', 4),
(6, 'João', '@joao_brandbooster', '55789549798', 'joao@brandbooster.com', 5),
(7, 'Gabriel Souza', '@gabrielsouza_fitness', '(11) 99876-5432', 'gabriel.souza@gmail.com', 6),
(8, 'Rafael', '@rafaelreal01', '1197845698', 'rafael@gmail.com', 7),
(9, 'Lucas ', '@lucascrossfitpower', '1147589698556', 'lucas@crossfitpower.com', 8),
(10, 'Bianca Mendes', '@bia_yoga', '1147586932', 'bia@yogaessence.com', 9),
(11, 'Camila', '@camila_zumba', '114589626488', 'camila@zumba.com.br', 10),
(12, 'MIguel Silva', '@miguel_zumba', '11548789789', 'miguel@zumba.com.br', 10),
(13, 'Henrique', '@henrique', '11236547998', 'henrique@gmail.com', 11);

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
(1, 1, 1, '2024-11-18 00:30:28'),
(2, 2, 1, '2024-11-18 00:33:07'),
(3, 1, 1, '2024-11-18 00:35:39'),
(4, 1, 1, '2024-11-18 00:36:10'),
(5, 1, 1, '2024-11-18 01:01:53'),
(6, 1, 1, '2024-11-18 01:45:57'),
(7, 2, 2, '2024-11-18 02:00:56'),
(8, 2, 1, '2024-11-18 02:00:57'),
(9, 5, 1, '2024-11-18 02:14:38'),
(10, 4, 1, '2024-11-18 02:15:20'),
(11, 4, 1, '2024-11-18 02:15:32'),
(12, 4, 1, '2024-11-18 02:15:32'),
(13, 4, 1, '2024-11-18 02:15:50'),
(14, 6, 2, '2024-11-18 02:16:44'),
(15, 6, 2, '2024-11-18 02:17:17'),
(16, 6, 2, '2024-11-18 02:17:17'),
(17, 6, 2, '2024-11-18 02:19:23'),
(18, 6, 2, '2024-11-18 02:19:34'),
(19, 6, 2, '2024-11-18 02:19:34'),
(20, 7, 3, '2024-11-18 02:28:15'),
(21, 7, 3, '2024-11-18 02:35:17'),
(22, 7, 3, '2024-11-18 02:35:18'),
(23, 8, 5, '2024-11-19 01:09:10'),
(24, 10, 6, '2024-11-19 01:23:52'),
(25, 9, 4, '2024-11-19 01:27:43'),
(26, 2, 8, '2024-11-19 02:05:30'),
(27, 2, 10, '2024-11-19 02:05:38'),
(28, 2, 10, '2024-11-19 02:05:49'),
(29, 2, 10, '2024-11-19 02:05:53'),
(30, 2, 8, '2024-11-19 02:06:35'),
(31, 2, 8, '2024-11-19 02:06:47'),
(32, 2, 8, '2024-11-19 02:06:47'),
(33, 5, 9, '2024-11-19 02:08:47'),
(34, 5, 9, '2024-11-19 02:09:11'),
(35, 5, 9, '2024-11-19 02:09:11');

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
(1, 1, 1, 1, '67890-RJ'),
(2, 2, 3, 4, 'Coach de produtividade'),
(3, 3, 1, 1, '1425795'),
(4, 4, 2, 1, '5556366'),
(5, 4, 3, 3, '6636336'),
(6, 5, 1, 1, '579878979'),
(7, 6, 4, 5, '4575787789'),
(8, 7, 2, 1, '123456-SP'),
(9, 8, 1, 1, '489687789'),
(10, 9, 1, 1, '156789798'),
(11, 9, 2, 3, '457887874'),
(12, 10, 5, 5, '58789789'),
(13, 11, 1, 3, '45674867'),
(14, 12, 1, 2, '457987'),
(15, 13, 1, 1, '145744748');

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
(1, 'Rafael Nogueira', 'rafaelnogueira@gmail.com', '$2y$10$i5DJAvQpBHmrETliBYv50OdqZKiZhcNMyIxN8bPqVlaVwe5Of5LjO', '54883405052', '54883405052673a73ae0931f3.61748323.jpg', 1, '21998765432'),
(2, 'Bianca Mendes', 'bianca.mendes@gestaopro.com', '$2y$10$YY24avnRSX1b1/zRZcGlReX/liArjsHMQJHBmaG9ScB0Ww8ct84.q', '67747895011', '67747895011673a7698b8b617.06862902.jpg', 1, '31987654321'),
(3, 'Lucas Pereira', 'lucas.pereira@consultoria.com', '$2y$10$pYf4LzfKgPM8pA16svlD7OE.DR8dkKIWn6.dic9v5eb1DHyzMy0yK', '55846217060', '55846217060673a7eda927f19.05084127.jpg', 1, '41912345678'),
(4, 'Luis', 'luis@gmail.com', '$2y$10$bcT57FHccqONG64EygMMO.Cad.CtxGjl4YDXpQlIW0mjz0iMd97E6', '49137927094', NULL, 0, '1199874659'),
(5, 'Camila Santos', 'camilasantos@carreiraestrategica.com', '$2y$10$4.Exb5BSDsYtT9tq7d.pkuvnVTe12iEc07z/JytZFLiOr0nquev3G', '84016345049', '84016345049673a831044f668.53980891.jpg', 1, '51976543210'),
(6, 'Edson', 'edson@gmail.com', '$2y$10$nu0L2CP57zOajINXYK2zCOZGVkm1OsG2PsejpPW78UU5hBhrEeq0y', '55134121010', '58204903049673a849fab05e0.89599626.jpg', 0, '1157489642'),
(7, 'Ademir', 'ademir@gmail.com', '$2y$10$8wUvYowzxBGl5hfXzWLLiO0D4vlYK3SpppW9EEehObFPil9qhNLjS', '06241937057', NULL, 0, '11748596254'),
(8, 'João Paulo Silva', 'joao.consultoria@gmail.com', '$2y$10$wYmXdPwzwOGNWyaGLS7oAeHc9oCEJIRSuN4l0YzWIG1z6tcje6.W6', '58204903049', '58204903049673a849fab05e0.89599626.jpg', 1, '11478248964584'),
(9, 'admin', 'admin@spotfit.com', '$2y$10$Xzae9/DGjGS06VYyMgBsieyVq3GwelZ2wVGZwMVWbM4ZU2vYOD16W', '20585396051', NULL, 1, '11957485962'),
(10, 'Gabriel Souza', 'gabriel.souza@gmail.com', '$2y$10$LOBD9amGWvO3NI1d09QKn.WJda5mNufYD7egkdiUzrMvtO3pAsbbC', '69755522077', '69755522077673be715d97040.93152350.jpg', 1, '119874587954'),
(11, 'Henrique', 'henrique@gmail.com', '$2y$10$aOvs0eT0TSEdRstIIRSt2eZbl9Tu7G7NU.nwvNtwX/OZMcrxZleWK', '74661822080', NULL, 1, '112457897879');

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
  MODIFY `consulting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `consulting_benefit`
--
ALTER TABLE `consulting_benefit`
  MODIFY `consulting_benefit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `consulting_comment`
--
ALTER TABLE `consulting_comment`
  MODIFY `id_consulting_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `consulting_image`
--
ALTER TABLE `consulting_image`
  MODIFY `consulting_image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `consulting_plan`
--
ALTER TABLE `consulting_plan`
  MODIFY `consulting_plans_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de tabela `consulting_professional`
--
ALTER TABLE `consulting_professional`
  MODIFY `consulting_professional_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `consulting_schedules`
--
ALTER TABLE `consulting_schedules`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `consulting_view`
--
ALTER TABLE `consulting_view`
  MODIFY `consulting_view_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

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
  MODIFY `professional_register_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `register_type`
--
ALTER TABLE `register_type`
  MODIFY `register_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

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
