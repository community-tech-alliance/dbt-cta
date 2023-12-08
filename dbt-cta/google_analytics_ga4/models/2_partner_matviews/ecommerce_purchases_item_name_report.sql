
SELECT
    *
FROM  {{ source('cta', 'ecommerce_purchases_item_name_report_base') }}