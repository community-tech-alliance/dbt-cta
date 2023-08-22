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
-- depends_on: {{ ref('calls_ab3') }}
select
    id,
    city,
    uuid,
    email,
    phone,
    state,
    status,
    street,
    country,
    user_id,
    tag_list,
    zip_code,
    last_name,
    created_at,
    first_name,
    updated_at,
    display_name,
    custom_fields,
    twilio_call_sid,
    call_campaign_id,
    originating_system,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_calls_hashid
from {{ ref('calls_ab3') }}
-- calls from {{ source('cta', '_airbyte_raw_calls') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
