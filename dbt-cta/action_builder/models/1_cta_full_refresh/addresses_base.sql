{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('addresses_ab3') }}
select
    id,
    city,
    dw_id,
    state,
    source,
    status,
    country,
    accuracy,
    latitude,
    owner_id,
    timezone,
    longitude,
    complement,
    created_at,
    owner_type,
    updated_at,
    geocode_bad,
    interact_id,
    postal_code,
    accuracy_type,
    created_by_id,
    updated_by_id,
    geocode_source,
    street_address,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_addresses_hashid
from {{ ref('addresses_ab3') }}
-- addresses from {{ source('cta', '_airbyte_raw_addresses') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
