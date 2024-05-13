DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

/* Llista el nom de tots els productes que hi ha en la taula producto. */
SELECT nombre FROM producto;

/* Llista els noms i els preus de tots els productes de la taula producto. */
SELECT nombre, precio FROM producto;

/* Llista totes les columnes de la taula producto. */
SELECT * FROM producto;

/* Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). (1 euro = 1,07 dólar) */
SELECT nombre, precio as Precio_EU, (precio * 1.07) as Precio_USD FROM producto;

/* Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars. */
SELECT nombre as nom_de_producto, precio as euros, (precio * 1.07) as dolars FROM producto;

/* Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula. */
SELECT UPPER(nombre) as nom_mayuscula, precio FROM producto;

/* Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula. */
SELECT LOWER(nombre) as nom_minuscula, precio FROM producto;

/* Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant. */
SELECT nombre as Nombres, UPPER(LEFT(nombre, 2)) as dos_primeras_letras FROM fabricante;

/* Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu. */
SELECT nombre as Nombre,precio as precio_sin_redondear, ROUND(precio, 0) as Precio_redondeado FROM producto;

/* Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal. */
SELECT nombre as Nombre,precio as Precio_sin_truncar, TRUNCATE(precio, 0) as Precio_truncado FROM producto;

/* Llista el codi dels fabricants que tenen productes en la taula producto. */
SELECT codigo_fabricante FROM producto;

/* Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits. */
SELECT DISTINCT codigo_fabricante FROM producto;

/* Llista els noms dels fabricants ordenats de manera ascendent. */
SELECT nombre as Nombres_fabricantes FROM fabricante
ORDER BY nombre;

/* Llista els noms dels fabricants ordenats de manera descendent. */
SELECT nombre as Nombres_fabricantes FROM fabricante
ORDER BY nombre DESC;

/* Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent. */
SELECT nombre as nombre_productos , precio as precio_producto FROM producto
ORDER BY nombre ASC, precio DESC ;

/* Retorna una llista amb les 5 primeres files de la taula fabricante. */
SELECT * FROM fabricante
LIMIT 5;

/* Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta. */
SELECT * FROM fabricante
LIMIT 2 OFFSET 3;

/* Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY. */
SELECT nombre as Producto, precio as Precio_minimo FROM producto
ORDER BY precio ASC
LIMIT 1;

/* Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY. */
SELECT nombre as Producto, precio as Precio_maximo FROM producto
ORDER BY precio DESC
LIMIT 1;

/* Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2. */
SELECT nombre FROM producto
WHERE codigo_fabricante = 2;

/* Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. */
SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante;

/* Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic. */
SELECT p.nombre, p.precio, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
ORDER BY f.nombre;

/* Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades. */
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante;


/* Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat. */
SELECT p.nombre, p.precio as precio_min, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
ORDER BY p.precio ASC
LIMIT 1;

/* Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car. */
SELECT p.nombre, p.precio as precio_max, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
ORDER BY p.precio DESC
LIMIT 1;

/* Retorna una llista de tots els productes del fabricant Lenovo. */ 
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE f.nombre = "Lenovo";

/* Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €. */
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE f.nombre = "Crucial" && p.precio > 200;

/* Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN. */

SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE f.nombre = 'Asus' || f.nombre = 'Hewlett-Packard' || f.nombre = 'Seagate';

/* Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Fent servir l'operador IN. */
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE f.nombre IN ('Asus', 'Hewlett-Packard','Seagate');

/* Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e. */
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE f.nombre LIKE '%e';

/* Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom. */
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE f.nombre LIKE '%w%';

/* Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. 
Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent). */
SELECT p.nombre, p.precio, f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM producto p 
JOIN fabricante f on f.codigo = p.codigo_fabricante
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

/* Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades. */
SELECT DISTINCT f.codigo as codigo_fabricante, f.nombre as nombre_fabricante FROM fabricante f 
JOIN producto p on f.codigo = p.codigo_fabricante

/* Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. 
El llistat haurà de mostrar també aquells fabricants que no tenen productes associats. */
SELECT f.nombre as nombre_fabricante, p.nombre as producto_asociado FROM fabricante f
JOIN producto p on f.codigo = p.codigo_fabricante;

/* Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat. */
SELECT f.nombre as nombre_fabricante, p.nombre as producto_asociado FROM fabricante f
LEFT JOIN producto p on f.codigo = p.codigo_fabricante
WHERE p.codigo_fabricante IS NULL;

/* Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN). */
SELECT p.nombre as producto FROM fabricante f,producto p 
WHERE f.codigo = p.codigo_fabricante
AND f.nombre = 'Lenovo';

/* Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN). */
SELECT * FROM producto
WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));


/* Llista el nom del producte més car del fabricant Lenovo. */
SELECT p.nombre, p.precio
FROM producto p
JOIN fabricante f on p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo'
ORDER BY p.precio DESC
LIMIT 1;


/* Llista el nom del producte més barat del fabricant Hewlett-Packard. */
SELECT p.nombre, p.precio
FROM producto p
JOIN fabricante f on p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Hewlett-Packard'
ORDER BY p.precio ASC
LIMIT 1;

/* Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo. */
SELECT * FROM producto
WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));


/* Llesta tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes. */
SELECT * FROM producto
WHERE precio >(SELECT AVG(precio) from producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Asus'));

/*Promedio del precio de productos 'Asus' => codigo_fabricante = 1 
Precio: 223.995
*/
SELECT AVG(precio) FROM producto
WHERE codigo_fabricante = 1;