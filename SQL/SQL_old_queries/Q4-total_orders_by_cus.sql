-- Question #4 Which states generate the most customers and orders?

SELECT
  cus.customer_state AS customer_state,
  COUNT(distinct cus.customer_unique_id) AS no_unique_customers,
  COUNT(distinct ord.order_id) AS total_orders
FROM data_analytics.customers AS cus
INNER JOIN data_analytics.orders AS ord
  ON cus.customer_id = ord.customer_id
GROUP BY customer_state
ORDER BY COUNT(distinct cus.customer_unique_id) DESC;


-- City wise data

SELECT
  cus.customer_city AS customer_city,
  COUNT(distinct cus.customer_unique_id) AS no_unique_customers,
  COUNT(distinct ord.order_id) AS total_orders
FROM data_analytics.customers AS cus
INNER JOIN data_analytics.orders AS ord
  ON cus.customer_id = ord.customer_id
GROUP BY customer_city
ORDER BY COUNT(distinct cus.customer_unique_id) DESC;

