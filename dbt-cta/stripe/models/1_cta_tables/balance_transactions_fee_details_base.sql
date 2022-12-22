{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('balance_transactions_fee_details_ab3') }}
select
    _airbyte_balance_transactions_hashid,
    type,
    amount,
    currency,
    application,
    description,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_fee_details_hashid
from {{ ref('balance_transactions_fee_details_ab3') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

