-- (1)Cargar el respaldo de la base de datos unidad2.sql
sudo su - postgres
psql -U postgres unidad2 < C:/Users/desafio_db/unidad2.sql
-- Entrar a la base de datos unidad2
\c unidad2
-- (2)Cargar la compra del cliente usuario01
-- a. Realizar las consultas correspondientes a este requerimiento
BEGIN TRANSACTION;
INSERT INTO public.compra values (33, 1 , '2022-04-13');
UPDATE producto SET stock = stock - 5 WHERE id = 9;
COMMIT;
-- b. Consultar la tabla producto para validar si fue efectivamente descontado en el stock
select * from producto;
-- (3)Cargar la compra del cliente usuario02
-- a. Realizar las consultas correspondientes para este requerimiento
BEGIN TRANSACTION;
INSERT INTO public.compra values (34, 2, '2020-02-02');
UPDATE producto SET stock = stock - 3 WHERE id = 1;
SAVEPOINT checkpoint1;
BEGIN TRANSACTION;
INSERT INTO public.compra values (35, 2, '2020-02-02');
UPDATE producto SET stock = stock - 3 WHERE id = 2;
SAVEPOINT checkpoint2;
BEGIN TRANSACTION;
INSERT INTO public.compra values (36, 2, '2020-02-02');
UPDATE producto SET stock = stock - 3 WHERE id = 8;
ROLLBACK TO checkpoint2;
-- Esta compra no se pudo realizar porque el stock del producto 8 es 0
-- b. Consultar la tabla producto para validar que si alguno de ellos se queda sin stock no se realice la compra
select * from producto;
-- (4)Realizar las siguientes consultas:
-- a. Deshabilitar el AUTOCOMMIT.
\set AUTOCOMMIT off
-- b. Insertar un nuevo cliente.
BEGIN TRANSACTION;
INSERT INTO public.cliente values (11, 'usuario011', 'usuario011@gmail.com');
-- c. Confirmar que fue agregado en la tabla cliente.
SELECT * FROM public.cliente;
-- d. Realizar un ROLLBACK.
ROLLBACK;
-- e. Confirmar que se restauró la información, sin considerar la inserción del punto b.
SELECT * FROM public.cliente;
-- f. Habilitar de nuevo el AUTOCOMMIT.
\echo :AUTOCOMMIT ON