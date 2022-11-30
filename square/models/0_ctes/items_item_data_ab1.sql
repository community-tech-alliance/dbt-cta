{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items') }}
select
    _airbyte_items_hashid,
    {{ json_extract_scalar('item_data', ['name'], ['name']) }} as name,
    {{ json_extract_string_array('item_data', ['tax_ids'], ['tax_ids']) }} as tax_ids,
    {{ json_extract_array('item_data', ['variations'], ['variations']) }} as variations,
    {{ json_extract_scalar('item_data', ['visibility'], ['visibility']) }} as visibility,
    {{ json_extract_scalar('item_data', ['category_id'], ['category_id']) }} as category_id,
    {{ json_extract_scalar('item_data', ['description'], ['description']) }} as description,
    {{ json_extract_array('item_data', ['item_options'], ['item_options']) }} as item_options,
    {{ json_extract_scalar('item_data', ['product_type'], ['product_type']) }} as product_type,
    {{ json_extract_scalar('item_data', ['ecom_visibility'], ['ecom_visibility']) }} as ecom_visibility,
    {{ json_extract_array('item_data', ['modifier_list_info'], ['modifier_list_info']) }} as modifier_list_info,
    {{ json_extract_scalar('item_data', ['skip_modifier_screen'], ['skip_modifier_screen']) }} as skip_modifier_screen,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_base') }} as table_alias
-- item_data at items/item_data
where 1 = 1
and item_data is not null
{{ incremental_clause('_airbyte_emitted_at') }}

