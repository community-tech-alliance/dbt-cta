{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_taxes_applied_money_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_taxes_hashid',
        'amount',
        'currency',
    ]) }} as _airbyte_applied_money_hashid,
    tmp.*
from {{ ref('orders_taxes_applied_money_ab2') }} tmp
-- applied_money at orders/taxes/applied_money
where 1 = 1

