{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_line_items_total_tax_money_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_line_items_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_total_tax_money_hashid,
    tmp.*
from {{ ref('orders_line_items_total_tax_money_ab2') }} as tmp
-- total_tax_money at orders/line_items/total_tax_money
where 1 = 1
