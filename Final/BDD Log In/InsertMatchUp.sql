use matchup;

insert into persona(primer_nombre,primer_apellido,birthday,genero,correo,contrasena,preferencia)
values
("Fabian","De La Cruz","2001-05-04",0,"fdelacruz@estud.usfq.edu.ec","Torneo123!",2),
("Mathias","Granizo","2005-07-01",False,"mgranizo@estud.usfq.edu.ec","Kiara123!",5),
("Esteban","Espin","2005-06-13",FALSE,"eespin@estud.usfq.edu.ec","Mono123!",3),
("Roberth","Lara","2003-08-23",false,"rlara@estud.usfq.edu.ec","Tito123!",1),
("Matias","Reyes","2003-09-21",false,"mreyes@estud.usfq.edu.ec","Triple123!",2),
("Josue","Ponce","2002-06-01",false,"jponce@estud.usfq.edu.ec","Rojo123!",4),
("Sebastian","Granizo","2001-09-11",false,"sgranizo@estud.usfq.edu.ec","Cuyes123!",5),
("Aaron","Vaca","2003-08-07",false,"avaca@estud.usfq.edu.ec","Santo123!",4),
("Mateo","Carrion","2002-04-19",false,"mcarrion@estud.usfq.edu.ec","Rubia123!",4)
;

update persona
set arbitro = '1'
where persona_id = 1;

update persona
set arbitro = '1'
where persona_id = 5;

update persona
set arbitro = '1'
where persona_id = 7;

insert into equipo(nombre,logo,color_local,color_visitante,dueno)
values
("BOL BOL", "LOGO","Rojo","Blanco",1),
("Momentum","LOGO","Blanco","Negro",6),
("Panda","LOGO","Negro","Blanco",7)
;

insert into entrenamiento(equipo_id,fecha,lugar)
values
(1,"2024-05-20 10:00:00", "Cancha de la USFQ");


insert into asiste
values
(1,1),
(3,1);

insert into equipo_persona values
(1,1),
(1,2),
(1,3),
(2,4),
(2,5),
(2,6),
(3,7),
(3,8),
(3,9)
;

insert into categoria (nombre) values
("Abierto")
;

insert into torneo(nombre,lugar,fecha_inicio,fecha_fin,descripcion,precio,premio,equipos_permitidos,
max_jugadores_permitidos,min_jugadores_permitidos,private,logo,categoria,creador)
values
("Baloncesto USFQ","https://maps.app.goo.gl/d3xbeEAVwSATmgVu7","2024-03-29","2024-04-12",
"El torneo se llevara acabo en la cancha de baloncesto de USFQ. Es unicamente para estudiantes
de la USFQ. Se tendra que presentar carnet para jugar",36,72,3,5,3,0,"LOGO",1,1);

insert into torneo_equipo values
(1,1),
(1,2),
(1,3)
;

insert into partido(secuencial_partido,secuencial_ronda ,equipo_local ,
equipo_visitante,marcador_local ,marcador_visitante ,fecha_de_juego ,torneo ,arbitro) 
values
(1,1,1,2,79,80,"2024-3-29 14:00:00",1,7),
(2,1,1,3,113,23,"2024-4-5 14:00:00",1,5),
(3,1,2,3,97,29,"2024-4-12 14:00:00",1,1)
;

select distinct torneo.nombre as Torneo, equipo.nombre as Equipos
from equipo, torneo, torneo_equipo as te
where te.equipo=equipo_id
and te.torneo=torneo_id;



select equipo.nombre as Equipo, CONCAT(persona.primer_nombre, ' ',persona.primer_apellido) as Jugador
from equipo_persona, persona, equipo, torneo
where equipo_persona.equipo = equipo_id
and equipo_persona.persona = persona.persona_id;

select distinct CONCAT(persona.primer_nombre, ' ',persona.primer_apellido) as Arbitro, 
CONCAT(home.nombre, " ", partido.marcador_local, " ", partido.marcador_visitante, " ",away.nombre)
 as Marcador
from persona, equipo as home, partido,equipo as away
where partido.equipo_local = home.equipo_id
and partido.equipo_visitante = away.equipo_id
and persona.persona_id=partido.arbitro;

select persona_id as ID, primer_nombre as Nombre, primer_apellido as Apellido, 
birthday as "Fecha de nacimiento", correo as Correo, contrasena as "Contraseña"
from persona;

select p.persona_id as ID, primer_nombre as Nombre, primer_apellido as Apellido, e.nombre as "Equipo",
fecha as "Fecha"
from persona as p, asiste as a, equipo as e, equipo_persona as ep,entrenamiento as en
where p.persona_id = a.persona_id
and ep.equipo = e.equipo_id
and ep.persona = p.persona_id
and en.entrenamiento_id = a.entrenamiento_id;

select fecha as "Fecha", lugar as "Lugar"
from equipo as e, entrenamiento as en, persona as p,equipo_persona as ep
where en.equipo_id = 1
;
select e.equipo_id as "Equipo"
from equipo as e, persona as p, equipo_persona as ep
where e.equipo_id = ep.equipo
and p.persona_id = ep.persona
and p.correo = "fdelacruz@estud.usfq.edu.ec"
;

select e.nombre as "Equipo"
from equipo as e, persona as p, equipo_persona as ep
where e.equipo_id = ep.equipo
and p.persona_id = ep.persona
and p.correo = "fdelacruz@estud.usfq.edu.ec"
;

SELECT en.fecha AS "Fecha", en.lugar AS "Lugar"
FROM entrenamiento AS en
INNER JOIN equipo AS e ON en.equipo_id = e.equipo_id
WHERE en.equipo_id = 1;
