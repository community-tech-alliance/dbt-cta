{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
select * from {{ source('cta','account_line_items_stats_base') }}
