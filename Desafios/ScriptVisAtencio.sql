USE fabrica;
CREATE OR REPLACE VIEW recaudado_vendedores AS
	(SELECT em.nombre,em.apellido,SUM(pr.precio * de.cantidad) as recaudado
    FROM empleados em
    INNER JOIN pedidos pe ON (pe.id_empleado = em.id_empleado)
    INNER JOIN detalles_pedido de ON (de.id_pedido = pe.id_pedido)
    INNER JOIN productos pr ON (pr.id_producto = de.id_producto)
    GROUP BY em.id_empleado
    );
-- El proposito de la vista es saber cuanto dinero recauda cada vendedor.
    
SELECT * FROM recaudado_vendedores;

CREATE OR REPLACE VIEW provincia_ventas AS 
	(SELECT p.nombre, COUNT(DISTINCT pe.id_pedido) as ventas_provincia
    FROM provincias p
    INNER JOIN clientes c ON (c.id_provincia = p.id_provincia)
    INNER JOIN pedidos pe ON (pe.id_cliente = c.id_cliente)
    GROUP BY p.id_provincia
    );
  -- El propósito de la vista es saber cuantas ventas se realizan por provincia.  
    
SELECT * FROM provincia_ventas;

CREATE OR REPLACE VIEW cantidad_productos_vendidos AS
	(
	SELECT p.id_producto,p.nombre,SUM(d.cantidad) as cantidad_vendidos
    FROM productos p
    INNER JOIN detalles_pedido d ON(d.id_producto = p.id_producto)
    GROUP BY p.id_producto
    );
-- El propósito de la vista es saber la cantidad de cada producto que se ha vendido.
    
SELECT * FROM cantidad_productos_vendidos;

CREATE OR REPLACE VIEW recaudado_por_producto AS
	(
	SELECT p.id_producto,p.nombre,SUM(d.cantidad*p.precio) as recaudado
    FROM productos p
    INNER JOIN detalles_pedido d ON(d.id_producto = p.id_producto)
    GROUP BY p.id_producto
    );
-- El propósito de la vista es ver cuanto a recaudado cada producto

SELECT * FROM recaudado_por_producto;

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

SELECT * FROM gastos_por_producto;

CREATE OR REPLACE VIEW beneficio_neto_venta_producto AS
	(
		SELECT re.id_producto,re.nombre,re.recaudado - ga.gastos as ingreso_neto
        FROM recaudado_por_producto re
        INNER JOIN gastos_por_producto ga ON (re.id_producto = ga.id_producto)
        -- gastos_por_producto no es una tabla, es una vista creada con anterioridad
    );
-- El propósito de la vista el obtener el "ingreso neto" por las ventas de los productos,
-- sin contar con el sueldo, mantenimiento, gastos de envio, impuestos y demas gastos.    

SELECT * FROM beneficio_neto_venta_producto







    
