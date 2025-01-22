{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('invoices_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'EmailStatus',
        boolean_to_string('AllowOnlineACHPayment'),
        object_to_string('DeliveryInfo'),
        boolean_to_string('AllowIPNPayment'),
        object_to_string('ShipAddr'),
        'HomeTotalAmt',
        object_to_string('MetaData'),
        'DocNumber',
        'PrintStatus',
        'DueDate',
        object_to_string('BillEmail'),
        'PrivateNote',
        array_to_string('LinkedTxn'),
        object_to_string('BillAddr'),
        boolean_to_string('AllowOnlinePayment'),
        'TxnDate',
        'airbyte_cursor',
        object_to_string('CustomerMemo'),
        array_to_string('Line'),
        'SyncToken',
        boolean_to_string('sparse'),
        'TotalAmt',
        'domain',
        array_to_string('CustomField'),
        object_to_string('SalesTermRef'),
        'Id',
        object_to_string('CustomerRef'),
        boolean_to_string('AllowOnlineCreditCardPayment'),
        'Balance',
        boolean_to_string('ApplyTaxAfterDiscount'),
        object_to_string('TxnTaxDetail'),
    ]) }} as _airbyte_invoices_hashid,
    tmp.*
from {{ ref('invoices_ab2') }} as tmp
-- invoices
where 1 = 1
