-- Question #5 Which sellers contribute most order volume?

SELECT
    se.seller_id AS seller,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM data_analytics.sellers AS se
INNER JOIN data_analytics.order_items AS oi
    ON se.seller_id = oi.seller_id
GROUP BY seller
ORDER BY total_orders DESC;