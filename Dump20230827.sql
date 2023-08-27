CREATE DATABASE  IF NOT EXISTS `academia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `academia`;
-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: academia
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `academia_assignment`
--

DROP TABLE IF EXISTS `academia_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_assignment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `file` varchar(100) NOT NULL,
  `description` longtext NOT NULL,
  `due_date` datetime(6) NOT NULL,
  `course_id` bigint NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academia_assignment_course_id_768919e2_fk_academia_course_id` (`course_id`),
  CONSTRAINT `academia_assignment_course_id_768919e2_fk_academia_course_id` FOREIGN KEY (`course_id`) REFERENCES `academia_course` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_assignment`
--

LOCK TABLES `academia_assignment` WRITE;
/*!40000 ALTER TABLE `academia_assignment` DISABLE KEYS */;
INSERT INTO `academia_assignment` VALUES (1,'PYTHON CALCULATOR','academia/uploads/assignements/SYLLABUS_IPNET_-_CSC__301-_Structures_de_Donnees_avec_Java_JrgckGd.pdf','All the info in the file','2023-09-01 23:00:00.000000',3,'EN COURS'),(3,'CURRENCY CONVERTER','academia/uploads/assignements/3_LES_NIVEAU_DE_PERTURBATION_0K.pdf','All infos in the file','2023-08-27 23:59:00.000000',3,'EN COURS');
/*!40000 ALTER TABLE `academia_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_course`
--

DROP TABLE IF EXISTS `academia_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_course` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `teacher_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academia_course_teacher_id_c9df717e_fk_academia_user_id` (`teacher_id`),
  CONSTRAINT `academia_course_teacher_id_c9df717e_fk_academia_user_id` FOREIGN KEY (`teacher_id`) REFERENCES `academia_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_course`
--

LOCK TABLES `academia_course` WRITE;
/*!40000 ALTER TABLE `academia_course` DISABLE KEYS */;
INSERT INTO `academia_course` VALUES (1,'DJANGO',6),(3,'PYTHON 1',10);
/*!40000 ALTER TABLE `academia_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_course_enrolled_students`
--

DROP TABLE IF EXISTS `academia_course_enrolled_students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_course_enrolled_students` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `course_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academia_course_enrolled_course_id_user_id_9cb29c95_uniq` (`course_id`,`user_id`),
  KEY `academia_course_enro_user_id_e449d58a_fk_academia_` (`user_id`),
  CONSTRAINT `academia_course_enro_course_id_79502193_fk_academia_` FOREIGN KEY (`course_id`) REFERENCES `academia_course` (`id`),
  CONSTRAINT `academia_course_enro_user_id_e449d58a_fk_academia_` FOREIGN KEY (`user_id`) REFERENCES `academia_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_course_enrolled_students`
--

LOCK TABLES `academia_course_enrolled_students` WRITE;
/*!40000 ALTER TABLE `academia_course_enrolled_students` DISABLE KEYS */;
INSERT INTO `academia_course_enrolled_students` VALUES (1,1,4),(2,1,7),(3,1,9),(4,3,4),(5,3,7),(6,3,9);
/*!40000 ALTER TABLE `academia_course_enrolled_students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_grade`
--

DROP TABLE IF EXISTS `academia_grade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_grade` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note` decimal(5,2) NOT NULL,
  `comment` longtext NOT NULL,
  `submission_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academia_grade_submission_id_55307393_fk_academia_submission_id` (`submission_id`),
  CONSTRAINT `academia_grade_submission_id_55307393_fk_academia_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `academia_submission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_grade`
--

LOCK TABLES `academia_grade` WRITE;
/*!40000 ALTER TABLE `academia_grade` DISABLE KEYS */;
INSERT INTO `academia_grade` VALUES (1,14.50,'Peut miieux faire',1);
/*!40000 ALTER TABLE `academia_grade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_submission`
--

DROP TABLE IF EXISTS `academia_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_submission` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  `submitted_at` datetime(6) NOT NULL,
  `assignment_id` bigint NOT NULL,
  `student_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `academia_submission_assignment_id_30771aab_fk_academia_` (`assignment_id`),
  KEY `academia_submission_student_id_6f0bf6ef_fk_academia_user_id` (`student_id`),
  CONSTRAINT `academia_submission_assignment_id_30771aab_fk_academia_` FOREIGN KEY (`assignment_id`) REFERENCES `academia_assignment` (`id`),
  CONSTRAINT `academia_submission_student_id_6f0bf6ef_fk_academia_user_id` FOREIGN KEY (`student_id`) REFERENCES `academia_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_submission`
--

LOCK TABLES `academia_submission` WRITE;
/*!40000 ALTER TABLE `academia_submission` DISABLE KEYS */;
INSERT INTO `academia_submission` VALUES (1,'academia/uploads/submissions/jquery-validation-1.19.1.zip','2023-08-27 06:41:01.303226',1,9);
/*!40000 ALTER TABLE `academia_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_user`
--

DROP TABLE IF EXISTS `academia_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(30) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `birth_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_user`
--

LOCK TABLES `academia_user` WRITE;
/*!40000 ALTER TABLE `academia_user` DISABLE KEYS */;
INSERT INTO `academia_user` VALUES (4,'pbkdf2_sha256$600000$lHeBj6Q801lA9CZ9z2Ycmp$gfZdOHsntr5Eh37l80LoGNd+JMnlGqLv0S+VDBOMBIE=',NULL,0,'bruce.lee@itacademia.com','BRUCE','Lee','',0,1,'2023-08-18 12:06:07.985004','STUDENT','90432345','2023-08-22'),(5,'pbkdf2_sha256$600000$Zz9lIvLJBtoxISmnwmlUj6$df/FsJ+V19iI72pDkV74XgiIMT8mGLlMxpHSYbCgzN4=','2023-08-27 17:25:56.012288',0,'admin@admin.com','admin','admin','',0,1,'2023-08-19 15:52:51.835966','ADMIN','00000','2023-08-22'),(6,'pbkdf2_sha256$600000$ym2OnOYqQdGrchdBe8pfNW$WxCdC2eHhMfkY5fVVHsGzYCYuVUzDD2NGUeFlx5VasM=',NULL,0,'isma.tate@itacademia.com','ISMA','Tate','',0,1,'2023-08-19 15:58:05.467162','TEACHER','9023245','2023-08-22'),(7,'pbkdf2_sha256$600000$H6w4Lcrc4NmlQhtSEZfNHx$8EcnRtNSUYrJ8zsOVarCYox/1RLlKmZ9QHYlz1aa26s=','2023-08-27 17:31:06.882519',0,'john.doe@itacademia.com','Doe','John','',0,1,'2023-08-21 20:40:59.739455','STUDENT','93245231','2023-08-22'),(9,'pbkdf2_sha256$600000$Y3S9EJqjPTYoBSNi5FqdFR$1MIInmdW5FfOMvghlicwd/VGwH/vxjOll9HrX7M5Jrg=','2023-08-27 15:47:41.443082',0,'kuzko.norman.@itacademia.com','KUZKO','Norman','',0,1,'2023-08-22 07:16:49.755052','STUDENT','93245122','1920-08-22'),(10,'pbkdf2_sha256$600000$TyBiDpIwH1zVwWVNCTup7M$H1qebeWmCULTtpo6m8XJ/YXzs5Eo50EC/++u3VEX3ag=','2023-08-27 17:20:32.830128',0,'ferrera.marta@itacademia.com','FERRERA','Marta','',0,1,'2023-08-22 18:54:29.095396','TEACHER','90299122','2000-02-20'),(11,'pbkdf2_sha256$600000$6dd1oM7TzH7fvaYBRhU9wX$F5t09xUtvd5N5Ck4c5stP0d9G4bwP4QnEGZjtBmQQNE=',NULL,0,'lonie.walker@itacademia.com','LONIE','Walker','',0,1,'2023-08-24 16:26:27.474573','STUDENT','93245122','2007-08-13');
/*!40000 ALTER TABLE `academia_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_user_groups`
--

DROP TABLE IF EXISTS `academia_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academia_user_groups_user_id_group_id_80617e77_uniq` (`user_id`,`group_id`),
  KEY `academia_user_groups_group_id_8247e3ff_fk_auth_group_id` (`group_id`),
  CONSTRAINT `academia_user_groups_group_id_8247e3ff_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `academia_user_groups_user_id_e5c80ab8_fk_academia_user_id` FOREIGN KEY (`user_id`) REFERENCES `academia_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_user_groups`
--

LOCK TABLES `academia_user_groups` WRITE;
/*!40000 ALTER TABLE `academia_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `academia_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `academia_user_user_permissions`
--

DROP TABLE IF EXISTS `academia_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `academia_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `academia_user_user_permi_user_id_permission_id_e3e291cc_uniq` (`user_id`,`permission_id`),
  KEY `academia_user_user_p_permission_id_a28891c0_fk_auth_perm` (`permission_id`),
  CONSTRAINT `academia_user_user_p_permission_id_a28891c0_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `academia_user_user_p_user_id_a71d3a6f_fk_academia_` FOREIGN KEY (`user_id`) REFERENCES `academia_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academia_user_user_permissions`
--

LOCK TABLES `academia_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `academia_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `academia_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add session',4,'add_session'),(14,'Can change session',4,'change_session'),(15,'Can delete session',4,'delete_session'),(16,'Can view session',4,'view_session'),(17,'Can add user',5,'add_user'),(18,'Can change user',5,'change_user'),(19,'Can delete user',5,'delete_user'),(20,'Can view user',5,'view_user'),(21,'Can add course',6,'add_course'),(22,'Can change course',6,'change_course'),(23,'Can delete course',6,'delete_course'),(24,'Can view course',6,'view_course'),(25,'Can add assignment',7,'add_assignment'),(26,'Can change assignment',7,'change_assignment'),(27,'Can delete assignment',7,'delete_assignment'),(28,'Can view assignment',7,'view_assignment'),(29,'Can add submission',8,'add_submission'),(30,'Can change submission',8,'change_submission'),(31,'Can delete submission',8,'delete_submission'),(32,'Can view submission',8,'view_submission'),(33,'Can add grade',9,'add_grade'),(34,'Can change grade',9,'change_grade'),(35,'Can delete grade',9,'delete_grade'),(36,'Can view grade',9,'view_grade');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (7,'academia','assignment'),(6,'academia','course'),(9,'academia','grade'),(8,'academia','submission'),(5,'academia','user'),(2,'auth','group'),(1,'auth','permission'),(3,'contenttypes','contenttype'),(4,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2023-07-28 19:18:43.417500'),(2,'contenttypes','0002_remove_content_type_name','2023-07-28 19:18:43.466491'),(3,'auth','0001_initial','2023-07-28 19:18:43.583132'),(4,'auth','0002_alter_permission_name_max_length','2023-07-28 19:18:43.628395'),(5,'auth','0003_alter_user_email_max_length','2023-07-28 19:18:43.639941'),(6,'auth','0004_alter_user_username_opts','2023-07-28 19:18:43.650322'),(7,'auth','0005_alter_user_last_login_null','2023-07-28 19:18:43.658439'),(8,'auth','0006_require_contenttypes_0002','2023-07-28 19:18:43.666094'),(9,'auth','0007_alter_validators_add_error_messages','2023-07-28 19:18:43.684935'),(10,'auth','0008_alter_user_username_max_length','2023-07-28 19:18:43.703348'),(11,'auth','0009_alter_user_last_name_max_length','2023-07-28 19:18:43.718538'),(12,'auth','0010_alter_group_name_max_length','2023-07-28 19:18:43.754011'),(13,'auth','0011_update_proxy_permissions','2023-07-28 19:18:43.785309'),(14,'auth','0012_alter_user_first_name_max_length','2023-07-28 19:18:43.823346'),(15,'sessions','0001_initial','2023-07-28 19:18:43.876192'),(16,'academia','0001_initial','2023-07-28 19:19:42.887000'),(17,'academia','0002_alter_course_enrolled_students_alter_course_teacher','2023-08-19 20:59:41.680766'),(18,'academia','0003_alter_course_teacher','2023-08-19 21:13:50.083499'),(19,'academia','0004_alter_course_enrolled_students','2023-08-19 23:06:43.813658'),(20,'academia','0005_assignment_status_user_birth_date','2023-08-22 11:29:01.555860'),(21,'academia','0006_alter_assignment_course','2023-08-22 21:33:12.483148'),(22,'academia','0007_alter_assignment_file','2023-08-23 09:04:02.299814'),(23,'academia','0008_alter_assignment_file','2023-08-23 09:04:02.312361'),(24,'academia','0009_alter_assignment_due_date','2023-08-23 09:46:11.561636'),(25,'academia','0010_alter_assignment_file_alter_submission_file','2023-08-23 17:19:52.438804');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1nyxms8k0lqstw73ycjqperu9emfzxnz','.eJxVjMsOwiAUBf-FtSEgwgWX7v0Gch9UqoYmpV0Z_12bdKHbMzPnpTKuS81rL3MeRZ2VV4ffjZAfpW1A7thuk-apLfNIelP0Tru-TlKel939O6jY67fGo01Ig40AhnwkIEnAMZApLkgSSIkCn8BHKwEHz8lBKWSccU6QSb0_6wk4Rg:1qXOPI:6QZxZh5bCElevXZ_oXukHRwHQxG2iGqEH7UHQz69cN8','2023-09-02 16:02:32.013795'),('4hnmpvkjxmoko91mop03g1uyhdhfjr9b','.eJxVjLEOAiEQRP-F2hCWsLBY2vsNBBaUUwPJcVcZ_9275Aotppn3Zt4ixHWpYR1lDlMWZwHi9NulyM_SdpAfsd275N6WeUpyV-RBh7z2XF6Xw_07qHHUbe2MJr8lE3i8ETgyhGCMRY1ZKw0-O1JsIZGOtiSlo7POF2RksOzF5wuL_TYP:1qQ3z7:QI9neTBsc0es5BQ4qKEGd3BQHP1w8-HyXXZMHEKDNT8','2023-08-13 10:49:13.970897'),('5u9yaqi6abeuc3hwpghkjt6fadwxxgvv','.eJxVjDsOwjAQBe_iGln-xJ-lpM8ZrLW9wQFkS3FSIe5OIqWA9s3Me7OA21rC1mkJc2ZXptnld4uYnlQPkB9Y742nVtdljvxQ-Ek7H1um1-10_w4K9rLXjiTarPVklEhAYJKL3imfhLFRWkEgUZlBaBiMF570TiArmsAA6uTY5wvHFjb3:1qUBA1:PlEC0gFgLQLPZrUgAcLlrVqEoXqIaAlzOM252vbdHTA','2023-08-24 19:17:29.382537'),('6r5zb2rvypjtd2qove0lomv4mpty06e0','.eJxVjDsOwyAQRO9CHSF-NpAyvc-A2F0ITiKQjF1FuXuE5CKpRpr3Zt4sxGMv4ehpCyuxK5OCXX5LiPhMdRB6xHpvHFvdtxX4UPhJO18apdftdP8OSuxlrJUVyvhEUpC2HpP2JJUWMVsyiGqCWaOZyek8jfAugwKXMQsfZQL2-QL_uzhp:1qaB0y:LisHXkTESbyWvnrOOHbrh0dxxJdMTDEuFc0SoJEoiSE','2023-09-10 08:20:56.714461'),('7pl3p2yqckduhbesu5ghrvocc7rdocsz','.eJxVjMEOwiAQRP-FsyECXWA9evcbCOyCVA1NSnsy_rtt0oPOcd6beYsQ16WGtec5jCwuAsXpt0uRnrntgB-x3SdJU1vmMcldkQft8jZxfl0P9--gxl63tSt6SwLF7HVUJRbWhKQNsncOWasClP1gAKy12WdfEJAUgSmDN2fx-QLoAzeZ:1qZQ6c:yrlSYcf3HAiqG0qev4SVWAPvxV_PFq_32twD68I7Zn0','2023-09-08 06:15:38.469866'),('8l1gjwhu0upmvyypfs5zfgjcommttg65','.eJxVjDsOwjAQBe_iGln-xJ-lpM8ZrLW9wQFkS3FSIe5OIqWA9s3Me7OA21rC1mkJc2ZXptnld4uYnlQPkB9Y742nVtdljvxQ-Ek7H1um1-10_w4K9rLXjiTarPVklEhAYJKL3imfhLFRWkEgUZlBaBiMF570TiArmsAA6uTY5wvHFjb3:1qToRJ:mw-3SDe57U96W_nXPRiGTY9H8WmhJc7AiUbPGpCpDx8','2023-08-23 19:01:49.470122'),('k9f7ftnkv9tejuathqf2kdx7cqx3ijx6','.eJxVjDsOwyAQRO9CHSF-NpAyvc-A2F0ITiKQjF1FuXuE5CKpRpr3Zt4sxGMv4ehpCyuxK5OCXX5LiPhMdRB6xHpvHFvdtxX4UPhJO18apdftdP8OSuxlrJUVyvhEUpC2HpP2JJUWMVsyiGqCWaOZyek8jfAugwKXMQsfZQL2-QL_uzhp:1qYlOE:sCCcItP8mmTLGxpi7mMcX-1hwV5S-gQtE07Kg-qwfmQ','2023-09-06 10:47:06.555633'),('mr7pi0tjykis99m0riykepyf11webcgb','.eJxVjLEOAiEQRP-F2hCWsLBY2vsNBBaUUwPJcVcZ_9275Aotppn3Zt4ixHWpYR1lDlMWZwHi9NulyM_SdpAfsd275N6WeUpyV-RBh7z2XF6Xw_07qHHUbe2MJr8lE3i8ETgyhGCMRY1ZKw0-O1JsIZGOtiSlo7POF2RksOzF5wuL_TYP:1qPT20:M8bHOha56VlEZ9fnYS2UsurozRGoIT7PC9vs-sJb5CI','2023-08-11 19:21:44.837529'),('qkdgox72wkm13dek4l7x7af9l01j37ok','.eJxVjMEOwiAQRP-FsyECXWA9evcbCOyCVA1NSnsy_rtt0oPOcd6beYsQ16WGtec5jCwuAsXpt0uRnrntgB-x3SdJU1vmMcldkQft8jZxfl0P9--gxl63tSt6SwLF7HVUJRbWhKQNsncOWasClP1gAKy12WdfEJAUgSmDN2fx-QLoAzeZ:1qZWaS:jgew88RTe8gFvmN8o3yV4EuEjSpwV0PVPZTaWd4GxOQ','2023-09-08 13:10:52.652838'),('rom6rckhcojt6ek6v5a1rp6qyq63766j','.eJxVjDsOwyAQRO9CHSF-NpAyvc-A2F0ITiKQjF1FuXuE5CKpRpr3Zt4sxGMv4ehpCyuxK5OCXX5LiPhMdRB6xHpvHFvdtxX4UPhJO18apdftdP8OSuxlrJUVyvhEUpC2HpP2JJUWMVsyiGqCWaOZyek8jfAugwKXMQsfZQL2-QL_uzhp:1qZWid:uheSCf-bPRIxF2tZiuygB8ohgVjDIMIf0keJDCwCQDc','2023-09-08 13:19:19.497755'),('u8wr4la7ut7byhfq9tpubipbdn31lk0d','.eJxVjLEOAiEQRP-F2hCWsLBY2vsNBBaUUwPJcVcZ_9275Aotppn3Zt4ixHWpYR1lDlMWZwHi9NulyM_SdpAfsd275N6WeUpyV-RBh7z2XF6Xw_07qHHUbe2MJr8lE3i8ETgyhGCMRY1ZKw0-O1JsIZGOtiSlo7POF2RksOzF5wuL_TYP:1qPTJb:zGP6fnx6wvAJ4yEdVAtlE9A-trIkIeQGa87bVo8gbTk','2023-08-11 19:39:55.241354'),('z8f94tb0g4ep5e63m1ktqycnutbpg5io','.eJxVjMEOwiAQRP-FsyECXWA9evcbCOyCVA1NSnsy_rtt0oPOcd6beYsQ16WGtec5jCwuAsXpt0uRnrntgB-x3SdJU1vmMcldkQft8jZxfl0P9--gxl63tSt6SwLF7HVUJRbWhKQNsncOWasClP1gAKy12WdfEJAUgSmDN2fx-QLoAzeZ:1qZalR:49XkcrMCLJ4mzPSuAjSN9154wa4F1euX6N12fNKW1NE','2023-09-08 17:38:29.971891'),('zm0dwirxj30qqth4e779dkf2rjej2em4','.eJxVjMsOwiAUBf-FtSEgwgWX7v0Gch9UqoYmpV0Z_12bdKHbMzPnpTKuS81rL3MeRZ2VV4ffjZAfpW1A7thuk-apLfNIelP0Tru-TlKel939O6jY67fGo01Ig40AhnwkIEnAMZApLkgSSIkCn8BHKwEHz8lBKWSccU6QSb0_6wk4Rg:1qY5AW:XrnmnOJSOyHBJwuKvs6pg4MrtmZQrGDlvplqUd6QGSU','2023-09-04 13:42:08.287042');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-27 18:54:03
