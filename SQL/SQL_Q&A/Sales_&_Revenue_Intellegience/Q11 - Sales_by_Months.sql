-- Question #11 How does sales performance change over time?

SELECT
    DATE_FORMAT(od.order_purchase_timestamp, '%m-%y') AS order_months,
    ROUND(SUM(p.payment_value),2) AS sales
FROM data_analytics.payments AS p
INNER JOIN data_analytics.orders AS od
    ON p.order_id = od.order_id
GROUP BY order_months
ORDER BY sales DESC;