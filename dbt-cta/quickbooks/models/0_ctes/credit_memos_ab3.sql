{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('credit_memos_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        object_to_string('ClassRef'),
        'EmailStatus',
        object_to_string('ShipAddr'),
        'RemainingCredit',
        'HomeTotalAmt',
        object_to_string('MetaData'),
        'DocNumber',
        'PrintStatus',
        object_to_string('BillEmail'),
        object_to_string('BillAddr'),
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
        'Balance',
        boolean_to_string('ApplyTaxAfterDiscount'),
        object_to_string('TxnTaxDetail'),
    ]) }} as _airbyte_credit_memos_hashid,
    tmp.*
from {{ ref('credit_memos_ab2') }} tmp
-- credit_memos
where 1 = 1

