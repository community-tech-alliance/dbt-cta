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
-- depends_on: {{ ref('user_activity_performances_export_ab3') }}
select
    performed_at,
    user_email,
    user_last_name,
    user_fullname,
    type,
    exported_at,
    user_first_name,
    user_id,
    activity_id,
    user_phone,
    id,
    campaign_id,
    activity_title,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_user_activity_performances_export_hashid
from {{ ref('user_activity_performances_export_ab3') }}
-- user_activity_performances_export from {{ source('cta', '_airbyte_raw_user_activity_performances_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}