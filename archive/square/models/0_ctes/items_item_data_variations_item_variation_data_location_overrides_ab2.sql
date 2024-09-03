{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_location_overrides_ab1') }}
select
    _airbyte_item_variation_data_hashid,
    cast(location_id as {{ dbt_utils.type_string() }}) as location_id,
    {{ cast_to_boolean('track_inventory') }} as track_inventory,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_variations_item_variation_data_location_overrides_ab1') }}
-- location_overrides at items/item_data/variations/item_variation_data/location_overrides
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

