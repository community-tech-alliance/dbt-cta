{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_terms') }}
select
    {{ json_extract_scalar('_airbyte_data', ['DueNextMonthDays'], ['DueNextMonthDays']) }} as DueNextMonthDays,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['Name'], ['Name']) }} as Name,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Type'], ['Type']) }} as Type,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_scalar('_airbyte_data', ['sparse'], ['sparse']) }} as sparse,
    {{ json_extract_scalar('_airbyte_data', ['DueDays'], ['DueDays']) }} as DueDays,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['DiscountDayOfMonth'], ['DiscountDayOfMonth']) }} as DiscountDayOfMonth,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['DiscountDays'], ['DiscountDays']) }} as DiscountDays,
    {{ json_extract_scalar('_airbyte_data', ['DayOfMonthDue'], ['DayOfMonthDue']) }} as DayOfMonthDue,
    {{ json_extract_scalar('_airbyte_data', ['DiscountPercent'], ['DiscountPercent']) }} as DiscountPercent,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_terms') }} as table_alias
-- terms
where 1 = 1
