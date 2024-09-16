{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('journal_entries_TxnTaxDetail_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_journal_entries_hashid',
        'TotalTax',
        object_to_string('TxnTaxCodeRef'),
        array_to_string('TaxLine'),
    ]) }} as _airbyte_TxnTaxDetail_hashid,
    tmp.*
from {{ ref('journal_entries_TxnTaxDetail_ab2') }} as tmp
-- TxnTaxDetail at journal_entries/TxnTaxDetail
where 1 = 1
