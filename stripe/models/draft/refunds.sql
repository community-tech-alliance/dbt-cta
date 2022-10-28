{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('refunds_ab3') }}
select
    id,
    amount,
    charge,
    object,
    reason,
    status,
    created,
    currency,
    metadata,
    payment_intent,
    receipt_number,
    transfer_reversal,
    balance_transaction,
    source_transfer_reversal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_refunds_hashid
from {{ ref('refunds_ab3') }}
-- refunds from {{ source('cta', '_airbyte_raw_refunds') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

