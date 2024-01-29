{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_ShipAddr_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_purchase_orders_hashid',
        'Long',
        'Id',
        'Line1',
        'Lat',
        'Line2',
        'Line3',
    ]) }} as _airbyte_ShipAddr_hashid,
    tmp.*
from {{ ref('purchase_orders_ShipAddr_ab2') }} tmp
-- ShipAddr at purchase_orders/ShipAddr
where 1 = 1

