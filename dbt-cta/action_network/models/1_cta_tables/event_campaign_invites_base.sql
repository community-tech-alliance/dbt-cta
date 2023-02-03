{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_campaign_invites_ab3') }}
select
    id,
    status,
    event_id,
    created_at,
    updated_at,
    event_campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_campaign_invites_hashid
from {{ ref('event_campaign_invites_ab3') }}
-- event_campaign_invites from {{ source('cta', '_airbyte_raw_event_campaign_invites') }}
where 1 = 1

