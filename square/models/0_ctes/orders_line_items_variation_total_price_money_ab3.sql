{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_line_items_variation_total_price_money_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_line_items_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_variation_total_price_money_hashid,
    tmp.*
from {{ ref('orders_line_items_variation_total_price_money_ab2') }} tmp
-- variation_total_price_money at orders/line_items/variation_total_price_money
where 1 = 1

