{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaign_participations_ab3') }}
select
    id,
    user_id,
    created_at,
    updated_at,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_participations_hashid
from {{ ref('campaign_participations_ab3') }}
-- campaign_participations from {{ source('cta', '_airbyte_raw_campaign_participations') }}
where 1 = 1

