{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_stats_daily_hashid'
) }}

select
    *
FROM {{ source('cta', 'ad_stats_base') }}
