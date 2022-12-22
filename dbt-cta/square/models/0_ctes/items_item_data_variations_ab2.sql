{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_variations_ab1') }}
select
    _airbyte_item_data_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(version as {{ dbt_utils.type_bigint() }}) as version,
    {{ cast_to_boolean('is_deleted') }} as is_deleted,
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(item_variation_data as {{ type_json() }}) as item_variation_data,
    present_at_location_ids,
    {{ cast_to_boolean('present_at_all_locations') }} as present_at_all_locations,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_variations_ab1') }}
-- variations at items/item_data/variations
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

