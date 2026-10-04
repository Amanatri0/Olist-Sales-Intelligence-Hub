-- Question #5 Which sellers contribute the most order volume?

-- Here the highest order volume doesn't necessary generates the highest revenue

SELECT 
    distinct sel.seller_id as no_seller, 
    COUNT(distinct oi.order_id) as order_count,
    ROUND(SUM(oi.price), 2) AS order_revenue,
    ROUND(AVG(oi.price),2) AS avg_price
FROM data_analytics.sellers as sel 
INNER JOIN data_analytics.order_items as oi 
    ON sel.seller_id = oi.seller_id 
GROUP BY sel.seller_id 
ORDER BY COUNT(distinct oi.order_id) DESC LIMIT 10;