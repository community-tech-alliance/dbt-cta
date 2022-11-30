{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('discounts_discount_data_amount_money_ab3') }}
select
    _airbyte_discount_data_hashid,
    amount,
    currency,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_amount_money_hashid
from {{ ref('discounts_discount_data_amount_money_ab3') }}
-- amount_money at discounts/discount_data/amount_money from {{ ref('discounts_discount_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

