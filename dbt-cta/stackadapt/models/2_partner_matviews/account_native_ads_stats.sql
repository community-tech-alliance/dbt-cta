{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
select * from {{ source('cta','account_native_ads_stats_base') }}
