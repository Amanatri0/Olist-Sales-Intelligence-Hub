-- Question #6 What is average order value?

SELECT
    ROUND(AVG(sales),2) AS avg_volume
FROM (
    SELECT
    order_id AS order_volume,
    ROUND(SUM(price),2) AS sales
FROM data_analytics.order_items
GROUP BY order_id
) AS orders_details;



SELECT
    order_id AS order_volume,
    ROUND(SUM(price),2) AS sales
FROM data_analytics.order_items
GROUP BY order_id