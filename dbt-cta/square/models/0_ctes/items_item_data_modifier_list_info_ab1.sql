{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items_item_data') }}
{{ unnest_cte(ref('items_item_data'), 'item_data', 'modifier_list_info') }}
select
    _airbyte_item_data_hashid,
    {{ json_extract_scalar(unnested_column_value('modifier_list_info'), ['enabled'], ['enabled']) }} as enabled,
    {{ json_extract_scalar(unnested_column_value('modifier_list_info'), ['visibility'], ['visibility']) }} as visibility,
    {{ json_extract_scalar(unnested_column_value('modifier_list_info'), ['modifier_list_id'], ['modifier_list_id']) }} as modifier_list_id,
    {{ json_extract_scalar(unnested_column_value('modifier_list_info'), ['max_selected_modifiers'], ['max_selected_modifiers']) }} as max_selected_modifiers,
    {{ json_extract_scalar(unnested_column_value('modifier_list_info'), ['min_selected_modifiers'], ['min_selected_modifiers']) }} as min_selected_modifiers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_base') }}
-- modifier_list_info at items/item_data/modifier_list_info
{{ cross_join_unnest('item_data', 'modifier_list_info') }}
where
    1 = 1
    and modifier_list_info is not null
{{ incremental_clause('_airbyte_emitted_at') }}

