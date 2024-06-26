{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_raw_id'
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ source('cta', 'registration_forms') }}

select
    _airbyte_raw_id,
    _airbyte_extracted_at,
    _airbyte_meta,
    id,
    uuid,
    party,
    score,
    county,
    extras,
    gender,
    van_id,
    scan_id,
    latitude,
    metadata,
    por_data,
    precinct,
    shift_id,
    state_id,
    attempted,
    completed,
    ethnicity,
    last_name,
    longitude,
    signature,
    created_at,
    first_name,
    ovr_status,
    updated_at,
    us_citizen,
    delivery_id,
    form_number,
    middle_name,
    name_prefix,
    name_suffix,
    voting_city,
    mailing_city,
    phone_number,
    voting_state,
    date_of_birth,
    email_address,
    mailing_state,
    identification,
    voting_zipcode,
    contacted_voter,
    district_config,
    mailing_zipcode,
    redacted_fields,
    social_security,
    voterfile_match,
    pledge_card_data,
    registration_date,
    registration_type,
    twilio_match_data,
    created_by_user_id,
    eligible_voting_age,
    hard_copy_collected,
    distance_from_location,
    secondary_identification,
    smarty_streets_match_data,
    voting_street_address_one,
    voting_street_address_two,
    mailing_street_address_one,
    mailing_street_address_two,
   {{ dbt_utils.surrogate_key([
     'id',
    'uuid',
    'party',
    'county',
    'extras',
    'gender',
    'van_id',
    'scan_id',
    'metadata',
    'por_data',
    'precinct',
    'shift_id',
    'state_id',
    'attempted',
    'completed',
    'ethnicity',
    'last_name',
    'signature',
    'first_name',
    'ovr_status',
    'us_citizen',
    'delivery_id',
    'form_number',
    'middle_name',
    'name_prefix',
    'name_suffix',
    'voting_city',
    'mailing_city',
    'phone_number',
    'voting_state',
    'date_of_birth',
    'email_address',
    'mailing_state',
    'identification',
    'voting_zipcode',
    'contacted_voter',
    'district_config',
    'mailing_zipcode',
    'social_security',
    'voterfile_match',
    'pledge_card_data',
    'registration_date',
    'registration_type',
    'twilio_match_data',
    'created_by_user_id',
    'eligible_voting_age',
    'hard_copy_collected',
    'secondary_identification',
    'smarty_streets_match_data',
    'voting_street_address_one',
    'voting_street_address_two',
    'mailing_street_address_one',
    'mailing_street_address_two'
    ]) }} as _airbyte_registration_forms_hashid
from {{ source('cta', 'registration_forms') }}
