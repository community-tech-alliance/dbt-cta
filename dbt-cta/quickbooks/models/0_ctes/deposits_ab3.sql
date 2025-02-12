{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('deposits_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        'TxnDate',
        'airbyte_cursor',
        object_to_string('DepartmentRef'),
        array_to_string('Line'),
        'SyncToken',
        object_to_string('DepositToAccountRef'),
        boolean_to_string('sparse'),
        'TotalAmt',
        object_to_string('MetaData'),
        'domain',
        'Id',
        object_to_string('CashBack'),
        'PrivateNote',
    ]) }} as _airbyte_deposits_hashid,
    tmp.*
from {{ ref('deposits_ab2') }} as tmp
-- deposits
where 1 = 1
