{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_LinkedTxn_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_purchase_orders_hashid',
        'TxnId',
        'TxnType',
    ]) }} as _airbyte_LinkedTxn_hashid,
    tmp.*
from {{ ref('purchase_orders_LinkedTxn_ab2') }} tmp
-- LinkedTxn at purchase_orders/LinkedTxn
where 1 = 1

