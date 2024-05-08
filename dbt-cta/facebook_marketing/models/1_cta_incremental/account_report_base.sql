{{
    config(
        cluster_by="_airbyte_extracted_at",
        partition_by={
            "field": "_airbyte_extracted_at",
            "data_type": "timestamp",
            "granularity": "day",
        },
        unique_key="_account_report_hashid",
    )
}}

-- depends_on: {{ ref('ads_insights_base') }}
with
    aggregations as (
        select
            date_start,
            account_id,
            account_name,
            sum(clicks) as clicks,
            sum(impressions) as impressions,
            sum(spend) as spend,
            max(_airbyte_extracted_at) as _airbyte_extracted_at
        from {{ ref("ads_insights_base") }}
        group by date_start, account_id, account_name
    )

select
    *,
    {{ dbt_utils.surrogate_key(["date_start", "account_id", "account_name"]) }}
    as _account_report_hashid,
    current_timestamp as _airbyte_normalized_at
from aggregations
