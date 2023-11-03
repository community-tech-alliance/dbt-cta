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
-- depends_on: {{ ref('taggings_export_ab3') }}
select
    reportable_id,
    voterbase_id,
    reported_by_email,
    tag_name,
    tag_slug,
    created_at,
    exported_at,
    reportable_type,
    van_id,
    updated_at,
    phone,
    user_id,
    tag_id,
    id,
    fullname,
    taggable_id,
    reported_by_fullname,
    value,
    email,
    campaign_id,
    taggable_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_taggings_export_hashid
from {{ ref('taggings_export_ab3') }}
-- taggings_export from {{ source('cta', '_airbyte_raw_taggings_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}