{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_CreditCardPayment_CCAccountRef_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_CreditCardPayment_hashid',
        'name',
        'value',
    ]) }} as _airbyte_CCAccountRef_hashid,
    tmp.*
from {{ ref('bill_payments_CreditCardPayment_CCAccountRef_ab2') }} as tmp
-- CCAccountRef at bill_payments/CreditCardPayment/CCAccountRef
where 1 = 1
