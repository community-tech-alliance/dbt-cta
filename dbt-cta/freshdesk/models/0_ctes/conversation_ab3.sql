{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- SQL model to get latest `date_updated` values for each sid
-- depends_on: {{ ref('conversation_ab2') }}

SELECT * FROM 
(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY _airbyte_emitted_at desc) as rownum 
FROM {{ ref('conversation_ab2') }}
)
where rownum=1