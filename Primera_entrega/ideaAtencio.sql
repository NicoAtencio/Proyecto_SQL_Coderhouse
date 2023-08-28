CREATE SCHEMA fabrica;
USE fabrica;

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






