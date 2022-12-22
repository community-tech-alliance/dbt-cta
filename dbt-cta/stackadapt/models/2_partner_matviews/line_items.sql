{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM {{ source('cta','line_items_base') }}