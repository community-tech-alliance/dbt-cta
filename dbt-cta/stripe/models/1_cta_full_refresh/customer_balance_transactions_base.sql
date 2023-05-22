{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}

{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customer_balance_transactions_ab3') }}
select
    id,
    type,
    amount,
    object,
    created,
    invoice,
    currency,
    customer,
    livemode,
    metadata,
    credit_note,
    description,
    ending_balance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_customer_balance_transactions_hashid
from {{ ref('customer_balance_transactions_ab3') }}
-- customer_balance_transactions from {{ source('cta', '_airbyte_raw_customer_balance_transactions') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

