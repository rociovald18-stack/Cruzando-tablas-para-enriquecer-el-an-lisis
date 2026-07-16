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
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    c.ciudad AS region,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria;


-- ===========================================
-- CONSULTA 2
-- Clientes sin compras
-- ===========================================

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;


-- ===========================================
-- CONSULTA 3
-- Productos sin ventas
-- ===========================================

SELECT
    p.nombre_producto,
    cat.nombre_categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;


-- ===========================================
-- CONSULTA 4
-- Consolidado de ventas
-- ===========================================

SELECT
    canal,
    SUM(total_venta) AS total_por_canal
FROM
(
    SELECT
        (cantidad * precio_unitario) AS total_venta,
        'Ventas' AS canal
    FROM ventas
) AS ventas_consolidadas
GROUP BY canal;
