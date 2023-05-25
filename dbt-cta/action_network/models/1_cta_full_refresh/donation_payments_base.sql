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
-- depends_on: {{ ref('donation_payments_ab3') }}
select
    id,
    tip,
    name,
    error,
    amount,
    user_id,
    group_id,
    wepay_id,
    recurring,
    created_at,
    error_code,
    updated_at,
    donation_id,
    wepay_status,
    error_message,
    fundraising_id,
    transaction_id,
    donation_user_id,
    recurring_period,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_donation_payments_hashid
from {{ ref('donation_payments_ab3') }}
-- donation_payments from {{ source('cta', '_airbyte_raw_donation_payments') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}