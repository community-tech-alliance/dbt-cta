{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id'
) }}

-- depends_on: {{ ref('organizations_ab3') }}
select
    id,
    name,
    type,
    roles,
    state,
    country,
    locality,
    created_at,
    updated_at,
    postal_code,
    contact_name,
    my_member_id,
    contact_email,
    contact_phone,
    address_line_1,
    createdByCaller,
    my_display_name,
    my_invited_email,
    contact_phone_optin,
    accepted_term_version,
    configuration_settings,
    administrative_district_level_1,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('organizations_ab3') }}
