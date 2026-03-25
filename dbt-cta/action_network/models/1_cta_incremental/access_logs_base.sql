{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('access_logs_ab1') }}
select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    details,
    user_id,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type,
    action_taken
from {{ ref('access_logs_ab1') }}
