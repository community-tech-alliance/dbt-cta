{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = 'id',
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('events_ab4') }}
select
    notes,
    extras,
    created_at,
    description,
    type,
    location_id,
    event_type_id,
    public,
    updated_at,
    turf_id,
    public_page_header_data,
    public_page_header_map_data,
    id,
    slug,
    campaign_id,
    invited_count,
    no_show_count,
    end_time,
    public_settings,
    created_by_user_id,
    start_time,
    first_occurrence_id,
    organization_id,
    name,
    walk_in_count,
    attended_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_events_hashid
from {{ ref('events_ab4') }}
-- events from {{ source('cta', '_airbyte_raw_events') }}
