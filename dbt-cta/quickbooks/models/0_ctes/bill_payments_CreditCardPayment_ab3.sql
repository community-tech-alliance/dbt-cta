{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_CreditCardPayment_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_bill_payments_hashid',
        object_to_string('CCAccountRef'),
    ]) }} as _airbyte_CreditCardPayment_hashid,
    tmp.*
from {{ ref('bill_payments_CreditCardPayment_ab2') }} as tmp
-- CreditCardPayment at bill_payments/CreditCardPayment
where 1 = 1
