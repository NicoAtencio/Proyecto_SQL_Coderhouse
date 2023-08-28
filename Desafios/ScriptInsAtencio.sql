USE fabrica;

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



