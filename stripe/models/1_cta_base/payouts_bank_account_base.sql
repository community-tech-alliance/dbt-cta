{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
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
-- bank_account at payouts/bank_account from {{ ref('payouts') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

