{{ config(
    cluster_by = ["_airbyte_unique_key","_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_unique_key",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('events_scd') }}
select
    _airbyte_unique_key,
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
from {{ ref('events_scd') }}
-- events from {{ source('sv_blocks', '_airbyte_raw_events') }}
where 1 = 1
and _airbyte_active_row = 1
{{ incremental_clause('_airbyte_emitted_at') }}

