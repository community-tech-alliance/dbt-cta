{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('donations_ab4') }}
select
    id,
    city,
    uuid,
    email,
    phone,
    state,
    amount,
    address,
    country,
    user_id,
    tag_list,
    zip_code,
    last_name,
    recurring,
    created_at,
    first_name,
    updated_at,
    display_name,
    total_amount,
    custom_amount,
    custom_fields,
    salesforce_id,
    fundraising_id,
    recurring_period,
    message_to_target,
    originating_system,
    updates_from_creator,
    updates_from_sponsor,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_donations_hashid
from {{ ref('donations_ab4') }}
-- donations from {{ source('cta', '_airbyte_raw_donations') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}
