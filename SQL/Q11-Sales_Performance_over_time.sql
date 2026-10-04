-- Question #11: How does sales performance change over time?

SELECT
    DATE_FORMAT(o.order_purchase_timestamp, '%y-%m') AS Months,
    ROUND(SUM(oi.price),2) AS sales_value,
    COUNT(distinct oi.order_id) AS order_count
FROM data_analytics.orders AS o
INNER JOIN data_analytics.order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp < '2018-09-01'
GROUP BY Months
ORDER BY Months;

