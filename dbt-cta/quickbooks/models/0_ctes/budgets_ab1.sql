{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_budgets') }}
select
    {{ json_extract_scalar('_airbyte_data', ['StartDate'], ['StartDate']) }} as StartDate,
    {{ json_extract_scalar('_airbyte_data', ['SyncToken'], ['SyncToken']) }} as SyncToken,
    {{ json_extract_scalar('_airbyte_data', ['Active'], ['Active']) }} as Active,
    {{ json_extract_array('_airbyte_data', ['BudgetDetail'], ['BudgetDetail']) }} as BudgetDetail,
    {{ json_extract('table_alias', '_airbyte_data', ['MetaData'], ['MetaData']) }} as MetaData,
    {{ json_extract_scalar('_airbyte_data', ['domain'], ['domain']) }} as domain,
    {{ json_extract_scalar('_airbyte_data', ['airbyte_cursor'], ['airbyte_cursor']) }} as airbyte_cursor,
    {{ json_extract_scalar('_airbyte_data', ['Id'], ['Id']) }} as Id,
    {{ json_extract_scalar('_airbyte_data', ['EndDate'], ['EndDate']) }} as EndDate,
    {{ json_extract_scalar('_airbyte_data', ['BudgetType'], ['BudgetType']) }} as BudgetType,
    {{ json_extract_scalar('_airbyte_data', ['Name'], ['Name']) }} as Name,
    {{ json_extract_scalar('_airbyte_data', ['BudgetEntryType'], ['BudgetEntryType']) }} as BudgetEntryType,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_budgets') }} as table_alias
-- budgets
where 1 = 1

