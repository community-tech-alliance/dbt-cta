{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_ab1') }}
select
    _airbyte_items_hashid,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    tax_ids,
    variations,
    cast(visibility as {{ dbt_utils.type_string() }}) as visibility,
    cast(category_id as {{ dbt_utils.type_string() }}) as category_id,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    item_options,
    cast(product_type as {{ dbt_utils.type_string() }}) as product_type,
    cast(ecom_visibility as {{ dbt_utils.type_string() }}) as ecom_visibility,
    modifier_list_info,
    {{ cast_to_boolean('skip_modifier_screen') }} as skip_modifier_screen,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_ab1') }}
-- item_data at items/item_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

