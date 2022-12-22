{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('modifier_list') }}
select
    _airbyte_modifier_list_hashid,
    {{ json_extract_scalar('modifier_list_data', ['name'], ['name']) }} as name,
    {{ json_extract_array('modifier_list_data', ['modifiers'], ['modifiers']) }} as modifiers,
    {{ json_extract_scalar('modifier_list_data', ['selection_type'], ['selection_type']) }} as selection_type,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('modifier_list_base') }} as table_alias
-- modifier_list_data at modifier_list/modifier_list_data
where 1 = 1
and modifier_list_data is not null
{{ incremental_clause('_airbyte_emitted_at') }}

