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
-- depends_on: {{ ref('activities_export_ab3') }}
select
    performs,
    created_at,
    completions,
    description,
    started,
    folder_name,
    impressions,
    type,
    title,
    seen,
    exported_at,
    privacy_setting,
    updated_at,
    contact_list_id,
    contact_list_name,
    activity_id,
    clicks,
    id,
    aasm_state,
    folder_id,
    published_at,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_activities_export_hashid
from {{ ref('activities_export_ab3') }}
-- activities_export from {{ source('cta', '_airbyte_raw_activities_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}