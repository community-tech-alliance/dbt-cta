{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_discount_ab1') }}
select
    _airbyte_discounts_hashid,
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast({{ adapter.quote('end') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('end') }},
    cast(start as {{ dbt_utils.type_bigint() }}) as start,
    cast(coupon as {{ type_json() }}) as coupon,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(invoice as {{ dbt_utils.type_string() }}) as invoice,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(invoice_item as {{ dbt_utils.type_string() }}) as invoice_item,
    cast(subscription as {{ dbt_utils.type_string() }}) as subscription,
    cast(promotion_code as {{ dbt_utils.type_string() }}) as promotion_code,
    cast(checkout_session as {{ dbt_utils.type_string() }}) as checkout_session,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('checkout_sessions_line_items_discounts_discount_ab1') }}
-- discount at checkout_sessions_line_items/discounts/discount
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

