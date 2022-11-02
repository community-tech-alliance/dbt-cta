{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_line_items_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(price as {{ type_json() }}) as price,
    taxes,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    discounts,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(amount_total as {{ dbt_utils.type_bigint() }}) as amount_total,
    cast(amount_subtotal as {{ dbt_utils.type_bigint() }}) as amount_subtotal,
    cast(checkout_session_id as {{ dbt_utils.type_string() }}) as checkout_session_id,
    cast(checkout_session_expires_at as {{ dbt_utils.type_bigint() }}) as checkout_session_expires_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_ab1') }}
-- checkout_sessions_line_items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

