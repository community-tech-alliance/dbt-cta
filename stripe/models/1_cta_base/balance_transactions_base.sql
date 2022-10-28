{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('balance_transactions_ab3') }}
select
    id,
    fee,
    net,
    type,
    amount,
    object,
    source,
    status,
    created,
    currency,
    description,
    fee_details,
    available_on,
    exchange_rate,
    sourced_transfers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_balance_transactions_hashid
from {{ ref('balance_transactions_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

