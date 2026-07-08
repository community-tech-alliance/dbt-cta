{{ config(
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'twilio_calls') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    sid,
    scan_id,
    user_id,
    remote_id,
    created_at,
    updated_at,
    from_number,
    phone_number,
    disconnected_at,
    twilio_recording_sid,
   {{ dbt_utils.surrogate_key([
     'id',
    'sid',
    'scan_id',
    'user_id',
    'remote_id',
    'from_number',
    'phone_number',
    'twilio_recording_sid'
    ]) }} as _airbyte_twilio_calls_hashid
from {{ source('cta', 'twilio_calls') }}
