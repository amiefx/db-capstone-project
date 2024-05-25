-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8;
-- -----------------------------------------------------
-- Schema little_lemons2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemons2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `LittleLemonDB`;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `ItemID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Type` VARCHAR(45) NULL,
  `Price` VARCHAR(45) NULL,
  PRIMARY KEY (`ItemID`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `MenuID` INT NOT NULL,
  `ItemID` INT NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `fk_Menu_MenuItems1_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `fk_Menu_MenuItems`
    FOREIGN KEY (`ItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`ItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `CustomerID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Contact` VARCHAR(32) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employee` (
  `EmployeeID` INT NOT NULL,
  `Name` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(32) NOT NULL,
  `Salary` INT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL,
  `TableNO` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_Bookings_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_Bookings_Employee1_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Bookings_Customer`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bookings_Employee`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Order` (
  `OrderID` INT NOT NULL,
  `TableNO` INT NOT NULL,
  `MenuID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  `Quantity` INT NULL,
  `BillAmount` DOUBLE NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Order_Bookings_idx` (`BookingID` ASC) VISIBLE,
  INDEX `fk_Order_Menu1_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Bookings`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_Menu`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`DeliveryStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`DeliveryStatus` (
  `DeliveryID` INT NOT NULL,
  `OrderID` INT NOT NULL,
  `DeliveryDate` TIMESTAMP NOT NULL,
  `DeliveryStatus` TINYINT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `fk_DeliveryStatus_Order1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_DeliveryStatus_Order1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Order` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
