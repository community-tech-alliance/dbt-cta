{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('modifier_list_modifier_list_data_modifiers') }}
select
    _airbyte_modifiers_hashid,
    {{ json_extract_scalar('modifier_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('modifier_data', ['ordinal'], ['ordinal']) }} as ordinal,
    {{ json_extract('table_alias', 'modifier_data', ['price_money'], ['price_money']) }} as price_money,
    {{ json_extract_scalar('modifier_data', ['on_by_default'], ['on_by_default']) }} as on_by_default,
    {{ json_extract_scalar('modifier_data', ['modifier_list_id'], ['modifier_list_id']) }} as modifier_list_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('modifier_list_modifier_list_data_modifiers_base') }} as table_alias
-- modifier_data at modifier_list/modifier_list_data/modifiers/modifier_data
where
    1 = 1
    and modifier_data is not null
{{ incremental_clause('_airbyte_emitted_at') }}

