{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_line_items_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        'uid',
        'name',
        'note',
        'quantity',
        'item_type',
        array_to_string('modifiers'),
        object_to_string('total_money'),
        array_to_string('applied_taxes'),
        'variation_name',
        object_to_string('total_tax_money'),
        object_to_string('base_price_money'),
        array_to_string('applied_discounts'),
        'catalog_object_id',
        object_to_string('gross_sales_money'),
        object_to_string('total_discount_money'),
        object_to_string('variation_total_price_money'),
    ]) }} as _airbyte_line_items_hashid,
    tmp.*
from {{ ref('orders_line_items_ab2') }} tmp
-- line_items at orders/line_items
where 1 = 1

