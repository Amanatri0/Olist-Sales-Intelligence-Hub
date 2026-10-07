-- Question #10 How does order value vary by payment method?

SELECT
        payment_type,
        ROUND(SUM(payment_value),2) AS sales_value,
        COUNT(DISTINCT order_id) AS order_counts,
        ROUND(SUM(payment_value) / COUNT(DISTINCT order_id),2) AS avg_sales
    FROM data_analytics.payments AS p
    WHERE payment_type != 'not_defined'
    GROUP BY payment_type
    ORDER BY sales_value DESC;