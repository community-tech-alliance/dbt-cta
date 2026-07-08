{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'timeline_events') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   date,
   action,
   finding,
   created_at,
   updated_at,
   created_by_user_id,
   performance_review_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'date',
    'action',
    'finding',
    'created_by_user_id',
    'performance_review_id'
    ]) }} as _airbyte_timeline_events_hashid
from {{ source('cta', 'timeline_events') }}
