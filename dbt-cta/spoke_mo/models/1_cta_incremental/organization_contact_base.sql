{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('organization_contact_ab3') }}
select
    carrier,
    last_lookup,
    lookup_name,
    status_code,
    subscribe_status,
    service,
    organization_id,
    created_at,
    id,
    contact_number,
    user_number,
    last_error_code,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organization_contact_hashid
from {{ ref('organization_contact_ab3') }}
-- organization_contact from {{ source('cta', '_airbyte_raw_organization_contact') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

