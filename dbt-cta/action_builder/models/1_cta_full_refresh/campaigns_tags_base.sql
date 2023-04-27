{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaigns_tags_ab3') }}
select
    id,
    tag_id,
    created_at,
    updated_at,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaigns_tags_hashid
from {{ ref('campaigns_tags_ab3') }}
-- campaigns_tags from {{ source('cta', '_airbyte_raw_campaigns_tags') }}
where 1 = 1

