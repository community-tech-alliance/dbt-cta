{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'zip_code'
) }}

-- SQL model to get latest `zip_code` values
-- depends_on: {{ ref('zip_code_ab3') }}

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY zip_code ORDER BY _airbyte_emitted_at desc) as rownum 
FROM {{ ref('zip_code_ab3') }}
)
where rownum=1