{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('items_item_data_item_options_ab1') }}
select
    _airbyte_item_data_hashid,
    cast(item_option_id as {{ dbt_utils.type_string() }}) as item_option_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('items_item_data_item_options_ab1') }}
-- item_options at items/item_data/item_options
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

