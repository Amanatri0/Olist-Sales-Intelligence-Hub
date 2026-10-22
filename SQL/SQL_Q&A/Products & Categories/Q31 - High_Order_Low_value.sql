-- Question #31: Which categories have high order volume but low merchandise value per order?

WITH category_metric AS 
(
    SELECT
        pt.product_category_name_english AS category,
        ROUND(SUM(oi.price),2) AS total_merchandise_value,
        COUNT(DISTINCT oi.order_id) AS order_count,
        ROUND((SUM(oi.price) / COUNT(DISTINCT oi.order_id)),2) AS order_value
    FROM data_analytics.order_items AS oi
    INNER JOIN data_analytics.products AS p
        ON oi.product_id = p.product_id
    INNER JOIN data_analytics.product_translation AS pt
        ON p.product_category_name = pt.product_category_name
    INNER JOIN data_analytics.orders AS o
        ON oi.order_id = o.order_id
    WHERE o.order_purchase_timestamp >= '2017-01-01'
        AND o.order_purchase_timestamp < '2018-09-01'
        AND pt.product_category_name_english IS NOT NULL
    GROUP BY pt.product_category_name_english
    ORDER BY COUNT(DISTINCT oi.order_id) DESC
),
order_ranked AS (
    SELECT
        order_count,
        category,
        ROW_NUMBER() OVER( ORDER BY order_count ) AS ranked_orders,
        COUNT(*) OVER() AS total_categories
    FROM category_metric
),
value_ranked AS (
    SELECT
        category,
        order_value,
        ROW_NUMBER() OVER( ORDER BY order_value ) AS ranked_values,
        COUNT(*) OVER() AS total_categories
    FROM category_metric
),
order_median AS (
    SELECT 
        ROUND(AVG(order_count),2) AS median_order_count
    FROM order_ranked
    WHERE ranked_orders IN (
        FLOOR((total_categories + 1) / 2),
        FLOOR((total_categories + 2) / 2)
    )
),
value_median AS (
    SELECT 
        ROUND(AVG(order_value),2) AS median_order_value
    FROM value_ranked
    WHERE ranked_values IN (
        FLOOR((total_categories + 1) / 2),
        FLOOR((total_categories + 2) / 2)
    )
)

SELECT
    cm.category,
    cm.order_count,
    cm.total_merchandise_value,
    cm.order_value,
    om.median_order_count,
    vm.median_order_value,
    CASE
        WHEN order_count > median_order_count THEN 'High'
        WHEN order_count = median_order_count THEN 'Median'
            ELSE 'Low'
        END AS order_volume,
    CASE 
        WHEN order_value > median_order_value THEN 'High'
        WHEN order_value = median_order_value THEN 'Median'
            ELSE 'Low'
        END AS merchandise_value
FROM category_metric AS cm
CROSS JOIN order_median AS om
CROSS JOIN value_median AS vm
ORDER BY cm.order_count DESC;
