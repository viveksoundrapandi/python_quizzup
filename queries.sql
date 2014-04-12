-- MySQL dump 10.13  Distrib 5.5.15, for Linux (x86_64)
--
-- Host: localhost    Database: quizzup
-- ------------------------------------------------------
-- Server version	5.5.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add user',6,'add_customuser'),(17,'Can change user',6,'change_customuser'),(18,'Can delete user',6,'delete_customuser'),(19,'Can add questions',7,'add_questions'),(20,'Can change questions',7,'change_questions'),(21,'Can delete questions',7,'delete_questions'),(22,'Can add choices',8,'add_choices'),(23,'Can change choices',8,'change_choices'),(24,'Can delete choices',8,'delete_choices'),(25,'Can add quiz history',9,'add_quizhistory'),(26,'Can change quiz history',9,'change_quizhistory'),(27,'Can delete quiz history',9,'delete_quizhistory'),(28,'Can add leader board',10,'add_leaderboard'),(29,'Can change leader board',10,'change_leaderboard'),(30,'Can delete leader board',10,'delete_leaderboard');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `user_id_refs_id_3ac0bf59` FOREIGN KEY (`user_id`) REFERENCES `pyquiz_customuser` (`id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'user','pyquiz','customuser'),(7,'questions','pyquiz','questions'),(8,'choices','pyquiz','choices'),(9,'quiz history','pyquiz','quizhistory'),(10,'leader board','pyquiz','leaderboard');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('atcw9dgiq9vvijasy3lkw7e9iufnzctu','MjI1YjEyOTgzYTI1YTVhZWNlZDk3NzBkYzE4MTJlMmRiMGY1ZGY0YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-04-26 12:58:31');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_choices`
--

DROP TABLE IF EXISTS `pyquiz_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id_id` int(11) NOT NULL,
  `choice_1` longtext NOT NULL,
  `choice_2` longtext NOT NULL,
  `choice_3` longtext,
  `choice_4` longtext,
  `answer` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pyquiz_choices_19f7f452` (`question_id_id`),
  CONSTRAINT `question_id_id_refs_id_776fff53` FOREIGN KEY (`question_id_id`) REFERENCES `pyquiz_questions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_choices`
--

LOCK TABLES `pyquiz_choices` WRITE;
/*!40000 ALTER TABLE `pyquiz_choices` DISABLE KEYS */;
INSERT INTO `pyquiz_choices` VALUES (1,1,'True','False',NULL,NULL,'True'),(2,2,'x=1,y=1','x=2,y=1','x=1,y=2','x=2,y=2','x=2,y=1');
/*!40000 ALTER TABLE `pyquiz_choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_customuser`
--

DROP TABLE IF EXISTS `pyquiz_customuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_customuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `role` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_customuser`
--

LOCK TABLES `pyquiz_customuser` WRITE;
/*!40000 ALTER TABLE `pyquiz_customuser` DISABLE KEYS */;
INSERT INTO `pyquiz_customuser` VALUES (1,'pbkdf2_sha256$12000$9BZwIb0K2HNJ$DKZRXFwkEhJ5oHk8rKYd4nDjyQvm9hSGUn/FonRfLyw=','2014-04-12 12:58:31',1,'vivek.s','vivek','soundrapandi','vivek.s@global-analytics.com',1,1,'2014-04-12 11:59:43','Web Developer'),(2,'pbkdf2_sha256$12000$pDXGjxUti87Y$FZg0/SDs/w9pXyxLLVi+W1v3tD6ZkjE/q3LyXXKJV/c=','2014-04-12 12:12:54',0,'vivekhas3','vivek','soundrapandi','vivekhas3@gmail.com',0,1,'2014-04-12 12:10:09','Sr. Software Engineer'),(3,'pbkdf2_sha256$12000$9BZwIb0K2HNJ$DKZRXFwkEhJ5oHk8rKYd4nDjyQvm9hSGUn/FonRfLyw=','2014-04-12 12:05:40',0,'testuser1','test1','test1','Thalaivar@gmail.com',1,1,'2014-04-12 11:59:43','Web Developer'),(4,'pbkdf2_sha256$12000$9BZwIb0K2HNJ$DKZRXFwkEhJ5oHk8rKYd4nDjyQvm9hSGUn/FonRfLyw=','2014-04-12 12:05:40',0,'testuser2','test2','test2','powerstar@gmail.com',1,1,'2014-04-12 11:59:43','Web Developer'),(5,'pbkdf2_sha256$12000$9BZwIb0K2HNJ$DKZRXFwkEhJ5oHk8rKYd4nDjyQvm9hSGUn/FonRfLyw=','2014-04-12 12:05:40',0,'testuser3','test3','test3','kaatupoochi@gmail.com',1,1,'2014-04-12 11:59:43','Web Developer');
/*!40000 ALTER TABLE `pyquiz_customuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_customuser_groups`
--

DROP TABLE IF EXISTS `pyquiz_customuser_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_customuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customuser_id` (`customuser_id`,`group_id`),
  KEY `pyquiz_customuser_groups_a110e492` (`customuser_id`),
  KEY `pyquiz_customuser_groups_5f412f9a` (`group_id`),
  CONSTRAINT `customuser_id_refs_id_cbbc0dee` FOREIGN KEY (`customuser_id`) REFERENCES `pyquiz_customuser` (`id`),
  CONSTRAINT `group_id_refs_id_35e90a15` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_customuser_groups`
--

LOCK TABLES `pyquiz_customuser_groups` WRITE;
/*!40000 ALTER TABLE `pyquiz_customuser_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `pyquiz_customuser_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_customuser_user_permissions`
--

DROP TABLE IF EXISTS `pyquiz_customuser_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_customuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `customuser_id` (`customuser_id`,`permission_id`),
  KEY `pyquiz_customuser_user_permissions_a110e492` (`customuser_id`),
  KEY `pyquiz_customuser_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `customuser_id_refs_id_99842607` FOREIGN KEY (`customuser_id`) REFERENCES `pyquiz_customuser` (`id`),
  CONSTRAINT `permission_id_refs_id_f82df302` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_customuser_user_permissions`
--

LOCK TABLES `pyquiz_customuser_user_permissions` WRITE;
/*!40000 ALTER TABLE `pyquiz_customuser_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `pyquiz_customuser_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_leaderboard`
--

DROP TABLE IF EXISTS `pyquiz_leaderboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_leaderboard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id_id` int(11) NOT NULL,
  `week_id` int(10) unsigned NOT NULL,
  `points` int(10) unsigned NOT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pyquiz_leaderboard_1ffdedc6` (`user_id_id`),
  CONSTRAINT `user_id_id_refs_id_0d68c541` FOREIGN KEY (`user_id_id`) REFERENCES `pyquiz_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_leaderboard`
--

LOCK TABLES `pyquiz_leaderboard` WRITE;
/*!40000 ALTER TABLE `pyquiz_leaderboard` DISABLE KEYS */;
INSERT INTO `pyquiz_leaderboard` VALUES (1,1,1,60,'2014-04-12 12:09:14'),(2,2,1,30,'2014-04-12 12:30:23'),(3,3,2,65,'2014-04-12 12:09:14'),(4,4,2,30,'2014-04-12 12:09:14'),(5,5,1,30,'2014-04-12 12:09:14');
/*!40000 ALTER TABLE `pyquiz_leaderboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_questions`
--

DROP TABLE IF EXISTS `pyquiz_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question` longtext NOT NULL,
  `week_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_questions`
--

LOCK TABLES `pyquiz_questions` WRITE;
/*!40000 ALTER TABLE `pyquiz_questions` DISABLE KEYS */;
INSERT INTO `pyquiz_questions` VALUES (1,'Is python object oriented?',1),(2,'What will be x & y? <code>x=1\ny=x\nx=2</code>',1);
/*!40000 ALTER TABLE `pyquiz_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_quizhistory`
--

DROP TABLE IF EXISTS `pyquiz_quizhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_quizhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id_id` int(11) NOT NULL,
  `week_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pyquiz_quizhistory_1ffdedc6` (`user_id_id`),
  CONSTRAINT `user_id_id_refs_id_adcc47b8` FOREIGN KEY (`user_id_id`) REFERENCES `pyquiz_customuser` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_quizhistory`
--

LOCK TABLES `pyquiz_quizhistory` WRITE;
/*!40000 ALTER TABLE `pyquiz_quizhistory` DISABLE KEYS */;
INSERT INTO `pyquiz_quizhistory` VALUES (1,1,1),(2,2,1);
/*!40000 ALTER TABLE `pyquiz_quizhistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-12 20:55:42
