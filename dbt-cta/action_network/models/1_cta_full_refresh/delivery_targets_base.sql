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
-- depends_on: {{ ref('delivery_targets_ab3') }}
select
    id,
    uuid,
    bioid,
    email,
    status,
    message,
    subject,
    form_data,
    created_at,
    updated_at,
    captcha_uid,
    captcha_url,
    delivery_id,
    target_name,
    target_party,
    target_state,
    delivery_method,
    target_district,
    target_position,
    captcha_required,
    letter_template_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_delivery_targets_hashid
from {{ ref('delivery_targets_ab3') }}
-- delivery_targets from {{ source('cta', '_airbyte_raw_delivery_targets') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
