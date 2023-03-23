{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_account_report_hashid'
) }}

-- depends_on: {{ source('cta', 'account_report_base') }}

SELECT
    *
FROM {{ source('cta', 'account_report_base') }}
