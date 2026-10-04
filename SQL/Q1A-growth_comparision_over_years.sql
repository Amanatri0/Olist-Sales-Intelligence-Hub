-- The dataset begins from September 2016 so we are excluding the year 2016 representing a partial period.
/* Initially checking the year on year growth i was shocked to find a massive growth on 13000% from 2016 - 2017, 
    while investigating further it was discovered that the dataset begins from September 2016 so we are excluding 
    the year 2016 which represents a partial period.
*/

SELECT 
YEAR(order_purchase_timestamp) AS order_year,
COUNT(DISTINCT order_id) AS order_count,
LAG(COUNT(DISTINCT order_id),1) OVER(ORDER BY YEAR(order_purchase_timestamp)) AS previous_year_order_count,
ROUND(
    (COUNT(DISTINCT order_id) - LAG(COUNT(DISTINCT order_id),1) OVER(ORDER BY YEAR(order_purchase_timestamp))) /
    LAG(COUNT(DISTINCT order_id),1) OVER(ORDER BY YEAR(order_purchase_timestamp)) * 100,2) 
    AS total_growth_compared_to_last_year
FROM data_analytics.orders
WHERE YEAR(order_purchase_timestamp) != 2016
GROUP BY YEAR(order_purchase_timestamp)
ORDER BY YEAR(order_purchase_timestamp);



-- Finds on 2016 year order counts

SELECT 
YEAR(order_purchase_timestamp) AS order_year,
MONTH(order_purchase_timestamp) AS order_month,
COUNT(distinct order_id) AS order_count
FROM data_analytics.orders
WHERE YEAR(order_purchase_timestamp) = 2016
GROUP BY YEAR(order_purchase_timestamp), MONTH(order_purchase_timestamp)
ORDER BY YEAR(order_purchase_timestamp);