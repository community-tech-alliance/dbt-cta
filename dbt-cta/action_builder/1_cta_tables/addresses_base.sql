{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
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
where 1 = 1

