{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_tasks_hashid"
) }}

-- Final base SQL model
-- depends_on: {{ ref('tasks_ab2') }}
select * except (_airbyte_raw_id)
from {{ ref('tasks_ab2') }}
