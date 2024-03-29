{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('items_item_data_variations_ab3') }}
select
    _airbyte_item_data_hashid,
    id,
    type,
    version,
    is_deleted,
    updated_at,
    item_variation_data,
    present_at_location_ids,
    present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_variations_hashid
from {{ ref('items_item_data_variations_ab3') }}
-- variations at items/item_data/variations from {{ ref('items_item_data') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

