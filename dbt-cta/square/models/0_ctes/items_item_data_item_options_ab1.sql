{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('items_item_data') }}
{{ unnest_cte(ref('items_item_data'), 'item_data', 'item_options') }}
select
    _airbyte_item_data_hashid,
    {{ json_extract_scalar(unnested_column_value('item_options'), ['item_option_id'], ['item_option_id']) }} as item_option_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_base') }}
-- item_options at items/item_data/item_options
{{ cross_join_unnest('item_data', 'item_options') }}
where
    1 = 1
    and item_options is not null
{{ incremental_clause('_airbyte_emitted_at') }}

