{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'quality_control_phone_verification_calls') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    number,
    status,
    user_id,
    external,
    created_at,
    updated_at,
    twilio_call_id,
    disconnected_at,
    voter_registration_scan_id,
   {{ dbt_utils.surrogate_key([
     'id',
    'number',
    'status',
    'user_id',
    'external',
    'twilio_call_id',
    'voter_registration_scan_id'
    ]) }} as _airbyte_quality_control_phone_verification_calls_hashid
from {{ source('cta', 'quality_control_phone_verification_calls') }}
