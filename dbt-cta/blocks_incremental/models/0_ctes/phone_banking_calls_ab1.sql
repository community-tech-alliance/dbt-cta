
{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_banking_calls') }}

select
   _airbyte_raw_id,
   _airbyte_extracted_at,
   _airbyte_meta,
   id,
   notes,
   round,
   extras,
   status,
   external,
   locked_at,
   person_id,
   created_at,
   updated_at,
   participated,
   phone_bank_id,
   twilio_call_id,
   called_by_user_id,
   locked_by_user_id,
   round_canvass_status,
   non_participation_reason,
   {{ dbt_utils.surrogate_key([
     'id',
    'notes',
    'round',
    'extras',
    'status',
    'external',
    'person_id',
    'participated',
    'phone_bank_id',
    'twilio_call_id',
    'called_by_user_id',
    'locked_by_user_id',
    'round_canvass_status',
    'non_participation_reason'
    ]) }} as _airbyte_phone_banking_calls_hashid
from {{ source('cta', 'phone_banking_calls') }}