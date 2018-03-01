CREATE TABLE `sakila`.`LOG_FILM` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '',
  `tipo` VARCHAR(45) NULL COMMENT '',
  `film_id` INT NULL COMMENT '',
  `last_value` VARCHAR(1000) NULL COMMENT '',
  `new_value` VARCHAR(1000) NULL COMMENT '',
  `timestamp` DATETIME NULL COMMENT '',
  PRIMARY KEY (`id`)  COMMENT '');
  
  
USE `sakila`;
DROP procedure IF EXISTS `insLogFilm`;

DELIMITER $$
USE `sakila`$$
CREATE PROCEDURE `insLogFilm` (
                 IN enTipo VARCHAR(45),
                               IN enFilm_id INT,
                               IN enLast_value VARCHAR(1000),
                               IN enNew_value VARCHAR(1000))
BEGIN

INSERT INTO LOG_FILM (tipo, film_id, last_value, new_value, timestamp) values (enTipo,enFilm_id,enLast_value,enNew_value,CURDATE());

END


$$

DELIMITER ;


CREATE TRIGGER saveLog BEFORE UPDATE ON film
  FOR EACH ROW 
    CALL insLogFilm("update",NEW.film_id,
        concat(OLD.film_id, " ",
        OLD.title, " ",
        OLD.description,
        " ", OLD.release_year,
        " ", OLD.language_id,
        " ", OLD.original_language_id,
        " ", OLD.rental_duration,
        " ", OLD.rental_rate,
        " ", OLD.length, " ",
        OLD.replacement_cost,
        " ", OLD.rating,
        " ", OLD.special_features),concat(NEW.film_id, " ",
        NEW.title, " ",
        NEW.description,
        " ", NEW.release_year,
        " ", NEW.language_id,
        " ", NEW.original_language_id,
        " ", NEW.rental_duration,
        " ", NEW.rental_rate,
        " ", NEW.length, " ",
        NEW.replacement_cost,
        " ", NEW.rating,
        " ", NEW.special_features));
        
        
ALTER TABLE `sakila`.`film` 
ADD COLUMN `original_language` VARCHAR(45) NULL COMMENT '' AFTER `last_update`;

USE `sakila`;
DROP procedure IF EXISTS `changeLanguage`;

DELIMITER $$
USE `sakila`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `changeLanguage`()
BEGIN

  DECLARE done INT DEFAULT FALSE;
  DECLARE a,b,d INT;
  DECLARE c, e VARCHAR(45);
  DECLARE cur1 CURSOR FOR SELECT b.film_id, c.category_id, e.name, a.actor_id, concat(d.first_name, " ", d.last_name) as 'actor_name'
FROM film_actor a, film b, film_category c, actor d, category e
WHERE a.film_id = b.film_id
AND b.film_id = c.film_id
AND a.actor_id = d.actor_id
AND c.category_id = e.category_id
ORDER BY b.film_id;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1; 

  read_loop: LOOP
    FETCH cur1 INTO a, b, c, d, e;
    
    IF done THEN
      LEAVE read_loop;
    END IF;
UPDATE film 
SET 
    original_language = 'Ingles'
WHERE
    film_id = a;
    IF c = "Documentary" THEN
    UPDATE film SET original_language = "Italiano" WHERE film_id = a;
  END IF;
    
    IF c = "Foreign" THEN
    UPDATE film SET original_language = "Japones" WHERE film_id = a;
  END IF;
    
    IF e = "SISSI SOBIESKI" THEN
    UPDATE film SET original_language = "Aleman" WHERE film_id = a;
  END IF;
    
    IF e = "ED CHASE" THEN
    UPDATE film SET original_language = "Mandarin" WHERE film_id = a;
  END IF;
    
    IF e = "AUDREY OLIVIER" THEN
    UPDATE film SET original_language = "Frances" WHERE film_id = a;
  END IF; 
        
  END LOOP;

  CLOSE cur1;

END$$

DELIMITER ;


CREATE TABLE gomitas (
  ID INT NOT NULL,
  NOMBRE VARCHAR(45) NOT NULL,
  PRECIO VARCHAR(45) NULL,
  INICIO DATE NOT NULL,
  FIN DATE NOT NULL,
  period business_time(INICIO,FIN),
  PRIMARY KEY (ID, business_time WITHOUT overlaps));

  INSERT INTO gomitas ( NOMBRE, PRECIO, INICIO, FIN) values
  ('panditas',5 ,'1-1-2018', '1-1-2019'),
  ('gummyworms',10 ,'1-1-2018', '1-1-2019'),
  ('gomitascocacola',15 ,'1-1-2018', '1-1-2019'),
  ('manguitos',20 ,'1-1-2018', '1-1-2019'),
  ('gummywormsacidas',25 ,'1-1-2018', '1-1-2019'),
  ('lifesavers',30 ,'1-1-2018', '1-1-2019'),
  ('lifesaversberries',30 ,'1-1-2018', '1-1-2019'),
  ('dulcigomas',25 ,'1-1-2018', '1-1-2019'),
  ('dientes',20 ,'1-1-2018', '1-1-2019'),
  ('haribo',15 ,'1-1-2018', '1-1-2019'),
  ('sourpatch',10 ,'1-1-2018', '1-1-2019'),
  ('piñas',5 ,'1-1-2018', '1-1-2019');


  UPDATE gomitas FOR portion of business_time FROM '1-2-1018' to '15-2-2018' SET precio = precio*1.45;
  UPDATE gomitas FOR portion of business_time FROM '15-2-2018' to '25-05-2018' SET precio = (precio/1.45)*1.1;
  UPDATE gomitas FOR portion of business_time FROM '25-04-2018' to '5-5-21018' SET precio = precio*1.45;
  UPDATE gomitas FOR portion of business_time FROM '5-5-2018' to '25-10-2018' SET precio = (precio/1.45)*1.1;
  UPDATE gomitas FOR portion of business_time FROM '25-10-2018' to '5-11-2018' SET precio = precio*1.45;
  UPDATE gomitas FOR portion of business_time FROM '5-11-2018' to '1-1-2019' SET precio = (precio/1.45)*1.1;

  SELECT * from gomita WHERE NOMBRE='panditas';

  SELECT SUM(precio)/COUNT(*) as promedio from gomita WHERE NOMBRE='gummyworms';

  SELECT MAX(precio) as MAX from gomita WHERE NOMBRE='panditas';

  SELECT MIN(precio) as MIN from gomita WHERE NOMBRE='panditas';
