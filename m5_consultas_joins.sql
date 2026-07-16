/* m5_consultas_joins.sql
   RetailPro — M5 Consultas JOINs
   BD: Ventas_Tech_DB (SQL Server)

   Incluye:
   - Consulta 1: Vista base (INNER JOIN)
   - Consulta 2: Clientes sin ventas (LEFT JOIN + WHERE IS NULL)
   - Consulta 3: Productos sin ventas (LEFT JOIN + WHERE IS NULL)
   - Consulta 4: Consolidado por canal (canal fijo, porque no existe en la BD)
*/

USE Ventas_Tech_DB;
GO

/* =========================
   CONSULTA 1 — Vista base del proyecto (INNER JOIN)
   ========================= */
SELECT
    v.fecha_venta,
    c.nombre AS nombre_cliente,
    NULL AS segmento,                    -- no existe en tu BD
    c.ciudad AS region,                -- sustituto de "territorios/region"
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta,
    'Ventas' AS canal                  -- no existe en tu BD
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria;
GO

/* =========================
   CONSULTA 2 — Clientes sin ventas (LEFT JOIN)
   ========================= */
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
GO

/* =========================
   CONSULTA 3 — Productos sin ventas (LEFT JOIN)
   ========================= */
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;
GO

/* =========================
   CONSULTA 4 — Consolidado por canal (UNION ALL)
   Nota: No existe canal en tu BD, así que se consolida como un canal fijo.
   ========================= */
SELECT
    'Ventas' AS canal,
    SUM(v.cantidad * v.precio_unitario) AS total_por_canal
FROM ventas v
GROUP BY 'Ventas';
GO
