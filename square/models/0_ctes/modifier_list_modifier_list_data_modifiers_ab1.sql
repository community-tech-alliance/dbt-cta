{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('modifier_list_modifier_list_data') }}
{{ unnest_cte(ref('modifier_list_modifier_list_data'), 'modifier_list_data', 'modifiers') }}
select
    _airbyte_modifier_list_data_hashid,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['version'], ['version']) }} as version,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['is_deleted'], ['is_deleted']) }} as is_deleted,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract('', unnested_column_value('modifiers'), ['modifier_data'], ['modifier_data']) }} as modifier_data,
    {{ json_extract_scalar(unnested_column_value('modifiers'), ['present_at_all_locations'], ['present_at_all_locations']) }} as present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('modifier_list_modifier_list_data') }} as table_alias
-- modifiers at modifier_list/modifier_list_data/modifiers
{{ cross_join_unnest('modifier_list_data', 'modifiers') }}
where 1 = 1
and modifiers is not null
{{ incremental_clause('_airbyte_emitted_at', this) }}

