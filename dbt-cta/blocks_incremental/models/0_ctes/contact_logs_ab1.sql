{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'contact_logs') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   meta,
   notes,
   user_id,
   person_id,
   created_at,
   updated_at,
   contact_type,
   contacted_at,
   {{ dbt_utils.surrogate_key([
     'id',
    'meta',
    'notes',
    'user_id',
    'person_id',
    'contact_type'
    ]) }} as _airbyte_contact_logs_hashid
from {{ source('cta', 'contact_logs') }}
