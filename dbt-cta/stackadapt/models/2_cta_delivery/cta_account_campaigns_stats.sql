{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
select * from {{ source('cta','account_campaigns_stats_base') }}