
SELECT
    *
FROM  {{ source('cta', 'ecommerce_purchases_item_id_report_base') }}