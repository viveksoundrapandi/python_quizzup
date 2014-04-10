-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: quizzup
-- ------------------------------------------------------
-- Server version	5.5.35-0ubuntu0.12.10.2

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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add questions',7,'add_questions'),(20,'Can change questions',7,'change_questions'),(21,'Can delete questions',7,'delete_questions'),(22,'Can add choices',8,'add_choices'),(23,'Can change choices',8,'change_choices'),(24,'Can delete choices',8,'delete_choices'),(28,'Can add leader board',10,'add_leaderboard'),(29,'Can change leader board',10,'change_leaderboard'),(30,'Can delete leader board',10,'delete_leaderboard'),(31,'Can add user details',11,'add_userdetails'),(32,'Can change user details',11,'change_userdetails'),(33,'Can delete user details',11,'delete_userdetails'),(34,'Can add quiz history',12,'add_quizhistory'),(35,'Can change quiz history',12,'change_quizhistory'),(36,'Can delete quiz history',12,'delete_quizhistory');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$12000$TobaK3gRS0oZ$ZOmw12oHt/JWcpvlIZAJWEmwPp9AMfOGOQM4pBjg8Xo=','2014-04-10 15:08:26',1,'vivek.s@global-analytics.com','','','vivek.s@global-analytics.com',1,1,'2014-04-04 20:07:22'),(3,'pbkdf2_sha256$12000$beiG3IWl9tdA$z6BzmYj6T9JS8HVNgGfZliyvfTSyrE7eIoxZTQLFHz8=','2014-04-08 13:33:37',0,'test3@global-analytics.com','test','test','test3@global-analytics.com',0,1,'2014-04-08 13:33:37'),(4,'pbkdf2_sha256$12000$3nO2ErLyeYmN$pwrr4ahBed3+gp894wnNM1sP0NVPipx//ZJtmaU6y/0=','2014-04-08 17:39:50',0,'test2@global-analytics.com','test','test','test2@global-analytics.com',0,1,'2014-04-08 17:39:50'),(5,'pbkdf2_sha256$12000$Dahmph6DBUy2$PwoYfspGZkPb+tobB9vnwdEzHfQbkaOPorMQ4gvmzQc=','2014-04-08 17:42:05',0,'vivekhas3@gmail.com','test','test','vivekhas3@gmail.com',0,1,'2014-04-08 17:42:05');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
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
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'log entry','admin','logentry'),(2,'permission','auth','permission'),(3,'group','auth','group'),(4,'user','auth','user'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'questions','pyquiz','questions'),(8,'choices','pyquiz','choices'),(10,'leader board','pyquiz','leaderboard'),(11,'user details','pyquiz','userdetails'),(12,'quiz history','pyquiz','quizhistory');
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
INSERT INTO `django_session` VALUES ('8b86hc8dwk1fmp4h33yoo6wtajpsg0px','MDBhZGYzOGQ5MTM4NzhhMjY5NDRiNWU1NmIzOWMzYzgzZDQwMzYxMzp7fQ==','2014-04-22 12:37:24'),('l9tiwx6a00ji6itkfelpvofiybv9lxet','MjI1YjEyOTgzYTI1YTVhZWNlZDk3NzBkYzE4MTJlMmRiMGY1ZGY0YTp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9pZCI6MX0=','2014-04-24 15:08:26');
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
INSERT INTO `pyquiz_choices` VALUES (1,1,'True','False',NULL,NULL,'True'),(2,2,'x=2,y=2','x=1,y=1','x=2,y=1','x=1,y=2','x=2,y=1');
/*!40000 ALTER TABLE `pyquiz_choices` ENABLE KEYS */;
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
  CONSTRAINT `user_id_id_refs_id_9b5894a2` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_leaderboard`
--

LOCK TABLES `pyquiz_leaderboard` WRITE;
/*!40000 ALTER TABLE `pyquiz_leaderboard` DISABLE KEYS */;
INSERT INTO `pyquiz_leaderboard` VALUES (1,1,1,60,'2014-04-10 16:56:08');
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
INSERT INTO `pyquiz_questions` VALUES (1,'Is python object oriented?',1),(2,'What is the value of x,y?<code>x=1\ny=x\nx=2</code>',1);
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
  CONSTRAINT `user_id_id_refs_id_2ce4b87c` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_quizhistory`
--

LOCK TABLES `pyquiz_quizhistory` WRITE;
/*!40000 ALTER TABLE `pyquiz_quizhistory` DISABLE KEYS */;
INSERT INTO `pyquiz_quizhistory` VALUES (2,1,1);
/*!40000 ALTER TABLE `pyquiz_quizhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pyquiz_userdetails`
--

DROP TABLE IF EXISTS `pyquiz_userdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pyquiz_userdetails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id_id` int(11) NOT NULL,
  `role` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pyquiz_userdetails_1ffdedc6` (`user_id_id`),
  CONSTRAINT `user_id_id_refs_id_db8027de` FOREIGN KEY (`user_id_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pyquiz_userdetails`
--

LOCK TABLES `pyquiz_userdetails` WRITE;
/*!40000 ALTER TABLE `pyquiz_userdetails` DISABLE KEYS */;
INSERT INTO `pyquiz_userdetails` VALUES (1,1,'Sr. Web Developer'),(2,3,'Team Lead'),(3,4,'Team Lead'),(4,5,'Team Lead');
/*!40000 ALTER TABLE `pyquiz_userdetails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-04-10 19:02:21
