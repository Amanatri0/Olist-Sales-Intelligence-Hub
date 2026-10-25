
WITH order_reviews_avg AS (
    -- Step 1: Calculate one average review score per order
    SELECT
        order_id,
        AVG(review_score) AS avg_review_score
    FROM data_analytics.order_reviews
    GROUP BY order_id
),

category_order_scores AS (
    -- Step 2: Connect each order's score to its product categories
    SELECT DISTINCT
        o.order_id,
        pt.product_category_name_english AS category,
        ora.avg_review_score
    FROM data_analytics.orders AS o
    INNER JOIN order_reviews_avg AS ora
        ON o.order_id = ora.order_id
    INNER JOIN data_analytics.order_items AS oi
        ON o.order_id = oi.order_id
    INNER JOIN data_analytics.products AS p
        ON oi.product_id = p.product_id
    INNER JOIN data_analytics.product_translation AS pt
        ON p.product_category_name = pt.product_category_name
    WHERE o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp < '2018-09-01'
      AND pt.product_category_name_english IS NOT NULL
),

category_satisfaction AS (
    -- Step 3: Calculate satisfaction for each category
    SELECT
        category,
        COUNT(*) AS reviewed_order_count,
        ROUND(AVG(avg_review_score), 2) AS avg_category_review_score
    FROM category_order_scores
    GROUP BY category
),

category_metric AS (
    -- Step 4: Calculate merchandise value for each category
    SELECT
        pt.product_category_name_english AS category,
        COUNT(DISTINCT oi.order_id) AS order_count,
        ROUND(SUM(oi.price), 2) AS total_merchandise_value,
        ROUND(
            SUM(oi.price) / COUNT(DISTINCT oi.order_id), 2
        ) AS merchandise_value_per_order
    FROM data_analytics.order_items AS oi
    INNER JOIN data_analytics.orders AS o
        ON oi.order_id = o.order_id
    INNER JOIN data_analytics.products AS p
        ON oi.product_id = p.product_id
    INNER JOIN data_analytics.product_translation AS pt
        ON p.product_category_name = pt.product_category_name
    WHERE o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp < '2018-09-01'
      AND pt.product_category_name_english IS NOT NULL
    GROUP BY pt.product_category_name_english
)

-- Step 5: Combine both analyses and classify categories

SELECT
    cm.category,
    cm.order_count,
    cm.total_merchandise_value,
    cm.merchandise_value_per_order,
    cs.reviewed_order_count,
    cs.avg_category_review_score,

    CASE
        WHEN cm.merchandise_value_per_order > 125.62
            THEN 'High'
        WHEN cm.merchandise_value_per_order = 125.62
            THEN 'Median'
        ELSE 'Low'
    END AS merchandise_value_class,

    CASE
        WHEN cs.avg_category_review_score < 4.13
            THEN 'Below Median'
        WHEN cs.avg_category_review_score = 4.13
            THEN 'Median'
        ELSE 'Above Median'
    END AS satisfaction_class

FROM category_metric AS cm
INNER JOIN category_satisfaction AS cs
    ON cm.category = cs.category
WHERE cm.merchandise_value_per_order > 125.62
    AND cs.avg_category_review_score < 4.13





-- ##### To calculate the median for customer satisfaction score by review_score from the table order_reviews

-- category_satisfaction AS (
--     SELECT
--         category,
--         COUNT(*) AS category_order_count,
--         COUNT(avg_review_score) AS reviewed_order_count,
--         ROUND(AVG(avg_review_score), 2) AS avg_category_review_score
--     FROM category_order_scores
--     GROUP BY category
-- ),
-- satisfaction_ranked AS (
--     SELECT
--         avg_category_review_score,
--         ROW_NUMBER() OVER (
--             ORDER BY avg_category_review_score
--         ) AS score_rank,
--         COUNT(*) OVER () AS total_categories
--     FROM category_satisfaction
-- ),
-- satisfaction_median AS (
--     SELECT
--         AVG(avg_category_review_score) AS median_satisfaction
--     FROM satisfaction_ranked
--     WHERE score_rank IN (
--         FLOOR((total_categories + 1) / 2),
--         FLOOR((total_categories + 2) / 2)
--     )
-- )


