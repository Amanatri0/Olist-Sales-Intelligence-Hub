-- Question #12 What is the average delivery time?


SELECT
    ROUND(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),2) AS avg_delivery_date
FROM data_analytics.orders
WHERE order_delivered_customer_date IS NOT NULL ;


-- finding the delivery days from the purchase time and the delayed days from the estimated delivery

SELECT
    order_id,
    DATE_FORMAT(order_purchase_timestamp, '%d-%m-%y') AS purchase_time,
    DATE_FORMAT(order_delivered_customer_date, '%d-%m-%y') AS order_delivered,
    DATE_FORMAT(order_estimated_delivery_date, '%d-%m-%y') AS estimated_date_of_delivery,
    DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS order_delivered_in_days,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS order_delayed_in_days
FROM data_analytics.orders
WHERE order_delivered_customer_date IS NOT NULL 
ORDER BY order_delayed_in_days DESC;


-- Maximum and minimum days taken to deliver orders

SELECT
    MAX(order_delayed_in_days) AS max_time_taken,
    MIN(order_delayed_in_days) AS min_time_taken
FROM(
SELECT
    order_id,
    DATE_FORMAT(order_purchase_timestamp, '%d-%m-%y') AS purchase_time,
    DATE_FORMAT(order_delivered_customer_date, '%d-%m-%y') AS order_delivered,
    DATE_FORMAT(order_estimated_delivery_date, '%d-%m-%y') AS estimated_date_of_delivery,
    DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS order_delivered_in_days,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS order_delayed_in_days
FROM data_analytics.orders
WHERE order_delivered_customer_date IS NOT NULL
ORDER BY order_delayed_in_days DESC) AS time_taken;


-- Maximum and minimum days taken to deliver orders

SELECT
    order_delayed_in_days,
    COUNT(order_id) AS delayed_order_count
FROM(
    SELECT
    order_id,
    DATE_FORMAT(order_purchase_timestamp, '%d-%m-%y') AS purchase_time,
    DATE_FORMAT(order_delivered_customer_date, '%d-%m-%y') AS order_delivered,
    DATE_FORMAT(order_estimated_delivery_date, '%d-%m-%y') AS estimated_date_of_delivery,
    DATEDIFF(order_delivered_customer_date, order_purchase_timestamp) AS order_delivered_in_days,
    DATEDIFF(order_delivered_customer_date, order_estimated_delivery_date) AS order_delayed_in_days
    FROM data_analytics.orders
) AS time_taken
GROUP BY order_delayed_in_days
ORDER BY order_delayed_in_days DESC;
