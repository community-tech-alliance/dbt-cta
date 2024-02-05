{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'voter_registration_reports_form_lookback_by_canvasser') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    wrong_number_count,
    failed_verification_count,
    dupe_dob_count,
    total_forms_phone_validation_attempted,
    total_forms_address_validation_attempted,
    valid_phone_count,
    dupe_zip_count,
    total_scans_qc,
    registered_count,
    total_forms_with_verifiable_calls,
    id,
    valid_address_count,
   {{ dbt_utils.surrogate_key([
     'wrong_number_count',
    'failed_verification_count',
    'dupe_dob_count',
    'total_forms_phone_validation_attempted',
    'total_forms_address_validation_attempted',
    'valid_phone_count',
    'dupe_zip_count',
    'total_scans_qc',
    'registered_count',
    'total_forms_with_verifiable_calls',
    'id',
    'valid_address_count'
    ]) }} as _airbyte_voter_registration_reports_form_lookback_by_canvasser_hashid
from {{ source('cta', 'voter_registration_reports_form_lookback_by_canvasser') }}
