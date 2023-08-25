{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_line_items_applied_discounts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_line_items_hashid',
        'uid',
        'discount_uid',
        object_to_string('applied_money'),
    ]) }} as _airbyte_applied_discounts_hashid,
    tmp.*
from {{ ref('orders_line_items_applied_discounts_ab2') }} as tmp
-- applied_discounts at orders/line_items/applied_discounts
where 1 = 1
