{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'zip'
) }}

-- SQL model to get latest `zip_code` values
-- depends_on: {{ ref('zip_code_ab3') }}

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY zip ORDER BY _airbyte_extracted_at desc) as rownum 
FROM {{ ref('zip_code_ab3') }}
)
where rownum=1