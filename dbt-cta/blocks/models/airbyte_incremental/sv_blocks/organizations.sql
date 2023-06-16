{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('organizations_scd') }}
select
    street_address,
    notes,
    city,
    extras,
    created_at,
    denominations,
    leader_id,
    issues,
    mailing_zipcode,
    soft_member_count,
    updated_at,
    turf_id,
    id,
    state,
    membership_type_legacy,
    slug,
    membership_type,
    mailing_city,
    website,
    contact_name,
    mailing_state,
    address_id,
    active,
    created_by_user_id,
    zipcode,
    name,
    organization_type,
    phone_number,
    members_count,
    influence_level,
    mailing_street_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organizations_hashid
from {{ ref('organizations_scd') }}
-- organizations from {{ source('sv_blocks', '_airbyte_raw_organizations') }}

