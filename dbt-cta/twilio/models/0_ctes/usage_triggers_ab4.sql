{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_usage_triggers_hashid',
    tags = [ "top-level-intermediate" ]
) }}
-- depends_on: {{ ref('usage_triggers_ab3') }}
-- ensures the base model contains only one row per id

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_usage_triggers_hashid ORDER BY _airbyte_emitted_at desc) as rownum 
FROM {{ ref('usage_triggers_ab3') }}
)
where rownum=1