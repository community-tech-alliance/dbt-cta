{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'activities') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    type,
    user_id,
    object_id,
    created_at,
    updated_at,
    object_type,
    occurred_at,
    {{ dbt_utils.surrogate_key([
        'id',
        'type',
        'user_id',
        'object_id',
        'object_type'
    ]) }} as _airbyte_activities_hashid
from {{ source('cta', 'activities') }}
