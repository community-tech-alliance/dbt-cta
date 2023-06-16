{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_sv_blocks",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('sv_blocks', '_airbyte_raw_lists') }}
select
    {{ json_extract_scalar('_airbyte_data', ['list_folder_id'], ['list_folder_id']) }} as list_folder_id,
    {{ json_extract_scalar('_airbyte_data', ['query'], ['query']) }} as query,
    {{ json_extract_scalar('_airbyte_data', ['search_params'], ['search_params']) }} as search_params,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['repopulation_status'], ['repopulation_status']) }} as repopulation_status,
    {{ json_extract_scalar('_airbyte_data', ['primary_emails_count'], ['primary_emails_count']) }} as primary_emails_count,
    {{ json_extract_scalar('_airbyte_data', ['people_count'], ['people_count']) }} as people_count,
    {{ json_extract_scalar('_airbyte_data', ['queryable'], ['queryable']) }} as queryable,
    {{ json_extract_scalar('_airbyte_data', ['phones_count'], ['phones_count']) }} as phones_count,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract_scalar('_airbyte_data', ['refreshed_at'], ['refreshed_at']) }} as refreshed_at,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['households_count'], ['households_count']) }} as households_count,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('sv_blocks', '_airbyte_raw_lists') }} as table_alias
-- lists
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

