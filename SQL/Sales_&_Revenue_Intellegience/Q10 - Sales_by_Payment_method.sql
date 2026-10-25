-- Question #10 How does order value vary by payment method?

SELECT
        payment_type,
        ROUND(SUM(p.payment_value),2) AS sales_value,
        COUNT(DISTINCT p.order_id) AS order_counts,
        ROUND(SUM(p.payment_value) / COUNT(DISTINCT p.order_id),2) AS avg_sales
    FROM data_analytics.payments AS p
    INNER JOIN data_analytics.orders AS o
        ON p.order_id = o.order_id
    WHERE payment_type != 'not_defined'
           AND o.order_purchase_timestamp >= '2017-01-01'
           AND o.order_purchase_timestamp < '2018-09-01'
    GROUP BY payment_type
    ORDER BY sales_value DESC;