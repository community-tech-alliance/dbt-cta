{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_total_service_charge_money_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_orders_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_total_service_charge_money_hashid,
    tmp.*
from {{ ref('orders_total_service_charge_money_ab2') }} as tmp
-- total_service_charge_money at orders/total_service_charge_money
where 1 = 1
