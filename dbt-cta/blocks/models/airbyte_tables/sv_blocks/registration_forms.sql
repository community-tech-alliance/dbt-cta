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
                            identifier='registration_forms_ab3'
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
-- depends_on: {{ ref('registration_forms_ab3') }}
select
    distance_from_location,
    metadata,
    eligible_voting_age,
    county,
    social_security,
    uuid,
    pledge_card_data,
    score,
    identification,
    voting_state,
    id,
    state_id,
    longitude,
    person_id,
    ovr_status,
    hard_copy_collected,
    mailing_street_address_two,
    completed,
    created_by_user_id,
    registration_date,
    secondary_identification,
    voting_city,
    phone_number,
    form_number,
    party,
    contacted_voter,
    mailing_street_address_one,
    gender,
    ethnicity,
    signature,
    date_of_birth,
    latitude,
    delivery_id,
    extras,
    created_at,
    voting_street_address_two,
    voting_zipcode,
    mailing_zipcode,
    registration_type,
    redacted_fields,
    van_id,
    name_prefix,
    updated_at,
    shift_id,
    first_name,
    online_registration,
    por_data,
    mailing_city,
    mailing_state,
    voting_street_address_one,
    name_suffix,
    twilio_match_data,
    last_name,
    middle_name,
    us_citizen,
    precinct,
    email_address,
    smarty_streets_match_data,
    scan_id,
    attempted,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_registration_forms_hashid
from {{ ref('registration_forms_ab3') }}
-- registration_forms from {{ source('sv_blocks', '_airbyte_raw_registration_forms') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

