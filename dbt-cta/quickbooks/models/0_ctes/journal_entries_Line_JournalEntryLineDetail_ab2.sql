{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('journal_entries_Line_JournalEntryLineDetail_ab1') }}
select
    _airbyte_Line_hashid,
    cast(PostingType as {{ dbt_utils.type_string() }}) as PostingType,
    cast(AccountRef as {{ type_json() }}) as AccountRef,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('journal_entries_Line_JournalEntryLineDetail_ab1') }}
-- JournalEntryLineDetail at journal_entries/Line/JournalEntryLineDetail
where 1 = 1

