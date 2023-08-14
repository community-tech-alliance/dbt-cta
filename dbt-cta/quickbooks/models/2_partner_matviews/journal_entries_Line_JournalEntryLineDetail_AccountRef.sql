select
    _airbyte_JournalEntryLineDetail_hashid,
    name,
    value,
    _airbyte_emitted_at,
    _airbyte_AccountRef_hashid
from {{ source('cta','journal_entries_Line_JournalEntryLineDetail_AccountRef_base') }}