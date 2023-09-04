USE mysql;

CREATE USER soloLectura@localhost IDENTIFIED BY 'solo_Lectura1';
GRANT SELECT ON fabrica_de_pastas.* TO soloLectura@localhost;
-- Se creó un usuario y se le dio permisos para poder visualizar el SCHEMA fabrica_de_pastas.

CREATE USER editor@localhost IDENTIFIED BY 'mucho_Acceso2';
GRANT SELECT,UPDATE,INSERT ON fabrica_de_pastas.* TO editor@localhost;
-- Se creó un usuario y se le dio permiso para lectura, modificación e inserción de datos
-- en todas las tablas del SCHEMA fabrica_de_pastas .


SELECT * FROM user 
WHERE user.User = 'editor' OR user.User = 'soloLectura';

SHOW GRANTS FOR soloLectura@localhost;
SHOW GRANTS FOR editor@localhost



