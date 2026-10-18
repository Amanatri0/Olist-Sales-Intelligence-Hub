-- Question #7 Which product categories generate the highest merchandise item value?

SELECT
    pt.product_category_name_english AS category, 
    ROUND(SUM(oi.price),2) AS total_item_value
FROM data_analytics.order_items AS oi
INNER JOIN data_analytics.orders AS o
    ON oi.order_id = o.order_id
INNER JOIN data_analytics.products AS p
    ON oi.product_id = p.product_id
INNER JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name
WHERE  o.order_purchase_timestamp >= '2017-01-01'
    AND o.order_purchase_timestamp < '2018-09-01'
    AND pt.product_category_name_english IS NOT NULL
GROUP BY pt.product_category_name_english
ORDER BY SUM(oi.price) DESC;

