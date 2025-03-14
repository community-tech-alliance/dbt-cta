{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_raw_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('journal_entries_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        object_to_string('CurrencyRef'),
        'ExchangeRate',
        object_to_string('TaxRateRef'),
        boolean_to_string('Adjustment'),
        'TxnDate',
        'airbyte_cursor',
        array_to_string('Line'),
        'SyncToken',
        boolean_to_string('sparse'),
        object_to_string('MetaData'),
        'domain',
        'DocNumber',
        'Id',
        'PrivateNote',
        object_to_string('TxnTaxDetail'),
    ]) }} as _airbyte_journal_entries_hashid,
    tmp.*
from {{ ref('journal_entries_ab2') }} as tmp
-- journal_entries
where 1 = 1
