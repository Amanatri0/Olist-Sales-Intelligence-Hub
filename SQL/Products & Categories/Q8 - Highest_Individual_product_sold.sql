-- Question #8 — Which individual products are purchased most frequently?

SELECT
    p.product_id AS products,
    pt.product_category_name_english AS product_category,
    COUNT(DISTINCT oi.order_id) AS distinct_order_count,
    COUNT(oi.product_id) AS order_item_count
FROM data_analytics.products AS p
INNER JOIN data_analytics.order_items AS oi
    ON p.product_id = oi.product_id
INNER JOIN data_analytics.orders AS o
    ON oi.order_id = o.order_id
INNER JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name
WHERE o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp < '2018-09-01'
GROUP BY p.product_id, pt.product_category_name_english
ORDER BY COUNT(DISTINCT oi.order_id) DESC
    LIMIT 10;
