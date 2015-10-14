SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `fanta_formazione` DEFAULT CHARACTER SET latin1 ;
USE `fanta_formazione` ;

-- -----------------------------------------------------
-- Table `fanta_formazione`.`squadre`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`squadre` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `nome` VARCHAR(45) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`giocatori`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`giocatori` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_squadra` INT NOT NULL ,
  `nome` VARCHAR(45) NOT NULL ,
  `ruolo` VARCHAR(1) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC, `nome` ASC) ,
  INDEX `FK_squadra_id` (`id_squadra` ASC) ,
  CONSTRAINT `FK_squadra_id`
    FOREIGN KEY (`id_squadra` )
    REFERENCES `fanta_formazione`.`squadre` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`giornate`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`giornate` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `data` DATE NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`utenti`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`utenti` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `mail` VARCHAR(200) NOT NULL ,
  `data_registrazione` DATE NULL DEFAULT NULL ,
  `data_ultimo_accesso` DATE NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`utenti_formazioni`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`utenti_formazioni` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `id_utente` INT NOT NULL ,
  `nome_formazione` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `FK_uf_id_utente` (`id_utente` ASC) ,
  CONSTRAINT `FK_uf_id_utente`
    FOREIGN KEY (`id_utente` )
    REFERENCES `fanta_formazione`.`utenti` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`formazioni`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`formazioni` (
  `id_giocatore` INT NOT NULL ,
  `id_utenti_formazioni` INT NOT NULL ,
  INDEX `FK_f_fg_id_giocatore` (`id_giocatore` ASC) ,
  INDEX `FK_f_fg_id_utenti_formazioni` (`id_utenti_formazioni` ASC) ,
  CONSTRAINT `FK_f_fg_id_giocatore`
    FOREIGN KEY (`id_giocatore` )
    REFERENCES `fanta_formazione`.`giocatori` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_f_fg_id_utenti_formazioni`
    FOREIGN KEY (`id_utenti_formazioni` )
    REFERENCES `fanta_formazione`.`utenti_formazioni` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`probabili_formazioni_fg`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`probabili_formazioni_fg` (
  `id_giocatore` INT NOT NULL ,
  `id_giornata` INT NOT NULL ,
  `titolare` TINYINT(1) NULL DEFAULT NULL ,
  `panchina` TINYINT(1) NULL DEFAULT NULL ,
  INDEX `FK_pf_fg_id_giocatore` (`id_giocatore` ASC) ,
  INDEX `FK_pf_fg_id_giornata` (`id_giornata` ASC) ,
  CONSTRAINT `FK_pf_fg_id_giocatore`
    FOREIGN KEY (`id_giocatore` )
    REFERENCES `fanta_formazione`.`giocatori` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_pf_fg_id_giornata`
    FOREIGN KEY (`id_giornata` )
    REFERENCES `fanta_formazione`.`giornate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`probabili_formazioni_gazzetta`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`probabili_formazioni_gazzetta` (
  `id_giocatore` INT NOT NULL ,
  `id_giornata` INT NOT NULL ,
  `titolare` TINYINT(1) NULL DEFAULT NULL ,
  `panchina` TINYINT(1) NULL DEFAULT NULL ,
  INDEX `FK_id_giocatore` (`id_giocatore` ASC) ,
  INDEX `FK_pf_g_id_giornata` (`id_giornata` ASC) ,
  CONSTRAINT `FK_pf_g_id_giocatore0`
    FOREIGN KEY (`id_giocatore` )
    REFERENCES `fanta_formazione`.`giocatori` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_pf_g_id_giornata`
    FOREIGN KEY (`id_giornata` )
    REFERENCES `fanta_formazione`.`giornate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`statistiche`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`statistiche` (
  `id_giocatore` INT NOT NULL ,
  `id_giornata` INT NOT NULL DEFAULT 1 ,
  `media_voto` DECIMAL(4,2) NOT NULL DEFAULT 0 ,
  `media_voto_fm` DECIMAL(4,2) NOT NULL DEFAULT 0 ,
  `goal_fatti` INT NOT NULL DEFAULT 0 ,
  `goal_rigore` INT NOT NULL DEFAULT 0 ,
  `goal_subiti` INT NOT NULL DEFAULT 0 ,
  `rigori_parati` INT NOT NULL DEFAULT 0 ,
  `rigori_sbagliati` INT NOT NULL DEFAULT 0 ,
  `autoreti` INT NOT NULL DEFAULT 0 ,
  `assist` INT NOT NULL DEFAULT 0 ,
  `ammonizioni` INT NOT NULL DEFAULT 0 ,
  `espulsioni` INT NOT NULL DEFAULT 0 ,
  INDEX `FK_stat_id_giocatore` (`id_giocatore` ASC) ,
  INDEX `FK_stat_id_giornata` (`id_giornata` ASC) ,
  CONSTRAINT `FK_stat_id_giocatore`
    FOREIGN KEY (`id_giocatore` )
    REFERENCES `fanta_formazione`.`giocatori` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_stat_id_giornata`
    FOREIGN KEY (`id_giornata` )
    REFERENCES `fanta_formazione`.`giornate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`calendario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`calendario` (
  `id_giornata` INT NOT NULL ,
  `id_squadra_casa` INT NOT NULL ,
  `id_squadra_fuori_casa` INT NOT NULL ,
  INDEX `FK_cal_id_giornata` (`id_giornata` ASC) ,
  INDEX `FK_cal_id_sq_casa` (`id_squadra_casa` ASC) ,
  INDEX `FK_cal_id_sq_fuori` (`id_squadra_fuori_casa` ASC) ,
  CONSTRAINT `FK_cal_id_giornata`
    FOREIGN KEY (`id_giornata` )
    REFERENCES `fanta_formazione`.`giornate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_cal_id_sq_casa`
    FOREIGN KEY (`id_squadra_casa` )
    REFERENCES `fanta_formazione`.`squadre` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_cal_id_sq_fuori`
    FOREIGN KEY (`id_squadra_fuori_casa` )
    REFERENCES `fanta_formazione`.`squadre` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fanta_formazione`.`probabili_formazioni`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `fanta_formazione`.`probabili_formazioni` (
  `id_giornate` INT NOT NULL ,
  `id_utenti_formazioni` INT NOT NULL ,
  `id_giocatore` INT NOT NULL ,
  `prob_titolare` INT NOT NULL ,
  `prob_panchina` INT NOT NULL ,
  `note` VARCHAR(100) NULL ,
  INDEX `FK_f_fg_giornate` (`id_giornate` ASC) ,
  INDEX `FK_f_fg_utenti_formazioni` (`id_utenti_formazioni` ASC) ,
  INDEX `FK_f_fg_giocatori` (`id_giocatore` ASC) ,
  CONSTRAINT `FK_f_fg_giornate`
    FOREIGN KEY (`id_giornate` )
    REFERENCES `fanta_formazione`.`giornate` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_f_fg_utenti_formazioni`
    FOREIGN KEY (`id_utenti_formazioni` )
    REFERENCES `fanta_formazione`.`utenti_formazioni` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_f_fg_giocatori`
    FOREIGN KEY (`id_giocatore` )
    REFERENCES `fanta_formazione`.`giocatori` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;