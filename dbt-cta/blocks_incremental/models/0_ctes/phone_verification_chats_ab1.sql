{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_verification_chats') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   _airbyte_generation_id,
   id,
   notes,
   status,
   form_id,
   messages,
   updated_at,
   inserted_at,
   phone_number,
   non_participation_reason,
   {{ dbt_utils.surrogate_key([
     'id',
    'notes',
    'status',
    'form_id',
    'messages',
    'phone_number',
    'non_participation_reason'
    ]) }} as _airbyte_phone_verification_chats_hashid
from {{ source('cta', 'phone_verification_chats') }}
