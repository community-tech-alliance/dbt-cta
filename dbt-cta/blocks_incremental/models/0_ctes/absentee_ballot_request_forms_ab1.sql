{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'absentee_ballot_request_forms') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    gender,
    eligible_voting_age,
    batch_id,
    name_suffix,
    date_of_birth,
    extras,
    last_name,
    created_at,
    middle_name,
    created_by_user_id,
    us_citizen,
    residential_address_id,
    email_address,
    updated_at,
    shift_id,
    election_id,
    request_date,
    phone_number,
    id,
    first_name,
    ballot_delivery_address_id,
   {{ dbt_utils.surrogate_key([
     'gender',
    'eligible_voting_age',
    'batch_id',
    'name_suffix',
    'date_of_birth',
    'extras',
    'last_name',
    'middle_name',
    'created_by_user_id',
    'us_citizen',
    'residential_address_id',
    'email_address',
    'shift_id',
    'election_id',
    'request_date',
    'phone_number',
    'id',
    'first_name',
    'ballot_delivery_address_id'
    ]) }} as _airbyte_absentee_ballot_request_forms_hashid
from {{ source('cta', 'absentee_ballot_request_forms') }}
