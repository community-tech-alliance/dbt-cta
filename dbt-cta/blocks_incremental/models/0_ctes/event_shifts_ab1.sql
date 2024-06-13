
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'event_shifts') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   end_time,
   event_id,
   created_at,
   start_time,
   updated_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'event_id'
    ]) }} as _airbyte_event_shifts_hashid
from {{ source('cta', 'event_shifts') }}