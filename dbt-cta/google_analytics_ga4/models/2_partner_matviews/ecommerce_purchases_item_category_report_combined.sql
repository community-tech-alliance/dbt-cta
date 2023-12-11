
SELECT
    *
FROM  {{ source('cta', 'ecommerce_purchases_item_category_report_combined_base') }}