{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_line_items_price_ab1') }}
select
    _airbyte_checkout_sessions_line_items_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(tiers as {{ type_json() }}) as tiers,
    {{ cast_to_boolean('active') }} as active,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(product as {{ dbt_utils.type_string() }}) as product,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(nickname as {{ dbt_utils.type_string() }}) as nickname,
    cast(recurring as {{ type_json() }}) as recurring,
    cast(lookup_key as {{ dbt_utils.type_string() }}) as lookup_key,
    cast(tiers_mode as {{ dbt_utils.type_string() }}) as tiers_mode,
    cast(unit_amount as {{ dbt_utils.type_bigint() }}) as unit_amount,
    cast(tax_behavior as {{ dbt_utils.type_string() }}) as tax_behavior,
    cast(billing_scheme as {{ dbt_utils.type_string() }}) as billing_scheme,
    cast(transform_quantity as {{ type_json() }}) as transform_quantity,
    cast(unit_amount_decimal as {{ dbt_utils.type_string() }}) as unit_amount_decimal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_price_ab1') }}
-- price at checkout_sessions_line_items/price
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

