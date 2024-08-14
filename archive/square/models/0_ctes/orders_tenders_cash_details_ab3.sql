{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('orders_tenders_cash_details_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_tenders_hashid',
        object_to_string('change_back_money'),
        object_to_string('buyer_tendered_money'),
    ]) }} as _airbyte_cash_details_hashid,
    tmp.*
from {{ ref('orders_tenders_cash_details_ab2') }} as tmp
-- cash_details at orders/tenders/cash_details
where 1 = 1
