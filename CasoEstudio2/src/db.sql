-- Crear la base de datos
CREATE DATABASE Caso2;

-- Crear el usuario y otorgar privilegios
CREATE USER 'usuario_caso2'@'%' IDENTIFIED BY 'Usuario_Clave.';
GRANT ALL PRIVILEGES ON Caso2.* TO 'usuario_caso2'@'%';
FLUSH PRIVILEGES;

-- Usar la base de datos
USE Caso2;

-- =========================
-- 1. TABLAS DE SEGURIDAD
-- =========================

CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(20) NOT NULL,
  password VARCHAR(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(75),
  telefono VARCHAR(15),
  PRIMARY KEY (id_usuario)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE role (
  rol VARCHAR(20),
  PRIMARY KEY (rol)
);

CREATE TABLE rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(20),
  id_usuario INT,
  PRIMARY KEY (id_rol),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE ruta (
  id_ruta INT AUTO_INCREMENT NOT NULL,
  patron VARCHAR(255) NOT NULL,
  rol_name VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_ruta)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE ruta_permit (
  id_ruta INT AUTO_INCREMENT NOT NULL,
  patron VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_ruta)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- =========================
-- 2. TABLAS DE CARRITO Y PRODUCTOS
-- =========================
CREATE TABLE constante (
  id_constante INT AUTO_INCREMENT NOT NULL,
  atributo VARCHAR(25) NOT NULL,
  valor VARCHAR(150) NOT NULL,
  PRIMARY KEY (id_constante)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen VARCHAR(1024),
  PRIMARY KEY (id_categoria)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(30) NOT NULL,
  detalle VARCHAR(1600) NOT NULL,
  precio DOUBLE,
  existencias INT,
  ruta_imagen VARCHAR(1024),
  PRIMARY KEY (id_producto),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha DATE,
  total DOUBLE,
  estado INT,
  PRIMARY KEY (id_factura),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  precio DOUBLE,
  cantidad INT,
  PRIMARY KEY (id_venta),
  FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- =========================
-- 4. INSERCIÓN DE DATOS
-- =========================

-- Usuarios
INSERT INTO usuario (id_usuario, username, password, nombre, apellidos, correo, telefono) VALUES 
(1, 'sebastian123', '$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.', 'Sebastián', 'Mendez Artavia', 'seb.vargas@gmail.com', '6001-2234'),
(2, 'fio', '$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi', 'Fiorella', 'Jaen Artavia', 'fiorella.rj@hotmail.com', '7223-8855'),
(3, 'magnusx', '$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO', 'Magnus', 'Mendez Artavia', 'magnus.alvarado@gmail.com', '6044-9191');

-- Roles base
INSERT INTO role (rol) VALUES ('ADMIN'), ('VENDEDOR'), ('USER');

-- Relación usuario - roles
INSERT INTO rol (id_rol, nombre, id_usuario) VALUES
(1, 'ROLE_ADMIN', 1),
(2, 'ROLE_VENDEDOR', 2),
(3, 'ROLE_USER', 3),
(4, 'ROLE_VENDEDOR', 2),
(5, 'ROLE_USER', 2),
(6, 'ROLE_USER', 3);

-- Categorías
INSERT INTO categoria (id_categoria, descripcion, ruta_imagen) VALUES 
(1, 'Libros accion', '/img/categoria1.png'),
(2, 'Libros animales', '/img/categoria2.png'),
(3, 'Libros finanzas', '/img/categoria3.png');

-- Productos
INSERT INTO producto (id_producto, id_categoria, descripcion, detalle, precio, existencias, ruta_imagen) VALUES 
(1, 1, 'Rapidos&Furiosos', 'Tiene libro?', 20.00, 100, '/img/producto1.png'),
(2, 1, 'Vacas', 'Que hacen las vacas?', 50.00, 50, '/img/producto2.png'),
(3, 2, 'BancoPopular', 'Libraso, lealo', 15.00, 200, '/img/producto3.png');

-- Facturas
INSERT INTO factura (id_factura, id_usuario, fecha, total, estado) VALUES
(1, 1, '2025-04-01', 90.00, 2),
(2, 2, '2025-04-02', 75.00, 2),
(3, 3, '2025-04-03', 100.00, 2);

-- Ventas
INSERT INTO venta (id_venta, id_factura, id_producto, precio, cantidad) VALUES
(1, 1, 1, 20.00, 2),
(2, 1, 2, 50.00, 1),
(3, 2, 3, 15.00, 3),
(4, 2, 1, 20.00, 1),
(5, 3, 2, 50.00, 2);

-- Rutas protegidas
INSERT INTO ruta (patron, rol_name) VALUES
('/carrito/agregar/**', 'USER'),
('/carrito/listado', 'USER'),
('/carrito/eliminar/**', 'USER'),
('/carrito/modificar/**', 'USER'),
('/carrito/guardar', 'USER'),
('/facturar/carrito', 'USER');

-- Rutas públicas
INSERT INTO ruta_permit (patron) VALUES 
('/'),
('/index'),
('/errores/'),
('/carrito/'),
('/registro/'),
('/js/'),
('/webjars/');

-- Constantes
INSERT INTO constante (atributo, valor) VALUES 
('dominio', 'localhost'),
('certificado', 'c:/cert'),
('dolar', '520.75'),
('paypal.client-id', 'AUjOjw5Q1I0QLTYjbvRS0j4Amd8xrUU2yL9UYyb3TOTcrazzd3G3lYRc6o7g9rOyZkfWEj2wxxDi0aRz'),
('paypal.client-secret', 'EMdb08VRlo8Vusd_f4aAHRdTE14ujnV9mCYPovSmXCquLjzWd_EbTrRrNdYrF1-C4D4o-57wvua3YD2u'),
('paypal.mode', 'sandbox'),
('urlPaypalCancel', 'http://localhost/payment/cancel'),
('urlPaypalSuccess', 'http://localhost/payment/success');

-- =========================
-- 5. LIMPIEZA DE LA DB (opcional)
-- =========================

/*
-- Primero, datos dependientes (con claves foráneas)
DELETE FROM venta;
DELETE FROM factura;
DELETE FROM producto;
DELETE FROM categoria;
DELETE FROM rol;

-- Luego, tabla principal
DELETE FROM usuario;
*/
