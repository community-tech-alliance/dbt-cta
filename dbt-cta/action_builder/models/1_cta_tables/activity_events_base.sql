{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('activity_events_ab3') }}
select
    id,
    name,
    item_id,
    payload,
    user_id,
    datetime,
    item_type,
    target_id,
    created_at,
    event_type,
    updated_at,
    campaign_id,
    target_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_activity_events_hashid
from {{ ref('activity_events_ab3') }}
-- activity_events from {{ source('cta', '_airbyte_raw_activity_events') }}
where 1 = 1

