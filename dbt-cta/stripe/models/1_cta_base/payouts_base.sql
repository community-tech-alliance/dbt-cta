{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_payouts_hashid',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payouts_ab3') }}
select
    id,
    date,
    type,
    amount,
    method,
    object,
    status,
    created,
    currency,
    livemode,
    metadata,
    automatic,
    recipient,
    description,
    destination,
    source_type,
    arrival_date,
    bank_account,
    failure_code,
    transfer_group,
    amount_reversed,
    failure_message,
    source_transaction,
    balance_transaction,
    statement_descriptor,
    statement_description,
    failure_balance_transaction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_payouts_hashid
from {{ ref('payouts_ab3') }}
-- payouts from {{ source('cta', '_airbyte_raw_payouts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

