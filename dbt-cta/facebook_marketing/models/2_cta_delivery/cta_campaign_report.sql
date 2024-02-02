{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_campaign_report_hashid'
) }}

-- depends_on: {{ source('cta', 'campaign_report_base') }}

SELECT
    *
FROM {{ source('cta', 'campaign_report_base') }}
