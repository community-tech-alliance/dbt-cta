{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'phone_verification_responses') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    round_number,
    notes,
    updated_at,
    voter_registration_scan_id,
    response,
    created_at,
    id,
    created_by_user_id,
    call_id,
    phone_verification_question_id,
   {{ dbt_utils.surrogate_key([
     'round_number',
    'notes',
    'voter_registration_scan_id',
    'response',
    'id',
    'created_by_user_id',
    'call_id',
    'phone_verification_question_id'
    ]) }} as _airbyte_phone_verification_responses_hashid
from {{ source('cta', 'phone_verification_responses') }}
