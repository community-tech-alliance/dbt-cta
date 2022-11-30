{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items_item_data_variations_item_variation_data') }}
{{ unnest_cte(ref('items_item_data_variations_item_variation_data'), 'item_variation_data', 'item_option_values') }}
select
    _airbyte_item_variation_data_hashid,
    {{ json_extract_scalar(unnested_column_value('item_option_values'), ['item_option_id'], ['item_option_id']) }} as item_option_id,
    {{ json_extract_scalar(unnested_column_value('item_option_values'), ['item_option_value_id'], ['item_option_value_id']) }} as item_option_value_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_variations_item_variation_data_base') }} as table_alias
-- item_option_values at items/item_data/variations/item_variation_data/item_option_values
{{ cross_join_unnest('item_variation_data', 'item_option_values') }}
where 1 = 1
and item_option_values is not null
{{ incremental_clause('_airbyte_emitted_at') }}

