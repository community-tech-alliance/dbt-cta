{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_CheckPayment_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_bill_payments_hashid',
        'PrintStatus',
        object_to_string('BankAccountRef'),
    ]) }} as _airbyte_CheckPayment_hashid,
    tmp.*
from {{ ref('bill_payments_CheckPayment_ab2') }} as tmp
-- CheckPayment at bill_payments/CheckPayment
where 1 = 1
