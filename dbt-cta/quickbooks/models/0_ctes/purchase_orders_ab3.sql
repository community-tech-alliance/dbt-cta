{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchase_orders_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        object_to_string('ClassRef'),
        'EmailStatus',
        'POStatus',
        object_to_string('ShipAddr'),
        object_to_string('VendorAddr'),
        object_to_string('MetaData'),
        'DocNumber',
        'DueDate',
        'PrivateNote',
        array_to_string('LinkedTxn'),
        'TxnDate',
        'airbyte_cursor',
        object_to_string('DepartmentRef'),
        array_to_string('Line'),
        'SyncToken',
        boolean_to_string('sparse'),
        'TotalAmt',
        'domain',
        object_to_string('APAccountRef'),
        array_to_string('CustomField'),
        object_to_string('ShipTo'),
        object_to_string('SalesTermRef'),
        'Id',
        object_to_string('VendorRef'),
        'Memo',
        object_to_string('TxnTaxDetail'),
    ]) }} as _airbyte_purchase_orders_hashid,
    tmp.*
from {{ ref('purchase_orders_ab2') }} as tmp
-- purchase_orders
where 1 = 1
