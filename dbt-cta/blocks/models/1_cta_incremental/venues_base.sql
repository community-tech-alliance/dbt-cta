{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('venues_ab3') }}
select
    maximum_size,
    rooms_available,
    updated_at,
    name,
    address_id,
    it_support,
    largest_size,
    created_at,
    public_transportation,
    id,
    parking_spots,
    hosted_event,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_venues_hashid
from {{ ref('venues_ab3') }}
-- venues from {{ source('cta', '_airbyte_raw_venues') }}

