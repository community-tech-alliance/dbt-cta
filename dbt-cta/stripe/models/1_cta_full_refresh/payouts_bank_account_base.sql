{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions=partitions_to_replace,
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payouts_bank_account_ab3') }}
select
    _airbyte_payouts_hashid,
    id,
    name,
    last4,
    object,
    status,
    country,
    currency,
    metadata,
    bank_name,
    fingerprint,
    routing_number,
    account_holder_name,
    account_holder_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_bank_account_hashid
from {{ ref('payouts_bank_account_ab3') }}
-- bank_account at payouts_base/bank_account from {{ ref('payouts_base') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

