{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id'
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organizations_hashid
from {{ ref('organizations_ab3') }}
-- organizations from {{ source('cta', '_airbyte_raw_organizations') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}


