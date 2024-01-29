{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_ShipTo_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_purchase_orders_hashid',
        'name',
        'value',
    ]) }} as _airbyte_ShipTo_hashid,
    tmp.*
from {{ ref('purchase_orders_ShipTo_ab2') }} tmp
-- ShipTo at purchase_orders/ShipTo
where 1 = 1

