{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM {{ source('cta','account_line_items_stats_base') }}