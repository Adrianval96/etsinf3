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
WHERE autor_id NOT IN (
    SELECT autor_id
    FROM escribir
);

-- Exercise 17
SELECT nombre
FROM autor
WHERE nacionalidad = 'Espa�ola'
AND 2 <= (
    SELECT COUNT(cod_ob)
    FROM escribir
    WHERE autor_id = autor.autor_id
);

-- Exercise 18
SELECT nombre
FROM autor
WHERE nacionalidad = 'Espa�ola'
AND autor_id IN (
    SELECT autor_id
    FROM escribir
    WHERE 2 <= (
        SELECT COUNT(id_lib)
        FROM esta_en
        WHERE escribir.cod_ob = cod_ob
    )
);

-- Exercise 19
SELECT titulo, cod_ob
FROM obra
WHERE 1 < (
    SELECT COUNT(autor_id)
    FROM escribir
    WHERE obra.cod_ob = cod_ob
);


-- QUERIES WITH UNIVERSAL QUANTIFICATION

-- Exercise 20
SELECT nombre
FROM amigo
WHERE NOT EXISTS (
    SELECT *
    FROM escribir
    WHERE autor_id = 'RUKI'
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM leer
        WHERE num = amigo.num
    )
) AND EXISTS (
    SELECT *
    FROM escribir NATURAL JOIN leer
    WHERE autor_id = 'RUKI'
    AND num = amigo.num
);


-- Exercise 21
SELECT nombre
FROM amigo
WHERE NOT EXISTS (
    SELECT *
    FROM escribir
    WHERE autor_id = 'GUAP'
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM leer
        WHERE num = amigo.num
    )
) AND EXISTS (
    SELECT *
    FROM escribir NATURAL JOIN leer
    WHERE autor_id = 'GUAP'
    AND num = amigo.num
);

-- Exercise 22
-- untested
SELECT nombre
FROM amigo
WHERE NOT EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir e1
    )
) AND EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = e1.autor_id
    )
);

-- Exercise 23
-- untested
SELECT amigo.nombre, autor.nombre
FROM amigo, autor
WHERE NOT EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob NOT IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = autor.autor_id
    )
) AND EXISTS (
    SELECT *
    FROM leer
    WHERE amigo.num = num
    AND cod_ob IN (
        SELECT cod_ob
        FROM escribir
        WHERE autor_id = autor.autor_id
    )
);

-- Exercise 24
-- untested
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE NOT EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id <> 'CAMA'
    ) AND EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id = 'CAMA'
    )
);

-- Exercise 25
-- untested
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE NOT EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id <> 'CAMA'
    ) AND EXISTS (
        SELECT *
        FROM escribir
        WHERE leer.cod_ob = cod_ob
        AND autor_id = 'CAMA'
    )
);

-- Exercise 26
-- untested
SELECT nombre
FROM amigo
WHERE num IN (
    SELECT num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir e
        WHERE NOT EXISTS (
            SELECT *
            FROM escribir
            WHERE e.autor_id <> autor_id
            AND cod_ob IN (
                SELECT cod_ob
                FROM leer
                WHERE num = amigo.num
            )
        )
    )
);

-- Exercise 27
-- untested
SELECT amigo.nombre, autor.nombre
FROM amigo, autor
WHERE num IN (
    SELECt num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir e
        WHERE NOT EXISTS (
            SELECT *
            FROM escribir
            WHERE e.autor_id <> autor_id
            AND cod_ob IN (
                SELECT cod_ob
                FROM leer
                WHERE num = amigo.num
            )
        ) AND autor.autor_id = autor_id
    )
);

-- Exercise 28
-- untested
SELECT  amigo.nombre, autor.nombre
FROM amigo, autor
WHERE num IN (
    SELECT num
    FROM leer
    WHERE cod_ob IN (
        SELECT cod_ob
        FROM escribir e
        WHERE NOT EXISTS (
            SELECT *
            FROM escribir
            WHERE e.autor_id <> autor_id
            AND autor.autor_id = autor_id
            AND cod_ob IN (
                SELECT cod_ob
                FROM leer
                WHERE num = amigo.num
            )
        ) AND autor.autor_id = autor_id
    )
) AND NOT EXISTS (
    SELECT *
    FROM leer, escribir
    WHERE amigo.num <> num
    AND leer.cod_ob = escribir.cod_ob
    AND escribir.autor_id = autor.autor_id
);


-- QUERIES WITH GROUP BY

-- Exercise 29
SELECT id_lib, titulo
FROM libro LEFT JOIN esta_en USING (id_lib)
WHERE titulo IS NOT NULL
GROUP BY id_lib, titulo
HAVING COUNT(cod_ob) > 1;

-- Exercise 30
SELECT nombre, COUNT(DISTINCT cod_ob)
FROM amigo, leer
WHERE amigo.num = leer.num
GROUP BY amigo.num, nombre
HAVING COUNT(DISTINCT cod_ob) > 3;

-- Exercise 31
SELECT tematica, COUNT(cod_ob)
FROM obra
WHERE tematica IS NOT NULL
GROUP BY tematica
HAVING COUNT(cod_ob) > 0
ORDER BY tematica;

-- Exercise 32
SELECT tematica, COUNT(cod_ob)
FROM tema LEFT JOIN obra USING (tematica)
GROUP BY tematica
ORDER BY tematica;

-- Exercise 33
SELECT nombre
FROM autor LEFT JOIN escribir USING (autor_id)
GROUP BY autor_id, nombre
HAVING COUNT(cod_ob) >= ALL (
    SELECT COUNT(cod_ob)
    FROM escribir
    GROUP BY autor_id
);

-- Exercise 34
SELECT nacionalidad
FROM autor
GROUP BY nacionalidad
HAVING COUNT(autor_id) <= ALL (
    SELECT COUNT(autor_id)
    FROM autor
    GROUP BY nacionalidad
);

-- Exercise 35
SELECT nombre
FROM amigo LEFT JOIN leer USING (num)
GROUP BY num, nombre
HAVING COUNT(cod_ob) >= ALL (
    SELECT COUNT(cod_ob)
    FROM leer
    GROUP BY num
);


-- OTHER QUERIES

-- Exercise 36
SELECT id_lib, titulo
FROM libro
WHERE titulo IS NOT NULL
AND num_obras = 1;

-- Exercise 37
SELECT titulo
FROM libro
WHERE titulo IS NOT NULL
    UNION
SELECT titulo
FROM obra LEFT JOIN esta_en USING (cod_ob)
WHERE id_lib IN (
    SELECT id_lib
    FROM libro
    WHERE num_obras = 1
);

-- Exercise 38
SELECT DISTINCT nombre
FROM amigo LEFT JOIN leer USING (num)
WHERE cod_ob IN (
    SELECT cod_ob
    FROM escribir
    WHERE autor_id = 'CAMA'
);

-- Exercise 39
SELECT nombre
FROM amigo
WHERE num NOT IN (
    SELECT num
    FROM leer LEFT JOIN escribir USING (cod_ob)
    WHERE autor_id = 'CAMA'
);

-- Exercise 40
SELECT nombre
FROM amigo
WHERE num NOT IN (
    SELECT num
    FROM leer LEFT JOIN escribir USING (cod_ob)
    WHERE autor_id = 'CAMA'
) AND num IN (
    SELECT num
    FROM leer
);

-- Exercise 41
-- untested
-- which friend has read the most works (don't GROUP BY)
