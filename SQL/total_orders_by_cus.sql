-- Question #4 Which states generate the most customers and orders?

SELECT 
  cus.customer_unique_id,
    COUNT(distinct ord.order_id) AS total_orders
FROM data_analytics.customers AS cus
INNER JOIN data_analytics.orders AS ord
    ON cus.customer_id = ord.customer_id
GROUP BY cus.customer_unique_id
ORDER BY COUNT(order_id) DESC;