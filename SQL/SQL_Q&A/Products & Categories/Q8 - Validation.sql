WITH product_orders AS (
    SELECT
        p.product_id,
        pt.product_category_name_english AS category,
        COUNT(DISTINCT oi.order_id) AS product_order_count
    FROM data_analytics.order_items AS oi
    INNER JOIN data_analytics.orders AS o
        ON oi.order_id = o.order_id
    INNER JOIN data_analytics.products AS p
        ON oi.product_id = p.product_id
    INNER JOIN data_analytics.product_translation AS pt
        ON p.product_category_name = pt.product_category_name
    WHERE o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp < '2018-09-01'
    GROUP BY
        p.product_id,
        pt.product_category_name_english
),
ranked_products AS (
    SELECT
        product_id,
        category,
        product_order_count,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY product_order_count DESC, product_id
        ) AS product_rank
    FROM product_orders
),
category_orders AS (
    SELECT
        pt.product_category_name_english AS category,
        COUNT(DISTINCT o.order_id) AS category_order_count
    FROM data_analytics.order_items AS oi
    INNER JOIN data_analytics.orders AS o
        ON oi.order_id = o.order_id
    INNER JOIN data_analytics.products AS p
        ON oi.product_id = p.product_id
    INNER JOIN data_analytics.product_translation AS pt
        ON p.product_category_name = pt.product_category_name
    WHERE o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp < '2018-09-01'
    GROUP BY category
)
SELECT
    rp.category,
    rp.product_id,
    rp.product_order_count,
    co.category_order_count,
    ROUND(
        100.0 * rp.product_order_count
        / co.category_order_count,
        2
    ) AS category_order_share_pct
FROM ranked_products AS rp
INNER JOIN category_orders AS co
    ON rp.category = co.category
WHERE rp.product_rank <= 10
ORDER BY rp.category, rp.product_rank;