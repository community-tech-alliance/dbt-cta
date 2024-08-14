{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_tenders_amount_money_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_tenders_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_amount_money_hashid,
    tmp.*
from {{ ref('orders_tenders_amount_money_ab2') }} as tmp
-- amount_money at orders/tenders/amount_money
where 1 = 1
