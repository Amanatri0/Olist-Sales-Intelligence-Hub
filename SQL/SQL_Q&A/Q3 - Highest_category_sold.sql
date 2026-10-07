-- Question #3 Which product categories generate the highest number of items sold?

SELECT
    pt.product_category_name_english AS product_category,
    ROUND(SUM(oi.price),0) AS sales_volume,
    COUNT(*) AS items_sold
FROM data_analytics.order_items AS oi
INNER JOIN data_analytics.products AS p
    ON oi.product_id = p.product_id
INNER JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name
GROUP BY product_category
ORDER BY sales_volume DESC;