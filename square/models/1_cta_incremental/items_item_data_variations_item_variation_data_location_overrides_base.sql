{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_location_overrides_ab3') }}
select
    _airbyte_item_variation_data_hashid,
    location_id,
    track_inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_location_overrides_hashid
from {{ ref('items_item_data_variations_item_variation_data_location_overrides_ab3') }}
-- location_overrides at items/item_data/variations/item_variation_data/location_overrides from {{ ref('items_item_data_variations_item_variation_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

