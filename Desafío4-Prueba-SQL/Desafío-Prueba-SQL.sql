-- Crear la base de datos Desafío-Prueba-SQL
CREATE DATABASE "Desafío-Prueba-SQL";

-- Tabla 'peliculas'
CREATE TABLE peliculas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    anno INTEGER
);
-- Tabla 'tags'
CREATE TABLE tags (
    id SERIAL PRIMARY KEY,
    tag VARCHAR(32),
    anno INTEGER
);

-- Tabla para la relación 'peliculas_tags'
CREATE TABLE peliculas_tags (
    pelicula_id INTEGER REFERENCES peliculas(id),
    tag_id INTEGER REFERENCES tags(id),
    PRIMARY KEY (pelicula_id, tag_id)
);

-- Insertar 5 películas y 5 tags con relaciones
INSERT INTO peliculas (nombre, anno) VALUES
    ('Cantando bajo la lluvia', 1952),
    ('Casablanca', 1942),
    ('El Resplandor', 1980),
    ('Lo que el viento se llevó', 1939),
    ('Arma letal', 1987);
	
Select * from peliculas;

INSERT INTO tags (tag, anno) VALUES
    ('Musical', 1952),
    ('Drama', 1942),
    ('Terror', 1980),
    ('Épica', 1939),
    ('Acción', 1987);
	
Select * from tags;

INSERT INTO peliculas_tags (pelicula_id, tag_id) VALUES
    (1, 1), (1, 2), (1, 3),
    (2, 2), (2, 4),
    (3, 1), (3, 5),
    (4, 2), (4, 4),
    (5, 1), (5, 5);

Select * from peliculas_tags;

-- Contar la cantidad de tags que tiene cada película
SELECT p.id, p.nombre, COUNT(pt.tag_id) AS cantidad_tags
FROM peliculas p
LEFT JOIN peliculas_tags pt ON p.id = pt.pelicula_id
GROUP BY p.id, p.nombre;

-- Tablas: 'preguntas', 'Usuarios' y 'Respuestas'
CREATE TABLE preguntas (
    id SERIAL PRIMARY KEY,
    pregunta VARCHAR(255),
    respuesta_correcta VARCHAR
);

CREATE TABLE Usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    edad INTEGER CHECK (edad >= 18),
    email VARCHAR UNIQUE
);

CREATE TABLE Respuestas (
    id SERIAL PRIMARY KEY,
    respuesta VARCHAR(255),
    usuario_id INTEGER REFERENCES Usuarios(id), 
    pregunta_id INTEGER REFERENCES preguntas(id)
);

-- Insertar 5 usuarios y 5 preguntas con respuestas
INSERT INTO Usuarios (nombre, edad, email) VALUES
    ('Pedro', 25, 'pedro@gmail.com'),
    ('Danae', 30, 'danae@gmail.com'),
    ('Nicolas', 22, 'nicolas@gmail.com'),
    ('Rosa', 19, 'rosa@gmail.com'),
    ('Ana', 40, 'ana@gmail.com');
	
Select * from Usuarios;

INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES
    ('¿Qué es la normalización en bases de datos?', 'Organiza los datos para reducir redundancias y mejorar la integridad'),
    ('¿En qué año se lanzó la primera versión de SQL?', '1974'),
    ('¿Cuántos JOINs principales hay en SQL?', '4'),
    ('¿Cuál es el lenguaje de programación utilizado en bases de datos Oracle?', 'PL/SQL'),
    ('¿Cuál es el término que describe la consistencia y durabilidad de una transacción en bases de datos?', 'ACID');

Select * from preguntas;

-- Agregar respuestas a las preguntas
INSERT INTO Respuestas (respuesta, usuario_id, pregunta_id) VALUES
    ('Organiza los datos para reducir redundancias y mejorar la integridad', 1, 1),
    ('1974', 2, 2),
    ('4', 3, 3),
    ('PL/SQL', 4, 4),
    ('ACID', 5, 5);
	
Select * from respuestas;

-- 6. Cuenta la cantidad de respuestas correctas totales por usuario
SELECT u.id, u.nombre, COUNT(r.id) AS respuestas_correctas
FROM Usuarios u
LEFT JOIN Respuestas r ON u.id = r.usuario_id
LEFT JOIN preguntas p ON r.pregunta_id = p.id
WHERE r.respuesta = p.respuesta_correcta OR r.respuesta IS NULL
GROUP BY u.id, u.nombre;


-- 7. Por cada pregunta, cuenta cuántos usuarios respondieron correctamente
SELECT p.id, p.pregunta, COUNT(r.id) AS usuarios_correctos
FROM preguntas p
LEFT JOIN Respuestas r ON p.id = r.pregunta_id AND r.respuesta = p.respuesta_correcta
GROUP BY p.id, p.pregunta;

-- 8. Implementa un borrado en cascada de las respuestas al borrar un usuario
-- Eliminara las respuesta relacionadas con el usuario
DELETE FROM Respuestas WHERE usuario_id = 5;

-- 9. Restricción para evitar insertar usuarios menores de 18 años
ALTER TABLE Usuarios ADD CONSTRAINT check_edad CHECK (edad >= 18);

-- 10. Alterar la tabla existente de usuarios agregando el campo email. Debe tener la restricción de ser único.
ALTER TABLE Usuarios ADD COLUMN email VARCHAR(255) UNIQUE;


