-- Question #1 How has order volume changed over time?

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month,
    COUNT(DISTINCT order_id) AS order_count
FROM data_analytics.orders
GROUP BY order_month
ORDER BY order_month ;