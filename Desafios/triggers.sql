use fabrica;

CREATE TABLE `_registro_pedido`(
	id_log INT PRIMARY KEY auto_increment,
    operacion VARCHAR(100),
	usuario VARCHAR(100) NOT NULL,
    fecha DATE NOT NULL,
    hora TIME NOT NULL
);
-- La creacion de esta tabla es para almacenar que usuario, cuando  y a que hora registro un nuevo pedido.

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


-- Pruebas
INSERT INTO pedidos(id_cliente,id_empleado,id_empresa_envio)
VALUES (4,1,3);
select * from pedidos;
-- comprobar que el pedido haya sido insertado correctamente
SELECT * FROM _registro_pedido;
-- comprobar que el registro haya sido insertado correctamente.

INSERT INTO detalles_pedido(id_producto,id_pedido)
VALUES (1,3);
SELECT * FROM detalles_pedido
ORDER BY id_pedido;
-- Corroborar que el detalle del pedido haya sido insertado correctamente.


