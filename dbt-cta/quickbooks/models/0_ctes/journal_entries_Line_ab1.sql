{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('journal_entries_base') }}
{{ unnest_cte(ref('journal_entries_base'), 'journal_entries', 'Line') }}
select
    _airbyte_journal_entries_hashid,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Description'], ['Description']) }} as Description,
    {{ json_extract_scalar(unnested_column_value('Line'), ['DetailType'], ['DetailType']) }} as DetailType,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Amount'], ['Amount']) }} as Amount,
    {{ json_extract_scalar(unnested_column_value('Line'), ['Id'], ['Id']) }} as Id,
    {{ json_extract('', unnested_column_value('Line'), ['JournalEntryLineDetail'], ['JournalEntryLineDetail']) }} as JournalEntryLineDetail,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('journal_entries_base') }}
-- Line at journal_entries/Line
{{ cross_join_unnest('journal_entries', 'Line') }}
where
    1 = 1
    and Line is not null
