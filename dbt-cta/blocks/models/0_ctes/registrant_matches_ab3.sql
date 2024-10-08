{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('registrant_matches_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'reg_address_street_name',
        'zip9',
        'birthdate',
        'cass_city',
        'reg_address_two',
        'mailing_address_street_name',
        'id',
        'state',
        'household_id_1',
        'mailing_address_unit_type',
        'household_id_2',
        'cass_county_fips',
        'earliest_registration_date',
        'mailing_address_street_type',
        'voter_file_version',
        'reg_zip4',
        'reg_zip5',
        'mailing_address_unit_number',
        'likely_cell_assignment_score',
        'race_source',
        'voter_file_latest_registration_date',
        'full_name',
        'registration_date',
        'reg_address_one',
        'confidence_score',
        'likely_landline_assignment_score',
        'phone_number',
        'mailing_address_post_directional',
        'reg_state',
        'type_code',
        'election_cycle',
        'cass_street_address',
        'likely_cell_connectivity_score',
        'dwid',
        'cass_state_fips',
        'reg_address_street_number',
        'mailing_address_one',
        'gender',
        'ethnicity',
        'mailing_address_pre_directional',
        'likely_landline',
        'created_at',
        'mailing_address_street_number',
        'likely_cell',
        'registration_form_id',
        'reg_address_unit_number',
        'reg_address_post_directional',
        'precinct_code',
        'reg_address_unit_type',
        'updated_at',
        'reg_address_street_type',
        'reg_address_pre_directional',
        'first_name',
        'cass_state',
        'mailing_city',
        'mailing_zip5',
        'mailing_state',
        'race',
        'likely_cell_restricted',
        'name_suffix',
        'unique_precinct_code',
        'change_of_address_date',
        'last_name',
        'cass_zipcode',
        'mailing_address_two',
        'county_name',
        'middle_name',
        'voter_file_acqusition_date',
        'mailing_zip4',
        'reg_city',
        'likely_landline_restricted',
        'applicant_id',
        'race_confidence',
        'likely_landline_connectivity_score',
        'age',
        'precinct_name',
    ]) }} as _airbyte_registrant_matches_hashid,
    tmp.*
from {{ ref('registrant_matches_ab2') }} as tmp
-- registrant_matches
where 1 = 1
