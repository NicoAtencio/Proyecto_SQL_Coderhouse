use fabrica;

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


-- PRUEBAS

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
