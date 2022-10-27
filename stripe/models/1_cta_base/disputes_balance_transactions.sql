{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('disputes_balance_transactions_ab3') }}
select
    _airbyte_disputes_hashid,
    id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_balance_transactions_hashid
from {{ ref('disputes_balance_transactions_ab3') }}
-- balance_transactions at disputes/balance_transactions from {{ ref('disputes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

