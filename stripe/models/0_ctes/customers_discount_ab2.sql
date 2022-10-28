{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_stripe_partner_a",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customers_discount_ab1') }}
select
    _airbyte_customers_hashid,
    cast({{ adapter.quote('end') }} as {{ dbt_utils.type_bigint() }}) as {{ adapter.quote('end') }},
    cast(start as {{ dbt_utils.type_bigint() }}) as start,
    cast(coupon as {{ type_json() }}) as coupon,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    cast(subscription as {{ dbt_utils.type_string() }}) as subscription,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customers_discount_ab1') }}
-- discount at customers/discount
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

