{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bill_payments_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'TxnDate',
        'airbyte_cursor',
        'PayType',
        object_to_string('DepartmentRef'),
        array_to_string('Line'),
        'SyncToken',
        object_to_string('CreditCardPayment'),
        boolean_to_string('sparse'),
        'TotalAmt',
        object_to_string('MetaData'),
        'domain',
        'DocNumber',
        object_to_string('APAccountRef'),
        object_to_string('CheckPayment'),
        'Id',
        object_to_string('VendorRef'),
    ]) }} as _airbyte_bill_payments_hashid,
    tmp.*
from {{ ref('bill_payments_ab2') }} as tmp
-- bill_payments
where 1 = 1
