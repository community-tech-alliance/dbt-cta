{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_regions_hashid'
) }}

-- SQL model to dedupe on the hashid field calculated in *_ab3
-- (this step is included because the data source seems to include duplicate rows)
-- depends_on: {{ ref('regions_ab3') }}

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY _airbyte_regions_hashid ORDER BY _airbyte_emitted_at desc) as rownum 
FROM {{ ref('regions_ab3') }}
)
where rownum=1