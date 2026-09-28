/*
    Order volume generally increased throughout 2017, rising from 800 orders in January to 5,673 in December, 
    with several month-to-month fluctuations. November recorded the highest monthly volume at 7,544 orders.
*/

SELECT 
DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_date,
COUNT(distinct order_id) AS order_count
FROM data_analytics.orders
GROUP BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m')
ORDER BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m');


-- 

SELECT 
DATE_FORMAT(order_purchase_timestamp, '%Y-%m-%d') AS order_date
FROM data_analytics.orders
WHERE YEAR(order_purchase_timestamp) = 2016 AND MONTH(order_purchase_timestamp) = 10
ORDER BY MONTH(order_purchase_timestamp);
