-- ### Q3 — Category Demand: Data Quality and Join Validation

SELECT
    c.product_category_name_english AS product_category,
    COUNT(DISTINCT o.order_id) AS order_count
FROM data_analytics.order_items AS o
INNER JOIN data_analytics.products AS p
    ON o.product_id = p.product_id
INNER JOIN data_analytics.product_translation AS c
    ON p.product_category_name = c.product_category_name
GROUP BY c.product_category_name_english
ORDER BY order_count DESC;


-- **Objective:** Validate the product and category relationships before finalizing the category order-count ranking.
-- 
-- **Validation performed:**
-- 1. Checked `df_category` for duplicate `product_category_name` keys. No duplicates were returned.
-- 2. Checked `df_products` for duplicate `product_id` values. No duplicates were returned.
-- 3. Used `LEFT JOIN` diagnostics to assess missing product and category relationships.
-- 4. Reconciled the total order-item row count against the category-mapping coverage.
-- 
-- **Results:**
-- - Total order-item rows: 112,650
-- - Mapped category rows: 111,023
-- - Unmapped category rows: 1,627
-- - Category mapping coverage: 98.56%
-- - Unmapped row percentage: 1.44%
-- 
-- **Conclusion:** The validation checks support the current join assumptions. Category-level results exclude order-item rows without a valid category mapping. This limitation must be documented when presenting the category-demand findings.

SELECT
    COUNT(*) AS total_order_item_rows,
    COUNT(c.product_category_name) AS mapped_order_item_rows,
    COUNT(*) - COUNT(c.product_category_name)
        AS unmapped_order_item_rows
FROM data_analytics.order_items AS oi
LEFT JOIN data_analytics.products AS p
    ON oi.product_id = p.product_id
LEFT JOIN data_analytics.product_translation AS c
    ON p.product_category_name = c.product_category_name;
