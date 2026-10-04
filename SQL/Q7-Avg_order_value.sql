-- Question #6: What is the average order value?

SELECT
    ROUND(AVG(order_value),2) AS avg_order_value
FROM (SELECT
    order_id AS orders,
    ROUND(SUM(price),2) AS order_value
FROM data_analytics.order_items
GROUP BY order_id
ORDER BY ROUND(AVG(price),2) DESC
) AS orders;


-- Sum of all the orders

SELECT
    order_id AS orders,
    ROUND(SUM(price),2) AS order_value
FROM data_analytics.order_items
GROUP BY order_id
ORDER BY ROUND(AVG(price),2) DESC;