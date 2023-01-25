{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('locations_ab3') }}
select
    id,
    city,
    state,
    status,
    address,
    country,
    event_id,
    latitude,
    zip_code,
    longitude,
    created_at,
    updated_at,
    location_name,
    event_campaign_id,
    event_campaign_upload_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_locations_hashid
from {{ ref('locations_ab3') }}
-- locations from {{ source('cta', '_airbyte_raw_locations') }}
where 1 = 1

