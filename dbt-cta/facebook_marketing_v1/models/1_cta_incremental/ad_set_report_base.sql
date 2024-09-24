{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_ad_set_report_hashid'
) }}

-- depends_on: {{ ref('ads_insights_overall_base') }}
with aggregations as (
    select
        date_start,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        adset_id,
        adset_name,
        timestamp_trunc(_airbyte_extracted_at, day) as _airbyte_extracted_at,
        sum(clicks) as clicks,
        sum(impressions) as impressions,
        sum(spend) as spend
    from {{ ref('ads_insights_overall_base') }}
    group by
        date_start,
        account_id,
        account_name,
        campaign_id,
        campaign_name,
        adset_id,
        adset_name,
        timestamp_trunc(_airbyte_extracted_at, day)
),

report_base as (
    select
        *,
    {{ dbt_utils.surrogate_key([
    'date_start',
    'adset_id'
    ]) }} as _ad_set_report_hashid,
        current_timestamp as _airbyte_normalized_at
    from aggregations
)


-- ensures the base model contains only one row per hashid
-- this deduplicates data even if the source data contains duplicate rows

select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _ad_set_report_hashid order by _airbyte_normalized_at desc) as rownum
        from report_base
    )
where rownum = 1
