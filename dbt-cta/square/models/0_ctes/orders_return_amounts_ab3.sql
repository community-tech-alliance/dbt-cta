{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_return_amounts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_orders_hashid',
        object_to_string('tax_money'),
        object_to_string('tip_money'),
        object_to_string('total_money'),
        object_to_string('discount_money'),
        object_to_string('service_charge_money'),
    ]) }} as _airbyte_return_amounts_hashid,
    tmp.*
from {{ ref('orders_return_amounts_ab2') }} tmp
-- return_amounts at orders/return_amounts
where 1 = 1

