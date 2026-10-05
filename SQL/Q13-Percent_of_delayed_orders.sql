-- Question #13 What percentage of delivered orders were delivered after the estimated delivery date?


SELECT
    (late_orders * 100.0 / total_orders) AS late_percentage
FROM
(
    SELECT COUNT(distinct order_id) AS total_orders
    FROM data_analytics.orders
    WHERE order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
) AS total
CROSS JOIN
(
    SELECT COUNT(distinct order_id) AS late_orders
    FROM data_analytics.orders
    WHERE order_delivered_customer_date IS NOT NULL
      AND order_estimated_delivery_date IS NOT NULL
      AND DATEDIFF(
          order_delivered_customer_date,
          order_estimated_delivery_date
      ) > 0
) AS late;



-- we were able to find that highest number of orders delayed in days are 14  


SELECT
    distinct order_id,
    order_status,
    order_purchase_timestamp,
    order_delivered_customer_date,
    order_estimated_delivery_date,
    DATEDIFF(
       order_delivered_customer_date,
        order_estimated_delivery_date
    ) AS delay_days
FROM data_analytics.orders
WHERE DATEDIFF(
       order_delivered_customer_date,
        order_estimated_delivery_date
    ) = 14;

