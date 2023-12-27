-- Crear la base de datos Desafío-Consultas-Múltiples-Tablas
CREATE DATABASE "Desafío-Consultas-Múltiples-Tablas";

-- Crear la tabla Usuarios
CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,
    email VARCHAR,
    nombre VARCHAR,
    apellido VARCHAR,
    rol VARCHAR
);

-- Insertar 5 usuarios, asegurándose de tener al menos un administrador
INSERT INTO Usuarios (email, nombre, apellido, rol) VALUES
    ('zulan1@gmail.com', 'Zulan 1', 'Aries 1', 'usuario'),
    ('eli2@gmail.com', 'Elisabeth 2', 'Bustos 2', 'usuario'),
    ('vania3@hotmail.com', 'Vania 3', 'Cea 3', 'usuario'),
    ('abrahan4@hotmail.com', 'Abrahan 4', 'Delgado 4', 'usuario'),
    ('aldo5@gmail.com', 'Aldo 5 ', 'Corso 5', 'administrador');

Select * from Usuarios;

-- Crear la tabla Posts
CREATE TABLE Posts (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    fecha_actualizacion TIMESTAMP,
    destacado BOOLEAN,
    usuario_id BIGINT REFERENCES Usuarios(id)
);

-- Insertar 5 posts
INSERT INTO Posts (titulo, contenido, fecha_creacion, destacado, usuario_id) VALUES
    ('Post:USACH1', 'Colaborativo 1', NOW(), true, 5),
    ('Post:USS2', 'Tutorial 2', NOW(), true, 5),
    ('Post:UDLA3', 'Listado de Recursos 3', NOW(), false, 3),
    ('Post:UCHILE4', 'Entrevista 4', NOW(), false, 4),
    ('Post:AIEP5', 'Ranking 5', NOW(), false, NULL);
Select * from Posts;

-- Crear la tabla Comentarios
CREATE TABLE Comentarios (
    id SERIAL PRIMARY KEY,
    contenido TEXT,
    fecha_creacion TIMESTAMP,
    usuario_id BIGINT REFERENCES Usuarios(id),
    post_id BIGINT REFERENCES Posts(id)
);

-- Insertar 5 comentarios
INSERT INTO Comentarios (contenido, fecha_creacion, usuario_id, post_id) VALUES
    ('Comentario1: feliz navidad Juan', NOW(), 1, 1),
    ('Comentario2: feliz navidad Maria', NOW(), 2, 2),
    ('Comentario3: feliz navidad Pedro', NOW(), 3, 1),
    ('Comentario4: feliz navidad Tito', NOW(), 1, 2),
    ('Comentario5: feliz navidad Kevin', NOW(), 2, 2);

Select * from Comentarios;

--Requerimientos

-- 1. Cruza los datos de la tabla usuarios y posts
SELECT u.nombre, u.email, p.titulo, p.contenido
FROM Usuarios u
JOIN Posts p ON u.id = p.usuario_id;

-- 2. Muestra el id, título y contenido de los posts de los administradores
SELECT p.id, p.titulo, p.contenido
FROM Usuarios u
JOIN Posts p ON u.id = p.usuario_id
WHERE u.rol = 'administrador';

-- 3. Cuenta la cantidad de posts de cada usuario
SELECT u.id, u.email, COUNT(p.id) AS cantidad_posts
FROM Usuarios u
LEFT JOIN Posts p ON u.id = p.usuario_id
GROUP BY u.id, u.email;

-- 5. Muestra el email del usuario que ha creado más posts
SELECT u.email
FROM Usuarios u
LEFT JOIN Posts p ON u.id = p.usuario_id
GROUP BY u.id, u.email
ORDER BY COUNT(p.id) DESC
LIMIT 1;

-- 6. Muestra la fecha del último post de cada usuario
SELECT u.id, u.email, MAX(p.fecha_creacion) AS ultima_fecha_post
FROM Usuarios u
LEFT JOIN Posts p ON u.id = p.usuario_id
GROUP BY u.id, u.email;

-- 7. Muestra el título y contenido del post con más comentarios
SELECT p.titulo, p.contenido
FROM Posts p
LEFT JOIN Comentarios c ON p.id = c.post_id
GROUP BY p.id, p.titulo, p.contenido
ORDER BY COUNT(c.id) DESC
LIMIT 1;

-- 8. Muestra en una tabla el título de cada post, el contenido de cada post y el contenido de cada comentario asociado a los posts mostrados, junto con el email del usuario que lo escribió
SELECT p.titulo, p.contenido AS contenido_post, c.contenido AS contenido_comentario, u.email AS email_usuario
FROM Posts p
LEFT JOIN Comentarios c ON p.id = c.post_id
LEFT JOIN Usuarios u ON p.usuario_id = u.id;

-- 9. Muestra el contenido del último comentario de cada usuario
SELECT u.id, u.email, c.contenido AS ultimo_comentario
FROM Usuarios u
LEFT JOIN Comentarios c ON u.id = c.usuario_id
WHERE c.fecha_creacion = (SELECT MAX(c2.fecha_creacion) FROM Comentarios c2 WHERE c2.usuario_id = u.id);

-- 10. Muestra los emails de los usuarios que no han escrito ningún comentario
SELECT u.email
FROM Usuarios u
LEFT JOIN Comentarios c ON u.id = c.usuario_id
WHERE c.id IS NULL;

