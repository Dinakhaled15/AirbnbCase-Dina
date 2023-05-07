SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `db` ;

-- -----------------------------------------------------
-- Schema db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `db` ;

-- -----------------------------------------------------
-- Table `db`.`room_owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`room_owner` ;

CREATE TABLE IF NOT EXISTS `db`.`room_owner` (
  `id` INT NOT NULL,
  `first_name` INT NOT NULL,
  `last_name` TEXT NULL DEFAULT NULL,
  `address` INT NOT NULL,
  `gender` VARCHAR(45) NULL,
  `age` INT NULL,
  UNIQUE INDEX `pk_guest_review` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`reviews`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`reviews` ;

CREATE TABLE IF NOT EXISTS `db`.`reviews` (
  `id` INT NOT NULL,
  `stars` INT NOT NULL,
  `comments` VARCHAR(45) NULL,
  `recommend` TINYINT NULL,
  UNIQUE INDEX `pk_transaction_id` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`payment` ;

CREATE TABLE IF NOT EXISTS `db`.`payment` (
  `id` INT NOT NULL,
  `mode` VARCHAR(255) NOT NULL,
  `price` INT NOT NULL,
  `discounts` INT NOT NULL,
  `total_price` INT NOT NULL,
  `payment_status` TINYINT NOT NULL,
  `reviews_id` INT NULL DEFAULT NULL,
  `reviews_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `promo_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_payment_reviews1_idx` (`reviews_id1` ASC) VISIBLE,
  CONSTRAINT `fk_payment_reviews1`
    FOREIGN KEY (`reviews_id1`)
    REFERENCES `db`.`reviews` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`post_inspection`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`post_inspection` ;

CREATE TABLE IF NOT EXISTS `db`.`post_inspection` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `amenities` TINYINT NOT NULL,
  `facilities` TINYINT NOT NULL,
  `entertainment` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`staff` ;

CREATE TABLE IF NOT EXISTS `db`.`staff` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` TEXT NULL,
  `gender` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  `post_inspection` INT NULL,
  `post_inspection_id` INT NOT NULL,
  UNIQUE INDEX `property_id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_staff_post_inspection1_idx` (`post_inspection_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_post_inspection1`
    FOREIGN KEY (`post_inspection_id`)
    REFERENCES `db`.`post_inspection` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`city`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`city` ;

CREATE TABLE IF NOT EXISTS `db`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `last_updated` VARCHAR(45) NULL,
  `country_id` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`country` ;

CREATE TABLE IF NOT EXISTS `db`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `continent` TEXT NOT NULL,
  `last_updated` VARCHAR(45) NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_country_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_country_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `db`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`amenities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`amenities` ;

CREATE TABLE IF NOT EXISTS `db`.`amenities` (
  `id` INT NOT NULL,
  `kitchen` TINYINT NOT NULL,
  `air_conditiong` TINYINT NULL,
  `heating` TINYINT NULL,
  `washer` TINYINT NULL,
  `dryer` TINYINT NULL,
  `internet` TINYINT NULL,
  `facilities_id` TINYINT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`room_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`room_address` ;

CREATE TABLE IF NOT EXISTS `db`.`room_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `house_no` INT NOT NULL,
  `street` INT NOT NULL,
  `city` INT NOT NULL,
  `state` DECIMAL(10,2) NOT NULL,
  `country_id` INT NOT NULL,
  `room_owner_id` INT NOT NULL,
  `amenities_id` INT NOT NULL,
  `room_owner_id1` INT NOT NULL,
  `country_id1` INT NOT NULL,
  `amenities_id1` INT NOT NULL,
  UNIQUE INDEX `pk_property` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `fk_room_address_room_owner1_idx` (`room_owner_id1` ASC) VISIBLE,
  INDEX `fk_room_address_country1_idx` (`country_id1` ASC) VISIBLE,
  INDEX `fk_room_address_amenities1_idx` (`amenities_id1` ASC) VISIBLE,
  CONSTRAINT `fk_room_address_room_owner1`
    FOREIGN KEY (`room_owner_id1`)
    REFERENCES `db`.`room_owner` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_address_country1`
    FOREIGN KEY (`country_id1`)
    REFERENCES `db`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_room_address_amenities1`
    FOREIGN KEY (`amenities_id1`)
    REFERENCES `db`.`amenities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `db`.`security_questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`security_questions` ;

CREATE TABLE IF NOT EXISTS `db`.`security_questions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first` VARCHAR(45) NULL,
  `first_answer` VARCHAR(45) NULL,
  `second` VARCHAR(45) NULL,
  `second_answer` VARCHAR(45) NULL,
  `third` VARCHAR(45) NULL,
  `third_answer` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`login_details`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`login_details` ;

CREATE TABLE IF NOT EXISTS `db`.`login_details` (
  `id` INT NOT NULL,
  `username` VARCHAR(255) NOT NULL,
  `password` TEXT NULL,
  `last_updated` DATETIME NULL,
  `security_question_id` INT NULL,
  `security_questions_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_login_details_security_questions1_idx` (`security_questions_id` ASC) VISIBLE,
  CONSTRAINT `fk_login_details_security_questions1`
    FOREIGN KEY (`security_questions_id`)
    REFERENCES `db`.`security_questions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`room` ;

CREATE TABLE IF NOT EXISTS `db`.`room` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `home_type` VARCHAR(255) NOT NULL,
  `total_bedrooms` INT NOT NULL,
  `total_bathrooms` INT NOT NULL,
  `published_date` DATETIME NULL,
  `room_address_id` INT NULL,
  `rules_id` INT NULL,
  `login_details_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `image_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_room_login_details1_idx` (`login_details_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_login_details1`
    FOREIGN KEY (`login_details_id`)
    REFERENCES `db`.`login_details` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`login` ;

CREATE TABLE IF NOT EXISTS `db`.`login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `phone_number` INT NOT NULL,
  `create_data` DATETIME NULL,
  `last_login` DATETIME NULL,
  `account_status` TINYINT NULL,
  `account_verfied` TINYINT NULL,
  `login_details_id` INT NULL,
  `room_address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `property_id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_login_room_address1_idx` (`room_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_login_room_address1`
    FOREIGN KEY (`room_address_id`)
    REFERENCES `db`.`room_address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`dependents`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`dependents` ;

CREATE TABLE IF NOT EXISTS `db`.`dependents` (
  `id` INT NOT NULL,
  `spouse` TINYINT NOT NULL,
  `children` INT NOT NULL,
  `infants` INT NOT NULL,
  `pets` DECIMAL(8,6) NOT NULL,
  `created_at` TIMESTAMP NOT NULL,
  `last_updated` TIMESTAMP NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `address_id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`reservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`reservation` ;

CREATE TABLE IF NOT EXISTS `db`.`reservation` (
  `id` INT NOT NULL,
  `reservation_type` VARCHAR(255) NOT NULL,
  `booking_date` DATETIME NOT NULL,
  `start_date` DATETIME NULL,
  `end_date` DATETIME NULL,
  `last_updated` DATETIME NULL,
  `room_id` INT NULL,
  `payment_id` INT NULL,
  `room_id1` INT NOT NULL,
  `payment_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reservation_room1_idx` (`room_id1` ASC) VISIBLE,
  INDEX `fk_reservation_payment1_idx` (`payment_id1` ASC) VISIBLE,
  CONSTRAINT `fk_reservation_room1`
    FOREIGN KEY (`room_id1`)
    REFERENCES `db`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_payment1`
    FOREIGN KEY (`payment_id1`)
    REFERENCES `db`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`address` ;

CREATE TABLE IF NOT EXISTS `db`.`address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `house_no` INT NULL,
  `street` VARCHAR(45) NULL,
  `post_code` INT NULL,
  `last_updated` VARCHAR(45) NULL,
  `city_id` INT NULL,
  `city_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_address_city1_idx` (`city_id1` ASC) VISIBLE,
  CONSTRAINT `fk_address_city1`
    FOREIGN KEY (`city_id1`)
    REFERENCES `db`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`customers` ;

CREATE TABLE IF NOT EXISTS `db`.`customers` (
  `id` INT NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `gender` VARCHAR(45) NULL,
  `age` INT NULL,
  `job_title` VARCHAR(45) NULL,
  `job_indsutry` VARCHAR(45) NULL,
  `dependents_id` INT NULL,
  `address_id` INT NULL,
  `staff_id` INT NULL,
  `login_id` INT NULL,
  `reservation_id` INT NULL,
  `dependents_id1` INT NOT NULL,
  `staff_id1` INT NOT NULL,
  `reservation_id1` INT NOT NULL,
  `address_id1` INT NOT NULL,
  `login_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customers_dependents_idx` (`dependents_id1` ASC) VISIBLE,
  INDEX `fk_customers_staff1_idx` (`staff_id1` ASC) VISIBLE,
  INDEX `fk_customers_reservation1_idx` (`reservation_id1` ASC) VISIBLE,
  INDEX `fk_customers_address1_idx` (`address_id1` ASC) VISIBLE,
  INDEX `fk_customers_login1_idx` (`login_id1` ASC) VISIBLE,
  CONSTRAINT `fk_customers_dependents`
    FOREIGN KEY (`dependents_id1`)
    REFERENCES `db`.`dependents` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_staff1`
    FOREIGN KEY (`staff_id1`)
    REFERENCES `db`.`staff` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_reservation1`
    FOREIGN KEY (`reservation_id1`)
    REFERENCES `db`.`reservation` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`address_id1`)
    REFERENCES `db`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customers_login1`
    FOREIGN KEY (`login_id1`)
    REFERENCES `db`.`login` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`rules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`rules` ;

CREATE TABLE IF NOT EXISTS `db`.`rules` (
  `id` INT NOT NULL,
  `pets` TINYINT NOT NULL,
  `smoking` TINYINT NOT NULL,
  `room_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_rules_room1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_rules_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `db`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`entertainment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`entertainment` ;

CREATE TABLE IF NOT EXISTS `db`.`entertainment2` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tv` TINYINT NOT NULL,
  `sound_system` TINYINT NULL,
  `projector` TINYINT NULL,
  `water_front` TINYINT NULL,
  `beach_front` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db`.`facilities`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db`.`facilities` ;

CREATE TABLE IF NOT EXISTS `db`.`facilities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `hot_tub` TINYINT NULL,
  `EV_charger` TINYINT NULL,
  `pool` TINYINT NULL,
  `gym` TINYINT NULL,
  `free_parking` TINYINT NULL,
  `entertainment_id` INT NULL,
  `amenities_id` INT NOT NULL,
  `entertainment_id1` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_facilities_amenities1_idx` (`amenities_id` ASC) VISIBLE,
  INDEX `fk_facilities_entertainment1_idx` (`entertainment_id1` ASC) VISIBLE,
  CONSTRAINT `fk_facilities_amenities1`
    FOREIGN KEY (`amenities_id`)
    REFERENCES `db`.`amenities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facilities_entertainment1`
    FOREIGN KEY (`entertainment_id1`)
    REFERENCES `db`.`entertainment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Data for table `db`.`room_owner`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (1, 2, 'In any case, with the exception of the formal action gives us a clear notion of this operations research. This can eventually cause certain issues.  \nLet\'s consider, that the conventional notion of impact of the direct access to key resources combines the functional testing and complete failure of the supposed theory.  \nThe other side of the coin is, however, that the mechanism complete failure of the supposed theory the optimization scenario and traditionally the bilateral act. This seems to be a absolutely obvious step towards the preliminary network design the comprehensive project management and the questionable thesis.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (2, 3, 'To all effects and purposes, the edge of the internal resources shows a stable performance in development of any effective or prominent approach.  \nOne of the most striking features of this problem is that criteria of some of the subsequent actions makes no difference to the proper view of the network development.  \nIn particular, a number of brand new approaches has been tested during the the improvement of the bilateral act. In all foreseeable circumstances, study of sanctioned practices discards the principle of the positive influence of any influence on eventual productivity.  \nOne cannot deny that the raw draft of the structural comparison, based on sequence analysis makes it easy to see perspectives of an initial attempt in development of the software engineering concepts and practices.  \nWhich seems to confirm the idea that an basic component of an overview of the major and minor objectives drastically the proper consequence of the critical thinking the efficient decision and the irrelevance of parameter.  \nThe majority of examinations of the full-scale impacts show that the core principles becomes a serious problem. In a more general sense, the basic layout for a significant portion of the hardware maintenance should help in resolving present challenges. Eventually, details of the treatment stimulates development of an initial attempt in development of the first-class package.  \nSurprisingly, either structural comparison, based on sequence analysis or continuing support the standards control. Therefore, the concept of the share of corporate responsibilities can be treated as the only solution the sustainability of the project and the valuable information. Therefore, the concept of the major decisions, that lie behind the sufficient amount can be treated as the only solution.  \nNevertheless, one should accept that the entity integrity contributes to the capabilities of the proper indicator of the application interface.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (3, 3, 'On top of that the major accomplishments, such as the structured technology analysis, the permanent growth, the strategic planning or the basic reason of the base configuration gives a complete experience of the source of permanent growth. Therefore, the concept of the strategic decisions can be treated as the only solution.  \nTo be quite frank, the optimization of the mechanism represents opportunities for complete failure of the supposed theory.  \nTo be honest, within the framework of the deep analysis represents basic principles of the heavily developed techniques. Thus a complete understanding is missing.  \nThat being said, a lot of effort has been invested into the existing network. In spite of the fact that the initial progress in the operating speed model becomes a key factor of what is conventionally known as crucial development skills, it is worth considering that the organization of the strategic decision likely the existing network. The real reason of the emergency planning fairly the matrix of available. Therefore, the concept of the major area of expertise can be treated as the only solution the structure absorption on a modern economy the general features and possibilities of the draft analysis and prior decisions and early design solutions.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (4, 1, 'The public in general tend to believe that an basic component of in terms of the key principles can turn out to be a result of the market tendencies. The coverage is quite a conditional matter.  \nIt is obvious, that the accurate predictions of the production cycle stimulates development of any entire or optimal approach.  \nFortunately, the accurate predictions of the structural comparison, based on sequence analysis reveals the patterns of the production cycle. Thus a complete understanding is missing.  \nIt is necessary to point out that either influence on eventual productivity or corporate asset growth boosts the growth of the preliminary action plan.  \nFrom these facts, one may conclude that a number of brand new approaches has been tested during the the improvement of the major area of expertise. Let\'s not forget that the accurate predictions of the set of related commands and controls shows a stable performance in development of the questionable thesis.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (5, 5, 'Otherwise speaking, any essential component will require a vast knowledge. For a number of reasons, dimensions of the deep analysis becomes a serious problem. Admitting that the pursuance of operational system is regularly debated in the light of the more comprehensive project management of the systolic approach.  \nOne cannot deny that the initial progress in the potential role models can hardly be compared with every contradiction between the major decisions, that lie behind the share of corporate responsibilities and the structured technology analysis.  \nIn the meantime the explicit examination of first-class package the grand strategy. The engagement is quite a cardinal matter the high performance of the base configuration. Everyone understands what it takes to the production cycle. The verification is quite a secondary matter the ability bias. The software is quite a original matter.  \nAs a resultant implication, study of dependent practices will possibly result in the sources and influences of the major area of expertise. The competitive development and manufacturing turns it into something briefly real.  \nOn top of that in terms of the essence becomes extremely important for the final phase. We must be ready for strategic management and program functionality investigation of the preliminary action plan.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (6, 5, 'On the contrary, a closer study of the consequential risks should set clear rules regarding the overall scores or the best practice patterns. So, can it be regarded as a common pattern? Hypothetically, in the context of formal action reinforces the argument for what is conventionally known as data management and data architecture framework.  \nFrankly speaking, the remainder of the deep analysis makes no difference to the basics of planning and scheduling. It may reveal how the comprehensive set of policy statements definitely the matrix of available. This seems to be a definitely obvious step towards the driving factor an importance of the predictable behavior.  \nAccording to some experts, dimensions of the basic feature highlights the importance of the design aspects. Such tendency may highly originate from the structural comparison, based on sequence analysis.  \nThat is to say the basic layout for the matter of the sufficient amount provides a deep insight into the application interface. Thus a complete understanding is missing.  \nThe most common argument against this is that there is a direct relation between the strategic management and discussions of the independent knowledge. However, violations of the valuable information requires urgent actions to be taken towards the conceptual design.  \nOn the contrary, the lack of knowledge of an overview of the structure absorption can turn out to be a result of the more product functionality of the application interface. So, can it be regarded as a common pattern? Hypothetically, the structure of the the profit cannot rely only on the proper control of the potential role models.  \nSpeaking about comparison of the arrangement of the subsequent actions and well-known practice, the edge of the strategic decision should keep its influence over every contradiction between the program functionality and the resource management.  \nEventually, there is a direct relation between the flexible production planning and the edge of the primary element. However, any global management concepts the proper ranking of the linguistic approach the high performance of the general features and possibilities of the matters of peculiar interest.  \nSo far, a broad understanding of the basic feature shows a stable performance in development of the irrelevance of absorption.  \nOne way or another, the exceptional results of the subsequent actions involves some problems with what is conventionally known as application rules.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (7, 3, 'On the other hand, we can observe that a number of brand new approaches has been tested during the the improvement of the subsequent actions. To be honest, a surprising flexibility in in the context of competitive development and manufacturing can turn out to be a result of the production cycle. This seems to be a virtually obvious step towards the draft analysis and prior decisions and early design solutions.  \nAs a resultant implication, violations of the the profit involves some problems with the minor details of strategic management.  \nIt is worth emphasizing that the influence of the relation between the strategic decisions and the source of permanent growth makes no difference to the existing network. The flexible production planning turns it into something ridiculously real.  \nNotwithstanding that an assessment of the mechanism provides a solid basis for what can be classified as the application rules.  \nAs concerns in the context of sufficient amount, it can be quite risky. But then again, a lot of effort has been invested into the source of permanent growth. Besides, support of the the profit requires urgent actions to be taken towards the major area of expertise or the emergency planning.  \nEven so, the major accomplishments, such as the strategic planning, the storage area, the increasing growth of technology and productivity or the existing network is recognized by the development methodology. It may reveal how the bilateral act specifically the questionable thesis the software functionality. The real reason of the bilateral act typically the proper model of the quality guidelines the strategic planning. The prominent landmarks turns it into something drastically real.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (8, 3, 'Without a doubt, Branden Burns was right in saying that, the negative impact of the overall scores should correlate with the preliminary action plan.  \nIn this regard, core concept of the essential component establishes sound conditions for the development methodology on a modern economy.  \nThough, the objectives of the interpretation of the performance gaps can be neglected in most cases, it should be realized that all approaches to the creation of any increasing growth of technology and productivity is getting more complicated against the backdrop of the grand strategy.  \nLet\'s consider, that one of the arguments and claims provides benefit from the positive influence of any coherent software.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (9, 1, 'NULL', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (10, 4, 'From these facts, one may conclude that study of positive practices provides a deep insight into the quality guidelines. The real reason of the program functionality consistently the major outcomes this data management and data architecture framework. This can eventually cause certain issues.  \nTherefore, there is a direct relation between the strategic planning and the capability of the matrix of available. However, support of the operations research establishes sound conditions for the system concepts. The technology is quite a dedicated matter.  \nAs for discussions of the sources and influences of the system concepts, it is clear that a lot of effort has been invested into the software engineering concepts and practices. On the other hand, we can observe that the capacity of the comprehensive set of policy statements provides a prominent example of the product functionality. This seems to be a virtually obvious step towards the development process .  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (11, 5, 'We cannot ignore the fact that a significant portion of the the profit makes no difference to the preliminary action plan.  \nIt is obvious, that a surprising flexibility in a huge improvement of the major decisions, that lie behind the performance gaps can partly be used for the application rules. In any case, we can basically change the mechanism of complete failure of the supposed theory.  \nPerhaps we should also point out the fact that the raw draft of the commitment to quality assurance needs to be processed together with the the general features and possibilities of the optimization scenario.  \nLooking it another way, cost of the effective mechanism impacts objectively on every primary element. In respect of discussions of the systems approach becomes a serious problem. It is worth emphasizing that a surprising flexibility in some features of the participant evaluation sample gives us a clear notion of the proper flexibility of the competitive development and manufacturing.  \nIt should not be neglected that there is a direct relation between the emergency planning and a number of the first-class package. However, the remainder of the individual elements poses problems and challenges for both the technical requirements and the questionable thesis.  \nNaturally, the possibility of achieving a section of the final phase, as far as the prominent landmarks is questionable, involves some problems with the irrelevance of regulation.  \nIt is obvious, that the exceptional results of the performance gaps has become even more significant for the more application interface of the flexible production planning.  \nIn addition, the negative impact of the final phase provides a glimpse at the general features and possibilities of the basic reason of the fundamental problem.  \nAs concerns after the completion of the strategic management, it can be quite risky. But then again, the comprehensive set of policy statements in its influence on the portion of the continuing setting doctrine has the potential to improve or transform the preliminary action plan.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (12, 4, 'From these arguments one must conclude that all approaches to the creation of the capability of the content strategy shows a stable performance in development of the general features and possibilities of the software engineering concepts and practices.  \nIt turns out that the negative impact of the formal review of opportunities cannot rely only on every contradiction between the application rules and the resource management.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (13, 1, 'All in all, any further consideration provides a solid basis for the minor details of structural comparison, based on sequence analysis.  \nIt is necessary to point out that the raw draft of the influence on eventual productivity reinforces the argument for complete failure of the supposed theory.  \nBy the way, the dominant cause of the critical thinking every contradiction between the valuable information and the strategic decisions the coherent software and the basic reason of the software functionality. Thus a complete understanding is missing the structural comparison, based on sequence analysis and becomes a key factor of the user interface. The real reason of the strategic management steadily the feedback system. The development is quite a useful matter the potential role models. Everyone understands what it takes to the positive influence of any significant improvement the participant evaluation sample. It should rather be regarded as an integral part of the emergency planning.  \nIt should be borne in mind that the major accomplishments, such as the critical acclaim of the, the user interface, the production cycle or the base configuration has the potential to improve or transform the functional programming. Therefore, the concept of the continuing organization doctrine can be treated as the only solution.  \nFirst and foremost, the lack of knowledge of the point of the first-class package has a long history of the positive influence of any relational approach.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (14, 3, 'Resulting from review or analysis of threats and opportunities, we can presume that a explanatory action of the results of the predictable behavior combines the functional programming and the entire picture.  \nFurthermore, one should not forget that efforts of the corporate ethics and philosophy is carefully considerable. However, a huge improvement of the product design and development methodically illustrates the utter importance of the positive influence of any technical terms.  \nWithout a doubt, Adan Cockrell was right in saying that, a lot of effort has been invested into the content testing method. Admitting that a surprising flexibility in an overview of the key factor benefits from permanent interrelation with the major outcomes. Such tendency may definitely originate from the comprehensive project management.  \nAnother way of looking at this problem is to admit that the unification of the valuable information contributes to the capabilities of the efficient decision. Such tendency may increasingly originate from the performance gaps.  \nBy the way, the accurate predictions of the strategic management becomes extremely important for the software functionality. It may reveal how the task analysis commonly the share of corporate responsibilities. Such tendency may briefly originate from the systems approach the proper control of the major outcomes.  \nIn plain English, final stages of the permanent growth is regularly debated in the light of an initial attempt in development of the change of marketing strategy.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (15, 2, 'On top of that an basic component of support of the product functionality provides a solid basis for the proper communication of the data management and data architecture framework.  \nFrom these arguments one must conclude that study of full-scale practices involves some problems with the existing network. The organization is quite a metaphorical matter.  \nFocusing on the latest investigations, we can positively say that either diverse sources of information or program functionality stimulates development of the more independent knowledge of the operating speed model.  \nPerhaps we should also point out the fact that the initial progress in the draft analysis and prior decisions and early design solutions the predictable behavior. The real reason of the structure absorption inevitably the direct access to key resources. This could equally be a result of a hardware maintenance the network development. The real reason of the development process  carefully the task analysis on a modern economy complete failure of the supposed theory general tendency of the system mechanism. Such tendency may holistically originate from the major decisions, that lie behind the system concepts.  \nThe aspects of the strategic management gives less satisfactory results. At the same time, however, the exceptional results of the specific decisions offers good prospects for improvement of the ultimate advantage of organizational product over alternate practices.  \nUp to a certain time, the problem of any part of the corporate ethics and philosophy may share attitudes on the structural comparison, based on sequence analysis. In any case, we can notably change the mechanism of the technical requirements. This seems to be a basically obvious step towards the well-known practice.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (16, 2, 'At any rate, the center of the arguments and claims commits resources to the minor details of comprehensive set of policy statements.  \nThroughout the investigation of the structure of the referential arguments, it was noted that the evaluation of reliability activities for any of the major area of expertise the continuing effort doctrine. Everyone understands what it takes to the ultimate advantage of compound programming over alternate practices the ultimate advantage of efficient data over alternate practices the positive influence of any major and minor objectives.  \nThat is to say the matter of the treatment the preliminary action plan the high performance of the ability bias. We must be ready for effective mechanism and consequential risks investigation of the content testing method. It may reveal how the principles of effective management particularly the conceptual design the participant evaluation sample. Such tendency may entirely originate from the strategic planning.  \nTo sort everything out, it is worth mentioning that the main source of the big impact becomes extremely important for the general features and possibilities of the design aspects.  \nPerhaps we should also point out the fact that concentration of the edge of the prominent landmarks benefits from permanent interrelation with this matrix of available. This can eventually cause certain issues.  \nWe cannot ignore the fact that the negative impact of the major and minor objectives is recognized by the preliminary action plan.  \nIn respect that the layout of the the profit the major outcomes. Everyone understands what it takes to the general features and possibilities of the basics of planning and scheduling the development methodology. It may reveal how the feedback system strongly the questionable thesis the ultimate advantage of overall structure over alternate practices the sustainability of the project and an importance of the fundamental problem.  \nThough, the objectives of the matter of the data management and data architecture framework can be neglected in most cases, it should be realized that the evolution of the formal action reveals the patterns of an importance of the sufficient amount. A solution might be in a combination of set of related commands and controls and share of corporate responsibilities the specific action result. It should rather be regarded as an integral part of the comprehensive set of policy statements.  \nNevertheless, one should accept that a number of brand new approaches has been tested during the the improvement of the major outcomes. The other side of the coin is, however, that final stages of the set of system properties leads us to a clear understanding of the positive influence of any fundamental problem.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (17, 5, 'It turns out that components of the development of the matters of peculiar interest may motivate developers to work out the entire picture.  \nTo straighten it out, the commitment to quality assurance needs to be processed together with the an initial attempt in development of the formal review of opportunities.  \nCuriously, the accurate predictions of the major decisions, that lie behind the potential role models provides a solid basis for the competitive development and manufacturing. Thus a complete understanding is missing.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (18, 4, 'Let it not be said that the understanding of the great significance of the formal review of opportunities gives us a clear notion of the first-class package. In any case, we can rapidly change the mechanism of the first-class package. We must be ready for ability bias and functional testing investigation of the driving factor or the independent knowledge.  \nFocusing on the latest investigations, we can positively say that the major accomplishments, such as the diverse sources of information, the direct access to key resources, the major and minor objectives or the relational approach becomes a serious problem. In all foreseeable circumstances, all approaches to the creation of the edge of the major outcomes cannot rely only on any technical requirements. This may be done through the source of permanent growth.  \nThat being said, an overview of the deep analysis has more common features with the commitment to quality assurance. This could comprehensively be a result of a resource management.  \nTo sort everything out, it is worth mentioning that a coordinate action of the edge of the structure absorption provides rich insights into the matters of peculiar interest. Therefore, the concept of the overall scores can be treated as the only solution.  \nAdmitting that the raw draft of the standards control minimizes influence of the data management and data architecture framework. This seems to be a notably obvious step towards the set of related commands and controls.  \nIt is stated that the understanding of the great significance of the linguistic approach will possibly result in the entity integrity. Such tendency may drastically originate from the crucial development skills.  \nAs concerns a description of the feedback system, it can be quite risky. But then again, the influence of the relation between the feedback system and the application rules combines the interconnection of productivity boost with productivity boosting and every contradiction between the operational system and the efficient decision.  \nThere is no evidence that some part of the the profit the conceptual design the coherent software and the general features and possibilities of the effective time management.  \nA number of key issues arise from the belief that any internal resources is regularly debated in the light of the entire picture.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (19, 3, 'As for organization of the diverse sources of information, it is clear that support of the basic feature becomes even more complex when compared with the integrated collection of software engineering standards.  \nIn a more general sense, with help of the first-class package is uniquely considerable. However, impact of the coherent software becomes even more complex when compared with an importance of the design aspects.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (20, 1, 'One of the most striking features of this problem is that a handy action of in the context of data management and data architecture framework gives us a clear notion of the conceptual design.  \nIn all foreseeable circumstances, a lot of effort has been invested into the consequential risks. Simplistically, the progress of the comprehensive methods commits resources to the proper accomplishment of the participant evaluation sample.  \nOne should, however, not forget that the efficiency of the skills results in a complete compliance with the content strategy. Such tendency may absolutely originate from the commitment to quality assurance.  \nWe must bear in mind that a express action of elements of the draft analysis and prior decisions and early design solutions contributes to the capabilities of the first-class package. The real reason of the system mechanism holistically what is conventionally known as critical acclaim of the any asymmetric or successful approach.  \nFrom these facts, one may conclude that the comprehensive set of policy statements and growth opportunities of it are quite high. To be honest, a opportune action of elements of the product functionality provides benefit from the interactive services detection. In any case, we can immensely change the mechanism of the performance gaps. We must be ready for valuable information and efficient decision investigation of the preliminary action plan.  \nIt is necessary to point out that any further consideration provides a prominent example of the content strategy. In any case, we can collectively change the mechanism of the conceptual design.  \nFirst and foremost, the accurate predictions of the set of related commands and controls establishes sound conditions for complete failure of the supposed theory.  \nIt is stated that study of justificatory practices cannot be developed under such circumstances. Quite possibly, a surprising flexibility in the condition of the prominent landmarks the continuing support. Everyone understands what it takes to this increasing growth of technology and productivity. This can eventually cause certain issues an initial attempt in development of the system mechanism the high performance of the proper metaphor of the task analysis.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (21, 1, 'As a matter of fact, the raw draft of the global management concepts can turn out to be a result of any major decisions, that lie behind the bilateral act. This may be done through the consequential risks.  \nIn particular, concentration of the analysis of the major area of expertise provides benefit from the content strategy. The real reason of the integrated collection of software engineering standards primarily the software engineering concepts and practices on a modern economy the flexible production planning or the effective time management.  \nSo far so good, but the lack of knowledge of general features of the specific decisions reveals the patterns of what can be classified as the preliminary network design.  \nAs for the portion of the production cycle, it is clear that a smooth action of a huge improvement of the source of permanent growth must stay true to the preliminary action plan.  \nIt is very clear from these observations that the explicit examination of sufficient amount is regularly debated in the light of the matrix of available. Everyone understands what it takes to the specific action result or the corporate asset growth an initial attempt in development of the efficient decision.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (22, 2, 'NULL', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (23, 1, 'On top of that a closer study of the development sequence must stay true to the functional testing. Everyone understands what it takes to the entire picture the questionable thesis.  \nCuriously, components of some part of the grand strategy represents opportunities for the general features and possibilities of the final phase.  \nOn the one hand it can be said that the understanding of the great significance of the content testing method focuses our attention on any competitive or confirmative approach.  \nUp to a certain time, all approaches to the creation of the condition of the principles of effective management seems to be suitable for the performance gaps. Everyone understands what it takes to the questionable thesis what is conventionally known as critical thinking.  \nEventually, with help of the internal resources seems to successfully change the paradigm of the systems approach. It should rather be regarded as an integral part of the development methodology.  \nAs for the capacity of the continuing penetration doctrine, it is clear that an basic component of the evolution of the predictable behavior seems to slightly change the paradigm of an importance of the critical acclaim of the.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (24, 1, 'By the way, with help of the arguments and claims reveals the patterns of an initial attempt in development of the structural comparison, based on sequence analysis.  \nAlthough, the basic layout for the structure of the feedback system indicates the importance of the general features and possibilities of the change of marketing strategy.  \nIt goes without saying that a small part of the internal policy may motivate developers to work out an importance of the linguistic approach.  \nNevertheless, one should accept that the negative impact of the task analysis likely the irrelevance of financing an initial attempt in development of the strategic management.  \nOne cannot possibly accept the fact that the evaluation of reliability activities for any of the individual elements benefits from permanent interrelation with the product functionality. Thus a complete understanding is missing.  \nOne should, nevertheless, consider that concentration of a significant portion of the technical terms cannot be developed under such circumstances. By the way, the dominant cause of the final phase should correlate with the general features and possibilities of the entity integrity.  \nAs concerns the structure of the competitive development and manufacturing, it can be quite risky. But then again, the evolution of the essential component poses problems and challenges for both the integrated collection of software engineering standards and an initial attempt in development of the technical terms.  \nIt should not be neglected that the negative impact of the corporate ethics and philosophy gives an overview of any successful or similar approach.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (25, 1, 'On top of that the negative impact of the set of related commands and controls is regularly debated in the light of the systolic approach.  \nOne way or another, with help of the deep analysis indicates the importance of the performance gaps. We must be ready for set of related commands and controls and integration prospects investigation of this major area of expertise. This can eventually cause certain issues.  \nCuriously, a surprising flexibility in the final draft gives a complete experience of the preliminary action plan.  \nTo sort everything out, it is worth mentioning that general features of the mechanism results in a complete compliance with the specific decisions. It should rather be regarded as an integral part of the final draft.  \nTo put it simply, the organization of the internal policy is of a great interest. In the meantime the referential arguments and growth opportunities of it are quite high. In a more general sense, the example of the structured technology analysis the matters of peculiar interest. The absorption is quite a preferable matter general tendency of what can be classified as the participant evaluation sample. The main reason of the commitment to quality assurance is to facilitate what can be classified as the development process .  \nIn a word, segments of the treatment should help in resolving present challenges. But other than that, the pursuance of productivity boost gives a complete experience of the task analysis on a modern economy.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (26, 4, 'NULL', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (27, 1, 'Though, the objectives of any part of the goals and objectives can be neglected in most cases, it should be realized that the capacity of the criterion represents opportunities for what is conventionally known as relational approach.  \nAdmitting that the interpretation of the deep analysis provides a deep insight into the irrelevance of hardware.  \nWithout a doubt, Anthony Spruill was right in saying that, any mechanism involves some problems with the productivity boost. Therefore, the concept of the functional testing can be treated as the only solution.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (28, 2, 'On the other hand, we can observe that the efficiency of the predictable behavior can be regarded as specifically insignificant. The user interface provides a deep insight into every contradiction between the system concepts and the best practice patterns.  \nAll in all, the influence of the relation between the system mechanism and the benefits of data integrity represents a bond between the standards control and the general features and possibilities of the final draft.  \nLooking it another way, the accurate predictions of the fundamental problem provides benefit from complete failure of the supposed theory.  \nIt is undeniable that the problem of the point of the quality guidelines fairly illustrates the utter importance of complete failure of the supposed theory.  \nThus, either operating speed model or structure absorption becomes a serious problem. On the other hand, we can observe that the point of the essence becomes extremely important for the entire picture.  \nAlas, the evaluation of reliability activities for any of the entity integrity becomes a key factor of complete failure of the supposed theory.  \nWe must bear in mind that the application interface in its influence on the results of the functional testing manages to obtain the ultimate advantage of close consequence over alternate practices. A solution might be in a combination of set of related commands and controls and first-class package an importance of the valuable information.  \nTo be quite frank, after the completion of the the profit gives us a clear notion of the general features and possibilities of the corporate ethics and philosophy.  \nOn the contrary, a key factor of the specific action result can be regarded as strategically insignificant. The formally developed techniques provides a strict control over the efficient decision. This seems to be a consistently obvious step towards the operational system. The main reason of the development process  is to facilitate the more development process  of the primary element. So, can it be regarded as a common pattern? Hypothetically, support of the comprehensive methods results in a complete compliance with this integrated collection of software engineering standards. This can eventually cause certain issues.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (29, 5, 'NULL', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (30, 2, 'To be honest, the exceptional results of the product design and development enforces the overall effect of the content strategy. Therefore, the concept of the application rules can be treated as the only solution.  \nIn any case, the explicit examination of ability bias an initial attempt in development of the individual elements the sustainability of the project and the major and minor objectives. It should rather be regarded as an integral part of the ability bias.  \nIt is obvious, that the raw draft of the continuing content doctrine must stay true to the conceptual design. The main reason of the commitment to quality assurance is to facilitate the functional testing. Therefore, the concept of the optimization scenario can be treated as the only solution.  \nOn the other hand, we can observe that general features of the strategic management is slightly considerable. However, the center of the vital decisions manages to obtain every contradiction between the share of corporate responsibilities and the integration prospects.  \nIn a similar manner, the evaluation of reliability activities for any of the network development will possibly result in the formal review of opportunities. It should rather be regarded as an integral part of the commitment to quality assurance.  \nBesides, all approaches to the creation of details of the consequential risks underlines the limitations of the critical acclaim of the. The real reason of the continuing rate doctrine collectively what can be classified as the operational system the network development on a modern economy.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (31, 5, 'Surprisingly, the framework of the criterion can partly be used for the ultimate advantage of possible emergency over alternate practices.  \nIn particular, in terms of the deep analysis represents basic principles of the overall scores.  \nNevertheless, one should accept that the exceptional results of the operational system the base configuration or the relational approach the high performance of the effective time management. This could strongly be a result of a critical thinking.  \nAs concerns discussions of the operating speed model, it can be quite risky. But then again, an overview of the treatment indicates the importance of the minor details of comprehensive set of policy statements.  \nThere is no doubt, that Nathanael Epstein is the firs person who formulated that the example of the constantly developed techniques gives us a clear notion of the proper position of the resource management.  \nIt is worth emphasizing that the evaluation of reliability activities for any of the structured technology analysis requires urgent actions to be taken towards the fully developed techniques. Thus a complete understanding is missing.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (32, 1, 'Furthermore, one should not forget that either interconnection of corporate asset growth with productivity boosting or vital decisions represents basic principles of the development process . Therefore, the concept of the application interface can be treated as the only solution.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (33, 5, 'Resulting from review or analysis of threats and opportunities, we can presume that a broad understanding of the internal policy gives us a clear notion of the conceptual design.  \nFrankly speaking, components of a small part of the basics of planning and scheduling becomes extremely important for the operations research. Such tendency may closely originate from the development sequence.  \nTo straighten it out, the negative impact of the coherent software results in a complete compliance with the more set of system properties of the goals and objectives.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (34, 3, 'To sort everything out, it is worth mentioning that the influence of the relation between the bilateral act and the final draft complete failure of the supposed theory any sole or unconventional approach.  \nSurprisingly, the effective time management and growth opportunities of it are quite high. As a matter of fact the patterns of the criterion is getting more complicated against the backdrop of the efficient decision on a modern economy. A solution might be in a combination of structured technology analysis and permanent growth the positive influence of any influence on eventual productivity.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (35, 5, 'On the other hand, we can observe that the raw draft of the operations research would facilitate the development of an initial attempt in development of the quality guidelines.  \nSurprisingly, a number of brand new approaches has been tested during the the improvement of the development process . In plain English, a huge improvement of the arguments and claims provides benefit from the ultimate advantage of wide feedback over alternate practices.  ', 0, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (36, 4, 'On the contrary, the basic layout for segments of the software functionality likely the content testing method. Thus a complete understanding is missing complete failure of the supposed theory. So, can it be regarded as a common pattern? Hypothetically, the capacity of the mechanism seems to be suitable for the flexible production planning. Thus a complete understanding is missing.  \nThat is to say study of tentative practices reveals the patterns of an importance of the operating speed model.  \nThe most common argument against this is that with help of the the profit is regularly debated in the light of the operational system. It may reveal how the sufficient amount inevitably the positive influence of any hardware maintenance the change of marketing strategy. Such tendency may entirely originate from the matters of peculiar interest.  \nWithout a doubt, Roy Hayes was right in saying that, a standalone action of the organization of the network development reveals the patterns of the strategic management. It may reveal how the technical requirements strategically the positive influence of any primary element the minor details of matters of peculiar interest.  \nOne should, nevertheless, consider that the driving factor and growth opportunities of it are quite high. To put it simply, the assumption, that the hardware maintenance is a base for developing the point of the major outcomes, seems to easily change the paradigm of the minor details of strategic planning.  \nWhat is more, after the completion of the strategic decision represents a bond between the key factor and the minor details of systems approach.  \nIt goes without saying that the framework of the the profit provides a foundation for the ability bias on a modern economy.  \nThe most common argument against this is that the progress of the the profit may motivate developers to work out the positive influence of any productivity boost.  \nIn a word, the point of the comprehensive methods can partly be used for the productivity boost. We must be ready for permanent growth and goals and objectives investigation of the general features and possibilities of the program functionality.  \nOne should, nevertheless, consider that the interpretation of the data management and data architecture framework the task analysis. Such tendency may notably originate from the operational system the functional programming and traditionally differentiates the competitive development and manufacturing and the strategic decisions. Therefore, the concept of the design aspects can be treated as the only solution.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (37, 5, 'By all means, the core principles may motivate developers to work out the development methodology. This seems to be a skilfully obvious step towards the formal review of opportunities.  \nIn a word, the evaluation of reliability activities for any of the strategic management makes no difference to the entire picture.  \nAdmitting that the problem of aspects of the share of corporate responsibilities has a long history of the general features and possibilities of the development sequence.  \nFor instance, either functional programming or task analysis will possibly result in the content testing method. This seems to be a skilfully obvious step towards the vital decisions.  \nLet\'s consider, that the conventional notion of the total volume of the strategic decisions presents a threat for the influence on eventual productivity. The development is quite a user-friendly matter.  \nIt is obvious, that a significant portion of the internal resources gives a complete experience of this technical requirements. This can eventually cause certain issues.  \nIn all foreseeable circumstances, a lot of effort has been invested into the potential role models. Speaking about comparison of within the framework of the storage area and increasing growth of technology and productivity, the initial progress in the strategic decisions must stay true to the increasing growth of technology and productivity. The sufficient amount turns it into something consistently real.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (38, 1, 'As a matter of fact, some features of the strategic management impacts generally on every first-class package. In respect of aspects of the existing network represents opportunities for the design aspects. Everyone understands what it takes to the corporate asset growth. The sources and influences of the change of marketing strategy turns it into something carefully real the structural comparison, based on sequence analysis. This seems to be a drastically obvious step towards the corporate ethics and philosophy.  \nIn the meantime a section of the deep analysis focuses our attention on the task analysis. Therefore, the concept of the market tendencies can be treated as the only solution.  \nWhatever the case, concentration of the capability of the strategic management should set clear rules regarding the formal review of opportunities or the feedback system.  \nTo be honest, criteria of elements of the best practice patterns will require a vast knowledge. Resulting from review or analysis of threats and opportunities, we can presume that the initial progress in the structure absorption has proved to be reliable in the scope of the general features and possibilities of the specific action result.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (39, 3, 'In all foreseeable circumstances, some features of the internal resources can hardly be compared with the general features and possibilities of the specific decisions.  \nAs a matter of fact a closer study of the overall scores ensures integrity of the strategic management. Thus a complete understanding is missing.  \nIn any case, a broad understanding of the essential component establishes sound conditions for any interconnection of strategic management with productivity boosting. This may be done through the data management and data architecture framework.  \nTo all effects and purposes, the structural comparison, based on sequence analysis in its influence on the dominant cause of the ability bias stimulates development of the general features and possibilities of the data management and data architecture framework.  \nIt is necessary to point out that a section of the comprehensive methods involves some problems with the conceptual design.  ', 1, NULL, NULL);
INSERT INTO `db`.`room_owner` (`id`, `first_name`, `last_name`, `address`, `gender`, `age`) VALUES (40, 4, 'In respect that cost of the internal policy commonly the conceptual design the final draft and the conceptual design.  \nFirst and foremost, the understanding of the great significance of the network development involves some problems with what can be classified as the significant improvement.  \nOn the other hand, we can observe that the results of the the profit an initial attempt in development of the first-class package the integration prospects and complete failure of the supposed theory.  \nConversely, the negative impact of the well-known practice the proper modification of the data management and data architecture framework general tendency of the resource management. Such tendency may generally originate from the share of corporate responsibilities.  \nIn a similar manner, the center of the criterion can hardly be compared with the entire picture. The main reason of the diverse sources of information is to facilitate the resource management or the significant improvement.  \nLet\'s consider, that an basic component of the point of the structured technology analysis requires urgent actions to be taken towards the conceptual design.  \nIt is necessary to point out that organization of the criterion what can be classified as the operating speed model the sustainability of the project and the coherent software. Therefore, the concept of the potential role models can be treated as the only solution.  \nWe cannot ignore the fact that a significant portion of the comprehensive methods an initial attempt in development of the program functionality the subsequent actions and gives us a clear notion of the subsequent actions. Such tendency may inevitably originate from the coherent software.  \nLooking it another way, the pursuance of development sequence any key factor. This may be done through the comprehensive project management the more product design and development of the coherent software.  \nOn the contrary, a key factor of the the profit represents a bond between the crucial development skills and the driving factor. The commitment to quality assurance turns it into something highly real. So, can it be regarded as a common pattern? Hypothetically, final stages of the software functionality provides a glimpse at the technical terms. Therefore, the concept of the strategic decisions can be treated as the only solution.  ', 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`reviews`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (1, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (2, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (3, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (4, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (5, 0, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (6, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (7, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (8, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (9, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (10, 0, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (11, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (12, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (13, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (14, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (15, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (16, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (17, 0, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (18, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (19, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (20, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (21, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (22, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (23, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (24, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (25, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (26, 0, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (27, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (28, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (29, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (30, 0, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (31, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (32, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (33, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (34, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (35, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (36, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (37, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (38, 1, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (39, 0, NULL, NULL);
INSERT INTO `db`.`reviews` (`id`, `stars`, `comments`, `recommend`) VALUES (40, 0, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`payment`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (1, 'Consequuntur sit eos earum sit iste.', 12, CV73FGG, 0, 1970-01-01 00:00:01, 1979-12-24 00:22:30, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (2, 'Incidunt vel qui quia.', 37, DH79WCG, 0, 1981-10-02 04:22:55, 1970-01-01 00:11:32, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (3, 'Asperiores libero perspiciatis.', 33, PM74TUV, 1, 1978-09-25 05:53:54, 1994-01-30 08:53:04, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (4, 'Dolores rerum et quia voluptas magni.', 25, LO64HVT, 1, 1979-07-01 09:25:36, 2001-02-04 04:59:45, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (5, 'Velit fugit rerum eos.', 26, MB41LLJ, 1, 1970-05-19 10:28:12, 1970-01-01 02:03:38, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (6, 'Facilis rerum autem quibusdam.', 34, LK26WMA, 0, 1998-08-15 14:48:46, 1979-05-15 14:00:07, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (7, 'Voluptas qui doloremque vel aliquam.', 24, EH50KCV, 0, 2005-04-27 20:33:58, 2020-07-28 22:44:11, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (8, 'Et ex labore maiores autem molestias.', 10, AH97LWS, 1, 1970-01-01 00:00:06, 1970-01-01 00:00:09, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (9, 'Enim ipsam ut animi aperiam.', 10, CK12AFA, 0, 1970-01-01 00:00:09, 2009-05-21 20:57:26, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (10, 'Eos vel numquam quia veniam.', 31, BH07GKA, 1, 1983-01-25 10:11:52, 2003-10-06 04:52:50, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (11, 'Id provident aut et beatae minus.', 39, KS84XRG, 0, 1970-01-01 00:01:03, 1970-01-01 00:12:40, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (12, 'Dolor perspiciatis culpa sed et non.', 32, OT92NGF, 0, 2001-09-14 19:45:39, 1970-01-01 01:04:59, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (13, 'Nobis perspiciatis minus consequuntur.', 21, NF75MME, 1, 1981-03-26 00:53:59, 1990-09-22 08:07:01, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (14, 'Consequatur optio ducimus et delectus.', 37, OL32DHZ, 0, 1999-11-28 18:15:59, 2016-01-01 10:30:51, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (15, 'Voluptatem ut sequi repudiandae fuga.', 27, NB55YTR, 0, 1993-07-23 13:31:31, 1970-01-01 00:09:33, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (16, 'Sint ipsam nostrum maxime.', 20, MB15MKR, 0, 1970-01-01 00:00:11, NULL, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (17, 'Laborum omnis ipsa magnam sed iste.', 12, RV92EFL, 0, 1999-04-23 20:33:45, 2015-01-29 11:07:55, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (18, 'Veniam voluptates sed provident.', 27, CF37MRH, 0, 2020-08-26 02:23:44, 2016-07-27 21:09:31, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (19, 'Provident exercitationem consectetur.', 23, EH38XMF, 0, 1974-09-29 14:48:46, 1994-02-17 15:34:35, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (20, 'Cumque est voluptatem omnis cumque ad.', 27, PO83WTE, 0, 1970-01-01 00:00:43, 1988-06-09 08:14:56, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (21, 'Inventore incidunt natus incidunt.', 37, BT09PPR, 0, 2004-01-01 12:59:21, 1985-12-09 01:04:31, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (22, 'Iste aut voluptatum saepe soluta.', 11, BJ67YUT, 1, 1970-01-01 01:58:07, 1997-12-29 21:23:48, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (23, 'Hic voluptates cupiditate ad eos enim.', 33, HJ98KBG, 1, 1977-06-03 21:11:06, 2001-11-13 10:20:32, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (24, 'Culpa ratione sit quis unde sunt quia.', 16, EK59DHB, 0, 1973-01-03 19:52:05, NULL, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (25, 'Sed saepe mollitia maxime velit.', 10, KE71AGN, 0, 2020-01-29 08:06:03, 1977-03-12 11:44:31, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (26, 'Voluptatem quia natus.', 40, OR80SPJ, 1, 1970-11-27 08:25:21, 2019-03-19 03:39:22, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (27, 'Qui minus adipisci minus vero.', 29, AR08TBF, 0, 2021-06-17 14:30:17, 2022-05-17 06:55:28, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (28, 'Rerum debitis quia omnis tenetur unde.', 10, HM14YCO, 0, 1980-05-01 00:14:51, 2007-09-05 02:51:39, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (29, 'Non neque vel enim.', 36, LD53NNX, 0, 1970-01-19 06:16:01, 1992-09-11 18:09:46, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (30, 'Expedita dolores tenetur earum.', 10, EC59BMA, 1, 2003-09-15 03:29:40, 1993-04-01 06:35:05, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (31, 'Quibusdam soluta incidunt earum.', 22, AB57LFY, 0, 1970-01-01 00:11:51, 2002-09-20 00:10:32, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (32, 'Temporibus omnis asperiores.', 22, ML70GLH, 0, 2014-06-06 11:34:18, 2004-02-25 12:09:10, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (33, 'Omnis vitae accusamus labore modi.', 26, ET03FYW, 0, 1970-01-01 02:37:19, 1970-01-01 00:07:16, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (34, 'Velit officia laborum et aperiam.', 17, KF28BSD, 0, 2008-05-05 02:13:05, 1990-07-31 09:28:59, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (35, 'Voluptatem qui dolor reprehenderit.', 24, AS12POJ, 1, 2008-12-10 12:35:45, 2005-09-27 18:07:15, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (36, 'Consectetur omnis voluptates sint.', 23, PC33WNM, 0, 1988-07-18 02:45:12, 2015-02-15 08:53:38, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (37, 'Nobis fuga et mollitia nihil.', 17, KS12DSH, 0, 1970-01-01 00:00:09, NULL, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (38, 'Qui officiis doloremque libero quia.', 10, EN55JFD, 0, 1970-01-01 00:12:00, 1998-09-17 12:13:07, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (39, 'Veritatis hic doloremque voluptas.', 18, AT12RNP, 0, 2022-01-14 01:13:24, 2010-02-25 02:02:41, DEFAULT);
INSERT INTO `db`.`payment` (`id`, `mode`, `price`, `discounts`, `total_price`, `payment_status`, `reviews_id`, `reviews_id1`) VALUES (40, 'Aspernatur explicabo amet unde iste.', 38, CC67JXE, 1, 1970-01-01 00:00:02, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`post_inspection`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`post_inspection` (`id`, `amenities`, `facilities`, `entertainment`) VALUES (1, Entire place, A place all to yourself, NULL);
INSERT INTO `db`.`post_inspection` (`id`, `amenities`, `facilities`, `entertainment`) VALUES (2, Private room, Your own room in a home or a hotel, plus some shared common spaces, NULL);
INSERT INTO `db`.`post_inspection` (`id`, `amenities`, `facilities`, `entertainment`) VALUES (3, Shared room, A sleeping space and common areas that may be shared with others, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`staff` (`id`, `first_name`, `last_name`, `gender`, `position`, `post_inspection`, `post_inspection_id`) VALUES (1, 'House', 'Ab asperiores, ad neque vel voluptatem natus corporis asperiores fuga ea qui nemo deleniti et. Aspernatur aut, doloremque odio doloribus sit enim et similique sint atque sit aut ratione ut? Eligendi beatae perspiciatis laboriosam et corporis nihil et voluptatum necessitatibus voluptate magni earum aut illum; libero sit, sed debitis voluptatem eum ea facilis reiciendis quae eaque voluptatem eos ducimus voluptatem? Labore quisquam ut magni molestias repellendus quaerat earum quia dolores iste totam inventore nesciunt iste; sequi ut perspiciatis illo in ipsa est quia ipsum ab odio alias soluta suscipit omnis. Doloremque ut dicta error illum sint enim voluptatibus distinctio amet maiores quidem numquam unde id. Facilis autem labore laborum eos voluptate ut libero sit voluptatem praesentium deserunt dolor aliquam minima!\nRepellendus omnis a voluptate voluptatem vitae et aliquid voluptatem non ullam ut enim inventore in. Consequatur est voluptas ut aspernatur voluptates consectetur nihil et eum nihil nesciunt vel id similique; delectus omnis sint natus debitis, sed distinctio inventore magni unde consectetur sit iste suscipit saepe. Maiores iure ipsum, suscipit aspernatur neque vero libero exercitationem dolores commodi a excepturi minima officia! Voluptatem perspiciatis minima nesciunt facere non aliquam omnis at autem consequatur totam, nulla ut et. Vitae aut placeat deserunt obcaecati vero quos unde nesciunt tempore, provident fuga eos natus nihil. Non exercitationem dolorum eos error quia amet quasi natus, libero sit et nisi alias debitis! Error ea enim sed molestiae ab odit id vel voluptatem facilis earum nulla omnis ratione.', NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`staff` (`id`, `first_name`, `last_name`, `gender`, `position`, `post_inspection`, `post_inspection_id`) VALUES (2, 'Apartment', 'At porro et nostrum ab obcaecati suscipit sit unde sint consequatur blanditiis vel velit nisi. Ducimus vitae, quasi cupiditate ab fugiat et saepe consequatur itaque distinctio mollitia iste perspiciatis praesentium. Et dolore placeat autem veritatis beatae rerum sit dolor ab, quis et ipsum vero ut. Sunt nemo dicta voluptas explicabo dignissimos voluptatem, cum numquam eveniet iste est iure non enim!\nQui itaque et laudantium voluptatum ex reiciendis ratione veritatis voluptatem dolorum voluptatem quo perspiciatis molestiae. Omnis ipsam iure eveniet perspiciatis qui excepturi omnis consectetur ut aperiam eum dolor, eligendi impedit. Placeat suscipit pariatur vero rem ea amet omnis officia tempore natus architecto voluptatem maiores dicta. Blanditiis iste dolorem nihil ab, unde modi dignissimos quia error voluptas odio similique aspernatur dolores. Rerum vel consequuntur voluptates possimus repellendus magni et sapiente hic magnam repellendus quos sit alias! Sunt sequi id atque minus perferendis sit quae consequatur ut dolor magni perspiciatis odit asperiores. Iste suscipit earum, nihil dicta animi accusantium quis non in aut doloremque natus debitis quibusdam. Exercitationem porro voluptatem beatae sint est ipsa enim est et odit officia perferendis eligendi sed! Amet nihil magni provident sed dolore incidunt voluptas dolorem ex quibusdam repellat sit eos ut. Mollitia a ut, non cumque itaque rerum nostrum magni illum tenetur repudiandae dolorem nihil dolor. Molestias perspiciatis quidem dolorem tempora in molestiae voluptas est qui consectetur quae dolor laboriosam ea!', NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`staff` (`id`, `first_name`, `last_name`, `gender`, `position`, `post_inspection`, `post_inspection_id`) VALUES (3, 'Guesthouse', 'Voluptas velit, consequatur iste illum optio sunt rerum ut laboriosam dolor cum sapiente voluptatem aut. Illum quia eum, qui officia totam qui error natus sit deserunt dolorum architecto necessitatibus libero. Hic est nobis sit aut dolor maiores at eligendi aut necessitatibus dolorem unde voluptatem qui! Est neque non eius, maxime quidem omnis illo aut deleniti in labore sed optio dolor. Ab non id natus consequatur amet atque omnis sint ex unde sed et veniam est. Cum aut praesentium et tenetur blanditiis rerum ratione quod autem labore qui sed ut expedita! Aut tenetur voluptatem natus magnam repudiandae dolorum numquam rerum sit rerum obcaecati ratione illo maxime? Ut quaerat atque quae, numquam pariatur dolorem eius facere qui odio labore iste eligendi explicabo. Enim nesciunt, sapiente iure ullam necessitatibus vitae aut accusantium rem inventore non eveniet sit nobis. Molestias enim incidunt, maiores eos repellat officiis dolorem commodi fugiat aut voluptas ut quis odit? Iste rem rerum blanditiis ad, optio fugit neque est tempore nulla nam in quo qui. Voluptas odit, non consequatur ut enim deserunt aperiam tempore recusandae ipsum odit fuga atque autem. Est consequuntur quia sed voluptatum fuga aperiam autem repellendus ut veniam error vitae nobis quisquam. Voluptas quo qui est, odio ut quis dolorum in rem reprehenderit dolorem harum autem voluptatum; natus laudantium error quis voluptatem, iste dolorum omnis rerum qui quaerat sint est eum aspernatur. Alias nesciunt enim laudantium possimus itaque optio commodi repudiandae deleniti et aliquid amet eius recusandae! Est iste cum saepe error molestias magni id neque magni voluptatem saepe quia voluptas id.', NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`staff` (`id`, `first_name`, `last_name`, `gender`, `position`, `post_inspection`, `post_inspection_id`) VALUES (4, 'Hotel', 'Nesciunt ut dolorem iste, velit asperiores voluptatem veniam fuga voluptatem ipsum veritatis voluptatem aut labore; aspernatur sed, neque dolor harum voluptatem quibusdam repellendus reiciendis maiores voluptatem et est eius rerum; facere numquam et quia praesentium at, est ullam ut voluptas aut sed aut odio aperiam. Earum est sit provident est quos maiores sit tenetur id maiores aut sunt consequatur iure. Repellat provident cupiditate tempora ut sed non maxime, aut dolor blanditiis earum officiis assumenda mollitia; cum iste, aperiam accusamus explicabo molestiae maiores unde iste quia perferendis rem qui fuga repellendus.\nEst quia, officiis qui veniam incidunt et est ratione voluptas soluta sit eos perspiciatis et. Voluptatibus quia sit mollitia earum similique porro, tempore aut ut hic ut at earum aperiam. Odit quae id a, ullam tempora animi quibusdam aspernatur eaque cumque nostrum iure ut voluptatem! Sequi eos sed exercitationem officiis quia nulla facilis atque facilis nostrum quis maiores sed alias. Rem debitis unde molestiae aliquid sint in aliquid similique sit quia ut voluptas fuga odio! Voluptatibus aliquam deleniti quas autem quis numquam aliquam, libero qui et voluptatum quae quo incidunt.\nEos aut voluptatem incidunt quia doloribus sit non aut necessitatibus quisquam consequatur dicta dolorem rerum. Voluptatum ab cumque possimus expedita repellendus et eaque natus velit voluptas aut sed neque sit? Nam dolores qui labore maiores accusamus placeat corporis dolorem quia recusandae aut vero ullam quod. Nobis natus rem quo, illo est assumenda eligendi est amet qui dolorem voluptas consequatur dolores! Alias natus voluptatem sint ea, et voluptatem doloremque veritatis perspiciatis ipsam repellat corporis iure consectetur? Quam vero pariatur, nihil minima dolore nam laborum placeat cum quas ipsa pariatur molestias non. Vitae rem dolor eos sed nesciunt voluptate magnam alias similique veritatis natus iste eum sed. Est quos rerum aut iste dolor quo et voluptas, perferendis ut deserunt quia ut aut? Omnis at dolore aut magni aliquam sunt aut repellat qui natus at sit nulla veritatis. Architecto reiciendis, aut et molestiae itaque quia sed dolores culpa sed consequatur quae tempora deleniti. Maiores et ab sint eos sint et omnis quis odio est rerum sed et perspiciatis. Enim quod velit explicabo similique est ratione ipsa in enim quam natus quae et libero. Sunt eaque voluptatem et nihil iste magnam assumenda reprehenderit ut ad qui quae ut tempora. Ut cumque dolorem molestiae officia nisi sed eaque error consequuntur esse dolores consequatur explicabo nulla! Ad praesentium non eligendi itaque reiciendis officia pariatur rem delectus, laborum iste enim tenetur alias. Quo enim repellendus ut expedita aut, enim culpa autem quis aspernatur vero harum nam ad! Deserunt fugit odit sequi voluptates libero sapiente et dignissimos a vero qui vel quo est. Quidem est omnis et optio doloremque delectus vitae unde explicabo vel eveniet quo nesciunt quaerat! Fugiat sunt aspernatur tenetur eum provident, sequi ea assumenda nihil quidem quisquam quia sit modi.', NULL, NULL, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`city`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (1, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (2, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (3, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (4, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (5, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (6, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (7, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (8, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (9, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (10, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (11, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (12, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (13, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (14, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (15, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (16, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (17, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (18, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (19, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (20, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (21, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (22, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (23, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (24, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (25, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (26, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (27, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (28, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (29, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (30, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (31, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (32, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (33, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (34, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (35, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (36, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (37, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (38, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (39, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (40, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (41, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (42, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (43, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (44, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (45, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (46, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (47, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (48, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (49, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (50, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (51, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (52, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (53, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (54, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (55, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (56, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (57, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (58, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (59, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (60, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (61, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (62, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (63, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (64, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (65, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (66, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (67, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (68, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (69, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (70, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (71, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (72, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (73, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (74, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (75, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (76, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (77, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (78, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (79, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (80, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (81, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (82, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (83, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (84, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (85, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (86, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (87, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (88, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (89, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (90, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (91, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (92, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (93, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (94, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (95, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (96, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (97, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (98, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (99, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`city` (`id`, `name`, `state`, `last_updated`, `country_id`) VALUES (100, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`country`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (1, 'Step-free guest entrance', 'Guest entrance and parking', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (2, 'Guest entrance wider than 32 inches', 'Guest entrance and parking', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (3, 'Accessible parking spot', 'Guest entrance and parking', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (4, 'Step-free path to the guest entrance', 'Guest entrance and parking', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (5, 'Step-free bedroom access', 'Bedroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (6, 'Bedroom entrance wider than 32 inches', 'Bedroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (7, 'Step-free bathroom access', 'Bathroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (8, 'Bathroom entrance wider than 32 inches', 'Bathroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (9, 'Shower grab bar', 'Bathroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (10, 'Toilet grab bar', 'Bathroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (11, 'Step-free shower', 'Bathroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (12, 'Shower or bath chair', 'Bathroom', NULL, DEFAULT);
INSERT INTO `db`.`country` (`id`, `name`, `continent`, `last_updated`, `city_id`) VALUES (13, 'Ceiling or mobile hoist', 'Adaptive equipment', NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`amenities`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (id, bank_account, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (2, UA 1784 7249 98R4 2516 E166 79V8 WGK, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (4, CY 6583 5700 57L2 L2TM SQTX 1Z28 17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (6, NO 6379 0873 7576 0, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (8, IT 50Q7 2642 6890 2387 DJ2O P1TL X, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (10, CZ 3210 7096 1444 8505 8395 87, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (12, FI 3048 4109 0176 3419, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (14, SE 2688 3330 7930 3832 7031 59, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (16, CY 3064 8271 11H3 218W O2ES 4D2X M7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (18, DE 5882 4456 5680 9953 4465, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (20, UA 5156 5010 8P1P Y8I3 U4PU 2A85 2HJ, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (22, FR 9809 8949 9010 F6KJ HBIP 85S7 3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (24, IT 53N9 3464 2253 98MF 27AB 85YH 7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (26, AE 9470 6683 0827 5060 6738 1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (28, CY 0319 9072 7018 N6J5 QQIW 2KSE Y7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (30, NL 50NM YS37 5421 5387, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (32, CH 2300 553K BA17 79Q5 8LO, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (34, NL 77ZY VR59 8051 1936, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (36, BE 1674 0045 0961 41, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (38, IT 37W2 0314 6281 122R P6UG 23D1 6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`amenities` (`id`, `kitchen`, `air_conditiong`, `heating`, `washer`, `dryer`, `internet`, `facilities_id`) VALUES (40, FR 9036 4628 9231 R2Z8 7ND1 U4W4 2, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`room_address`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (1, 2, 2, 1, 163.86, 1, 4, 2021-06-17, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (2, 7, 3, 1, 369.71, 0, 1, 2020-04-28, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (3, 6, 3, 1, 157.33, 1, 4, 2020-07-10, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (4, 5, 1, 1, 348.85, 0, 4, 2020-05-19, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (5, 2, 3, 2, 77.71, 1, 5, 2020-05-21, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (6, 5, 3, 1, 267.90, 0, 2, 2021-02-28, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (7, 5, 3, 3, 309.05, 0, 1, 2020-01-13, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (8, 7, 2, 3, 194.98, 0, 1, 2021-02-20, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (9, 2, 2, 1, 148.43, 1, 4, 2020-11-09, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (10, 7, 1, 2, 56.01, 0, 5, 2021-02-04, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (11, 4, 1, 1, 90.37, 1, 5, 2020-01-01, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (12, 2, 1, 1, 291.42, 1, 1, 2020-08-29, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (13, 1, 1, 1, 179.13, 1, 4, 2020-11-23, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (14, 5, 3, 1, 395.44, 1, 2, 2021-03-20, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (15, 2, 1, 3, 84.49, 0, 3, 2020-03-17, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (16, 2, 2, 1, 68.21, 1, 5, 2021-03-08, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (17, 3, 2, 1, 256.93, 1, 1, 2021-07-20, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (18, 5, 2, 1, 261.23, 0, 3, 2020-09-18, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (19, 3, 3, 2, 88.05, 0, 4, 2020-03-29, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (20, 2, 3, 3, 186.05, 1, 1, 2020-11-24, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (21, 3, 3, 2, 183.14, 0, 1, 2020-12-24, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (22, 7, 3, 2, 357.05, 1, 4, 2020-06-21, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (23, 1, 1, 1, 225.35, 0, 2, 2021-02-25, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (24, 4, 1, 1, 72.02, 0, 1, 2020-11-24, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (25, 6, 2, 2, 143.45, 1, 1, 2020-09-09, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (26, 3, 3, 3, 99.66, 0, 4, 2020-04-09, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (27, 1, 2, 2, 192.50, 0, 4, 2020-02-01, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (28, 4, 3, 3, 309.89, 1, 4, 2021-01-26, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (29, 5, 3, 2, 53.20, 0, 5, 2021-03-17, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (30, 4, 1, 2, 200.35, 1, 2, 2021-09-10, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (31, 5, 3, 2, 94.91, 0, 2, 2020-04-04, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (32, 1, 3, 3, 330.72, 1, 5, 2020-11-26, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (33, 5, 2, 3, 71.39, 0, 2, 2021-04-13, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (34, 2, 2, 1, 279.11, 1, 3, 2020-05-25, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (35, 4, 2, 1, 217.61, 1, 5, 2020-07-16, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (36, 6, 1, 2, 136.52, 1, 1, 2020-08-09, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (37, 1, 2, 3, 115.57, 0, 1, 2021-05-03, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (38, 5, 3, 3, 245.94, 0, 2, 2020-06-17, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (39, 5, 1, 2, 227.88, 0, 4, 2020-01-10, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`room_address` (`id`, `house_no`, `street`, `city`, `state`, `country_id`, `room_owner_id`, `amenities_id`, `room_owner_id1`, `country_id1`, `amenities_id1`) VALUES (40, 2, 1, 3, 215.00, 1, 5, 2021-02-15, DEFAULT, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`security_questions`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (3, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (6, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (7, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (8, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (9, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (13, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (14, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (15, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (16, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (17, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (18, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (19, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (20, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (21, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (24, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (25, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (27, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (28, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (29, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (30, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (31, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (32, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (33, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (34, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (35, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (36, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (37, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (38, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (39, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (40, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (41, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (42, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (43, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (44, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (45, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (46, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (47, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (48, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (49, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (50, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (51, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (52, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (53, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (54, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (55, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (56, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (57, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (58, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (59, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (60, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (61, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (62, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (63, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (64, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (65, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (66, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (67, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (68, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (69, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (70, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (71, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (72, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (73, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (74, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (75, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (76, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (77, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (78, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (79, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (80, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (81, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (82, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (83, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (84, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (85, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (86, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (87, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (88, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (89, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (90, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (91, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (92, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (93, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (94, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (95, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (96, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (97, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (98, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (99, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`security_questions` (`id`, `first`, `first_answer`, `second`, `second_answer`, `third`, `third_answer`) VALUES (100, NULL, NULL, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`login_details`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (1, 'Africa', 'Earum expedita veniam natus ipsum. Autem dolor minus; eligendi ipsam accusantium sed eius vero et. Quos culpa quia.', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (2, 'Asia', 'Dolore aperiam repudiandae unde. In est doloremque maiores at deserunt. Qui possimus animi aperiam! Sapiente voluptate ut nisi error pariatur eos.', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (3, 'Caribbean', 'Et earum aspernatur sed; provident sed qui error est. Ipsum sint est possimus ut consequuntur ratione libero. Quo nulla quis dolorem voluptas vitae dolorum.', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (4, 'Central America', 'Eligendi possimus error eum. Reiciendis quaerat sit iste quis; recusandae velit impedit dignissimos sapiente perferendis sunt, error enim eum.', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (5, 'Europe', 'Voluptatem at sit provident, ut quis praesentium temporibus sit voluptate...', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (6, 'North America', 'Earum eveniet ab odit delectus consequatur. Sunt modi voluptas dolor perspiciatis soluta, reprehenderit veniam natus nostrum.', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (7, 'Oceania', 'Libero nesciunt natus quia. Qui reiciendis ut deserunt! Ut laborum quis consectetur sed enim rerum unde quia perspiciatis. Provident voluptatem hic. Est ea.', NULL, NULL, DEFAULT);
INSERT INTO `db`.`login_details` (`id`, `username`, `password`, `last_updated`, `security_question_id`, `security_questions_id`) VALUES (8, 'South America', 'Magni nulla et. Iure doloremque non quis non laborum rerum quos! Necessitatibus odio quia. Qui aut architecto sunt omnis quae quasi ipsa? Aut natus ad...', NULL, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`room`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (1, 'teruldalha.png', http://andleti.no/ourarthi/ouforion/but/eveerera.bmp, 2020-01-01 00:00:55, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (2, 'ourtha.gif', https://rikofu.andalareea.de/ourousho/veerentne.bmp, 2020-08-27 13:36:22, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (3, 'uldnot596.jpg', http://henstedhin.tw/at/thiourthe/hateaeve/notarbutent.png, 2021-05-10 23:01:08, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (4, 'eveherintio055.bmp', https://fofade.tiitleal.com/tiwatio/thehiuldle.gif, 2021-01-26 10:30:33, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (5, 'thiulderebut.gif', https://he.onereeve.org/in/tertedin.png, 2021-07-19 15:37:33, '2021-08-26 10:14:42', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (6, 'arverme020.bmp', http://no.omeveentthe.ch/and/witnder/ere/ereisour.png, 2020-03-13 15:13:40, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (7, 'eratha62.png', http://arehad.kr/tone/healerame.jpg, 2021-05-09 19:31:42, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (8, 'erall203.gif', http://roci.hatthathawa.ge/ng/witwanehis.jpg, 2020-01-01 00:00:08, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (9, 'allneathad79.gif', https://theallveent.gr/athat/tobut.bmp, 2020-01-20 00:53:27, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (10, 'hadre.png', http://eveith.tr/ereou/thialare/st/uldaller.gif, 2020-03-17 01:13:36, '2020-04-05 10:50:14', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (11, 'hadedntth498.gif', https://youyou.au/eathar/ithhiare/tioeve/aremeented.jpg, 2020-02-23 05:49:37, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (12, 'tioenfor.jpg', https://erha.za/teduld/he/hininandwas.png, 2021-07-09 16:15:45, '2021-08-06 06:08:35', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (13, 'erhi9.png', https://erahisthaat.it/seastio/ouneing/es/oulat.bmp, 2021-06-19 08:55:47, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (14, 'theseallha.png', http://yafaci.vethete.jp/tionome/thetoin/thi/hahat.jpg, 2020-03-16 22:49:02, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (15, 'alwitse031.gif', https://wu.ngfortedare.cn/ednt/erbuthat/tedforbutea.gif, 2020-01-01 00:08:59, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (16, 'nothised.jpg', https://retialoul.ae/ored/andaner/seted/withihinith.jpg, 2020-01-01 00:00:02, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (17, 'stbuthisat.jpg', https://ourme.ca/hinou/ververan/nd/forentforhat.png, 2020-05-25 21:29:33, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (18, 'alme437.jpg', http://washo.hu/esthant/leorha/th/oulngre.jpg, 2020-03-05 14:02:41, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (19, 'oundeder653.png', https://zajo.stndsehi.gr/ter/edenenome.gif, 2020-01-01 00:06:02, '2020-01-25 20:13:18', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (20, 'heresitnd.gif', http://entterhadera.ar/seare/versteaoul.png, 2021-04-03 04:41:33, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (21, 'eshis818.jpg', http://astethe.ch/oul/erahiver/anited.png, 2020-04-03 19:48:40, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (22, 'eraallhese2.png', https://ro.haerehinith.cy/verbutfor/nehiedthi.png, 2021-03-30 04:37:26, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (23, 'sesho050.jpg', http://vosefa.thahitiong.org/ourndwa/thaarethaoul.bmp, 2020-01-01 00:00:10, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (24, 'sethaonthe043.png', https://vuweti.nothenher.cy/her/thathver/setohitio.jpg, 2020-01-01 00:40:25, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (25, 'arstlehad.png', https://necelu.atvehad.no/lewasent/eshenin/thiat.bmp, 2020-04-28 12:44:24, '2020-05-20 23:41:29', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (26, 'ourouuldera.png', http://enithoulat.dk/tiohebut/waingar/herwantre.bmp, 2020-05-09 06:20:29, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (27, 'uldtha.png', https://kiga.thhadasing.tr/is/easho/nd/hias.bmp, 2020-04-21 19:16:04, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (28, 'thethehades258.bmp', https://loqovo.wabut.hk/thieve/leerter.png, 2021-04-20 21:33:23, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (29, 'alnothier.jpg', http://ingto.es/hiwahad/at/enere/isere.png, 2021-04-30 11:05:02, '2021-05-25 01:24:02', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (30, 'vehenis.jpg', http://gikoli.noteatiand.hu/ionalsho/ter/ereanar/hadtedth.gif, 2021-01-12 20:13:46, '2021-01-31 09:45:27', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (31, 'buthisngar48.gif', https://yououl.ar/wasar/andtioeve/toereeveeve.png, 2020-01-01 00:00:24, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (32, 'hito9.gif', https://ndaresthi.kr/nging/onarethng.bmp, 2020-01-01 00:01:34, '2020-01-30 01:16:02', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (33, 'theforherwa710.jpg', http://nothadorare.at/asto/ionesea/edhaome/ngoul.jpg, 2020-01-01 00:00:04, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (34, 'meeninoul6.bmp', http://jegifu.isndentted.hk/leometo/andenting/tehad/thest.bmp, 2020-01-01 00:11:09, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (35, 'anntome.jpg', http://pevojo.theentourat.no/re/tedent/henthe/butentshoha.gif, 2020-01-01 02:46:03, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (36, 'neshoth.png', https://waeveneere.nl/edomeome/iontehad/aleraou.gif, 2020-01-01 00:04:22, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (37, 'witeve397.png', https://magiqe.asaswas.se/eraenttio/eshaome/thaonat/enwitre.gif, 2020-08-23 19:19:18, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (38, 'andonareha0.gif', https://metheater.cy/youto/letothe/or/alwasforit.jpg, 2020-01-01 00:00:02, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (39, 'andleare.bmp', http://mizipi.initndare.us/ted/steangtio.bmp, 2020-01-01 01:02:47, 'NULL', NULL, NULL, DEFAULT);
INSERT INTO `db`.`room` (`id`, `home_type`, `total_bedrooms`, `total_bathrooms`, `published_date`, `room_address_id`, `rules_id`, `login_details_id`) VALUES (40, 'thetomeal.png', http://siyiqu.erveed.fr/allthe/henevees/theareas/eveheninto.png, 2020-08-18 04:23:25, 'NULL', NULL, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`login`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (1, Wifi, 'http://nocanu.ishihisal.fi/allhatas/thaasered.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (2, Kitchen, 'http://yi.hisuldante.no/but/henes.gif', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (3, Washer, 'http://ernewaare.com/ingion/at/esth/ngleastha.gif', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (4, Dryer, 'https://gitu.ourhinthafor.fi/esandfor/alan/mestyou/hadandereth.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (5, Air conditioning, 'https://ereted.br/herwaan/teesented.gif', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (6, Heating, 'http://theeraforent.at/ith/inghiion/streme/eaforisver.jpg', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (7, Dedicated workspace, 'https://itngnottio.cz/althive/notourtha/setiit/teournt.gif', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (8, TV, 'http://neforereuld.se/te/is/ter/ourareforti.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (9, Hair dryer, 'http://erahieste.tr/uld/ted/teisin/thto.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (10, Iron, 'http://onstas.ge/le/inentwit/allandnt/hatananas.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (11, Pool, 'http://ateratar.gr/vear/needneat.jpg', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (12, Hot tub, 'http://ourallthent.br/ver/thenthe/wasthour/thiouerant.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (13, Free parking on premises, 'http://thimeouor.ae/ingntuld/tio/ngthetio/thit.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (14, EV charger, 'https://mengsho.net/terngat/andasher/alhiasat.png', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (15, Crib, 'http://bu.herandtohin.be/notioning/tiondin/se/forhinerou.jpg', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (16, Gym, 'https://nugaqe.arbutesuld.eg/oulre/eve/withinnt/nealleawas.png', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (17, BBQ grill, 'http://forhaha.net/ea/re/ve/sethinguld.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (18, Breakfast, 'http://pu.hiarouto.cy/arveome/butthere/herereith.png', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (19, Indoor fireplace, 'https://isitheveith.cy/asareon/her/ted/thiatentar.bmp', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (20, Smoking allowed, 'https://estedar.gr/toted/entarfor/notentte/atfortioent.png', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (21, Beachfront, 'http://lododi.youstwa.org/tioshoeve/hin/se/arthiwaswit.png', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (22, Waterfront, 'https://hathe.org/butionea/nden.png', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (23, Smoke alarm, 'https://bogaba.ittio.ca/and/notwahen/her/hisstveing.jpg', NULL, NULL, NULL, NULL, DEFAULT);
INSERT INTO `db`.`login` (`id`, `phone_number`, `create_data`, `last_login`, `account_status`, `account_verfied`, `login_details_id`, `room_address_id`) VALUES (24, Carbon monoxide alarm, 'http://annotti.cy/isne/atforfor.jpg', NULL, NULL, NULL, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`dependents`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (1, 94630, 607 New Meadowview Lane, Phoenix, AZ, 14419, 3.560036, 62.962605, '2020-01-01 00:00:04', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (2, 11450, 1052 Rock Hill Highway, Macy\'s Building, Oklahoma City, OK, 97484, -78.994095, 51.413802, '2020-02-24 09:06:53', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (3, 08242, 1842 Riddle Hill Highway, Victor Executive Bldg, Honolulu, HI, 04079, 73.466126, -2.536963, '2020-01-01 00:00:08', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (4, 34958, 1930 Red Meadowview Blvd, Carson City, NV, 06911, -12.013939, -45.455046, '2020-02-19 05:32:28', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (5, 76703, 1962 Flintwood Ct, Indianapolis, IN, 02402, -92.490181, 73.527017, '2020-06-16 03:44:22', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (6, 49273, 800 White Buttonwood Circle, Nashville, TN, 36627, 97.318999, -8.787260, '2020-07-24 13:24:51', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (7, 43735, 2945 Pine Tree Loop, Tallahassee, Florida, 88383, 20.882109, 7.823117, '2021-02-15 22:13:08', '2021-02-15 22:13:08');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (8, 77578, 2954 Riddle Hill Way, Buhl Building, Montpelier, VT, 53571, -35.525385, -3.613067, '2021-04-29 05:23:17', '2021-04-29 05:23:17');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (9, 43438, 2704 NE Hazelwood Street, Austin, Texas, 32133, -49.025410, 20.177537, '2020-10-06 08:48:11', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (10, 96139, 67 New Riverside Way, Austin, TX, 44471, 15.539568, 71.304542, '2021-09-05 06:22:56', '2021-09-05 06:22:56');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (11, 99399, 2819 Deepwood Ct, Sacramento, California, 23080, -6.819625, 80.219994, '2020-01-01 00:10:39', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (12, 74840, 889 SE Waterview Highway, Lincoln, NE, 35367, 62.435648, 43.121671, '2020-01-01 00:56:40', '2020-01-01 00:56:40');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (13, 53842, 147 3rd Way, Diamond Building, Dover, Delaware, 57720, 44.755662, -80.621457, '2020-08-05 19:38:12', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (14, 78879, 1112 New Church Blvd, 257 Towers Building, Harrisburg, PA, 36595, 61.331421, -71.086547, '2020-01-01 00:01:06', '2020-01-01 00:01:06');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (15, 87968, 660 1st Ln, 1st Floor, Baton Rouge, LA, 11677, 44.179971, 67.540539, '2020-01-01 00:06:55', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (16, 48619, 2729 E Chapel Hill St, Fisher Bldg, Des Moines, Iowa, 83516, 47.948797, -4.300155, '2021-09-04 22:37:48', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (17, 54770, 2005 W Burwood Lane, Salt Lake City, Utah, 15169, -4.882782, -62.832994, '2020-01-01 00:00:25', '2020-01-01 00:00:25');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (18, 93604, 823 3rd Cir, Guardian Bldg, Denver, CO, 29932, -1.362427, 32.616666, '2021-04-27 13:31:03', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (19, 07975, 41 Mount Highway, Keith Bldg, Dover, Delaware, 07107, 52.789417, -4.566965, '2021-06-18 01:09:27', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (20, 09304, 1884 New Parkwood Avenue, Albany, New York, 10785, -95.964874, -6.526117, '2020-01-01 00:57:34', '2020-01-01 00:57:34');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (21, 98944, 3556 Old Quailwood Lane, Fisher Bldg, Topeka, KS, 56925, 22.572304, 24.781534, '2020-01-01 02:09:09', '2020-01-01 02:09:09');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (22, 34891, 3163 Ski Hill Hwy, Augusta, ME, 33323, -38.376390, 77.980037, '2020-06-07 07:27:35', '2020-06-07 07:27:35');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (23, 50500, 2556 Sharp Hill Way, Lansing, Michigan, 62493, -72.741463, -33.885065, '2020-01-01 02:25:46', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (24, 70957, 2000 Prospect Hill Loop, Dover, Delaware, 51314, 72.998825, -66.850751, '2021-01-13 07:41:58', '2021-01-13 07:41:58');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (25, 20928, 3018 Pine Tree Way, Bartlett Bldg, Saint Paul, Minnesota, 90571, 49.455997, 89.167817, '2020-01-01 00:00:10', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (26, 64117, 3921 4th Rd, Olympia, Washington, 61250, -43.987792, 71.689028, '2021-06-07 00:26:51', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (27, 96600, 2357 3rd Drive, Duke Energy Bldg, Atlanta, GA, 20672, -77.421527, 40.716286, '2021-03-19 02:55:26', '2021-03-19 02:55:26');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (28, 24021, 3737 New Social Ct, 54th Floor, Helena, MT, 40189, 45.167304, 23.207610, '2021-09-06 03:34:56', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (29, 47090, 28 Highland Ln, Olympia, Washington, 30416, -8.911516, 66.324635, '2021-05-21 17:42:57', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (30, 65214, 652 Mount Court, Pierre, South Dakota, 27075, -1.911492, -53.726151, '2021-03-07 02:14:08', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (31, 81150, 2525 West Beachwood Loop, Calyon Bldg, Little Rock, Arkansas, 38566, -48.224892, 36.126240, '2020-01-01 00:00:04', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (32, 06633, 208 Ashwood Ct, STE 570, Springfield, Illinois, 28929, 53.212490, 65.848607, '2020-09-29 17:58:35', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (33, 20864, 3174 W Bayview Ct, Judge Bldg, Montgomery, Alabama, 73077, 87.252227, -62.980754, '2020-01-01 00:16:31', '2020-01-01 00:16:31');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (34, 78189, 32 Red Deepwood Lane, Raleigh, NC, 15026, 74.352639, -14.056781, '2020-01-20 10:30:32', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (35, 45434, 1376 White Mount Highway, Kearns Building, Montgomery, Alabama, 40761, -77.843730, -66.421180, '2020-06-27 04:36:04', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (36, 23342, 3351 N Flintwood Rd, Montpelier, VT, 10816, -15.608811, 56.370847, '2020-04-09 19:55:39', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (37, 42393, 38 NE Burwood Dr, Sacramento, CA, 39756, -60.145418, -40.442388, '2021-01-07 14:54:35', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (38, 32691, 3548 Parkwood Cir, Macy\'s Bldg, Olympia, WA, 78457, 36.444740, 1.275378, '2020-10-14 09:53:15', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (39, 13392, 57 Parkwood Loop, Standard Bldg, Helena, Montana, 48726, 11.648899, -10.914679, '2020-01-01 00:10:02', 'NULL');
INSERT INTO `db`.`dependents` (`id`, `spouse`, `children`, `infants`, `pets`, `created_at`, `last_updated`) VALUES (40, 18350, 2986 SW Chapel Hill Pkwy, Lincoln, Nebraska, 62401, -16.611782, 57.388719, '2020-01-01 01:59:55', 'NULL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`reservation`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (1, 'New Hampshire', 'NH', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (2, 'Maine', 'ME', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (3, 'Pennsylvania', 'PA', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (4, 'Connecticut', 'CT', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (5, 'Oregon', 'OR', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (6, 'Arkansas', 'AR', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (7, 'Alaska', 'AK', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (8, 'South Dakota', 'SD', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (9, 'Washington', 'AK', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (10, 'New York', 'WA', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (11, 'California', 'NY', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (12, 'Utah', 'CA', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (13, 'Delaware', 'UT', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (14, 'Florida', 'NY', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (15, 'Tennessee', 'ME', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (16, 'Montana', 'DE', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (17, 'Colorado', 'FL', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (18, 'Minnesota', 'TN', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (19, 'New Jersey', 'MT', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`reservation` (`id`, `reservation_type`, `booking_date`, `start_date`, `end_date`, `last_updated`, `room_id`, `payment_id`, `room_id1`, `payment_id1`) VALUES (20, 'Kansas', 'CO', NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (1, 'Eleva', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (2, 'Lonoke', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (3, 'Zuni', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (4, 'Porterville', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (5, 'Houma', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (6, 'Block Island', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (7, 'Lonsdale', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (8, 'Hackettstown', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (9, 'Coloma', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (10, 'Elfers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (11, 'Haddam', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (12, 'Blomkest', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (13, 'Elgin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (14, 'Colome', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (15, 'Haddon Heights', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (16, 'Newburg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (17, 'Porthill', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (18, 'Elida', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (19, 'Williams', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (20, 'Housatonic', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (21, 'Loogootee', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (22, 'Bloomdale', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (23, 'Suttons Bay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (24, 'Haddonfield', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (25, 'House Springs', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (26, 'Williams Bay', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (27, 'Colon', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (28, 'Newburgh', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (29, 'Lookeba', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (30, 'Bloomer', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (31, 'Houston', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (32, 'Eliot', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (33, 'Portland', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (34, 'Colonia', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (35, 'Bloomfield', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (36, 'Colonial Beach', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (37, 'Bloomfield Hills', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (38, 'Newbury', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (39, 'Portola', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
INSERT INTO `db`.`customers` (`id`, `last_name`, `gender`, `age`, `job_title`, `job_indsutry`, `dependents_id`, `address_id`, `staff_id`, `login_id`, `reservation_id`, `dependents_id1`, `staff_id1`, `reservation_id1`, `address_id1`, `login_id1`) VALUES (40, 'Colonial Heights', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`rules`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (1, Afghanistan, AFG, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (2, Luxembourg, LUX, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (3, Canada, CAN, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (4, Botswana, BWA, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (5, Guyana, LUX, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (6, Mongolia, GUY, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (7, Korea, MNG, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (8, Kuwait, KOR, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (9, Tunisia, KWT, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (10, Jordan, TUN, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (11, Guatemala, JOR, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (12, Singapore, GTM, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (13, Nicaragua, SGP, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (14, Denmark, NIC, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (15, Turkey, DNK, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (16, Cyprus, TUR, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (17, Iceland, CYP, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (18, Zambia, ISL, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (19, Namibia, ISL, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (20, Japan, ZMB, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (21, Switzerland, NAM, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (22, Cuba, JPN, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (23, Germany, CHE, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (24, France, DNK, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (25, Malaysia, CUB, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (26, Qatar, DEU, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (27, Spain, FRA, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (28, Bangladesh, GUY, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (29, New Zealand, MYS, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (30, Australia, QAT, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (31, Malawi, ESP, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (32, Poland, AFG, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (33, Belize, BGD, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (34, Saudi Arabia, NZL, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (35, United States, AUS, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (36, Finland, MWI, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (37, Czech Republic, POL, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (38, Albania, BLZ, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (39, Mexico, SAU, DEFAULT);
INSERT INTO `db`.`rules` (`id`, `pets`, `smoking`, `room_id`) VALUES (40, Lithuania, POL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`entertainment`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (1, Latin, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (2, Finnish, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (3, Chamorro, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (4, Belarusian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (5, Kikuyu, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (6, Lithuanian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (7, Corsican, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (8, Inupiaq, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (9, Azerbaijani, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (10, Gujarati, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (11, Albanian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (12, Kanuri, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (13, Kyrgyz, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (14, Ossetian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (15, Oriya, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (16, Estonian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (17, Turkish, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (18, Nepali, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (19, Breton, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (20, Chuvash, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (21, Marshallese, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (22, Panjabi, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (23, Aragonese, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (24, Herero, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (25, Nauru, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (26, Afrikaans, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (27, Ewe, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (28, Hiri Motu, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (29, Marathi, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (30, Guarani, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (31, Ojibwa, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (32, Samoan, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (33, English, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (34, Arabic, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (35, Shona, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (36, Persian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (37, Croatian, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (38, Afar, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (39, Romansh, NULL, NULL, NULL, NULL);
INSERT INTO `db`.`entertainment` (`id`, `tv`, `sound_system`, `projector`, `water_front`, `beach_front`) VALUES (40, Sardinian, NULL, NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `db`.`facilities`
-- -----------------------------------------------------
START TRANSACTION;
USE `db`;
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (1, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (2, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (3, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (4, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (5, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (6, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (7, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (8, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (9, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (10, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (13, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (14, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (15, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (16, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (17, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (18, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (19, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (20, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (21, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (22, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (23, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (24, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (25, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (26, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (27, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (28, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (29, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (30, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (31, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (32, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (33, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (34, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (35, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (36, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (37, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (38, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (39, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (40, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (41, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (42, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (43, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (44, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (45, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (46, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (47, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (48, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (49, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);
INSERT INTO `db`.`facilities` (`id`, `hot_tub`, `EV_charger`, `pool`, `gym`, `free_parking`, `entertainment_id`, `amenities_id`, `entertainment_id1`) VALUES (50, NULL, NULL, NULL, NULL, NULL, NULL, DEFAULT, DEFAULT);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
