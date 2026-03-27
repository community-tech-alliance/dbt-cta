{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}
-- depends_on: {{ source('cta', 'ladder_logs') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    exit,
    user_id,
    group_id,
    ladder_id,
    step_uuid,
    created_at,
    updated_at
from {{ source('cta', 'ladder_logs') }}
