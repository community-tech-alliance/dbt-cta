{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('cta', '_airbyte_raw_items') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['type'], ['type']) }} as type,
    {{ json_extract_scalar('_airbyte_data', ['version'], ['version']) }} as version,
    {{ json_extract_scalar('_airbyte_data', ['image_id'], ['image_id']) }} as image_id,
    {{ json_extract('table_alias', '_airbyte_data', ['item_data'], ['item_data']) }} as item_data,
    {{ json_extract_scalar('_airbyte_data', ['is_deleted'], ['is_deleted']) }} as is_deleted,
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract('table_alias', '_airbyte_data', ['custom_attribute_values'], ['custom_attribute_values']) }} as custom_attribute_values,
    {{ json_extract_string_array('_airbyte_data', ['present_at_location_ids'], ['present_at_location_ids']) }} as present_at_location_ids,
    {{ json_extract_scalar('_airbyte_data', ['present_at_all_locations'], ['present_at_all_locations']) }} as present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('cta', '_airbyte_raw_items') }} as table_alias
-- items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

