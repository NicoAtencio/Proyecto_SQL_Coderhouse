use fabrica;

DELIMITER $$
CREATE FUNCTION recaudado_por_vendedor(id INT) RETURNS INT
READS SQL DATA
BEGIN
	DECLARE recaudado_vendedor INT;
	SELECT re.recaudado INTO recaudado_vendedor 
    FROM empleados e
    INNER JOIN recaudado_vendedores re ON re.nombre = e.nombre AND re.apellido = e.apellido
    -- recaudado_vendedores no es una tabla, es una vista.
    WHERE id_empleado = id;
    RETURN recaudado_vendedor;
END $$
-- A la función se le pasa como parametro el id del empleado y retorna la cantidad de dinero que ha 
-- sido recaudado por sus ventas, para ello se utilizo dentro de la función la vista recaudado_vendedores
-- con el fin de no tener que repetir dos veces la misma lógica y juntar la mayor cantidad de conceptos.

SELECT id_empleado,nombre,apellido,recaudado_por_vendedor(id_empleado) AS recaudado
FROM empleados
WHERE id_sector=1;
-- Los empleados con id_sector=1 pertenecen al departamento de ventas.
-- Esta consulta debe devolver los nombres , el id y lo recaudado de cada vendedor.

DELIMITER $$
CREATE FUNCTION sector_del_empleado(id INT) RETURNS VARCHAR(50)
READS SQL DATA
BEGIN
    DECLARE nombre_sector VARCHAR(50);
    SELECT sector.nombre INTO nombre_sector
    FROM empleados
    INNER JOIN sector on sector.id_sector = empleados.id_sector
    WHERE id_empleado = id;
    RETURN nombre_sector;
END$$
-- La función recive como parametro el id de un empleado y devuelve el nombre del sector en el que 
-- desarrolla su actividad.

select id_empleado, CONCAT(nombre,' ',apellido) AS nombre,sector_del_empleado(id_empleado) AS sector
FROM empleados;
-- Este es un listado de todos los empleados y el sector donde se encuentra pero un mejor uso
-- de la función es saber a que sector pertenece un empleado o un grupo empleados en particular.


