-- Crear la base de datos Desafío-Consultas-Agrupadas
CREATE DATABASE "Desafío-Consultas-Agrupadas";
-- Crear la tabla INSCRITOS
CREATE TABLE INSCRITOS (
    cantidad INT,
    fecha DATE,
    fuente VARCHAR
);

-- Insertar datos en la tabla INSCRITOS
INSERT INTO INSCRITOS (cantidad, fecha, fuente) VALUES
    (44, '01/01/2021', 'Blog'),
    (56, '01/01/2021', 'Página'),
    (39, '01/02/2021', 'Blog'),
    (81, '01/02/2021', 'Página'),
    (12, '01/03/2021', 'Blog'),
    (91, '01/03/2021', 'Página'),
    (48, '01/04/2021', 'Blog'),
    (45, '01/04/2021', 'Página'),
    (55, '01/05/2021', 'Blog'),
    (33, '01/05/2021', 'Página'),
    (18, '01/06/2021', 'Blog'),
    (12, '01/06/2021', 'Página'),
    (34, '01/07/2021', 'Blog'),
    (24, '01/07/2021', 'Página'),
    (83, '01/08/2021', 'Blog'),
    (99, '01/08/2021', 'Página');
	
	Select * from INSCRITOS;
	
	-- 1. ¿Cuántos registros hay?
SELECT COUNT(*) AS total_registros FROM INSCRITOS;

-- 2. ¿Cuántos inscritos hay en total?
SELECT SUM(cantidad) AS total_inscritos FROM INSCRITOS;

-- 3. ¿Cuál o cuáles son los registros de mayor antigüedad?
SELECT * FROM INSCRITOS WHERE fecha = (SELECT MIN(fecha) FROM INSCRITOS);

-- 4. ¿Cuántos inscritos hay por día? (entendiendo un día como una fecha distinta de ahora en adelante)
SELECT fecha, SUM(cantidad) AS inscritos_por_dia FROM INSCRITOS GROUP BY fecha;

-- 5. ¿Cuántos inscritos hay por fuente?
SELECT fuente, SUM(cantidad) AS inscritos_por_fuente FROM INSCRITOS GROUP BY fuente;

-- 6. ¿Qué día se inscribió la mayor cantidad de personas? Y ¿Cuántas personas se inscribieron en ese día?
SELECT fecha, SUM(cantidad) AS total_inscritos FROM INSCRITOS GROUP BY fecha ORDER BY total_inscritos DESC LIMIT 1;

-- 7. ¿Qué días se inscribieron la mayor cantidad de personas utilizando el blog? ¿Cuántas personas fueron?
SELECT fecha, SUM(cantidad) AS total_inscritos_blog
FROM INSCRITOS
WHERE fuente = 'Blog'
GROUP BY fecha
ORDER BY total_inscritos_blog DESC
LIMIT 1;

-- 8. ¿Cuál es el promedio de personas inscritas por día?
SELECT AVG(cantidad) AS promedio_inscritos_por_dia FROM INSCRITOS;

-- 9. ¿Qué días se inscribieron más de 50 personas?
SELECT fecha, SUM(cantidad) AS total_inscritos
FROM INSCRITOS
GROUP BY fecha
HAVING SUM(cantidad) > 50;

-- 10. ¿Cuál es el promedio diario de personas inscritas a partir del tercer día en adelante, considerando únicamente las fechas posteriores o iguales a la indicada?
SELECT AVG(cantidad) AS promedio_inscritos_desde_tercer_dia
FROM INSCRITOS
WHERE fecha >= (SELECT MIN(fecha) + INTERVAL '2 day' FROM INSCRITOS);