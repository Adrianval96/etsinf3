-- QUERIES USING 1 RELATION

-- Exercise 1
SELECT nombre
FROM autor
WHERE nacionalidad = 'Argentina';

-- Exercise 2
SELECT titulo
FROM obra
WHERE titulo LIKE '%mundo%';

-- Exercise 3
SELECT id_lib, num_obras
FROM libro
WHERE "A�O" < 1990
AND num_obras > 1;

-- Exercise 4
SELECT COUNT(*) LIB_A�O
FROM libro
WHERE "A�O" IS NOT NULL;

-- Exercise 5
SELECT COUNT(*) M�S_1_OB
FROM libro
WHERE num_obras > 1;

-- Exercise 6
SELECT id_lib
FROM libro
WHERE "A�O" = 1997
AND titulo IS NULL;

-- Exercise 7
SELECT titulo
FROM libro
WHERE titulo IS NOT NULL
ORDER BY titulo DESC;

-- Exercise 8
SELECT SUM(num_obras) OBRAS
FROM libro
WHERE "A�O" BETWEEN 1990 AND 1999;


-- QUERIES USING MORE THAN 1 RELATION

-- Exercise 9
SELECT COUNT(DISTINCT autor_id)
FROM escribir
WHERE cod_ob IN (
    SELECT cod_ob
    FROM obra
    WHERE titulo LIKE '%ciudad%'
);

-- Exercise 10
SELECT titulo
FROM obra
WHERE cod_ob IN (
    SELECT cod_ob
    FROM escribir
    WHERE autor_id IN (
        SELECT autor_id
        FROM autor
        WHERE nombre = 'Cam�s, Albert'
    )
);

-- Exercise 11
SELECT nombre
FROM autor
WHERE autor_id IN (
    SELECT autor_id
    FROM escribir
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM obra
        WHERE titulo = 'La tata'
    )
);

-- Exercise 12
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = 'RUKI'
    )
);

-- Exercise 13
SELECT id_lib, titulo
FROM libro
WHERE titulo IS NOT NULL
AND 1 < (
    SELECT COUNT(cod_ob)
    FROM esta_en
    WHERE libro.id_lib = id_lib
);


-- QUERIES WITH SUBQUERIES

-- Exercise 14
SELECT titulo, nombre
FROM autor, obra
WHERE nacionalidad = 'Francesa'
AND cod_ob IN (
    SELECT cod_ob
    FROM escribir
    WHERE autor_id = autor.autor_id
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id <> autor.autor_id
    )
);

-- Exercise 15
SELECT COUNT(autor_id) SIN_OBRA
FROM autor
WHERE autor_id NOT IN (
    SELECT autor_id
    FROM escribir
);

-- Exercise 16
SELECT nombre
FROM autor
WHERE nacionalidad = 'Espa�ola'
AND 2 <= (
    SELECT COUNT(cod_ob)
    FROM escribir
    WHERE autor_id = autor.autor_id
);

-- Exercise 17
SELECT 