{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('people_ab3') }}
select
    gender,
    ethnicity,
    email_source,
    interest_level,
    prefix,
    birth_date,
    call_stoppage,
    extras,
    created_at,
    denominations,
    external_id,
    issues,
    skills,
    search_terms,
    mailing_address_id,
    residential_address_id,
    suffix_name,
    primary_phone_number,
    requested_public_record_exception,
    updated_at,
    voter_source_id,
    receives_sms,
    leadership_score,
    registered_state,
    id,
    first_name,
    assigned_to_user_id,
    slug,
    voter_status,
    languages,
    primary_email_address,
    primary_language,
    last_name,
    middle_name,
    external_ids,
    registration_date,
    best_contact_method,
    party_id,
    creator_id,
    pronouns,
    work_organization_id,
    position,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_people_hashid
from {{ ref('people_ab3') }}
-- people from {{ source('cta', '_airbyte_raw_people') }}

