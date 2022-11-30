{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('refunds_processing_fee_amount_money_ab3') }}
select
    _airbyte_processing_fee_hashid,
    amount,
    currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_amount_money_hashid
from {{ ref('refunds_processing_fee_amount_money_ab3') }}
-- amount_money at refunds/processing_fee/amount_money from {{ ref('refunds_processing_fee') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

