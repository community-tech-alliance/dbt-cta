{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_returns_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_orders_hashid',
        'uid',
        'source_order_id',
        array_to_string('return_line_items'),
    ]) }} as _airbyte_returns_hashid,
    tmp.*
from {{ ref('orders_returns_ab2') }} as tmp
-- returns at orders/returns
where 1 = 1
