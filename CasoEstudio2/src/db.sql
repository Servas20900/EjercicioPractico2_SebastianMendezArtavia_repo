CREATE DATABASE Caso2;

create user 'usuario_caso2'@'%' identified by 'Usuario_Clave.';

grant all privileges on caso2.* to 'usuario_caso2'@'%';
flush privileges;



USE Caso2;
/*Para seguridad*/

CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  password varchar(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(75) NULL,
  telefono VARCHAR(15) NULL,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;







INSERT INTO usuario 
(id_usuario, username, password, nombre, apellidos, correo, telefono) 
VALUES 
(1, 'sebastian123', '$2a$10$XvT7gFyUzK7xCkR1PjM1FeiU3x5X7FzqzV7YQ9EaTqvMx1lGpPi9S', 'Sebastián', 'Mendez Artavia', 'seb.vargas@gmail.com', '6001-2234'),
(2, 'fio', '$2a$10$LgE3uZzwqYj3fQ9K7vFzE.1nL9eH9Vl0s2YbGvqz0O2hTXfC6xY6e', 'Fiorella', 'Jaen Artavia', 'fiorella.rj@hotmail.com', '7223-8855'),
(3, 'magnusx', '$2a$10$Qqv9N8N8sKlFvY8K1EpEzOBZz0z5TzBkD3zKZ0rL1wJ5KxW3zH7qG', 'Magnus', 'Mendez Artavia', 'magnus.alvarado@gmail.com', '6044-9191');







create table rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  foreign key fk_rol_usuario (id_usuario) references usuario(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

insert into rol (id_rol, nombre, id_usuario) values
 (1,'ROLE_ADMIN',1), (2,'ROLE_VENDEDOR',2), (3,'ROLE_USER',3),
 (4,'ROLE_VENDEDOR',2), (5,'ROLE_USER',2),
 (6,'ROLE_USER',3);







/*Para el carrito*/

create table categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen varchar(1024),
  PRIMARY KEY (id_categoria))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO categoria (id_categoria,descripcion,ruta_imagen,activo) VALUES 
('1','Entrada Partido','/img/categoria1.png'),
('2','Entrada Concierto','/img/categoria2.png'),
('3','Entrada algo','/img/categoria3.png'),






create table producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(30) NOT NULL,  
  detalle VARCHAR(1600) NOT NULL, 
  precio double,
  existencias int,  
  ruta_imagen varchar(1024),
  PRIMARY KEY (id_producto),
  foreign key fk_producto_caregoria (id_categoria) references categoria(id_categoria)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


/* Se insertan 3 registros en la tabla producto como ejemplo */
INSERT INTO producto 
(id_producto, id_categoria, descripcion, detalle, precio, existencias, ruta_imagen) 
VALUES 
(1, 1, 'Entrada General', 'Ticket para entrada general al evento', 20.00, 100, '/img/producto1.png'),
(2, 1, 'Entrada VIP', 'Ticket para entrada VIP, incluye acceso exclusivo y servicios adicionales', 50.00, 50, '/img/producto2.png'),
(3, 2, 'Entrada Estudiante', 'Descuento para estudiantes en entrada general', 15.00, 200, '/img/producto3.png');










create table factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha date,  
  total double,
  estado int,
  PRIMARY KEY (id_factura),
  foreign key fk_factura_usuario (id_usuario) references usuario(id_usuario)  
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO factura (id_factura, id_usuario, fecha, total, estado) VALUES
(1, 1, '2025-04-01', 90.00, 2),
(2, 2, '2025-04-02', 75.00, 2), 
(3, 3, '2025-04-03', 100.00, 2); 










create table venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  precio double, 
  cantidad int,
  PRIMARY KEY (id_venta),
  foreign key fk_ventas_factura (id_factura) references factura(id_factura),
  foreign key fk_ventas_producto (id_producto) references producto(id_producto) 
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


INSERT INTO venta (id_venta, id_factura, id_producto, precio, cantidad) VALUES
(1, 1, 1, 20.00, 2), 
(2, 1, 2, 50.00, 1), 
(3, 2, 3, 15.00, 3), 
(4, 2, 1, 20.00, 1), 
(5, 3, 2, 50.00, 2); 


/*
Limpiar la db 

-- Primero, datos dependientes (con claves foráneas)
DELETE FROM venta;
DELETE FROM factura;
DELETE FROM producto;
DELETE FROM categoria;
DELETE FROM rol;

-- Luego, tabla principal
DELETE FROM usuario;
 */
