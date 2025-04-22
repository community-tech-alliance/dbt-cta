{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quality_control_flags') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    notes,
    status,
    ready_at,
    shift_id,
    created_at,
    trigger_id,
    updated_at,
    action_plan,
    reviewed_at,
    completed_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'notes',
    'status',
    'trigger_id',
    'action_plan',
    'shift_id',
    ]) }} as _airbyte_quality_control_flags_hashid
from {{ source('cta', 'quality_control_flags') }}
