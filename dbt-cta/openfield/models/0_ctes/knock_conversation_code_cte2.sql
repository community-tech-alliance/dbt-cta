{{ config(
    cluster_by = "_cta_loaded_at",
    partition_by = {"field": "_cta_loaded_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_knock_conversation_code_hashid',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('knock_conversation_code_cte1') }}
-- ensures the base model contains only one row per id

select * from
    (
        select
            *,
            row_number() over (partition by _knock_conversation_code_hashid order by _cta_loaded_at desc) as rownum
        from {{ ref('knock_conversation_code_cte1') }}
    )
where rownum = 1
