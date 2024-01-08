{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'twilio_calls') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    updated_at,
    user_id,
    remote_id,
    created_at,
    phone_number,
    id,
    scan_id,
    disconnected_at,
   {{ dbt_utils.surrogate_key([
     'user_id',
    'remote_id',
    'phone_number',
    'id',
    'scan_id'
    ]) }} as _airbyte_twilio_calls_hashid
from {{ source('cta', 'twilio_calls') }}
