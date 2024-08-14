{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_line_items_modifiers_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_line_items_hashid',
        'uid',
        'name',
        object_to_string('base_price_money'),
        'catalog_object_id',
        object_to_string('total_price_money'),
    ]) }} as _airbyte_modifiers_hashid,
    tmp.*
from {{ ref('orders_line_items_modifiers_ab2') }} as tmp
-- modifiers at orders/line_items/modifiers
where 1 = 1
