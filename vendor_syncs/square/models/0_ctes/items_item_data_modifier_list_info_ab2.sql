{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_modifier_list_info_ab1') }}
select
    _airbyte_item_data_hashid,
    {{ cast_to_boolean('enabled') }} as enabled,
    cast(visibility as {{ dbt_utils.type_string() }}) as visibility,
    cast(modifier_list_id as {{ dbt_utils.type_string() }}) as modifier_list_id,
    cast(max_selected_modifiers as {{ dbt_utils.type_bigint() }}) as max_selected_modifiers,
    cast(min_selected_modifiers as {{ dbt_utils.type_bigint() }}) as min_selected_modifiers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_modifier_list_info_ab1') }}
-- modifier_list_info at items/item_data/modifier_list_info
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

