-- Question #5 How many customer are repeating orders ?

SELECT
  total_orders,
  COUNT(customer_count) AS number_of_customer
FROM(
    SELECT 
        cus.customer_unique_id as customer_count,
        COUNT(distinct ord.order_id) AS total_orders
    FROM data_analytics.customers AS cus
    INNER JOIN data_analytics.orders AS ord
        ON cus.customer_id = ord.customer_id
    GROUP BY cus.customer_unique_id
) AS customer_orders_count
GROUP BY total_orders
ORDER BY total_orders
