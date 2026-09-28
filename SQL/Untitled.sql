SELECT 
YEAR(order_purchase_timestamp) AS order_year,
COUNT(DISTINCT order_id) AS order_count,
LAG(COUNT(DISTINCT order_id),1) OVER(ORDER BY YEAR(order_purchase_timestamp)) AS previous_year_order_count,
ROUND(
    (COUNT(DISTINCT order_id) - LAG(COUNT(DISTINCT order_id),1) OVER(ORDER BY YEAR(order_purchase_timestamp))) /
    LAG(COUNT(DISTINCT order_id),1) OVER(ORDER BY YEAR(order_purchase_timestamp)) * 100,2) 
    AS total_growth_compared_to_last_year
FROM data_analytics.orders
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY YEAR(order_purchase_timestamp);