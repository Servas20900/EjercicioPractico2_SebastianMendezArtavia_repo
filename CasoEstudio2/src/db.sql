-- Crear la base de datos
CREATE DATABASE practicacaso2;


-- Crear el usuario y otorgar privilegios
CREATE USER 'usuario_practicacaso2'@'%' IDENTIFIED BY 'Usuario_Clavepractica.';
GRANT ALL PRIVILEGES ON practicacaso2.* TO 'usuario_practicacaso2'@'%';
FLUSH PRIVILEGES;

-- Usar la base de datos
USE practicacaso2;

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
-- 2. cosas demas 
-- =========================

CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen VARCHAR(1024),
  PRIMARY KEY (id_categoria)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- =========================
-- 3. TABLAS DE LA BIBLIOTECA (ACTUALIZADO)
-- =========================

-- Libros
CREATE TABLE libro (
  id_libro INT NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(150) NOT NULL,
  autor VARCHAR(100) NOT NULL,
  anio_publicacion INT,
  id_categoria INT NOT NULL,
  stock INT DEFAULT 1,
  ruta_imagen VARCHAR(1024),
  PRIMARY KEY (id_libro),
  FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

-- Préstamos (con devolución incluida)
CREATE TABLE prestamo (
  id_prestamo INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  id_libro INT NOT NULL,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  devuelto BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (id_prestamo),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;


-- =========================
-- 4. INSERCIÓN DE DATOS
-- =========================

-- Usuarios
INSERT INTO usuario (id_usuario, username, password, nombre, apellidos, correo, telefono) VALUES 
(1, 'a', '$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.', 'a', 'ab', 'a@gmail.com', '6001-2234'),
(2, 'b', '$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi', 'b', 'bc', 'b@hotmail.com', '7223-8855'),
(3, 'c', '$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO', 'c', 'cd', 'c@gmail.com', '6044-9191');

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

--


INSERT INTO libro (titulo, autor, anio_publicacion, id_categoria, stock) VALUES
('El Alquimista', 'Paulo Coelho', 1990, 1, 5),
('La granja de los animales', 'George Orwell', 1945, 2, 3),
('Padre Rico Padre Pobre', 'Robert Kiyosaki', 1997, 3, 4),
('Cien años de soledad', 'Gabriel García Márquez', 1967, 1, 2);


-- Préstamo activo (no devuelto aún)
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, devuelto) VALUES
(1, 1, '2025-04-10', FALSE),
(2, 2, '2025-04-12', FALSE);

-- Préstamo devuelto
INSERT INTO prestamo (id_usuario, id_libro, fecha_prestamo, fecha_devolucion, devuelto) VALUES
(3, 3, '2025-04-01', '2025-04-15', TRUE),
(1, 4, '2025-03-20', '2025-04-02', TRUE);
