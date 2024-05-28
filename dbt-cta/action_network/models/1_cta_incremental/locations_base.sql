{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('locations_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_locations_hashid
from {{ ref('locations_ab4') }}