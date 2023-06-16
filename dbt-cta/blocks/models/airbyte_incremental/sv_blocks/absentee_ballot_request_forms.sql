{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('absentee_ballot_request_forms_ab3') }}
select
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_absentee_ballot_request_forms_hashid
from {{ ref('absentee_ballot_request_forms_ab3') }}
-- absentee_ballot_request_forms from {{ source('sv_blocks', '_airbyte_raw_absentee_ballot_request_forms') }}

