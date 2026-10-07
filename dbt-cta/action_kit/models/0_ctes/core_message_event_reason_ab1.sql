{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = ['id', 'created_at']
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'core_message_event_reason') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    _airbyte_generation_id,
    id,
    reason,
    created_at,
    hash_reason
from {{ source('cta', 'core_message_event_reason') }}
