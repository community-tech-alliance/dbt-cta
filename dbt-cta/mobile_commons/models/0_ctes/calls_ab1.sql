{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'calls') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    email,
    profile,
    duration,
    end_time,
    mconnect,
    voicemail,
    start_time,
    call_status,
    voip_number,
    carrier_name,
    transcription,
    handset_number,
    profile_status,
    connection_source,
    destination_number,
    voicemail_duration,
    profile_status_at_call_time,
   {{ dbt_utils.surrogate_key([
     'id',
    'email',
    'duration',
    'end_time',
    'voicemail',
    'start_time',
    'call_status',
    'voip_number',
    'carrier_name',
    'transcription',
    'handset_number',
    'profile_status',
    'connection_source',
    'destination_number',
    'voicemail_duration',
    'profile_status_at_call_time'
    ]) }} as _airbyte_calls_hashid
from {{ source('cta', 'calls') }}
