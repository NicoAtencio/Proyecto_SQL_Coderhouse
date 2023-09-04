use fabrica_de_pastas;

SET AUTOCOMMIT = 0;

CREATE TABLE stock(
	id_producto INT NOT NULL,
    cantidad INT DEFAULT 0,
    KEY id_producto(id_producto),
    CONSTRAINT producto_fk FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
-- Creación de tablas para controlar el inventario de los productos y que el proyecto se parezca mas
-- al modelo de negocios, en proxima entrega relizare triggers para descontar del stock cada vez que se
-- realize una venta. Esto no es parte del desafio de sub-lenguaje TCL solo lo implemento para futuras
-- entregas.
INSERT INTO stock(id_producto,cantidad)
VALUES(1,1000),(2,1000),(3,1000),(4,1000),(5,1000);
-- Insercion de datos a la tabla stock.

START TRANSACTION;
SELECT * FROM empleados;
-- Para ver los datos de la tabla antes de eliminarlos.
DELETE FROM empleados WHERE id_empleado = 6;
SELECT * FROM empleados;
-- Para ver los datos de la tabla luego de eliminar "momentaneamente"

-- ROLLBACK Esta sentencia la usaria en caso de no querer que se efectue el DELETE;
COMMIT;
-- Lo que hice una transaccion para eliminar a un empleado y al ver que fue eliminado el empleado
-- correcto realize un commit para que se efectuen todos los cambios realizados dentro de la tansaccion.

START TRANSACTION; 
SELECT * FROM pedidos;
-- ver contenido de la tabla antes de modificacion de datos

SELECT * FROM detalles_pedido;
-- ver contenido de detalles antes de la insercion de datos.


INSERT INTO pedidos(id_cliente,id_empleado,id_empresa_envio)
values(5,3,4),(1,3,1),(2,1,2),(4,3,2);
-- insercion de datos a la tabla pedidos.

savepoint id_pedido_7;
INSERT INTO detalles_pedido(id_producto,id_pedido,cantidad) 
VALUES (1,7,100),(2,7,100);
UPDATE stock
SET cantidad = cantidad - 100
WHERE id_producto = 1 OR id_producto = 2;
-- La idea para la proxima entrega es que ya este realizado el trigger para que se descuente 
-- del stock automaticamente.

savepoint id_pedido_8;
INSERT INTO detalles_pedido(id_producto,id_pedido,cantidad)
VALUES (3,8,100),(4,8,100);
UPDATE stock
SET cantidad = cantidad - 100
WHERE id_producto = 3 OR id_producto = 4;

savepoint id_pedido_9;
INSERT INTO detalles_pedido(id_producto,id_pedido,cantidad)
VALUES (5,9,100);
UPDATE stock
SET cantidad = cantidad - 100
WHERE id_producto = 5;

-- ROOLBACK TO id_pedido_9 ==> Lo que habria echo esta sentencia es que no se ejecute el insert 
-- a la tablas detalles_pedido y stock que se encuentran debajo de la sentencia savepoint id_pedido_9,
-- es un simulador de lo que hubiera echo en caso de no querer insertar esos datos.

SELECT * FROM pedidos;
SELECT * FROM detalles_pedido;
-- ver tablas con insercion de datos
COMMIT;
-- Lo que hice en esta transaccion fue insertar nuevos datos en la tabla pedidos y tambien modifique
-- datos en la tabla stock e inserte en detalles_pedido ya que en el modelo de negocios son modificadas en caso
-- de una venta.





