SELECT 
    sel.seller_id as no_seller, 
    COUNT(distinct oi.order_id) as order_count,
    ROUND(SUM(oi.price), 2) AS order_revenue,
    ROUND(AVG(oi.price),2) AS avg_price,
    pdt.product_category_name_english AS product_category
FROM data_analytics.sellers as sel 
INNER JOIN data_analytics.order_items as oi 
    ON sel.seller_id = oi.seller_id 
INNER JOIN data_analytics.products AS pd
    ON oi.product_id = pd.product_id
INNER JOIN data_analytics.product_category_name_translation as pdt
    ON pd.product_category_name = pdt.product_category_name
GROUP BY sel.seller_id, 
    pdt.product_category_name_english
ORDER BY order_revenue DESC 
    LIMIT 10;
