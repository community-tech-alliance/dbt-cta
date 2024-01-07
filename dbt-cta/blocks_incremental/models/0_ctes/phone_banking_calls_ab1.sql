
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
   notes,
   phone_bank_id,
   round_canvass_status,
   called_by_user_id,
   participated,
   twilio_call_id,
   extras,
   created_at,
   non_participation_reason,
   external,
   round,
   updated_at,
   locked_at,
   locked_by_user_id,
   id,
   status,
   person_id,
   {{ dbt_utils.surrogate_key([
     'notes',
    'phone_bank_id',
    'round_canvass_status',
    'called_by_user_id',
    'participated',
    'twilio_call_id',
    'extras',
    'non_participation_reason',
    'external',
    'round',
    'locked_by_user_id',
    'id',
    'status',
    'person_id'
    ]) }} as _airbyte_phone_banking_calls_hashid
from {{ source('cta', 'phone_banking_calls') }}