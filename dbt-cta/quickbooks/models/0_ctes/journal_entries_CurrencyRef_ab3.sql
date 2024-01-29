{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('journal_entries_CurrencyRef_ab2') }}
select
    {{ dbt_utils.generate_surrogate_key([
        '_airbyte_journal_entries_hashid',
        'name',
        'value',
    ]) }} as _airbyte_CurrencyRef_hashid,
    tmp.*
from {{ ref('journal_entries_CurrencyRef_ab2') }} tmp
-- CurrencyRef at journal_entries/CurrencyRef
where 1 = 1

