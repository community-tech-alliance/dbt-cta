{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_ab3') }}
select
    _airbyte_variations_hashid,
    sku,
    name,
    item_id,
    ordinal,
    price_money,
    pricing_type,
    item_option_values,
    location_overrides,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_item_variation_data_hashid
from {{ ref('items_item_data_variations_item_variation_data_ab3') }}
-- item_variation_data at items/item_data/variations/item_variation_data from {{ ref('items_item_data_variations') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

