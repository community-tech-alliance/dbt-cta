{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items_item_data_variations') }}
select
    _airbyte_variations_hashid,
    {{ json_extract_scalar('item_variation_data', ['sku'], ['sku']) }} as sku,
    {{ json_extract_scalar('item_variation_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('item_variation_data', ['item_id'], ['item_id']) }} as item_id,
    {{ json_extract_scalar('item_variation_data', ['ordinal'], ['ordinal']) }} as ordinal,
    {{ json_extract('table_alias', 'item_variation_data', ['price_money'], ['price_money']) }} as price_money,
    {{ json_extract_scalar('item_variation_data', ['pricing_type'], ['pricing_type']) }} as pricing_type,
    {{ json_extract_array('item_variation_data', ['item_option_values'], ['item_option_values']) }} as item_option_values,
    {{ json_extract_array('item_variation_data', ['location_overrides'], ['location_overrides']) }} as location_overrides,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_variations_base') }} as table_alias
-- item_variation_data at items/item_data/variations/item_variation_data
where
    1 = 1
    and item_variation_data is not null
{{ incremental_clause('_airbyte_emitted_at') }}

