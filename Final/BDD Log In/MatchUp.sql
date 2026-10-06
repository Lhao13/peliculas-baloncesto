drop database if exists matchup;
create database matchup;

drop schema if exists matchup;
create schema matchup;

use matchup;
drop table if exists persona;
create table persona(
persona_id int auto_increment primary key,
primer_nombre varchar(50) not null,
segundo_nombre varchar(50),
primer_apellido varchar(50) not null,
segundo_apellido varchar(50),
birth_country varchar(50),
birth_province varchar(50),
birth_city varchar(50),
birthday date not null,
genero tinyint(1) not null,
estatura int(3),
peso int(3),
telefono varchar(10),
correo varchar(50) not null,
posicion_principal varchar(50),
posicion_secundaria varchar(50),
arbitro tinyint(1),
profile_pic blob,
contrasena varchar(50) not null,
preferencia int(1) not null
);

drop table if exists equipo;
create table equipo(
equipo_id int auto_increment primary key,
nombre varchar(50) not null,
logo blob not null,
color_local varchar(15) not null,
color_visitante varchar (15) not null,
dueno int not null,
constraint fk_person foreign key (dueno)  references persona(persona_id)

);

drop table if exists entrenamiento;
create table entrenamiento(
    entrenamiento_id  int auto_increment primary key,
    equipo_id INT,
    fecha datetime,
    lugar VARCHAR(100),
    constraint fk_equipo foreign key (equipo_id)  references equipo(equipo_id)

);

drop table if exists Asiste;
CREATE TABLE Asiste (
    persona_id INT,
    entrenamiento_id INT,
    FOREIGN KEY (persona_id) REFERENCES Persona(persona_id),
    FOREIGN KEY (entrenamiento_id) REFERENCES Entrenamiento(entrenamiento_id),
    PRIMARY KEY (persona_id, entrenamiento_id)
);

drop table if exists categoria;
create table categoria(
categoria_id int auto_increment primary key,
nombre varchar(50) not null,
genero varchar(1),
edad int(3)
);

drop table if exists torneo;
create table torneo(
torneo_id int auto_increment primary key,
nombre varchar(100) not null,
lugar varchar(200) not null,
fecha_inicio date not null,
fecha_fin date not null,
descripcion varchar(500),
precio int(6) not null,
premio int(6) not null,
equipos_permitidos int(4) not null,
max_jugadores_permitidos int(3) not null,
min_jugadores_permitidos int(3) not null,
private tinyint(1) not null,
logo blob not null,
categoria int not null,
creador int not null,
constraint fk_categoria foreign key (categoria)  references categoria(categoria_id),
constraint fk_persona foreign key (creador)  references persona(persona_id)
);

drop table if exists partido;
create table partido(
partido_id int auto_increment primary key,
secuencial_partido int(5) not null,
secuencial_ronda int(5) not null,
equipo_local int not null,
equipo_visitante int not null,
marcador_local int(3) not null,
marcador_visitante int(3) not null,
fecha_de_juego datetime not null,
torneo int not null,
arbitro int,
constraint fk_torneo foreign key (torneo)  references torneo(torneo_id),
constraint fk_arbitro foreign key (arbitro) references persona(persona_id),
constraint fk_local foreign key (equipo_local) references equipo(equipo_id),
constraint fk_visitante foreign key (equipo_visitante) references equipo(equipo_id)
);

drop table if exists equipo_persona;
create table equipo_persona(
equipo int not null,
persona int not null,
primary key(equipo,persona),
constraint fk_equipo_persona foreign key (equipo)  references equipo(equipo_id),
constraint fk_persona_equipo foreign key (persona)  references persona(persona_id)
);

drop table if exists torneo_equipo;
create table torneo_equipo(
torneo int not null,
equipo int not null,
primary key(torneo,equipo),
constraint fk_torneo_equipo foreign key (torneo)  references torneo(torneo_id),
constraint fk_equipo_torneo foreign key (equipo)  references equipo(equipo_id)
);


DELIMITER //

CREATE PROCEDURE CheckEmailFormat(IN email VARCHAR(50), OUT isValid BOOLEAN)
BEGIN
    DECLARE atCount INT;
    
    SET atCount = (SELECT LENGTH(email) - LENGTH(REPLACE(email, '@', '')));
    
    IF atCount = 1 THEN
        SET isValid = TRUE;
    ELSE
        SET isValid = FALSE;
    END IF;
END //
DELIMITER //

CREATE PROCEDURE InsertPlayer(
    IN p_primer_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_birthday DATE,
    IN p_genero TINYINT,
    IN p_correo VARCHAR(50),
    IN p_contrasena VARCHAR(50),
    IN p_preferencia INT(1),
    OUT player_id INT
)
BEGIN
    DECLARE emailCount INT;
    DECLARE isUnique BOOLEAN;
    
    -- Check if email has correct format
    CALL CheckEmailFormat(p_correo, isUnique);
    
    IF isUnique THEN
        -- Check if email is unique
        SELECT COUNT(*) INTO emailCount FROM persona WHERE correo = p_correo;
        IF emailCount > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
        END IF;
        
        -- Insert player
        INSERT INTO persona (
            primer_nombre, primer_apellido, birthday, genero,
            correo, contrasena, preferencia
        ) VALUES (
            p_primer_nombre, p_primer_apellido, p_birthday, p_genero,
            p_correo, p_contrasena, p_preferencia
        );

        -- Get player ID of the newly inserted player
        SET player_id = LAST_INSERT_ID();
    ELSE  
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email format is incorrect';
    END IF;
END //


DELIMITER //

CREATE TRIGGER crear_persona
BEFORE INSERT ON persona
FOR EACH ROW
BEGIN
    DECLARE emailCount INT;
    DECLARE isUnique BOOLEAN;

    -- Check if email has correct format
    CALL CheckEmailFormat(NEW.correo, isUnique);

    IF isUnique THEN
        -- Check if email is unique
        SELECT COUNT(*) INTO emailCount FROM persona WHERE correo = NEW.correo;
        IF emailCount > 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email already exists';
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email format is incorrect';
    END IF;
END //

DELIMITER //




