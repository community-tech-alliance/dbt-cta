{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_CheckPayment_BankAccountRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_CheckPayment_hashid',
        'name',
        'value',
    ]) }} as _airbyte_BankAccountRef_hashid,
    tmp.*
from {{ ref('bill_payments_CheckPayment_BankAccountRef_ab2') }} tmp
-- BankAccountRef at bill_payments/CheckPayment/BankAccountRef
where 1 = 1

