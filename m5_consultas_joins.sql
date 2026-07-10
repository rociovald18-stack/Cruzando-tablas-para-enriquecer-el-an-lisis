-- ===========================================
-- RetailPro
-- M5 - Consultas JOINs
-- Autor: Rocío Valdez
-- ===========================================

-- ===========================================
-- CONSULTA 1
-- Vista base para Power BI
-- ===========================================

SELECT
    ...
FROM ventas v
INNER JOIN clientes c
    ON ...
INNER JOIN productos p
    ON ...
INNER JOIN territorios t
    ON ...

-- ===========================================
-- CONSULTA 2
-- Clientes sin compras
-- ===========================================

SELECT
    ...
FROM clientes c
LEFT JOIN ventas v
    ON ...
WHERE ... IS NULL;

-- ===========================================
-- CONSULTA 3
-- Productos sin ventas
-- ===========================================

SELECT
    ...
FROM productos p
LEFT JOIN ventas v
    ON ...
WHERE ... IS NULL;

-- ===========================================
-- CONSULTA 4
-- Consolidado por canal
-- ===========================================

SELECT
    canal,
    SUM(total_venta) AS total
FROM
(
    SELECT ..., 'Online' AS canal
    FROM ventas
    WHERE canal='Online'

    UNION ALL

    SELECT ..., 'Presencial' AS canal
    FROM ventas
    WHERE canal='Presencial'
) ventas_consolidadas

GROUP BY canal;
