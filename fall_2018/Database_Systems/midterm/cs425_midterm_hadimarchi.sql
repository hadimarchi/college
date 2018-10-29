-- MySQL dump 10.13  Distrib 5.7.24, for Linux (x86_64)
--
-- Host: localhost    Database: BB DB
-- ------------------------------------------------------
-- Server version	5.7.24-0ubuntu0.18.04.1

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
-- Current Database: `BB DB`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `BB DB` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `BB DB`;

--
-- Table structure for table `ADDRESS`
--

DROP TABLE IF EXISTS `ADDRESS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ADDRESS` (
  `PERSON_id` int(11) NOT NULL,
  `type` set('Mailing','Physical') NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `zip` int(11) NOT NULL,
  `state` set('Alabama','Alaska','Arizona','Arkansa','California','Colorado','Deleware','Florida','Georgia','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusets','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota','Tennesse','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming') NOT NULL,
  PRIMARY KEY (`PERSON_id`,`type`,`street`,`city`,`zip`,`state`),
  CONSTRAINT `fk_ADDRESS_PERSON` FOREIGN KEY (`PERSON_id`) REFERENCES `PERSON` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ADDRESS`
--

LOCK TABLES `ADDRESS` WRITE;
/*!40000 ALTER TABLE `ADDRESS` DISABLE KEYS */;
/*!40000 ALTER TABLE `ADDRESS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `COACH`
--

DROP TABLE IF EXISTS `COACH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COACH` (
  `EMPLOYEE_id` int(11) NOT NULL,
  `team` varchar(45) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_id`,`team`),
  KEY `fk_COACH_TEAM_idx` (`team`),
  CONSTRAINT `fk_COACH_EMPLOYEE` FOREIGN KEY (`EMPLOYEE_id`) REFERENCES `EMPLOYEE` (`PERSON_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COACH_TEAM` FOREIGN KEY (`team`) REFERENCES `TEAM` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COACH`
--

LOCK TABLES `COACH` WRITE;
/*!40000 ALTER TABLE `COACH` DISABLE KEYS */;
/*!40000 ALTER TABLE `COACH` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPLOYEE`
--

DROP TABLE IF EXISTS `EMPLOYEE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EMPLOYEE` (
  `PERSON_id` int(11) NOT NULL,
  `salary` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`PERSON_id`),
  CONSTRAINT `fk_EMPLOYEE_PERSON` FOREIGN KEY (`PERSON_id`) REFERENCES `PERSON` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPLOYEE`
--

LOCK TABLES `EMPLOYEE` WRITE;
/*!40000 ALTER TABLE `EMPLOYEE` DISABLE KEYS */;
/*!40000 ALTER TABLE `EMPLOYEE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FAN`
--

DROP TABLE IF EXISTS `FAN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FAN` (
  `PERSON_id` int(11) NOT NULL AUTO_INCREMENT,
  `favorite_player` int(11) DEFAULT NULL,
  `favorite_team` varchar(45) NOT NULL,
  PRIMARY KEY (`PERSON_id`),
  KEY `fk_FAN_PLAYER_idx` (`favorite_player`),
  KEY `fk_FAN_TEAM_idx` (`favorite_team`),
  CONSTRAINT `fk_FAN_PERSON` FOREIGN KEY (`PERSON_id`) REFERENCES `PERSON` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FAN_PLAYER` FOREIGN KEY (`favorite_player`) REFERENCES `PLAYER` (`EMPLOYEE_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FAN_TEAM` FOREIGN KEY (`favorite_team`) REFERENCES `TEAM` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FAN`
--

LOCK TABLES `FAN` WRITE;
/*!40000 ALTER TABLE `FAN` DISABLE KEYS */;
/*!40000 ALTER TABLE `FAN` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GAME`
--

DROP TABLE IF EXISTS `GAME`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GAME` (
  `date_time` datetime NOT NULL,
  `home_team` varchar(45) NOT NULL,
  `home_team_score` int(11) NOT NULL DEFAULT '0',
  `visiting_team` varchar(45) NOT NULL,
  `visiting_team_score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`date_time`,`home_team`,`visiting_team`),
  KEY `fk_VISITING_TEAM_idx` (`visiting_team`),
  KEY `fk_HOME_TEAM_idx` (`home_team`),
  CONSTRAINT `fk_HOME_TEAM` FOREIGN KEY (`home_team`) REFERENCES `TEAM` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_VISITING_TEAM` FOREIGN KEY (`visiting_team`) REFERENCES `TEAM` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GAME`
--

LOCK TABLES `GAME` WRITE;
/*!40000 ALTER TABLE `GAME` DISABLE KEYS */;
/*!40000 ALTER TABLE `GAME` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OFFICIAL`
--

DROP TABLE IF EXISTS `OFFICIAL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OFFICIAL` (
  `EMPLOYEE_id` int(11) NOT NULL,
  `type` set('Referee','Scorekeeper','Timekeeper') NOT NULL,
  `GAME_date_time` datetime NOT NULL,
  `GAME_home_team` varchar(45) NOT NULL,
  `GAME_visiting_team` varchar(45) NOT NULL,
  PRIMARY KEY (`EMPLOYEE_id`,`GAME_date_time`,`GAME_home_team`,`GAME_visiting_team`),
  KEY `fk_OFFICIAL_GAME_idx` (`GAME_date_time`,`GAME_home_team`,`GAME_visiting_team`),
  CONSTRAINT `fk_OFFICIAL_EMPLOYEE` FOREIGN KEY (`EMPLOYEE_id`) REFERENCES `EMPLOYEE` (`PERSON_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_OFFICIAL_GAME` FOREIGN KEY (`GAME_date_time`, `GAME_home_team`, `GAME_visiting_team`) REFERENCES `GAME` (`date_time`, `home_team`, `visiting_team`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OFFICIAL`
--

LOCK TABLES `OFFICIAL` WRITE;
/*!40000 ALTER TABLE `OFFICIAL` DISABLE KEYS */;
/*!40000 ALTER TABLE `OFFICIAL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PERSON`
--

DROP TABLE IF EXISTS `PERSON`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PERSON` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `middle_initial` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PERSON`
--

LOCK TABLES `PERSON` WRITE;
/*!40000 ALTER TABLE `PERSON` DISABLE KEYS */;
/*!40000 ALTER TABLE `PERSON` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PLAYER`
--

DROP TABLE IF EXISTS `PLAYER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PLAYER` (
  `EMPLOYEE_id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `team` varchar(45) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`EMPLOYEE_id`,`number`,`team`,`start_date`),
  KEY `fk_PLAYER_TEAM_idx` (`team`),
  CONSTRAINT `fk_PLAYER_EMPLOYEE` FOREIGN KEY (`EMPLOYEE_id`) REFERENCES `EMPLOYEE` (`PERSON_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PLAYER_TEAM` FOREIGN KEY (`team`) REFERENCES `TEAM` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYER`
--

LOCK TABLES `PLAYER` WRITE;
/*!40000 ALTER TABLE `PLAYER` DISABLE KEYS */;
/*!40000 ALTER TABLE `PLAYER` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hal`@`localhost`*/ /*!50003 TRIGGER `BB DB`.`PLAYER_BEFORE_INSERT` BEFORE INSERT ON `PLAYER` FOR EACH ROW
BEGIN
 
 DECLARE is_coach INT;
 DECLARE is_official INT;
 SELECT COUNT(1) INTO is_coach from COACH where (NEW.EMPLOYEE_id = COACH.EMPLOYEE_id);
 if is_coach=1 then 
	SIGNAL SQLSTATE '45000'
    SET message_text = "Player exists in COACH table";
 end if;
 SELECT COUNT(1) INTO is_official from OFFICIAL where (NEW.EMPLOYEE_id = OFFICIAL.EMPLOYEE_id);
 if is_official=1 then
	SIGNAL SQLSTATE '45000'
    SET message_text = "Player exists in OFFICIAL table";
 end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PLAYER_STATS`
--

DROP TABLE IF EXISTS `PLAYER_STATS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PLAYER_STATS` (
  `PLAYER_id` int(11) NOT NULL,
  `assists` int(11) NOT NULL DEFAULT '0',
  `rebounds` int(11) NOT NULL DEFAULT '0',
  `points` int(11) NOT NULL DEFAULT '0',
  `fouls` int(11) NOT NULL DEFAULT '0',
  `GAME_date_time` datetime NOT NULL,
  `GAME_home_team` varchar(45) NOT NULL,
  `GAME_visiting_team` varchar(45) NOT NULL,
  PRIMARY KEY (`PLAYER_id`,`GAME_date_time`,`GAME_home_team`,`GAME_visiting_team`),
  KEY `fk_PLAYER_STATS_GAME_idx` (`GAME_date_time`,`GAME_home_team`,`GAME_visiting_team`),
  CONSTRAINT `fk_PLAYER_PLAYER_STATS` FOREIGN KEY (`PLAYER_id`) REFERENCES `PLAYER` (`EMPLOYEE_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PLAYER_STATS_GAME` FOREIGN KEY (`GAME_date_time`, `GAME_home_team`, `GAME_visiting_team`) REFERENCES `GAME` (`date_time`, `home_team`, `visiting_team`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PLAYER_STATS`
--

LOCK TABLES `PLAYER_STATS` WRITE;
/*!40000 ALTER TABLE `PLAYER_STATS` DISABLE KEYS */;
/*!40000 ALTER TABLE `PLAYER_STATS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TEAM`
--

DROP TABLE IF EXISTS `TEAM`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TEAM` (
  `name` varchar(45) NOT NULL,
  `PLAYER_captain_id` int(11) NOT NULL,
  `city` varchar(45) DEFAULT NULL,
  `color` varchar(45) NOT NULL,
  `state` set('Alabama','Alaska','Arizona','Arkansa','California','Colorado','Deleware','Florida','Georgia','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusets','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota','Tennesse','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming') NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  KEY `fk_TEAM_CAPTAIN_idx` (`PLAYER_captain_id`),
  CONSTRAINT `fk_TEAM_CAPTAIN` FOREIGN KEY (`PLAYER_captain_id`) REFERENCES `PLAYER` (`EMPLOYEE_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TEAM`
--

LOCK TABLES `TEAM` WRITE;
/*!40000 ALTER TABLE `TEAM` DISABLE KEYS */;
/*!40000 ALTER TABLE `TEAM` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `view_coaches`
--

DROP TABLE IF EXISTS `view_coaches`;
/*!50001 DROP VIEW IF EXISTS `view_coaches`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_coaches` AS SELECT 
 1 AS `id`,
 1 AS `first_name`,
 1 AS `MI`,
 1 AS `last_name`,
 1 AS `address_type`,
 1 AS `street`,
 1 AS `city`,
 1 AS `state`,
 1 AS `zip`,
 1 AS `salary`,
 1 AS `team`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_current_players_coaches`
--

DROP TABLE IF EXISTS `view_current_players_coaches`;
/*!50001 DROP VIEW IF EXISTS `view_current_players_coaches`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_current_players_coaches` AS SELECT 
 1 AS `id`,
 1 AS `first_name`,
 1 AS `MI`,
 1 AS `last_name`,
 1 AS `address_type`,
 1 AS `street`,
 1 AS `city`,
 1 AS `state`,
 1 AS `zip`,
 1 AS `salary`,
 1 AS `team`,
 1 AS `position`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `view_player`
--

DROP TABLE IF EXISTS `view_player`;
/*!50001 DROP VIEW IF EXISTS `view_player`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_player` AS SELECT 
 1 AS `id`,
 1 AS `first_name`,
 1 AS `MI`,
 1 AS `last_name`,
 1 AS `salary`,
 1 AS `team`,
 1 AS `number`,
 1 AS `start_date`,
 1 AS `end_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `BB DB`
--

USE `BB DB`;

--
-- Final view structure for view `view_coaches`
--

/*!50001 DROP VIEW IF EXISTS `view_coaches`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`hal`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_coaches` AS select `COACH`.`EMPLOYEE_id` AS `id`,`PERSON`.`first_name` AS `first_name`,`PERSON`.`middle_initial` AS `MI`,`PERSON`.`last_name` AS `last_name`,`ADDRESS`.`type` AS `address_type`,`ADDRESS`.`street` AS `street`,`ADDRESS`.`city` AS `city`,`ADDRESS`.`state` AS `state`,`ADDRESS`.`zip` AS `zip`,`EMPLOYEE`.`salary` AS `salary`,`COACH`.`team` AS `team` from (((`COACH` join `EMPLOYEE` on((`COACH`.`EMPLOYEE_id` = `EMPLOYEE`.`PERSON_id`))) join `PERSON` on((`COACH`.`EMPLOYEE_id` = `PERSON`.`id`))) join `ADDRESS` on((`COACH`.`EMPLOYEE_id` = `ADDRESS`.`PERSON_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_current_players_coaches`
--

/*!50001 DROP VIEW IF EXISTS `view_current_players_coaches`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`hal`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_current_players_coaches` AS select `PLAYER`.`EMPLOYEE_id` AS `id`,`PERSON`.`first_name` AS `first_name`,`PERSON`.`middle_initial` AS `MI`,`PERSON`.`last_name` AS `last_name`,`ADDRESS`.`type` AS `address_type`,`ADDRESS`.`street` AS `street`,`ADDRESS`.`city` AS `city`,`ADDRESS`.`state` AS `state`,`ADDRESS`.`zip` AS `zip`,`EMPLOYEE`.`salary` AS `salary`,`PLAYER`.`team` AS `team`,'Player' AS `position` from (((`PLAYER` join `EMPLOYEE` on((`PLAYER`.`EMPLOYEE_id` = `EMPLOYEE`.`PERSON_id`))) join `PERSON` on((`PLAYER`.`EMPLOYEE_id` = `PERSON`.`id`))) join `ADDRESS` on((`PLAYER`.`EMPLOYEE_id` = `ADDRESS`.`PERSON_id`))) where isnull(`PLAYER`.`end_date`) union select `COACH`.`EMPLOYEE_id` AS `id`,`PERSON`.`first_name` AS `first_name`,`PERSON`.`middle_initial` AS `MI`,`PERSON`.`last_name` AS `last_name`,`ADDRESS`.`type` AS `address_type`,`ADDRESS`.`street` AS `street`,`ADDRESS`.`city` AS `city`,`ADDRESS`.`state` AS `state`,`ADDRESS`.`zip` AS `zip`,`EMPLOYEE`.`salary` AS `salary`,`COACH`.`team` AS `team`,'Coach' AS `position` from (((`COACH` join `EMPLOYEE` on((`COACH`.`EMPLOYEE_id` = `EMPLOYEE`.`PERSON_id`))) join `PERSON` on((`COACH`.`EMPLOYEE_id` = `PERSON`.`id`))) join `ADDRESS` on((`COACH`.`EMPLOYEE_id` = `ADDRESS`.`PERSON_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_player`
--

/*!50001 DROP VIEW IF EXISTS `view_player`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`hal`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_player` AS select `PLAYER`.`EMPLOYEE_id` AS `id`,`PERSON`.`first_name` AS `first_name`,`PERSON`.`middle_initial` AS `MI`,`PERSON`.`last_name` AS `last_name`,`EMPLOYEE`.`salary` AS `salary`,`PLAYER`.`team` AS `team`,`PLAYER`.`number` AS `number`,`PLAYER`.`start_date` AS `start_date`,`PLAYER`.`end_date` AS `end_date` from ((`PLAYER` join `EMPLOYEE` on((`PLAYER`.`EMPLOYEE_id` = `EMPLOYEE`.`PERSON_id`))) join `PERSON` on((`PLAYER`.`EMPLOYEE_id` = `PERSON`.`id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-26 20:28:19
