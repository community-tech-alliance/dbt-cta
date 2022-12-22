{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM source('cta','account_native_ads_stats_creatives_base')