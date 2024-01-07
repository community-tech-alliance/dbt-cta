
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
   notes,
   canvasser_id,
   trigger_id,
   reviewed_at,
   created_at,
   completed_at,
   ready_at,
   updated_at,
   packet_id,
   action_plan,
   triggered_by_shift_id,
   id,
   status,
   {{ dbt_utils.surrogate_key([
     'notes',
    'canvasser_id',
    'trigger_id',
    'packet_id',
    'action_plan',
    'triggered_by_shift_id',
    'id',
    'status'
    ]) }} as _airbyte_quality_control_flags_hashid
from {{ source('cta', 'quality_control_flags') }}