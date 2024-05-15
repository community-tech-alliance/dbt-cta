{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_insights_platform_and_device_hashid'
) }}

-- depends_on: {{ source('cta', 'ads_insights_platform_and_device_base') }}

SELECT
    *
FROM {{ source('cta', 'ads_insights_platform_and_device_base') }}
