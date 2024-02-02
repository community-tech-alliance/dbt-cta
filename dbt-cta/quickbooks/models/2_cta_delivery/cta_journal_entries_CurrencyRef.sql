select
    _airbyte_journal_entries_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_CurrencyRef_hashid
from {{ source('cta','journal_entries_CurrencyRef_base') }}