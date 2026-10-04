-- Question #10 How does order value vary by payment method?


-- Number of orders with having more than 1 payment types eg-: (credit card + voucher)

SELECT 
    order_id,
    COUNT(distinct payment_type)
FROM data_analytics.payments AS p
GROUP BY order_id
HAVING COUNT(distinct payment_type) > 1;

-- Count of the total number of orders with having more than 1 payment types eg-: (credit card + voucher)

SELECT
    COUNT(*) AS orders_with_multiple_payment_types
FROM
(
    SELECT
        order_id
    FROM data_analytics.payments
    GROUP BY order_id
    HAVING COUNT(DISTINCT payment_type) > 1
) AS multi_payment_orders;

-- Actually answering the question after analysing, we are taking payment_values in account as there are 2246 payments done via different payment methods

SELECT 
    payment_type,
    COUNT(*) AS payment_records,
    COUNT(distinct order_id) AS unique_orders,
    ROUND(SUM(payment_value),2) AS payment_value,
    ROUND(AVG(payment_value),2) AS avg_payment_value
FROM data_analytics.payments AS p
WHERE payment_type != 'not_defined'
GROUP BY payment_type
ORDER BY payment_value DESC;


-- 3 payment methods are not defined 
SELECT *
FROM data_analytics.payments
WHERE payment_type = 'not_defined';


-- checking there status in order table

SELECT
    p.order_id,
    p.payment_type,
    p.payment_value,
    o.order_status,
    o.order_purchase_timestamp
FROM data_analytics.payments AS p
INNER JOIN data_analytics.orders AS o
    ON o.order_id = p.order_id
WHERE p.payment_type = 'not_defined';

