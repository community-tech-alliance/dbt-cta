{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('purchases_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'TxnDate',
        'airbyte_cursor',
        object_to_string('AccountRef'),
        object_to_string('RemitToAddr'),
        array_to_string('Line'),
        'SyncToken',
        boolean_to_string('Credit'),
        boolean_to_string('sparse'),
        'TotalAmt',
        object_to_string('MetaData'),
        'domain',
        'DocNumber',
        object_to_string('PurchaseEx'),
        'PaymentType',
        'Id',
        'PrintStatus',
        object_to_string('EntityRef'),
        'PrivateNote',
    ]) }} as _airbyte_purchases_hashid,
    tmp.*
from {{ ref('purchases_ab2') }} tmp
-- purchases
where 1 = 1

