{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('campaign_configuration_tag_categories_ab3') }}
select
    id,
    position,
    created_at,
    updated_at,
    campaign_id,
    tag_category_id,
    campaign_configuration_target_id,
    campaign_configuration_target_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_campaign_configuration_tag_categories_hashid
from {{ ref('campaign_configuration_tag_categories_ab3') }}
-- campaign_configuration_tag_categories from {{ source('cta', '_airbyte_raw_campaign_configuration_tag_categories') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}