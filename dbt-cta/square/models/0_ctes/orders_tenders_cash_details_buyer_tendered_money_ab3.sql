{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_tenders_cash_details_buyer_tendered_money_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_cash_details_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_buyer_tendered_money_hashid,
    tmp.*
from {{ ref('orders_tenders_cash_details_buyer_tendered_money_ab2') }} as tmp
-- buyer_tendered_money at orders/tenders/cash_details/buyer_tendered_money
where 1 = 1
