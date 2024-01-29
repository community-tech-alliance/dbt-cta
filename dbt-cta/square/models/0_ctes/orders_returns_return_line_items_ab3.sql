{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_returns_return_line_items_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_returns_hashid',
        'uid',
        'quantity',
        'item_type',
        object_to_string('total_money'),
        object_to_string('total_tax_money'),
        object_to_string('base_price_money'),
        object_to_string('gross_return_money'),
        object_to_string('total_discount_money'),
        object_to_string('variation_total_price_money'),
    ]) }} as _airbyte_return_line_items_hashid,
    tmp.*
from {{ ref('orders_returns_return_line_items_ab2') }} as tmp
-- return_line_items at orders/returns/return_line_items
where 1 = 1
