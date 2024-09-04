{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ads_insights_overall_hashid'
) }}


select * except (rownum) from
    (
        select
            *,
            row_number() over (partition by _airbyte_ads_insights_overall_hashid order by _airbyte_extracted_at desc) as rownum
        from {{ ref('ads_insights_overall_ab4') }}
    )
where rownum = 1
