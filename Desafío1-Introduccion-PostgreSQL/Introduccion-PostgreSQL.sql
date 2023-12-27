-- Crear la base de datos "Introduccion-PostgreSQL"
CREATE DATABASE "Introduccion-PostgreSQL";

-- Crear la tabla "clientes" con las columnas especificadas
CREATE TABLE clientes (
    email varchar(50),
    nombre varchar,
    telefono varchar(16),
    empresa varchar(50),
    prioridad smallint CHECK (prioridad BETWEEN 1 AND 10)
);

-- Insertar datos en la tabla "clientes"
INSERT INTO clientes (email, nombre, telefono, empresa, prioridad) VALUES
    ('cliente1@gmail.com', 'Cliente 1', '123456789', 'Empresa A', 5),
    ('cliente2@gmail.com', 'Cliente 2', '987654321', 'Empresa B', 8),
    ('cliente3@gmail.com', 'Cliente 3', '555555555', 'Empresa C', 3),
    ('cliente4@gmail.com', 'Cliente 4', '666666666', 'Empresa A', 10),
    ('cliente5@gmail.com', 'Cliente 5', '444444444', 'Empresa B', 7);

Select * from clientes;
-- Seleccionar los tres clientes de mayor prioridad
SELECT * FROM clientes ORDER BY prioridad DESC LIMIT 3;

-- Seleccionar 2 registros basados en prioridad o empresa
SELECT * FROM clientes WHERE prioridad = 7 OR empresa = 'Empresa A' LIMIT 2;