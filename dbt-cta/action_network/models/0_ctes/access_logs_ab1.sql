{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- depends_on: {{ source('cta', 'access_logs') }}

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
from {{ source('cta', 'access_logs') }}