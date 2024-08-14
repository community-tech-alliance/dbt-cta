{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items_item_data') }}
{{ unnest_cte(ref('items_item_data'), 'item_data', 'variations') }}
select
    _airbyte_item_data_hashid,
    {{ json_extract_scalar(unnested_column_value('variations'), ['id'], ['id']) }} as id,
    {{ json_extract_scalar(unnested_column_value('variations'), ['type'], ['type']) }} as type,
    {{ json_extract_scalar(unnested_column_value('variations'), ['version'], ['version']) }} as version,
    {{ json_extract_scalar(unnested_column_value('variations'), ['is_deleted'], ['is_deleted']) }} as is_deleted,
    {{ json_extract_scalar(unnested_column_value('variations'), ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract('', unnested_column_value('variations'), ['item_variation_data'], ['item_variation_data']) }} as item_variation_data,
    {{ json_extract_string_array(unnested_column_value('variations'), ['present_at_location_ids'], ['present_at_location_ids']) }} as present_at_location_ids,
    {{ json_extract_scalar(unnested_column_value('variations'), ['present_at_all_locations'], ['present_at_all_locations']) }} as present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_base') }}
-- variations at items/item_data/variations
{{ cross_join_unnest('item_data', 'variations') }}
where
    1 = 1
    and variations is not null
{{ incremental_clause('_airbyte_emitted_at') }}

