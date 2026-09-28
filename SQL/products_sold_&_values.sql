--  Question #3: Which product categories contribute most to order value?

SELECT
    pct.product_category_name_english AS product_category,
    ROUND(SUM(ori.price), 0) AS sales_value,
    COUNT(ori.product_id) AS items_sold,
    COUNT(distinct ori.product_id) AS distinct_products_sold,
    ROUND(AVG(ori.price), 2) AS avg_price
FROM data_analytics.products AS pc
INNER JOIN data_analytics.product_category_name_translation AS pct
    ON pc.product_category_name = pct.product_category_name
INNER JOIN data_analytics.order_items AS ori
    ON pc.product_id = ori.product_id
GROUP BY pct.product_category_name_english
ORDER BY sales_value DESC;
