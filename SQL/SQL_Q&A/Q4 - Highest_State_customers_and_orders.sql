-- Question #4 Which states generate most customers and orders?

SELECT
    cus.customer_state AS customer_state,
    COUNT(DISTINCT cus.customer_unique_id) AS no_customers,
    COUNT(DISTINCT od.order_id) AS order_volume
FROM data_analytics.customers AS cus
INNER JOIN data_analytics.orders AS od
    ON cus.customer_id = od.customer_id
GROUP BY customer_state
ORDER BY no_customers DESC;