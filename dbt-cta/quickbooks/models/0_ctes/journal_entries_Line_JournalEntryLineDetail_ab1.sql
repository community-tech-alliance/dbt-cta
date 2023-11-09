{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('journal_entries_Line_base') }}
select
    _airbyte_Line_hashid,
    {{ json_extract_scalar('JournalEntryLineDetail', ['PostingType'], ['PostingType']) }} as PostingType,
    {{ json_extract('table_alias', 'JournalEntryLineDetail', ['AccountRef'], ['AccountRef']) }} as AccountRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('journal_entries_Line_base') }} as table_alias
-- JournalEntryLineDetail at journal_entries/Line/JournalEntryLineDetail
where 1 = 1
and JournalEntryLineDetail is not null

