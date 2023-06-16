{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    partitions = partitions_to_replace,
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='registrant_matches_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "]
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('registrant_matches_ab3') }}
select
    reg_address_street_name,
    zip9,
    birthdate,
    cass_city,
    reg_address_two,
    mailing_address_street_name,
    id,
    state,
    household_id_1,
    mailing_address_unit_type,
    household_id_2,
    cass_county_fips,
    earliest_registration_date,
    mailing_address_street_type,
    voter_file_version,
    reg_zip4,
    reg_zip5,
    mailing_address_unit_number,
    likely_cell_assignment_score,
    race_source,
    voter_file_latest_registration_date,
    full_name,
    registration_date,
    reg_address_one,
    confidence_score,
    likely_landline_assignment_score,
    phone_number,
    mailing_address_post_directional,
    reg_state,
    type_code,
    election_cycle,
    cass_street_address,
    likely_cell_connectivity_score,
    dwid,
    cass_state_fips,
    reg_address_street_number,
    mailing_address_one,
    gender,
    ethnicity,
    mailing_address_pre_directional,
    likely_landline,
    created_at,
    mailing_address_street_number,
    likely_cell,
    registration_form_id,
    reg_address_unit_number,
    reg_address_post_directional,
    precinct_code,
    reg_address_unit_type,
    updated_at,
    reg_address_street_type,
    reg_address_pre_directional,
    first_name,
    cass_state,
    mailing_city,
    mailing_zip5,
    mailing_state,
    race,
    likely_cell_restricted,
    name_suffix,
    unique_precinct_code,
    change_of_address_date,
    last_name,
    cass_zipcode,
    mailing_address_two,
    county_name,
    middle_name,
    voter_file_acqusition_date,
    mailing_zip4,
    reg_city,
    likely_landline_restricted,
    applicant_id,
    race_confidence,
    likely_landline_connectivity_score,
    age,
    precinct_name,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_registrant_matches_hashid
from {{ ref('registrant_matches_ab3') }}
-- registrant_matches from {{ source('sv_blocks', '_airbyte_raw_registrant_matches') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

