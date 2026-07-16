Objetivo
Este archivo m5_consultas_joins.sql contiene las consultas SQL del entregable M5 - Consultas JOINs para el proyecto RetailPro.
El propósito es construir una vista enriquecida combinando tablas para su uso en Power BI y, además, responder consultas de negocio con LEFT JOIN (clientes y productos sin ventas).

Base de datos utilizada
Se usa la base Ventas_Tech_DB con las tablas:

ventas (hechos)
clientes (dimensión)
productos (dimensión)
categorias (dimensión)
Nota importante sobre la consigna
La consigna menciona datos como “Online/Presencial” y “territorios/segmento”, pero en la BD provista no se encontró información (no existen columnas/tabla relacionadas a esas dimensiones).
Por lo tanto:

En la Consulta 1 se reemplaza el “region/territorio” por clientes.ciudad y se deja segmento como NULL porque no existe en el modelo.
En la Consulta 4 el “canal” se resuelve como constante ('Ventas') porque no hay campo canal ni forma de distinguir Online vs Presencial con los datos actuales.
Consultas incluidas
Consulta 1 — Vista base del proyecto (INNER JOIN)
Cruza ventas con:

clientes para obtener nombre_cliente y region (desde ciudad)
productos para obtener nombre_producto
categorias para obtener categoria
Incluye también el cálculo:

total_venta = cantidad * precio_unitario*
Además agrega:

canal = 'Ventas' (constante, ya que no existe canal en la BD)
segmento = NULL (no existe en la BD)
Consulta 2 — Clientes sin ventas (LEFT JOIN + WHERE IS NULL)
Identifica clientes de clientes que no aparecen en ventas:

LEFT JOIN ventas
filtro: WHERE v.id_venta IS NULL
Retorna nombre, email y fecha_registro.

Consulta 3 — Productos sin ventas (LEFT JOIN + WHERE IS NULL)
Identifica productos que no tienen registros en ventas:

LEFT JOIN ventas
filtro: WHERE v.id_venta IS NULL
Retorna nombre_producto, categoria y precio.

Consulta 4 — Consolidado por canal (UNION ALL / agregación)
La consigna pide UNION ALL para “Online y Presencial” y luego GROUP BY canal.
Como no hay fuente de canal (Online/Presencial) en la BD, se consolida todo bajo un canal fijo:

canal = 'Ventas'
total_por_canal = SUM(cantidad * precio_unitario)*
Criterios de diseño (resumen técnico)
INNER JOIN para la vista enriquecida (todas las filas deben tener match entre hechos y dimensiones).
LEFT JOIN + WHERE ... IS NULL para “sin ventas” (mantiene la dimensión completa y filtra las que no tienen match).
Cálculo de métricas con total_venta = cantidad * precio_unitario.
Adaptación de campos no disponibles: se usa ciudad como región y se fija canal como 'Ventas' por ausencia de datos Online/Presencial y territorios/segmento.*
