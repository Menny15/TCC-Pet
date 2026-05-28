-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema buscapet
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema buscapet
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `buscapet` DEFAULT CHARACTER SET utf8 ;
USE `buscapet` ;

-- -----------------------------------------------------
-- Table `buscapet`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buscapet`.`usuario` (
  `idUsuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(20) NULL,
  `dataCadastro` DATE NOT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `buscapet`.`localizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buscapet`.`localizacao` (
  `idLocalizacao` INT NOT NULL AUTO_INCREMENT,
  `cidade` VARCHAR(64) NOT NULL,
  `estado` VARCHAR(32) NOT NULL,
  `bairro` VARCHAR(45) NULL,
  `cep` VARCHAR(8) NULL,
  `complemento` VARCHAR(100) NULL,
  `numero` VARCHAR(10) NOT NULL,
  `logradouro` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idLocalizacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `buscapet`.`pet`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buscapet`.`pet` (
  `idPet` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `raca` VARCHAR(50) NULL,
  `sexo` VARCHAR(2) NOT NULL,
  `descricao` TEXT NOT NULL,
  `idLocalizacao` INT NOT NULL,
  PRIMARY KEY (`idPet`),
  INDEX `fk_Pet_Localizacao1_idx` (`idLocalizacao` ASC),
  CONSTRAINT `fk_Pet_Localizacao1`
    FOREIGN KEY (`idLocalizacao`)
    REFERENCES `buscapet`.`localizacao` (`idLocalizacao`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `buscapet`.`anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buscapet`.`anuncio` (
  `idAnuncio` INT NOT NULL AUTO_INCREMENT,
  `status_pet` INT NOT NULL,
  `idPet` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`idAnuncio`),
  INDEX `fk_Anuncio_Pet1_idx` (`idPet` ASC),
  INDEX `fk_Anuncio_Usuario1_idx` (`idUsuario` ASC),
  UNIQUE INDEX `idPet_UNIQUE` (`idPet` ASC) VISIBLE,
  CONSTRAINT `fk_Anuncio_Pet1`
    FOREIGN KEY (`idPet`)
    REFERENCES `buscapet`.`pet` (`idPet`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Anuncio_Usuario1`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `buscapet`.`usuario` (`idUsuario`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `buscapet`.`foto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `buscapet`.`foto` (
  `idFoto` INT NOT NULL AUTO_INCREMENT,
  `urlFoto` VARCHAR(255) NULL,
  `idPet` INT NOT NULL,
  PRIMARY KEY (`idFoto`),
  INDEX `fk_Foto_Pet1_idx` (`idPet` ASC),
  CONSTRAINT `fk_Foto_Pet1`
    FOREIGN KEY (`idPet`)
    REFERENCES `buscapet`.`pet` (`idPet`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;