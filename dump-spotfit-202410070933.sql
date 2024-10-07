-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: spotfit
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.24-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'Emagrecimento'),(2,'Hipertrofia'),(3,'Treinamento de atletas'),(4,'Saúde'),(5,'Pressão alta'),(6,'Obesidade'),(7,'Envelhecimento saudável'),(8,'Alta performance'),(9,'Funcional'),(10,'Calistenia'),(11,'Dança'),(12,'Crossfit'),(13,'Fisioterapia'),(14,'Yoga/Pilates');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting`
--

DROP TABLE IF EXISTS `consulting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting` (
  `consulting_id` int(11) NOT NULL AUTO_INCREMENT,
  `consulting_name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `contact_email` varchar(255) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `adm_user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`consulting_id`),
  KEY `adm_user_id` (`adm_user_id`),
  CONSTRAINT `consulting_ibfk_1` FOREIGN KEY (`adm_user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting`
--

LOCK TABLES `consulting` WRITE;
/*!40000 ALTER TABLE `consulting` DISABLE KEYS */;
INSERT INTO `consulting` VALUES (1,'Consultoria 1','Descrição da consultoria \r\n\r\nWhat is Lorem Ipsum?\r\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\n\r\nWhy do we use it?\r\nIt is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the ','gutiinacio@gmail.com','119830206981',1),(2,'FitJourney Consultoria','Another description...','ana@gmail.com','119830206982',1),(3,'Vital Balance Consulting','More description...','carlos@gmail.com','119830206983',1),(4,'Wellness Warriors','Fourth description...','maria@gmail.com','119830206984',1),(5,'Prime Performance Consulting','Fifth description...','luiz@gmail.com','119830206985',1),(6,'Holistic Health Hub','Sixth description...','fernanda@gmail.com','119830206986',1),(7,'Elevate Fitness Consulting','Seventh description...','juliana@gmail.com','119830206987',1),(8,'Peak Potential Consultants','Eighth description...','pedro@gmail.com','119830206988',1),(9,'ProHealth Consulting','Ninth description...','roberta@gmail.com','119830206989',1),(10,'Dynamic Vitality Advisors','Tenth description...','thiago@gmail.com','119830206990',1),(11,'Optimal Wellness Solutions','Eleventh description...','clara@gmail.com','119830206991',1);
/*!40000 ALTER TABLE `consulting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_access`
--

DROP TABLE IF EXISTS `consulting_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_access` (
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `liked` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`consulting_id`),
  KEY `consulting_id` (`consulting_id`),
  CONSTRAINT `consulting_access_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `consulting_access_ibfk_2` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_access`
--

LOCK TABLES `consulting_access` WRITE;
/*!40000 ALTER TABLE `consulting_access` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulting_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_benefit`
--

DROP TABLE IF EXISTS `consulting_benefit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_benefit` (
  `consulting_benefit_id` int(11) NOT NULL AUTO_INCREMENT,
  `benefit` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`consulting_benefit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_benefit`
--

LOCK TABLES `consulting_benefit` WRITE;
/*!40000 ALTER TABLE `consulting_benefit` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulting_benefit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_benefit_professional`
--

DROP TABLE IF EXISTS `consulting_benefit_professional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_benefit_professional` (
  `consulting_benefit_id` int(11) NOT NULL,
  `consulting_professional_id` int(11) NOT NULL,
  PRIMARY KEY (`consulting_benefit_id`,`consulting_professional_id`),
  KEY `consulting_professional_id` (`consulting_professional_id`),
  CONSTRAINT `consulting_benefit_professional_ibfk_1` FOREIGN KEY (`consulting_benefit_id`) REFERENCES `consulting_benefit` (`consulting_benefit_id`),
  CONSTRAINT `consulting_benefit_professional_ibfk_2` FOREIGN KEY (`consulting_professional_id`) REFERENCES `consulting_professional` (`consulting_professional_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_benefit_professional`
--

LOCK TABLES `consulting_benefit_professional` WRITE;
/*!40000 ALTER TABLE `consulting_benefit_professional` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulting_benefit_professional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_category`
--

DROP TABLE IF EXISTS `consulting_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_category` (
  `consulting_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`consulting_id`,`category_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `consulting_category_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`),
  CONSTRAINT `consulting_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_category`
--

LOCK TABLES `consulting_category` WRITE;
/*!40000 ALTER TABLE `consulting_category` DISABLE KEYS */;
INSERT INTO `consulting_category` VALUES (1,13),(2,5),(3,8),(4,1),(5,6),(6,9),(7,11),(8,7),(9,12),(10,4),(11,2);
/*!40000 ALTER TABLE `consulting_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_comment`
--

DROP TABLE IF EXISTS `consulting_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_comment` (
  `id_consulting_comment` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `consulting_id` int(11) NOT NULL,
  `comment_type` varchar(50) DEFAULT NULL,
  `comment_text` text DEFAULT NULL,
  `rating` decimal(2,1) DEFAULT NULL,
  PRIMARY KEY (`id_consulting_comment`),
  KEY `user_id` (`user_id`),
  KEY `consulting_id` (`consulting_id`),
  CONSTRAINT `consulting_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `consulting_comment_ibfk_2` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_comment`
--

LOCK TABLES `consulting_comment` WRITE;
/*!40000 ALTER TABLE `consulting_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulting_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_image`
--

DROP TABLE IF EXISTS `consulting_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_image` (
  `consulting_image_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text DEFAULT NULL,
  `image_dir` varchar(255) DEFAULT NULL,
  `consulting_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`consulting_image_id`),
  KEY `consulting_id` (`consulting_id`),
  CONSTRAINT `consulting_image_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_image`
--

LOCK TABLES `consulting_image` WRITE;
/*!40000 ALTER TABLE `consulting_image` DISABLE KEYS */;
INSERT INTO `consulting_image` VALUES (1,'Image descirption','/assets/img/perfil_profissional.jpg',1),(2,'Another image description','/assets/img/perfil_profissional.jpg',2),(3,'More image description','/assets/img/perfil_profissional.jpg',3),(4,'Fourth image description','/assets/img/perfil_profissional.jpg',4),(5,'Fifth image description','/assets/img/perfil_profissional.jpg',5),(6,'Sixth image description','/assets/img/perfil_profissional.jpg',6),(7,'Seventh image description','/assets/img/perfil_profissional.jpg',7),(8,'Eighth image description','/assets/img/perfil_profissional.jpg',8),(9,'Ninth image description','/assets/img/perfil_profissional.jpg',9),(10,'Tenth image description','/assets/img/perfil_profissional.jpg',10),(11,'Eleventh image description','/assets/img/perfil_profissional.jpg',11);
/*!40000 ALTER TABLE `consulting_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_plan`
--

DROP TABLE IF EXISTS `consulting_plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_plan` (
  `consulting_plans_id` int(11) NOT NULL AUTO_INCREMENT,
  `consulting_id` int(11) NOT NULL,
  `plan` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` text DEFAULT NULL,
  `period` varchar(50) NOT NULL,
  PRIMARY KEY (`consulting_plans_id`),
  KEY `consulting_id` (`consulting_id`),
  CONSTRAINT `consulting_plan_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_plan`
--

LOCK TABLES `consulting_plan` WRITE;
/*!40000 ALTER TABLE `consulting_plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulting_plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_plan_benefit`
--

DROP TABLE IF EXISTS `consulting_plan_benefit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_plan_benefit` (
  `consulting_plans_id` int(11) NOT NULL,
  `id_beneficio_consultoria` int(11) NOT NULL,
  PRIMARY KEY (`consulting_plans_id`,`id_beneficio_consultoria`),
  KEY `id_beneficio_consultoria` (`id_beneficio_consultoria`),
  CONSTRAINT `consulting_plan_benefit_ibfk_1` FOREIGN KEY (`consulting_plans_id`) REFERENCES `consulting_plan` (`consulting_plans_id`),
  CONSTRAINT `consulting_plan_benefit_ibfk_2` FOREIGN KEY (`id_beneficio_consultoria`) REFERENCES `consulting_benefit` (`consulting_benefit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_plan_benefit`
--

LOCK TABLES `consulting_plan_benefit` WRITE;
/*!40000 ALTER TABLE `consulting_plan_benefit` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulting_plan_benefit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consulting_professional`
--

DROP TABLE IF EXISTS `consulting_professional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulting_professional` (
  `consulting_professional_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `instagram` varchar(255) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `consulting_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`consulting_professional_id`),
  KEY `consulting_id` (`consulting_id`),
  CONSTRAINT `consulting_professional_ibfk_1` FOREIGN KEY (`consulting_id`) REFERENCES `consulting` (`consulting_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulting_professional`
--

LOCK TABLES `consulting_professional` WRITE;
/*!40000 ALTER TABLE `consulting_professional` DISABLE KEYS */;
INSERT INTO `consulting_professional` VALUES (1,'Pablo','@gutiinacio','119581369155','email@email.com',1),(2,'Ana','@ana_fit','119581369156','ana@email.com',2),(3,'Carlos','@carlos_fit','119581369157','carlos@email.com',3),(4,'Maria','@maria_fit','119581369158','maria@email.com',4),(5,'Luiz','@luiz_fit','119581369159','luiz@email.com',5),(6,'Fernanda','@fernanda_fit','119581369160','fernanda@email.com',6),(7,'Juliana','@juliana_fit','119581369161','juliana@email.com',7),(8,'Pedro','@pedro_fit','119581369162','pedro@email.com',8),(9,'Roberta','@roberta_fit','119581369163','roberta@email.com',9),(10,'Thiago','@thiago_fit','119581369164','thiago@email.com',10),(11,'Clara','@clara_fit','119581369165','clara@email.com',11);
/*!40000 ALTER TABLE `consulting_professional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_contact`
--

DROP TABLE IF EXISTS `email_contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_contact` (
  `email_contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `person_name` varchar(255) NOT NULL,
  `person_email` varchar(255) NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`email_contact_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_contact`
--

LOCK TABLES `email_contact` WRITE;
/*!40000 ALTER TABLE `email_contact` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `profession`
--

DROP TABLE IF EXISTS `profession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profession` (
  `profession_id` int(11) NOT NULL AUTO_INCREMENT,
  `profession_name` varchar(100) NOT NULL,
  `profession_description` text DEFAULT NULL,
  PRIMARY KEY (`profession_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profession`
--

LOCK TABLES `profession` WRITE;
/*!40000 ALTER TABLE `profession` DISABLE KEYS */;
INSERT INTO `profession` VALUES (1,'Educador físico','Especialista em exercícios e ao ensino da técnica correta'),(2,'Nutricionista','Especialista em saúde alimentar, cria planos de alimentação balanceados para promover bem-estar e nutrição'),(3,'Fisioterapeuta','Profissional que reabilita e previne lesões musculoesqueléticas por meio de exercícios, terapias e técnicas manuais'),(4,'Influenciador','Compartilha dicas de exercícios, nutrição e estilo de vida saudável para motivar seguidores'),(5,'Instrutor de Yoga/Pilates','Ensina técnicas de yoga ou pilates para melhorar flexibilidade, força, equilíbrio e relaxamento');
/*!40000 ALTER TABLE `profession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `professional_register`
--

DROP TABLE IF EXISTS `professional_register`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `professional_register` (
  `professional_register_id` int(11) NOT NULL AUTO_INCREMENT,
  `consulting_professional_id` int(11) DEFAULT NULL,
  `profession_id` int(11) DEFAULT NULL,
  `register_type_id` int(11) DEFAULT NULL,
  `register` varchar(255) NOT NULL,
  PRIMARY KEY (`professional_register_id`),
  KEY `consulting_professional_id` (`consulting_professional_id`),
  KEY `profession_id` (`profession_id`),
  KEY `register_type_id` (`register_type_id`),
  CONSTRAINT `professional_register_ibfk_1` FOREIGN KEY (`consulting_professional_id`) REFERENCES `consulting_professional` (`consulting_professional_id`),
  CONSTRAINT `professional_register_ibfk_2` FOREIGN KEY (`profession_id`) REFERENCES `profession` (`profession_id`),
  CONSTRAINT `professional_register_ibfk_3` FOREIGN KEY (`register_type_id`) REFERENCES `register_type` (`register_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `professional_register`
--

LOCK TABLES `professional_register` WRITE;
/*!40000 ALTER TABLE `professional_register` DISABLE KEYS */;
INSERT INTO `professional_register` VALUES (1,1,1,1,'174'),(2,2,1,1,'175'),(3,3,1,1,'176'),(4,4,1,1,'177'),(5,5,1,1,'178'),(6,6,1,1,'179'),(7,7,1,1,'180'),(8,8,1,1,'181'),(9,9,1,1,'182'),(10,10,1,1,'183'),(11,11,1,1,'184');
/*!40000 ALTER TABLE `professional_register` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `register_type`
--

DROP TABLE IF EXISTS `register_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `register_type` (
  `register_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `type_description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`register_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `register_type`
--

LOCK TABLES `register_type` WRITE;
/*!40000 ALTER TABLE `register_type` DISABLE KEYS */;
INSERT INTO `register_type` VALUES (1,'CREF','Brasil','Conselho Regional de Educação Física; para atuar em avaliações e prescrições de exercícios'),(2,'CRN','Brasil','Conselho Regional de Nutrição; exige graduação em Nutrição e especialização esportiva'),(3,'CREFITO','Brasil','Conselho Regional de Fisioterapia e Terapia Ocupacional. É obrigatório para atuar legalmente na área'),(4,'CFN','Brasil','Conselho Federal que regulamenta e fiscaliza a atuação dos nutricionistas no Brasil'),(5,'CRM','Brasil','Conselho Regional de Medicina; regula, fiscaliza e habilita médicos para o exercício profissional no');
/*!40000 ALTER TABLE `register_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `user_password` varchar(255) NOT NULL,
  `cpf_or_cnpj` varchar(20) NOT NULL,
  `profile_photo` varchar(255) DEFAULT NULL,
  `professional` tinyint(1) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Gustavo ','gutiinacio@gmail.com','$2y$10$I1LoTBKnJuAr9nUOp2xKgev/78oxJFgYs4EPv4NswU2owvOkiKGBe','51882572890','download.jpg',NULL,'11983020691'),(2,'Gustavo ','gutiinacio@gmail.com','$2y$10$r09ODrlfOW8lohowHJZDouiLOXTAi8TOzhsgIO3Tr6aV/9h74I8Z2','51882572890','a.jpg',NULL,'11983020691');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'spotfit'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-07  9:33:59
