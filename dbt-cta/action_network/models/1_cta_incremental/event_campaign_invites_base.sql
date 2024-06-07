{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('event_campaign_invites_ab4') }}
select
    id,
    status,
    event_id,
    created_at,
    updated_at,
    event_campaign_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_event_campaign_invites_hashid
from {{ ref('event_campaign_invites_ab4') }}
