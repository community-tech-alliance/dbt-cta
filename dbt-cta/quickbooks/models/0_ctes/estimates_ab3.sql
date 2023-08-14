{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('estimates_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'EmailStatus',
        object_to_string('DeliveryInfo'),
        object_to_string('ShipAddr'),
        'HomeTotalAmt',
        object_to_string('MetaData'),
        'DocNumber',
        'PrintStatus',
        object_to_string('BillEmail'),
        array_to_string('LinkedTxn'),
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
        'Id',
        object_to_string('CustomerRef'),
        'TxnStatus',
        boolean_to_string('ApplyTaxAfterDiscount'),
        object_to_string('TxnTaxDetail'),
    ]) }} as _airbyte_estimates_hashid,
    tmp.*
from {{ ref('estimates_ab2') }} tmp
-- estimates
where 1 = 1

