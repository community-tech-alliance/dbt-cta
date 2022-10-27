{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_line_items_price_recurring_ab1') }}
select
    _airbyte_price_hashid,
    cast({{ adapter.quote('interval') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('interval') }},
    cast(usage_type as {{ dbt_utils.type_string() }}) as usage_type,
    cast(interval_count as {{ dbt_utils.type_bigint() }}) as interval_count,
    cast(aggregate_usage as {{ dbt_utils.type_string() }}) as aggregate_usage,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_price_recurring_ab1') }}
-- recurring at checkout_sessions_line_items/price/recurring
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

