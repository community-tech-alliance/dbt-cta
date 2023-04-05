{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('checkout_sessions_line_items_price_tiers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_price_hashid',
        'up_to',
        'flat_amount',
        'unit_amount',
        'flat_amount_decimal',
        'unit_amount_decimal',
    ]) }} as _airbyte_tiers_hashid,
    tmp.*
from {{ ref('checkout_sessions_line_items_price_tiers_ab2') }} tmp
-- tiers at checkout_sessions_line_items/price/tiers
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

