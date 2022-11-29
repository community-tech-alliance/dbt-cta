{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_account_report_hashid'
) }}

-- depends_on: {{ source('cta', 'account_report_base') }}

SELECT
     _account_report_hashid
    ,MAX(date_start) as date_start
    ,MAX(account_id) as account_id
    ,MAX(account_name) as account_name
    ,MAX(clicks) as clicks
    ,MAX(impressions) as impressions
    ,MAX(spend) as spend
    ,MAX(_airbyte_emitted_at) as _airbyte_emitted_at
    ,MAX(_airbyte_normalized_at) as _airbyte_normalized_at
FROM {{ source('cta', 'account_report_base') }}
GROUP BY _account_report_hashid