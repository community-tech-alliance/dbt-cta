
SELECT
    *
FROM  {{ source('cta', 'ecommerce_purchases_item_brand_report_base') }}