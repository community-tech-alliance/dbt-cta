{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bills_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'TxnDate',
        'airbyte_cursor',
        object_to_string('DepartmentRef'),
        array_to_string('Line'),
        'SyncToken',
        boolean_to_string('sparse'),
        'TotalAmt',
        object_to_string('MetaData'),
        'domain',
        'DocNumber',
        object_to_string('APAccountRef'),
        object_to_string('SalesTermRef'),
        'Id',
        'DueDate',
        object_to_string('VendorRef'),
        'Balance',
        'PrivateNote',
        array_to_string('LinkedTxn'),
    ]) }} as _airbyte_bills_hashid,
    tmp.*
from {{ ref('bills_ab2') }} as tmp
-- bills
where 1 = 1
