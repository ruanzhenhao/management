-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: wyx-missions-management
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message` (
  `id` int NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `content` char(100) NOT NULL COMMENT '通知标题',
  `title` char(20) NOT NULL COMMENT '通知内容',
  `type` int NOT NULL COMMENT '是否需要按钮 1.为通知 2.为需要按钮',
  `team_id` int DEFAULT NULL,
  `create_user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,'2024-10-28 18:46:32','项目报告下周到期。','提醒',1,0,1),(2,'2024-10-28 18:46:32','团队会议定于明天。','会议通知',1,0,1),(3,'2025-01-08 00:00:00','admin要请你加入团队','邀请加入团队',2,1,1),(4,'2025-01-08 00:00:00','admin要请你加入团队','邀请加入团队',2,1,1),(5,'2025-01-08 00:00:00','admin要请你加入团队','邀请加入团队',2,1,1),(6,'2025-01-08 00:00:00','admin要请你加入团队','邀请加入团队',2,1,1),(7,'2025-01-08 00:00:00','admin要请你加入团队','邀请加入团队',2,1,1),(8,'2025-01-08 00:00:00','admin要请你加入团队','邀请加入团队',2,1,1);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message_user`
--

DROP TABLE IF EXISTS `message_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL COMMENT '接收者id',
  `message_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='信息与用户连接表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message_user`
--

LOCK TABLES `message_user` WRITE;
/*!40000 ALTER TABLE `message_user` DISABLE KEYS */;
INSERT INTO `message_user` VALUES (1,1,1),(2,16,1),(3,20,1),(4,21,2),(5,20,8);
/*!40000 ALTER TABLE `message_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mission_file_url`
--

DROP TABLE IF EXISTS `mission_file_url`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mission_file_url` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_user_id` int NOT NULL,
  `file_name` char(250) NOT NULL,
  `file_url` char(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mission_file_url`
--

LOCK TABLES `mission_file_url` WRITE;
/*!40000 ALTER TABLE `mission_file_url` DISABLE KEYS */;
INSERT INTO `mission_file_url` VALUES (10,1,'484e15dd-a59a-4f42-a578-a2a24b3963ec.txt','uploads/484e15dd-a59a-4f42-a578-a2a24b3963ec.txt');
/*!40000 ALTER TABLE `mission_file_url` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `task`
--

DROP TABLE IF EXISTS `task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_name` char(50) NOT NULL COMMENT '任务名',
  `demand` char(200) NOT NULL COMMENT '要求',
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `team_id` int NOT NULL COMMENT '发布活动的团队id',
  `update_id` int NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `create_user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='任务表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `task`
--

LOCK TABLES `task` WRITE;
/*!40000 ALTER TABLE `task` DISABLE KEYS */;
INSERT INTO `task` VALUES (1,'10.22任务','java课程1至10集','2024-10-28 19:30:03','2024-10-28 19:30:11',1,1,'2024-11-28 19:30:22','2025-10-28 19:30:25',16),(2,'任务 1','完成代码审查','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-04 19:33:08',16),(3,'任务 2','编写项目文档','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2025-11-07 19:33:08',1),(4,'任务 3','进行单元测试','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-02 19:33:08',16),(5,'任务 4','修复已知bug','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-10-31 19:33:08',16),(6,'任务 5','设计前端界面','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-11 19:33:08',16),(7,'任务 6','实现后端API','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-09 19:33:08',16),(8,'任务 7','准备项目发布','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-05 19:33:08',16),(9,'任务 8','进行代码合并','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-03 19:33:08',16),(10,'任务 9','进行性能测试','2024-10-28 19:33:08','2024-10-28 19:33:08',1,1,'2024-10-28 19:33:08','2024-11-06 19:33:08',16),(11,'任务 10','更新依赖库','2024-10-28 19:33:08','2024-10-28 19:33:08',5,1,'2024-10-28 19:33:08','2025-11-08 19:33:08',16),(34,'java 1-20','看完','2025-01-06 14:43:43','2025-01-06 14:43:43',1,1,'2025-01-22 16:00:00','2025-02-12 16:00:00',1),(35,'java 1-20','看完','2025-01-06 14:47:15','2025-01-06 14:47:15',1,1,'2025-01-22 16:00:00','2025-02-12 16:00:00',1);
/*!40000 ALTER TABLE `task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_name` char(20) NOT NULL,
  `create_Id` int NOT NULL,
  `update_Id` int NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `introduction` char(200) DEFAULT NULL COMMENT '团队简介',
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_pk` (`team_name`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'阮老师太太太有实力了',1,1,'2024-10-28 18:37:18','2024-10-28 18:37:18','好好学习天天向上\n'),(2,'团队B',2,2,'2024-10-28 18:37:18','2024-10-28 18:37:18','这是团队B的简介。'),(5,'2024级后端课程',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00',NULL),(17,'461695161',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','451541481859148596'),(18,'4616951618748',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','451541481859148596'),(19,'94891818',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','1289948184187'),(20,'阮振豪真牛逼',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','5415154'),(21,'阮振豪真牛逼111',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','5415154undefined'),(22,'阮666',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','256161651'),(23,'451541581',1,1,'2024-11-10 00:00:00','2024-11-10 00:00:00','asdfasf98a4fgaw 微积分不能考虑WJFDE JNL啊我飞u今晚发你计划位'),(24,'升降器',1,1,'2024-11-11 00:00:00','2024-11-11 00:00:00','5454548'),(25,'123213432',1,1,'2024-11-19 00:00:00','2024-11-19 00:00:00','阿斯蒂芬撒放哪里打撒'),(26,'测试信息',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','1111'),(27,'册数165146',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','42345646'),(28,'421534',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','44648'),(29,'大哥发的',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','16126'),(30,'阿斯顿发山东',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','5215641'),(31,'565465',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','3516'),(32,'劳动模范腊味饭',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','21646'),(34,'劳动模范腊味饭.3',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','21646'),(36,'91949',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','5126+2'),(38,'919499',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','5126+2'),(39,'919499216129',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','5126+2'),(40,'阿富汗比你快啦u额问你大佛批发文',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','5126+2'),(42,'13331666666666666',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','5126+2'),(43,'3236526546854',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(46,'32365265468546',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(48,'323652654685465',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(49,'5446954864196849684',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(50,'444984894',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(52,'4449848945',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(53,'4449848945阿第三方',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(54,'4449848945阿第三',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(55,'4449848945阿第',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(56,'4449848945阿第9',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(60,'4449848945阿第987',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(61,'4449848945阿第989',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(62,'6126416856',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(63,'三等奖佛山店',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(64,'大赛粉红色',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(65,'地方GV奥迪',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(66,'5626954',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬'),(67,'想法啊不能减肥噶手抓饼',1,1,'2025-01-08 00:00:00','2025-01-08 00:00:00','阿斯顿发斯蒂芬');
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_invitationcode`
--

DROP TABLE IF EXISTS `team_invitationcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_invitationcode` (
  `id` int NOT NULL AUTO_INCREMENT,
  `team_id` int NOT NULL,
  `invitation_code` mediumtext NOT NULL,
  `validity_time` date NOT NULL COMMENT '最晚有效期',
  `create_time` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_invitationcode`
--

LOCK TABLES `team_invitationcode` WRITE;
/*!40000 ALTER TABLE `team_invitationcode` DISABLE KEYS */;
INSERT INTO `team_invitationcode` VALUES (1,9,'1731223108255','2024-11-28','2024-11-10'),(2,16,'1731223217771','2024-11-28','2024-11-10'),(3,17,'1731223263815','2024-11-21','2024-11-10'),(4,18,'1731223293254','2024-11-21','2024-11-10'),(5,19,'1731223407824','2024-11-28','2024-11-10'),(6,20,'1731223505030','2024-11-12','2024-11-10'),(7,21,'1731223524039','2024-11-12','2024-11-10'),(8,22,'1731223544879','2024-11-20','2024-11-10'),(9,23,'1731223585241','2024-11-15','2024-11-10'),(10,24,'1731327206889','2024-11-19','2024-11-11'),(11,25,'1731997092409','2024-11-28','2024-11-19'),(12,1,'1732762473178','2024-12-28','2024-11-28'),(13,21,'1732768406427','2024-12-28','2024-11-28'),(14,26,'1736319307206','2025-01-31','2025-01-08'),(15,27,'1736319432755','2025-01-31','2025-01-08'),(16,28,'1736319510400','2025-01-23','2025-01-08'),(17,29,'1736319727911','2025-01-25','2025-01-08'),(18,30,'1736319771849','2025-01-24','2025-01-08'),(19,31,'1736319970450','2025-01-24','2025-01-08'),(20,32,'1736320052581','2025-01-23','2025-01-08'),(21,34,'1736320255276','2025-01-23','2025-01-08'),(22,36,'1736320298501','2025-01-30','2025-01-08'),(23,67,'1736322145988','2025-01-18','2025-01-08');
/*!40000 ALTER TABLE `team_invitationcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_user`
--

DROP TABLE IF EXISTS `team_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `team_id` int NOT NULL,
  `role` int DEFAULT NULL COMMENT '暂定3个身份 1组长 2管理员 3组员 创建者默认为组长',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='连接团队表和用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_user`
--

LOCK TABLES `team_user` WRITE;
/*!40000 ALTER TABLE `team_user` DISABLE KEYS */;
INSERT INTO `team_user` VALUES (1,1,1,3),(2,16,1,2),(3,20,1,1),(4,21,1,1),(5,16,2,3),(7,16,5,3),(11,1,17,3),(12,1,18,3),(13,1,19,3),(14,1,20,3),(15,1,21,3),(16,1,22,3),(17,1,23,3),(18,1,24,3),(19,1,25,3),(21,1,2,2),(23,21,3,1),(24,21,2,2),(26,20,2,2),(29,16,21,1),(30,1,5,1),(31,1,26,3),(32,1,27,3),(33,1,28,3),(34,1,29,3),(35,1,30,3),(36,1,31,3),(37,1,32,3),(38,1,34,3),(39,1,36,3),(40,1,67,3);
/*!40000 ALTER TABLE `team_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `username` char(10) DEFAULT NULL COMMENT '用户名',
  `sex` char(2) DEFAULT '男',
  `password` char(20) DEFAULT '123456',
  `phone` char(20) DEFAULT NULL,
  `id_number` char(18) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL,
  `name` char(10) DEFAULT NULL COMMENT '网名',
  `img` char(30) DEFAULT 'assets/headshot/type2.jpg',
  `address` char(50) DEFAULT NULL,
  `email` char(20) DEFAULT NULL,
  `hobby` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_pk` (`phone`),
  UNIQUE KEY `user_pk_2` (`phone`),
  UNIQUE KEY `user_pk_3` (`id_number`),
  UNIQUE KEY `user_pk_4` (`username`),
  UNIQUE KEY `user_pk_5` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','男','123456789','15257484671','330205200412071813','2024-10-16 11:23:54','2024-10-31 17:46:21','伍子胥','assets/headshot/type1.jpg','浙江省宁波市江北区庄桥街道童家村','2234029046@QQ.com','敲代码'),(16,'吴彪爱炉管','男','123456','13812345678',NULL,'2024-10-21 21:13:33','2024-10-21 21:13:33','吴彪','assets/headshot/type2.jpg',NULL,NULL,NULL),(20,'用户1','男','123456','1234567890','110101199001011234','2024-10-28 18:41:14','2024-10-28 18:41:14','用户一','assets/headshot/type11.jpg','地址1','user1@example.com','爱好1'),(21,'用户2','女','123456','1234567891','110101199002022345','2024-10-28 18:41:14','2024-10-28 18:41:14','用户二','assets/headshot/type8.jpg','地址2','user2@example.com','爱好2');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_task`
--

DROP TABLE IF EXISTS `user_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_task` (
  `id` int NOT NULL AUTO_INCREMENT,
  `task_id` int NOT NULL,
  `status` int NOT NULL COMMENT '1 未完成 2已完成 3进行中 4待审核',
  `update_id` int NOT NULL,
  `update_time` datetime NOT NULL,
  `text` char(250) DEFAULT NULL,
  `completed_time` datetime DEFAULT NULL COMMENT '完成時間',
  `team_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_task`
--

LOCK TABLES `user_task` WRITE;
/*!40000 ALTER TABLE `user_task` DISABLE KEYS */;
INSERT INTO `user_task` VALUES (1,1,2,1,'2024-12-12 11:28:45','南无阿设计风格哦啊世界','2024-12-26 20:35:20',1,1),(2,2,1,1,'2024-10-28 19:52:45',NULL,NULL,1,1),(3,3,1,1,'2024-10-28 19:52:45',NULL,'2024-11-13 16:53:35',1,16),(4,4,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(5,5,3,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(6,6,1,1,'2024-10-28 19:52:45',NULL,NULL,1,1),(7,7,2,1,'2024-10-28 19:52:45',NULL,'2024-11-12 16:53:45',1,1),(8,8,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(9,9,2,1,'2024-10-28 19:52:45',NULL,'2024-12-26 20:34:46',1,21),(10,10,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(11,11,1,1,'2024-10-28 19:52:45',NULL,NULL,1,1),(12,1,2,1,'2024-10-28 19:52:45',NULL,'2024-10-26 16:54:31',1,21),(13,2,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(14,3,2,1,'2024-10-28 19:52:45',NULL,'2024-10-26 16:54:37',1,20),(15,4,1,1,'2024-10-28 19:52:45',NULL,NULL,1,21),(16,5,3,1,'2024-10-28 19:52:45',NULL,NULL,1,21),(17,6,1,1,'2024-10-28 19:52:45',NULL,NULL,1,16),(18,7,2,1,'2024-10-28 19:52:45',NULL,'2024-10-30 16:54:39',1,20),(19,8,1,1,'2024-10-28 19:52:45',NULL,NULL,1,21),(20,9,1,1,'2024-10-28 19:52:45',NULL,'2024-12-26 20:35:17',1,1),(21,10,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(22,11,1,1,'2024-10-28 19:52:45',NULL,NULL,1,21),(23,1,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(24,2,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(25,3,2,1,'2024-10-28 19:52:45',NULL,'2024-10-30 16:54:41',1,20),(26,4,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(27,5,3,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(28,6,1,1,'2024-10-28 19:52:45',NULL,NULL,1,21),(29,7,2,1,'2024-10-28 19:52:45',NULL,'2024-10-26 16:54:42',1,20),(30,8,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(31,9,2,1,'2024-10-28 19:52:45',NULL,'2024-12-26 20:35:17',1,20),(32,10,1,1,'2024-10-28 19:52:45',NULL,NULL,1,1),(33,11,1,1,'2024-10-28 19:52:45',NULL,NULL,1,20),(34,1,2,16,'2024-10-28 15:13:24',NULL,'2024-11-13 15:13:31',1,20),(103,35,1,1,'2025-01-06 14:47:15',NULL,NULL,1,16),(104,35,1,1,'2025-01-06 14:47:15',NULL,NULL,1,20),(105,35,1,1,'2025-01-06 14:47:15',NULL,NULL,1,21);
/*!40000 ALTER TABLE `user_task` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-26 12:23:51
