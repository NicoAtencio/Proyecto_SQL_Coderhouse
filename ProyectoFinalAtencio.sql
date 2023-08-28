CREATE SCHEMA fabrica_de_pastas;
USE fabrica_de_pastas;


-- CREACION DE TABLAS

CREATE TABLE `sector` (
  `id_sector` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (`id_sector`)
);

CREATE TABLE `empleados` (
  `id_empleado` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL UNIQUE,
  `id_sector` int NOT NULL,
  PRIMARY KEY (`id_empleado`),
  FOREIGN KEY (`id_sector`) REFERENCES `sector` (`id_sector`)
);

CREATE TABLE `productos` (
  `id_producto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL UNIQUE,
  `precio` int NOT NULL,
  PRIMARY KEY (`id_producto`)
);

CREATE TABLE `proveedores` (
  `id_proveedor` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`)
);

CREATE TABLE `materias_prima` (
  `id_materia` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `id_proveedor` int DEFAULT NULL,
  `precio` int NOT NULL,
  PRIMARY KEY (`id_materia`),
  FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`)
);

CREATE TABLE `recetas` (
  `id_producto` int NOT NULL,
  `id_materia` int NOT NULL,
  `cantidad_materia_gr` int NOT NULL,
  FOREIGN KEY (`id_materia`) REFERENCES `materias_prima` (`id_materia`),
  FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
);

CREATE TABLE `realizacion_empleados` (
  `id_producto` int NOT NULL,
  `id_empleado` int NOT NULL,
  FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`),
  FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
);

CREATE TABLE `empresas_envio` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(20) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
);

CREATE TABLE `provincias` (
  `id_provincia` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL UNIQUE,
  PRIMARY KEY (`id_provincia`)
);

CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(50) NOT NULL UNIQUE,
  `id_provincia` int NOT NULL,
  PRIMARY KEY (`id_cliente`),
  FOREIGN KEY (`id_provincia`) REFERENCES `provincias` (`id_provincia`)
);

CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `id_empleado` int NOT NULL,
  `id_empresa_envio` int NOT NULL,
  PRIMARY KEY (`id_pedido`),
  FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`),
  FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id_empleado`),
  FOREIGN KEY (`id_empresa_envio`) REFERENCES `empresas_envio` (`id`)
);

CREATE TABLE `detalles_pedido` (
  `id_producto` int NOT NULL,
  `id_pedido` int NOT NULL,
  `cantidad` int NOT NULL,
  FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id_producto`)
);

CREATE TABLE `_registro_pedido`(
	id_log INT PRIMARY KEY auto_increment,
    operacion VARCHAR(100),
	usuario VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL
);
-- La creacion de esta tabla es para almacenar que usuario, cuando  y a que hora registro un nuevo pedido.

-- INSERCION DE DATOS

INSERT INTO sector(nombre)
VALUES('Ventas'),('Contabilidad'),('Mantenimiento'),('Produccion'),('Recursos humanos');

INSERT INTO empleados(nombre,apellido,telefono,id_sector)
VALUES('Fields','Sapson', '899-871-5137', 1),('Franni','Stopforth', '912-581-0646',5),
('Lucas','Aindriu','366-841-3712',1),('Gregorio','Keyzman','135-721-2557',4),('Fran','Godar','823-146-4294',4);

INSERT INTO productos(nombre,precio)
VALUES('Fideos', 300),('Fideos de morron', 350),('ñoquis', 320),('ravioles espinaca', 450),('ravioles jamon y queso', 500);

INSERT INTO proveedores(Nombre)
VALUES('NASDAQ'),('NYSE'),('SATSDEL');

INSERT INTO materias_prima(nombre,id_proveedor,precio)
VALUES('Huevo por Kg',1,200),('Harina por Kg',2, 15),('Jamon por Kg',2,70),('Queso por Kg',2, 40),('Morron por kg',3, 30),('Papa',3,5),('Espinaca',3,10);

INSERT INTO recetas
VALUES(1,1,530),(1,2,1500),(2,1,350),(2,2,1500),(2,5,500),(3,2,1000),(3,6,500),(4,1,100),(4,2,1000),
(4,7,250),(5,1,100),(5,2,1000),(5,3,500),(5,4,500);

INSERT INTO realizacion_empleados
VALUES(1,4),(2,4),(3,5),(4,4),(4,5),(5,4),(5,5);

INSERT INTO empresas_envio(nombre,telefono)
VALUES('SWIN', '795-772-2055'),('LAYN','675-488-8623'),('SHOS','530-424-1223'),('FOLD','283-591-8652');

INSERT INTO provincias(nombre)
VALUES('Mendoza'),('Buenos Aires'),('San Juan'),('San Luis'),('Cordoba'),('Santa Fe'),('Entre Rios'),
('Corrientes'),('Misiones'),('Chaco'),('Formosa'),('Santiago del Estero'),('Tucuman'),('Salta'),
('Jujuy'),('Catamarca'),('La Rioja'),('Neuquen'),('La Pampa'),('Rio Negro'),('Chubut'),
('Tierra del fuego'),('Santa Cruz');


INSERT INTO clientes(nombre,telefono,id_provincia)
VALUES ('Michael Kors Holdings Limited','425-216-7005',1 ),('BB&T Corporation','305-882-0707',3),
('BB&T Corporation','219-163-2397',2),('Interactive Brokers Group, Inc.','183-688-0844',4),
('TerraForm Global, Inc.','601-773-6592',1);

INSERT INTO pedidos(id_cliente,id_empleado,id_empresa_envio)
VALUES (1,3,1),(2,3,1),(1,1,1),(3,3,2),(5,3,1);

INSERT INTO detalles_pedido
VALUES(1,1,50), (2,1,100),(5,1,70),(1,2,90),(4,2,40),(2,3,28),(4,4,80),(5,4,100),(1,5,120),(2,5,40);

-- CREACION DE VISTAS

CREATE OR REPLACE VIEW recaudado_vendedores AS
	(SELECT em.nombre,em.apellido,SUM(pr.precio * de.cantidad) as recaudado
    FROM empleados em
    INNER JOIN pedidos pe ON (pe.id_empleado = em.id_empleado)
    INNER JOIN detalles_pedido de ON (de.id_pedido = pe.id_pedido)
    INNER JOIN productos pr ON (pr.id_producto = de.id_producto)
    GROUP BY em.id_empleado
    );
-- El proposito de la vista es saber cuanto dinero recauda cada vendedor.

CREATE OR REPLACE VIEW provincia_ventas AS 
	(SELECT p.nombre, COUNT(DISTINCT pe.id_pedido) as ventas_provincia
    FROM provincias p
    INNER JOIN clientes c ON (c.id_provincia = p.id_provincia)
    INNER JOIN pedidos pe ON (pe.id_cliente = c.id_cliente)
    GROUP BY p.id_provincia
    );
  -- El propósito de la vista es saber cuantas ventas se realizan por provincia.
  
  CREATE OR REPLACE VIEW cantidad_productos_vendidos AS
	(
	SELECT p.id_producto,p.nombre,SUM(d.cantidad) as cantidad_vendidos
    FROM productos p
    INNER JOIN detalles_pedido d ON(d.id_producto = p.id_producto)
    GROUP BY p.id_producto
    );
-- El propósito de la vista es saber la cantidad de cada producto que se ha vendido.

CREATE OR REPLACE VIEW recaudado_por_producto AS
	(
	SELECT p.id_producto,p.nombre,SUM(d.cantidad*p.precio) as recaudado
    FROM productos p
    INNER JOIN detalles_pedido d ON(d.id_producto = p.id_producto)
    GROUP BY p.id_producto
    );
-- El propósito de la vista es ver cuanto a recaudado cada producto

CREATE OR REPLACE VIEW gastos_por_producto AS
 (
	SELECT p.id_producto, p.nombre, SUM(d.cantidad*((r.cantidad_materia_gr*m.precio)/1000)) as gastos
    FROM productos p
    INNER JOIN detalles_pedido d ON(d.id_producto = p.id_producto)
    INNER JOIN recetas r ON (r.id_producto = p.id_producto)
    INNER JOIN materias_prima m ON (m.id_materia = r.id_materia)
    GROUP BY p.id_producto
);
-- El propósito de la vista es saber cuanto a costado la venta de los productos.

CREATE OR REPLACE VIEW beneficio_neto_venta_producto AS
	(
		SELECT re.id_producto,re.nombre,re.recaudado - ga.gastos as ingreso_neto
        FROM recaudado_por_producto re
        INNER JOIN gastos_por_producto ga ON (re.id_producto = ga.id_producto)
        -- gastos_por_producto no es una tabla, es una vista creada con anterioridad
    );
-- El propósito de la vista el obtener el "ingreso neto" por las ventas de los productos,
-- sin contar con el sueldo, mantenimiento, gastos de envio, impuestos y demas gastos.   


-- CREACION DE FUNCIONES

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


-- CREACION STORED PROCEDURES

DELIMITER $$
CREATE PROCEDURE `nuevo_empleado` (
	IN nombre_e VARCHAR(50),
    IN apellido_e VARCHAR(50),
    IN telefono_e VARCHAR(20),
    IN id_sector_e INT
)
BEGIN
	INSERT INTO empleados(nombre,apellido,telefono,id_sector)
    values (nombre_e,apellido_e,telefono_e,id_sector_e);
END$$
-- El proposito es agregar a un nuevo empleado a travez de un stored procedures.

DELIMITER $$
CREATE PROCEDURE `nuevo_pedido_mas_detalle`(
IN id_cliente_env INT,
IN id_empleado_env INT,
IN id_empresa_env INT,
IN productos_ids TEXT,
IN cantidades TEXT)
BEGIN
    DECLARE pedido_id INT;
    DECLARE i INT DEFAULT 1;
    DECLARE producto_id INT;
    DECLARE cantidad_producto INT;
	
    INSERT INTO pedidos(id_cliente,id_empleado,id_empresa_envio)
	VALUES(id_cliente_env,id_empleado_env,id_empresa_env);
    
    SELECT MAX(id_pedido) INTO pedido_id
    FROM pedidos;
    
    WHILE i <= LENGTH(REPLACE(productos_ids,',','')) DO
    -- Esto da como resultado la cantidad de id_productos pasados como parametro sin contar la co.
    SET producto_id = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(productos_ids,',',i),',',-1) AS SIGNED);
    SET cantidad_producto = CAST(SUBSTRING_INDEX((SUBSTRING_INDEX(cantidades,',',i)),',',-1) AS SIGNED);
    -- En ambos casos obtengo el numero de la posicion i del texto donde los numeros estan
    -- separados por coma y lo convierto a un INT.
    
    INSERT INTO detalles_pedido(id_producto,id_pedido,cantidad)
    VALUES(producto_id,pedido_id,cantidad_producto);
    
    SET i = i + 1;
    END WHILE;
END$$
-- El objetivo es agregar datos en dos tablas, la tabla pedidos y la tabla detalles_pedido, para ello se pasa como
-- parametro al stored nuevo_pedido_mas_detalle el id del cliente, el id del empleado a cargo de la venta, el id de
-- la empresa encargada del envio, todos los id de los productos para el detalle de ventas en formato de texto separados
-- por una coma y sin espacios, y lo mismo con el parametro donde pasamos la cantidad de cada producto tambien en forma
-- de texto separado por coma y sin espacios. Lo primero que hace es insertar en la tabla pedidos los tres primeros
-- parametro, luego obtiene el id del pedido realizado y finalmente a travez de un bucle inserta el id del pedido y
-- los ultimos dos parametros en la tabla detalles_pedido. Al final se llama a stored para ver su funcionamiento.


-- CREACION TRIGGERS



DELIMITER $$
CREATE TRIGGER trigger_registrar_pedido
AFTER INSERT ON pedidos
FOR EACH ROW
BEGIN
	INSERT INTO _registro_pedido(operacion,usuario,fecha,hora)
    VALUES ('Insercion pedido',USER(),CURDATE(),CURTIME());
END $$
-- Lo que hace el trigger es cuando un usuario registra un nuevo pedido automaticamente en la tabla registro_pedido
-- se insertan el tipo de operación, el uusario, la fecha y la hora en la que registra el pedido.


DELIMITER $$
CREATE TRIGGER trigger_revizar_cantidad_producto
BEFORE INSERT ON detalles_pedido
FOR EACH ROW
BEGIN
	IF NEW.cantidad <= 0 OR NEW.cantidad IS NULL THEN
		SET NEW.cantidad = 50;
	END IF;
END $$
-- Lo que hace este trigger es en caso de que al agregar una nueva fila en detalles_pedidos si no le ingresan
-- una cantidad de producto o ingresa un valor negativo se le asigne 50 a la cantidad.


-- PRUEBAS VISTAS
SELECT * FROM recaudado_vendedores;
SELECT * FROM provincia_ventas;
SELECT * FROM cantidad_productos_vendidos;
SELECT * FROM recaudado_por_producto;
SELECT * FROM gastos_por_producto;
SELECT * FROM beneficio_neto_venta_producto;

-- PRUEBAS FUNCIONES
SELECT id_empleado,nombre,apellido,recaudado_por_vendedor(id_empleado) AS recaudado
FROM empleados
WHERE id_sector=1;
-- Los empleados con id_sector=1 pertenecen al departamento de ventas.
-- Esta consulta debe devolver los nombres , el id y lo recaudado de cada vendedor.

select id_empleado, CONCAT(nombre,' ',apellido) AS nombre,sector_del_empleado(id_empleado) AS sector
FROM empleados;
-- Este es un listado de todos los empleados y el sector donde se encuentra pero un mejor uso
-- de la función es saber a que sector pertenece un empleado o un grupo empleados en particular.


-- PRUEBAS STORED PROCEDURES
CALL nuevo_empleado('Agregado','Constored','111-111-4444',2);
-- Primer Stored procedures que agrega un empleado nuevo
SELECT * FROM empleados;
-- corroborar que se asigno el nuevo empleado

CALL nuevo_pedido_mas_detalle(2,1,1,'1,2,3,4,5','100,24,54,78,100');
-- Segundo Stored procedures que agrega un venta mas el detalle de ella.

SELECT * from pedidos WHERE id_pedido = (SELECT MAX(id_pedido) FROM pedidos);
-- Corroborar que se haya asignado correctamente el pedido

SELECT * from detalles_pedido where id_pedido = (SELECT MAX(id_pedido) FROM detalles_pedido);
-- Corroborar que se haya asignado los valores correspondientes al detalle del pedido.


-- PRUEBAS TRIGGERS
INSERT INTO pedidos(id_cliente,id_empleado,id_empresa_envio)
VALUES (4,1,3);
select * from pedidos;
-- comprobar que el pedido haya sido insertado correctamente
SELECT * FROM _registro_pedido;
-- comprobar que el registro haya sido insertado correctamente.
-- Debido a que las pruebas se realizan luego de crear los objetos en esta tabla habrá dos registros
-- porque en una prueba anterior se hizo una inserción a la tabla pedidos.

INSERT INTO detalles_pedido(id_producto,id_pedido)
VALUES (1,3);
SELECT * FROM detalles_pedido
ORDER BY id_pedido;
-- Corroborar que el detalle del pedido haya sido insertado correctamente.




