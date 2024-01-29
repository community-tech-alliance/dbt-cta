{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('payments_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        boolean_to_string('ProcessPayment'),
        'PaymentRefNum',
        'TxnDate',
        'airbyte_cursor',
        array_to_string('Line'),
        'UnappliedAmt',
        'SyncToken',
        object_to_string('DepositToAccountRef'),
        boolean_to_string('sparse'),
        'TotalAmt',
        object_to_string('MetaData'),
        object_to_string('PaymentMethodRef'),
        'domain',
        'Id',
        object_to_string('ARAccountRef'),
        object_to_string('CustomerRef'),
        'PrivateNote',
        array_to_string('LinkedTxn'),
    ]) }} as _airbyte_payments_hashid,
    tmp.*
from {{ ref('payments_ab2') }} tmp
-- payments
where 1 = 1

