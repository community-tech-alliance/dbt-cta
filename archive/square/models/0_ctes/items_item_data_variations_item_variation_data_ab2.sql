{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_variations_item_variation_data_ab1') }}
select
    _airbyte_variations_hashid,
    cast(sku as {{ dbt_utils.type_string() }}) as sku,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(item_id as {{ dbt_utils.type_string() }}) as item_id,
    cast(ordinal as {{ dbt_utils.type_bigint() }}) as ordinal,
    cast(price_money as {{ type_json() }}) as price_money,
    cast(pricing_type as {{ dbt_utils.type_string() }}) as pricing_type,
    item_option_values,
    location_overrides,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_variations_item_variation_data_ab1') }}
-- item_variation_data at items/item_data/variations/item_variation_data
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

