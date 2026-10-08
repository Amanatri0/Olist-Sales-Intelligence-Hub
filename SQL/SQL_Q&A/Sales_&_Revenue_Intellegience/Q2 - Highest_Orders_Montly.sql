SELECT 
    DATE_FORMAT(order_purchase_timestamp, '%y-%m') AS order_months,
    COUNT(DISTINCT order_id) AS order_counts
FROM data_analytics.orders
WHERE order_purchase_timestamp >= '2017-01-01' AND
      order_purchase_timestamp < '2018-09-01'
GROUP BY order_months
ORDER BY order_counts DESC;

