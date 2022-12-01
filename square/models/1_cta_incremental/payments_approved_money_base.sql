{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('payments_approved_money_ab3') }}
select
    _airbyte_payments_hashid,
    amount,
    currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_approved_money_hashid
from {{ ref('payments_approved_money_ab3') }}
-- approved_money at payments/approved_money from {{ ref('payments') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

