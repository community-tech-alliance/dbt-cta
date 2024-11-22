select
    _airbyte_journal_entries_hashid,
    Description,
    DetailType,
    Amount,
    Id,
    JournalEntryLineDetail,
    _airbyte_emitted_at,
    _airbyte_Line_hashid
from {{ source('cta','journal_entries_Line_base') }}
