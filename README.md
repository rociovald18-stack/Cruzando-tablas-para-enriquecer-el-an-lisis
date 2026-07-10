# M5 - Consultas SQL con JOINs y UNION ALL

## Autor

**Rocío Valdez**

---

# Descripción

En esta actividad se desarrollaron consultas SQL utilizando **INNER JOIN**, **LEFT JOIN** y **UNION ALL** para integrar información de distintas tablas del proyecto **RetailPro**.

El objetivo fue construir una vista enriquecida que sirva como fuente de datos para Power BI, además de identificar clientes sin compras, productos sin ventas y consolidar las ventas por canal.

---

# Consulta 1 - Vista base (INNER JOIN)

Se utilizó **INNER JOIN** para relacionar las tablas:

- ventas
- clientes
- productos
- territorios

Esta consulta reúne en una única vista la siguiente información:

- Fecha de venta
- Nombre del cliente
- Segmento
- Región
- Producto
- Categoría
- Cantidad
- Precio unitario
- Total de venta
- Canal

Esta consulta será utilizada como base para el dashboard de Power BI.

### ¿Por qué INNER JOIN?

Se eligió INNER JOIN porque únicamente interesan las ventas que poseen información completa en todas las tablas relacionadas. Si alguna venta no tuviera un cliente, producto o territorio asociado, no aparecería en el resultado, evitando registros incompletos para el análisis.

---

# Consulta 2 - Clientes sin ventas (LEFT JOIN)

Se utilizó **LEFT JOIN** entre la tabla **clientes** y la tabla **ventas**.

Posteriormente se aplicó el filtro:

```sql
WHERE ventas.id_venta IS NULL
```

De esta forma se obtienen únicamente los clientes registrados que nunca realizaron una compra.

### ¿Por qué LEFT JOIN?

LEFT JOIN conserva todos los registros de la tabla clientes, incluso cuando no existe una venta relacionada. Esto permite identificar fácilmente clientes inactivos para futuras campañas comerciales o acciones de fidelización.

---

# Consulta 3 - Productos sin ventas (LEFT JOIN)

Se utilizó **LEFT JOIN** entre la tabla **productos** y la tabla **ventas**.

Luego se aplicó:

```sql
WHERE ventas.id_venta IS NULL
```

Con esta consulta se identifican los productos que nunca registraron ventas.

### ¿Por qué es útil?

Permite detectar artículos con bajo rendimiento comercial, facilitando decisiones como promociones, descuentos o incluso la discontinuación de productos.

---

# Consulta 4 - Consolidado por canal (UNION ALL)

Para construir el consolidado se utilizó **UNION ALL**, combinando las ventas de los canales:

- Online
- Presencial

Posteriormente se realizó un **GROUP BY** para calcular el total vendido por cada canal.

### ¿Por qué UNION ALL?

UNION ALL mantiene absolutamente todos los registros.

En este caso no interesa eliminar duplicados, ya que cada venta representa una transacción diferente y debe conservarse para obtener un total correcto por canal.

---

# Diferencia entre INNER JOIN, LEFT JOIN y UNION ALL

## INNER JOIN

Devuelve únicamente los registros que tienen coincidencia en ambas tablas.

Se utiliza cuando únicamente interesa trabajar con información completa.

---

## LEFT JOIN

Devuelve todos los registros de la tabla principal, incluso cuando no existe información relacionada en la segunda tabla.

Los registros sin coincidencia aparecen con valores **NULL**.

---

## UNION ALL

Combina los resultados de varias consultas manteniendo todos los registros, incluso si existen filas duplicadas.

Es ideal para consolidar información proveniente de distintas fuentes sin perder datos.

---

# Conclusión

Las consultas desarrolladas permiten construir una base de datos enriquecida para análisis en Power BI y responder preguntas de negocio relevantes, como identificar clientes sin compras, productos sin movimiento y comparar el desempeño de los distintos canales de venta.

El uso adecuado de **INNER JOIN**, **LEFT JOIN** y **UNION ALL** garantiza consultas eficientes, datos completos y una mejor preparación de la información para la generación de indicadores y dashboards.
