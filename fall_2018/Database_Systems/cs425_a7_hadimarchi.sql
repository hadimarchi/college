-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Congress
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Congress
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Congress` DEFAULT CHARACTER SET utf8 ;
USE `Congress` ;

-- -----------------------------------------------------
-- Table `Congress`.`REGION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`REGION` ;

CREATE TABLE IF NOT EXISTS `Congress`.`REGION` (
  `RName` SET('Northeast', 'Midwest', 'Northwest', 'Southwest', 'Southeast') NOT NULL,
  PRIMARY KEY (`RName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Congress`.`STATE`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`STATE` ;

CREATE TABLE IF NOT EXISTS `Congress`.`STATE` (
  `SName` SET('Alabama', 'Alaska', 'Arizona', 'Arkansa', 'California', 'Colorado', 'Deleware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusets', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennesse', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington','West Virginia', 'Wisconsin', 'Wyoming') NOT NULL,
  `RName` SET('Northeast', 'Midwest', 'Northwest', 'Southwest', 'Southeast') NOT NULL,
  PRIMARY KEY (`SName`, `RName`),
  INDEX `fk_STATE_REGION1_idx` (`RName` ASC),
  CONSTRAINT `fk_STATE_REGION_idx`
    FOREIGN KEY (`RName`)
    REFERENCES `Congress`.`REGION` (`RName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Congress`.`DISTRICT`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`DISTRICT` ;

CREATE TABLE IF NOT EXISTS `Congress`.`DISTRICT` (
  `DName` VARCHAR(45) NOT NULL,
  `SName` SET('Alabama', 'Alaska', 'Arizona', 'Arkansa', 'California', 'Colorado', 'Deleware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusets', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennesse', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington','West Virginia', 'Wisconsin', 'Wyoming') NOT NULL,
  PRIMARY KEY (`DName`, `SName`),
  INDEX `fk_DISTRICT_STATE_idx` (`SName` ASC),
  CONSTRAINT `fk_DISTRICT_STATE_idx`
    FOREIGN KEY (`SName`)
    REFERENCES `Congress`.`STATE` (`SName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'e';


-- -----------------------------------------------------
-- Table `Congress`.`CONGRESSPERSON`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`CONGRESSPERSON` ;

CREATE TABLE IF NOT EXISTS `Congress`.`CONGRESSPERSON` (
  `CName` VARCHAR(45) NOT NULL,
  `Party` SET('Republican', 'Democrat', 'Independent', 'Other') NOT NULL,
  `ElectedDate` DATE NOT NULL,
  `DName` VARCHAR(45) NOT NULL,
  `SName` SET('Alabama', 'Alaska', 'Arizona', 'Arkansa', 'California', 'Colorado', 'Deleware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusets', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennesse', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington','West Virginia', 'Wisconsin', 'Wyoming') NOT NULL,
  PRIMARY KEY (`CName`, `Party`, `ElectedDate`, `DName`, `SName`),
  INDEX `fk_CONGRESSPERSON_DISTRICT_idx` (`DName` ASC, `SName` ASC),
  CONSTRAINT `fk_CONGRESSPERSON_DISTRICT_idx`
    FOREIGN KEY (`DName` , `SName`)
    REFERENCES `Congress`.`DISTRICT` (`DName` , `SName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Congress`.`BILL`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`BILL` ;

CREATE TABLE IF NOT EXISTS `Congress`.`BILL` (
  `BillName` VARCHAR(256) NOT NULL,
  `DateOfVote` DATE NOT NULL,
  `Passed` SET('Yes', 'No') NOT NULL,
  PRIMARY KEY (`BillName`, `DateOfVote`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Congress`.`Voted`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`Voted` ;

CREATE TABLE IF NOT EXISTS `Congress`.`Voted` (
  `BillName` VARCHAR(256) NOT NULL,
  `DateOfVote` DATE NOT NULL,
  `CName` VARCHAR(45) NOT NULL,
  `Vote` SET('Yes', 'No', 'Abstain', 'Absent') NOT NULL,
  `Party` SET('Republican', 'Democrat', 'Independent', 'Other') NOT NULL,
  `ElectedDate` DATE NOT NULL,
  `DName` VARCHAR(45) NOT NULL,
  `SName` SET('Alabama', 'Alaska', 'Arizona', 'Arkansa', 'California', 'Colorado', 'Deleware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusets', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennesse', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington','West Virginia', 'Wisconsin', 'Wyoming') NOT NULL,
  PRIMARY KEY (`BillName`, `DateOfVote`, `CName`, `Party`, `ElectedDate`, `DName`, `SName`),
  INDEX `fk_CONGRESSPERSON_Voted_idx` (`CName` ASC, `Party` ASC, `ElectedDate` ASC, `DName` ASC, `SName` ASC),
  INDEX `fk_Voted_BILL_idx` (`BillName` ASC, `DateOfVote` ASC),
  CONSTRAINT `fk_Voted_BILL`
    FOREIGN KEY (`BillName` , `DateOfVote`)
    REFERENCES `Congress`.`BILL` (`BillName` , `DateOfVote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONGRESSPERSON_Voted`
    FOREIGN KEY (`CName` , `ElectedDate` , `DName` , `Party` , `SName`)
    REFERENCES `Congress`.`CONGRESSPERSON` (`CName` , `ElectedDate` , `DName` , `Party` , `SName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `Congress`.`Sponsered`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Congress`.`Sponsered` ;

CREATE TABLE IF NOT EXISTS `Congress`.`Sponsered` (
  `BillName` VARCHAR(256) NOT NULL,
  `DateOfVote` DATE NOT NULL,
  `CName` VARCHAR(45) NOT NULL,
  `Party` SET('Republican', 'Democrat', 'Independent', 'Other') NOT NULL,
  `ElectedDate` DATE NOT NULL,
  `DName` VARCHAR(45) NOT NULL,
  `SName` SET('Alabama', 'Alaska', 'Arizona', 'Arkansa', 'California', 'Colorado', 'Deleware', 'Florida', 'Georgia', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 'Maryland', 'Massachusets', 'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada', 'New Hampshire', 'New Jersey', 'New Mexico', 'New York', 'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon', 'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota', 'Tennesse', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington','West Virginia', 'Wisconsin', 'Wyoming') NOT NULL,
  PRIMARY KEY (`BillName`, `DateOfVote`, `CName`, `Party`, `ElectedDate`, `DName`, `SName`),
  INDEX `fk_CONGRESSPERSON_Sponsored_idx` (`CName` ASC, `Party` ASC, `ElectedDate` ASC, `DName` ASC, `SName` ASC),
  INDEX `fk_Sponsored_BILL_idx` (`BillName` ASC, `DateOfVote` ASC),
  CONSTRAINT `fk_Sponsored_BILL`
    FOREIGN KEY (`BillName` , `DateOfVote`)
    REFERENCES `Congress`.`BILL` (`BillName` , `DateOfVote`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONGRESSPERSON_Sponsered`
    FOREIGN KEY (`CName` , `ElectedDate` , `DName` , `Party` , `SName`)
    REFERENCES `Congress`.`CONGRESSPERSON` (`CName` , `ElectedDate` , `DName` , `Party` , `SName`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
