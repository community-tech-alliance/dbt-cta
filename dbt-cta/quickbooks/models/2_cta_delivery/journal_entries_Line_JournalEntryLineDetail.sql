select
    _airbyte_Line_hashid,
    PostingType,
    AccountRef,
    _airbyte_emitted_at,
    _airbyte_JournalEntryLineDetail_hashid
from {{ source('cta','journal_entries_Line_JournalEntryLineDetail_base') }}
