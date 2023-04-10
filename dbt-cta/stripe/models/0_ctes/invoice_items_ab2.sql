{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('invoice_items_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(date as {{ dbt_utils.type_bigint() }}) as date,
    cast(plan as {{ type_json() }}) as plan,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(period as {{ type_json() }}) as period,
    cast(invoice as {{ dbt_utils.type_string() }}) as invoice,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(quantity as {{ dbt_utils.type_bigint() }}) as quantity,
    {{ cast_to_boolean('proration') }} as proration,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(unit_amount as {{ dbt_utils.type_bigint() }}) as unit_amount,
    {{ cast_to_boolean('discountable') }} as discountable,
    cast(subscription as {{ dbt_utils.type_string() }}) as subscription,
    cast(subscription_item as {{ dbt_utils.type_string() }}) as subscription_item,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('invoice_items_ab1') }}
-- invoice_items
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

