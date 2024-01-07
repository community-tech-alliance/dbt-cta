
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quality_control_schedules') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   date,
   user_type,
   updated_at,
   user_id,
   minutes,
   created_at,
   id,
   {{ dbt_utils.surrogate_key([
     'date',
    'user_type',
    'user_id',
    'minutes',
    'id'
    ]) }} as _airbyte_quality_control_schedules_hashid
from {{ source('cta', 'quality_control_schedules') }}