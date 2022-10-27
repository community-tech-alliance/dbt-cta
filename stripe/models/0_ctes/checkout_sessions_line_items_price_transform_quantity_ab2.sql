{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_line_items_price_transform_quantity_ab1') }}
select
    _airbyte_price_hashid,
    cast(round as {{ dbt_utils.type_string() }}) as round,
    cast(divide_by as {{ dbt_utils.type_bigint() }}) as divide_by,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_price_transform_quantity_ab1') }}
-- transform_quantity at checkout_sessions_line_items/price/transform_quantity
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

