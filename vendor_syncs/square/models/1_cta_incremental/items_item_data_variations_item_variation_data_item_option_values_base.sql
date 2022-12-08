{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_item_option_values_ab3') }}
select
    _airbyte_item_variation_data_hashid,
    item_option_id,
    item_option_value_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_item_option_values_hashid
from {{ ref('items_item_data_variations_item_variation_data_item_option_values_ab3') }}
-- item_option_values at items/item_data/variations/item_variation_data/item_option_values from {{ ref('items_item_data_variations_item_variation_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

