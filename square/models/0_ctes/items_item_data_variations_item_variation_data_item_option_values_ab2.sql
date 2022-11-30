{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_item_option_values_ab1') }}
select
    _airbyte_item_variation_data_hashid,
    cast(item_option_id as {{ dbt_utils.type_string() }}) as item_option_id,
    cast(item_option_value_id as {{ dbt_utils.type_string() }}) as item_option_value_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_variations_item_variation_data_item_option_values_ab1') }}
-- item_option_values at items/item_data/variations/item_variation_data/item_option_values
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

