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
-- depends_on: {{ ref('user_activities_export_ab3') }}
select
    performs,
    user_email,
    utm_campaign,
    user_last_name,
    created_at,
    testimonial_note,
    completed,
    impressions,
    user_fullname,
    user_last_seen_at,
    exported_at,
    user_first_name,
    testimonial_media_url,
    updated_at,
    user_id,
    activity_id,
    clicks,
    user_phone,
    id,
    published_at,
    campaign_id,
    utm_source,
    activity_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_activities_export_hashid
from {{ ref('user_activities_export_ab3') }}
-- user_activities_export from {{ source('cta', '_airbyte_raw_user_activities_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}