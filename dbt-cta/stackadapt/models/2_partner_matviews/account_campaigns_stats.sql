{{ config(
    auto_refresh = false,
    full_refresh = false
) }}
SELECT * FROM source('cta','account_campaigns_stats_base')