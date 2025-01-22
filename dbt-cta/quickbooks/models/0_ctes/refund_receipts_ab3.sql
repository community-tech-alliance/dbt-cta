{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('refund_receipts_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('BillAddr'),
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'TxnDate',
        'airbyte_cursor',
        object_to_string('CustomerMemo'),
        array_to_string('Line'),
        'SyncToken',
        object_to_string('DepositToAccountRef'),
        boolean_to_string('sparse'),
        'TotalAmt',
        'HomeTotalAmt',
        object_to_string('MetaData'),
        object_to_string('PaymentMethodRef'),
        'domain',
        'DocNumber',
        array_to_string('CustomField'),
        'Id',
        'PrintStatus',
        object_to_string('CustomerRef'),
        'Balance',
        object_to_string('BillEmail'),
        boolean_to_string('ApplyTaxAfterDiscount'),
        object_to_string('TxnTaxDetail'),
    ]) }} as _airbyte_refund_receipts_hashid,
    tmp.*
from {{ ref('refund_receipts_ab2') }} as tmp
-- refund_receipts
where 1 = 1
