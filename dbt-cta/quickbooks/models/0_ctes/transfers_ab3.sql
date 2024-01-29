{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('transfers_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        'SyncToken',
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        object_to_string('ToAccountRef'),
        object_to_string('FromAccountRef'),
        object_to_string('MetaData'),
        'Amount',
        'domain',
        'TxnDate',
        'airbyte_cursor',
        'Id',
        'PrivateNote',
    ]) }} as _airbyte_transfers_hashid,
    tmp.*
from {{ ref('transfers_ab2') }} tmp
-- transfers
where 1 = 1

