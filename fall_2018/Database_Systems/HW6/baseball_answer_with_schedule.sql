
CREATE DATABASE /*!32312 IF NOT EXISTS*/ `baseball_answer_with_schedule` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `baseball_answer_with_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COACH` (
  `Personnel_id` int(11) NOT NULL,
  `Team_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Personnel_id`),
  KEY `fk_Coach_Team1_idx` (`Team_name`),
  CONSTRAINT `COACH_ibfk_1` FOREIGN KEY (`Personnel_id`) REFERENCES `PERSONNEL` (`id`),
  CONSTRAINT `fk_Coach_Team1_idx` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DIVISION` (
  `name` varchar(45) NOT NULL,
  `League_name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `fk_DIVISION_League1_idx` (`League_name`),
  CONSTRAINT `fk_DIVISION_League1_idx` FOREIGN KEY (`League_name`) REFERENCES `LEAGUE` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GAME` (
  `Schedule_date` datetime NOT NULL,
  `Home_Team_name` varchar(45) NOT NULL,
  `Visitor_Team_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Schedule_date`,`Home_Team_name`,`Visitor_Team_name`),
  KEY `fk_Game_Home1_idx` (`Home_Team_name`),
  KEY `fk_Game_Visitor1_idx` (`Visitor_Team_name`),
  CONSTRAINT `fk_Game_Home1_idx` FOREIGN KEY (`Home_Team_name`) REFERENCES `HOME` (`Team_name`),
  CONSTRAINT `fk_Game_Visitor1_idx` FOREIGN KEY (`Visitor_Team_name`) REFERENCES `VISITOR` (`Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Game_Pitcher` (
  `Pitcher_Player_Personnel_id` int(11) NOT NULL,
  `Record_type` varchar(15) NOT NULL,
  `Game_Schedule_date` datetime NOT NULL,
  `Game_Home_Team_name` varchar(45) NOT NULL,
  `Game_Visitor_Team_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Pitcher_Player_Personnel_id`,`Game_Schedule_date`,`Game_Home_Team_name`,`Game_Visitor_Team_name`),
  KEY `fk_Game_Pitcher_GAME1_idx` (`Game_Schedule_date`,`Game_Home_Team_name`,`Game_Visitor_Team_name`),
  KEY `Record_type` (`Record_type`),
  CONSTRAINT `Game_Pitcher_ibfk_1` FOREIGN KEY (`Record_type`) REFERENCES `Record` (`type`),
  CONSTRAINT `fk_Game_Pitcher_GAME1_idx` FOREIGN KEY (`Game_Schedule_date`, `Game_Home_Team_name`, `Game_Visitor_Team_name`) REFERENCES `GAME` (`Schedule_date`, `Home_Team_name`, `Visitor_Team_name`),
  CONSTRAINT `fk_Game_Pitcher_Record1_idx` FOREIGN KEY (`Pitcher_Player_Personnel_id`) REFERENCES `PITCHER` (`Player_Personnel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Game_Umpire` (
  `Umpire_Personnel_id` int(11) NOT NULL,
  `Game_Schedule_date` datetime NOT NULL,
  `Game_Home_Team_name` varchar(45) NOT NULL,
  `Game_Visitor_Team_name` varchar(45) NOT NULL,
  PRIMARY KEY (`Umpire_Personnel_id`,`Game_Schedule_date`,`Game_Home_Team_name`,`Game_Visitor_Team_name`),
  KEY `fk_Game_Umpire_Game1_idx` (`Game_Schedule_date`,`Game_Home_Team_name`,`Game_Visitor_Team_name`),
  CONSTRAINT `fk_Game_Umpire_Game1_idx` FOREIGN KEY (`Game_Schedule_date`, `Game_Home_Team_name`, `Game_Visitor_Team_name`) REFERENCES `GAME` (`Schedule_date`, `Home_Team_name`, `Visitor_Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HOME` (
  `Schedule_date` datetime NOT NULL,
  `Team_name` varchar(45) NOT NULL,
  `runs` int(11) NOT NULL DEFAULT '0',
  `hits` int(11) NOT NULL DEFAULT '0',
  `errors` int(11) NOT NULL DEFAULT '0',
  `Pitcher_Player_Personnel_id` int(11) NOT NULL,
  PRIMARY KEY (`Schedule_date`,`Team_name`),
  KEY `fk_Home_Pitcher1_idx` (`Pitcher_Player_Personnel_id`),
  KEY `Team_name` (`Team_name`),
  CONSTRAINT `HOME_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`name`),
  CONSTRAINT `fk_Home_Pitcher1_idx` FOREIGN KEY (`Pitcher_Player_Personnel_id`) REFERENCES `PITCHER` (`Player_Personnel_id`),
  CONSTRAINT `fk_Home_Schedule1_idx` FOREIGN KEY (`Schedule_date`) REFERENCES `SCHEDULE` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LEAGUE` (
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orientation` (
  `type` varchar(10) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PERSONNEL` (
  `id` int(11) NOT NULL,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `birth_date` date NOT NULL,
  `birth_place` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PITCHER` (
  `Player_Personnel_id` int(11) NOT NULL,
  `ERA` double NOT NULL DEFAULT '0',
  PRIMARY KEY (`Player_Personnel_id`),
  CONSTRAINT `PITCHER_ibfk_1` FOREIGN KEY (`Player_Personnel_id`) REFERENCES `PLAYER` (`Personnel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PLAYER` (
  `Personnel_id` int(11) NOT NULL,
  `batting_average` double NOT NULL,
  `Team_name` varchar(45) NOT NULL DEFAULT 'Free agent',
  `Orientation_type` varchar(10) NOT NULL,
  PRIMARY KEY (`Personnel_id`),
  KEY `fk_Player_Team1_idx` (`Team_name`),
  KEY `fk_Player_Orientation1_idx` (`Orientation_type`),
  CONSTRAINT `PLAYER_ibfk_1` FOREIGN KEY (`Personnel_id`) REFERENCES `PERSONNEL` (`id`),
  CONSTRAINT `fk_Player_Orientation1_idx` FOREIGN KEY (`Orientation_type`) REFERENCES `Orientation` (`type`),
  CONSTRAINT `fk_Player_Team1_idx` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Player_Score` (
  `Player_Personnel_id` int(11) NOT NULL,
  `single` int(11) DEFAULT '0',
  `triple` int(11) DEFAULT '0',
  `home_run` int(11) DEFAULT '0',
  `Game_Schedule_date` datetime NOT NULL,
  `Game_Home_Team_name` varchar(45) NOT NULL,
  `Game_Visitor_Team_name` varchar(45) NOT NULL,
  `ddouble` int(11) DEFAULT '0',
  PRIMARY KEY (`Player_Personnel_id`,`Game_Schedule_date`,`Game_Home_Team_name`,`Game_Visitor_Team_name`),
  KEY `fk_Game_Statistis_Game1_idx` (`Game_Schedule_date`,`Game_Home_Team_name`,`Game_Visitor_Team_name`),
  CONSTRAINT `Player_Score_ibfk_1` FOREIGN KEY (`Player_Personnel_id`) REFERENCES `PLAYER` (`Personnel_id`),
  CONSTRAINT `fk_Game_Statistis_Game1_idx` FOREIGN KEY (`Game_Schedule_date`, `Game_Home_Team_name`, `Game_Visitor_Team_name`) REFERENCES `GAME` (`Schedule_date`, `Home_Team_name`, `Visitor_Team_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Record` (
  `type` varchar(15) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCHEDULE` (
  `date` datetime NOT NULL,
  PRIMARY KEY (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TEAM` (
  `name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `manager` int(11) NOT NULL,
  `Division_name` varchar(45) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `manager` (`manager`),
  KEY `fk_Team_Division1_idx` (`Division_name`),
  CONSTRAINT `fk_Team_Division1_idx` FOREIGN KEY (`Division_name`) REFERENCES `DIVISION` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UMPIRE` (
  `Personnel_id` int(11) NOT NULL,
  PRIMARY KEY (`Personnel_id`),
  CONSTRAINT `UMPIRE_ibfk_1` FOREIGN KEY (`Personnel_id`) REFERENCES `PERSONNEL` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VISITOR` (
  `Schedule_date` datetime NOT NULL,
  `Team_name` varchar(45) NOT NULL,
  `runs` int(11) NOT NULL,
  `hits` int(11) NOT NULL,
  `errors` int(11) NOT NULL,
  `Pitcher_Player_Personnel_id` int(11) NOT NULL,
  PRIMARY KEY (`Schedule_date`,`Team_name`),
  KEY `fk_Visitor_Pitcher1_idx` (`Pitcher_Player_Personnel_id`),
  KEY `Team_name` (`Team_name`),
  CONSTRAINT `VISITOR_ibfk_1` FOREIGN KEY (`Team_name`) REFERENCES `TEAM` (`name`),
  CONSTRAINT `fk_Visitor_Pitcher1_idx` FOREIGN KEY (`Pitcher_Player_Personnel_id`) REFERENCES `PITCHER` (`Player_Personnel_id`),
  CONSTRAINT `fk_Visitor_Schedule1_idx` FOREIGN KEY (`Schedule_date`) REFERENCES `SCHEDULE` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
