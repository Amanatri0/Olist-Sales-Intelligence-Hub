-- Question #3 and #7 combine analysis with validation and unmapped categorical orders as well as price


SELECT
    pt.product_category_name_english AS category,
    COUNT(distinct o.order_id) AS order_count,
    ROUND(SUM(oi.price),2) AS total_item_value,
    ROUND(
        SUM(oi.price) / COUNT(distinct o.order_id) , 2
    ) AS avg_item_value
FROM data_analytics.order_items AS oi
INNER JOIN data_analytics.orders AS o
    ON oi.order_id = o.order_id
INNER JOIN data_analytics.products AS p
    ON oi.product_id = p.product_id
INNER JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name
WHERE o.order_purchase_timestamp >= '2017-01-01'
    AND o.order_purchase_timestamp < '2018-09-01'
    AND pt.product_category_name_english IS NOT NULL
GROUP BY category
ORDER BY avg_item_value DESC;


-- Question 3 validation for unmapped orders

SELECT
    COUNT(*) AS total_order_item_rows,

    COUNT(
        pt.product_category_name_english
    ) AS mapped_order_item_rows,

    COUNT(*) -
    COUNT(
        pt.product_category_name_english
    ) AS unmapped_order_item_rows,

    ROUND(
        100.0 * COUNT(pt.product_category_name_english)
        / COUNT(*),
        2
    ) AS mapping_coverage_pct

FROM data_analytics.order_items AS oi

INNER JOIN data_analytics.orders AS o
    ON oi.order_id = o.order_id

INNER JOIN data_analytics.products AS p
    ON oi.product_id = p.product_id

LEFT JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name

WHERE o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp < '2018-09-01';



--  Question 7 validation for unmapped price without frieght value

SELECT
    COUNT(*) AS unmapped_order_item_rows,
    ROUND(SUM(oi.price), 2) AS unmapped_item_value,
    ROUND(SUM(oi.freight_value), 2) AS unmapped_freight_value
FROM data_analytics.order_items AS oi

INNER JOIN data_analytics.orders AS o
    ON oi.order_id = o.order_id

INNER JOIN data_analytics.products AS p
    ON oi.product_id = p.product_id

LEFT JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name

WHERE o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp < '2018-09-01'
  AND pt.product_category_name_english IS NULL;

