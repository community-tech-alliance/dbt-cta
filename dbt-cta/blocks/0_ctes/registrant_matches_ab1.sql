{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_registrant_matches') }}
select
    {{ json_extract_scalar('_airbyte_data', ['reg_address_street_name'], ['reg_address_street_name']) }} as reg_address_street_name,
    {{ json_extract_scalar('_airbyte_data', ['zip9'], ['zip9']) }} as zip9,
    {{ json_extract_scalar('_airbyte_data', ['birthdate'], ['birthdate']) }} as birthdate,
    {{ json_extract_scalar('_airbyte_data', ['cass_city'], ['cass_city']) }} as cass_city,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_two'], ['reg_address_two']) }} as reg_address_two,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_street_name'], ['mailing_address_street_name']) }} as mailing_address_street_name,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['state'], ['state']) }} as state,
    {{ json_extract_scalar('_airbyte_data', ['household_id_1'], ['household_id_1']) }} as household_id_1,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_unit_type'], ['mailing_address_unit_type']) }} as mailing_address_unit_type,
    {{ json_extract_scalar('_airbyte_data', ['household_id_2'], ['household_id_2']) }} as household_id_2,
    {{ json_extract_scalar('_airbyte_data', ['cass_county_fips'], ['cass_county_fips']) }} as cass_county_fips,
    {{ json_extract_scalar('_airbyte_data', ['earliest_registration_date'], ['earliest_registration_date']) }} as earliest_registration_date,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_street_type'], ['mailing_address_street_type']) }} as mailing_address_street_type,
    {{ json_extract_scalar('_airbyte_data', ['voter_file_version'], ['voter_file_version']) }} as voter_file_version,
    {{ json_extract_scalar('_airbyte_data', ['reg_zip4'], ['reg_zip4']) }} as reg_zip4,
    {{ json_extract_scalar('_airbyte_data', ['reg_zip5'], ['reg_zip5']) }} as reg_zip5,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_unit_number'], ['mailing_address_unit_number']) }} as mailing_address_unit_number,
    {{ json_extract_scalar('_airbyte_data', ['likely_cell_assignment_score'], ['likely_cell_assignment_score']) }} as likely_cell_assignment_score,
    {{ json_extract_scalar('_airbyte_data', ['race_source'], ['race_source']) }} as race_source,
    {{ json_extract_scalar('_airbyte_data', ['voter_file_latest_registration_date'], ['voter_file_latest_registration_date']) }} as voter_file_latest_registration_date,
    {{ json_extract_scalar('_airbyte_data', ['full_name'], ['full_name']) }} as full_name,
    {{ json_extract_scalar('_airbyte_data', ['registration_date'], ['registration_date']) }} as registration_date,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_one'], ['reg_address_one']) }} as reg_address_one,
    {{ json_extract_scalar('_airbyte_data', ['confidence_score'], ['confidence_score']) }} as confidence_score,
    {{ json_extract_scalar('_airbyte_data', ['likely_landline_assignment_score'], ['likely_landline_assignment_score']) }} as likely_landline_assignment_score,
    {{ json_extract_scalar('_airbyte_data', ['phone_number'], ['phone_number']) }} as phone_number,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_post_directional'], ['mailing_address_post_directional']) }} as mailing_address_post_directional,
    {{ json_extract_scalar('_airbyte_data', ['reg_state'], ['reg_state']) }} as reg_state,
    {{ json_extract_scalar('_airbyte_data', ['type_code'], ['type_code']) }} as type_code,
    {{ json_extract_scalar('_airbyte_data', ['election_cycle'], ['election_cycle']) }} as election_cycle,
    {{ json_extract_scalar('_airbyte_data', ['cass_street_address'], ['cass_street_address']) }} as cass_street_address,
    {{ json_extract_scalar('_airbyte_data', ['likely_cell_connectivity_score'], ['likely_cell_connectivity_score']) }} as likely_cell_connectivity_score,
    {{ json_extract_scalar('_airbyte_data', ['dwid'], ['dwid']) }} as dwid,
    {{ json_extract_scalar('_airbyte_data', ['cass_state_fips'], ['cass_state_fips']) }} as cass_state_fips,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_street_number'], ['reg_address_street_number']) }} as reg_address_street_number,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_one'], ['mailing_address_one']) }} as mailing_address_one,
    {{ json_extract_scalar('_airbyte_data', ['gender'], ['gender']) }} as gender,
    {{ json_extract_scalar('_airbyte_data', ['ethnicity'], ['ethnicity']) }} as ethnicity,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_pre_directional'], ['mailing_address_pre_directional']) }} as mailing_address_pre_directional,
    {{ json_extract_scalar('_airbyte_data', ['likely_landline'], ['likely_landline']) }} as likely_landline,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_street_number'], ['mailing_address_street_number']) }} as mailing_address_street_number,
    {{ json_extract_scalar('_airbyte_data', ['likely_cell'], ['likely_cell']) }} as likely_cell,
    {{ json_extract_scalar('_airbyte_data', ['registration_form_id'], ['registration_form_id']) }} as registration_form_id,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_unit_number'], ['reg_address_unit_number']) }} as reg_address_unit_number,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_post_directional'], ['reg_address_post_directional']) }} as reg_address_post_directional,
    {{ json_extract_scalar('_airbyte_data', ['precinct_code'], ['precinct_code']) }} as precinct_code,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_unit_type'], ['reg_address_unit_type']) }} as reg_address_unit_type,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_street_type'], ['reg_address_street_type']) }} as reg_address_street_type,
    {{ json_extract_scalar('_airbyte_data', ['reg_address_pre_directional'], ['reg_address_pre_directional']) }} as reg_address_pre_directional,
    {{ json_extract_scalar('_airbyte_data', ['first_name'], ['first_name']) }} as first_name,
    {{ json_extract_scalar('_airbyte_data', ['cass_state'], ['cass_state']) }} as cass_state,
    {{ json_extract_scalar('_airbyte_data', ['mailing_city'], ['mailing_city']) }} as mailing_city,
    {{ json_extract_scalar('_airbyte_data', ['mailing_zip5'], ['mailing_zip5']) }} as mailing_zip5,
    {{ json_extract_scalar('_airbyte_data', ['mailing_state'], ['mailing_state']) }} as mailing_state,
    {{ json_extract_scalar('_airbyte_data', ['race'], ['race']) }} as race,
    {{ json_extract_scalar('_airbyte_data', ['likely_cell_restricted'], ['likely_cell_restricted']) }} as likely_cell_restricted,
    {{ json_extract_scalar('_airbyte_data', ['name_suffix'], ['name_suffix']) }} as name_suffix,
    {{ json_extract_scalar('_airbyte_data', ['unique_precinct_code'], ['unique_precinct_code']) }} as unique_precinct_code,
    {{ json_extract_scalar('_airbyte_data', ['change_of_address_date'], ['change_of_address_date']) }} as change_of_address_date,
    {{ json_extract_scalar('_airbyte_data', ['last_name'], ['last_name']) }} as last_name,
    {{ json_extract_scalar('_airbyte_data', ['cass_zipcode'], ['cass_zipcode']) }} as cass_zipcode,
    {{ json_extract_scalar('_airbyte_data', ['mailing_address_two'], ['mailing_address_two']) }} as mailing_address_two,
    {{ json_extract_scalar('_airbyte_data', ['county_name'], ['county_name']) }} as county_name,
    {{ json_extract_scalar('_airbyte_data', ['middle_name'], ['middle_name']) }} as middle_name,
    {{ json_extract_scalar('_airbyte_data', ['voter_file_acqusition_date'], ['voter_file_acqusition_date']) }} as voter_file_acqusition_date,
    {{ json_extract_scalar('_airbyte_data', ['mailing_zip4'], ['mailing_zip4']) }} as mailing_zip4,
    {{ json_extract_scalar('_airbyte_data', ['reg_city'], ['reg_city']) }} as reg_city,
    {{ json_extract_scalar('_airbyte_data', ['likely_landline_restricted'], ['likely_landline_restricted']) }} as likely_landline_restricted,
    {{ json_extract_scalar('_airbyte_data', ['applicant_id'], ['applicant_id']) }} as applicant_id,
    {{ json_extract_scalar('_airbyte_data', ['race_confidence'], ['race_confidence']) }} as race_confidence,
    {{ json_extract_scalar('_airbyte_data', ['likely_landline_connectivity_score'], ['likely_landline_connectivity_score']) }} as likely_landline_connectivity_score,
    {{ json_extract_scalar('_airbyte_data', ['age'], ['age']) }} as age,
    {{ json_extract_scalar('_airbyte_data', ['precinct_name'], ['precinct_name']) }} as precinct_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_registrant_matches') }} as table_alias
-- registrant_matches
where 1 = 1

