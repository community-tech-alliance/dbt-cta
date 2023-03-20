{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaign_topline_setting_items_ab3') }}
select
    id,
    item_id,
    imported,
    position,
    item_type,
    created_at,
    updated_at,
    campaign_id,
    targetable_id,
    targetable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_topline_setting_items_hashid
from {{ ref('campaign_topline_setting_items_ab3') }}
-- campaign_topline_setting_items from {{ source('cta', '_airbyte_raw_campaign_topline_setting_items') }}
where 1 = 1

