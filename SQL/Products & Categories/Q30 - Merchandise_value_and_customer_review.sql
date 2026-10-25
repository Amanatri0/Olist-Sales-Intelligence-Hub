-- Question #30 Which categories have high merchandise value but poor customer satisfaction?

SELECT
    pt.product_category_name_english AS category,
    ROUND(SUM(oi.price),2) AS merchandise_order_value,
    SUM(review_score) AS total_review_score_by_category
FROM data_analytics.order_reviews AS orr
INNER JOIN data_analytics.order_items AS oi
    ON orr.order_id = oi.order_id
INNER JOIN data_analytics.orders AS o
    ON oi.order_id = o.order_id
INNER JOIN data_analytics.products AS p
    ON p.product_id = oi.product_id
INNER JOIN data_analytics.product_translation AS pt
    ON p.product_category_name = pt.product_category_name
WHERE o.order_purchase_timestamp >= '2017-01-01'
    AND o.order_purchase_timestamp < '2018-09-01'
GROUP BY pt.product_category_name_english ;


SELECT
    order_id,
    COUNT(*) AS review_count
FROM data_analytics.order_reviews
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY review_count DESC;

SELECT
    review_id,
    COUNT(*) AS record_count
FROM data_analytics.order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

SELECT
    review_id,
    order_id,
    review_score
FROM data_analytics.order_reviews
WHERE order_id = 'c88b1d1b157a9999ce368f218a407141';

SELECT
    COUNT(*) AS total_review_records,
    COUNT(DISTINCT review_id) AS unique_review_ids,
    COUNT(DISTINCT order_id) AS unique_orders
FROM data_analytics.order_reviews;

SELECT
    review_id,
    COUNT(*) AS record_count,
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT review_score) AS distinct_scores
FROM data_analytics.order_reviews
GROUP BY review_id
HAVING COUNT(*) > 1
ORDER BY record_count DESC;