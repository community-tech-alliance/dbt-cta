{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('customer_balance_transactions_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(amount as {{ dbt_utils.type_float() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(invoice as {{ dbt_utils.type_string() }}) as invoice,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(customer as {{ dbt_utils.type_string() }}) as customer,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    cast(credit_note as {{ dbt_utils.type_string() }}) as credit_note,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(ending_balance as {{ dbt_utils.type_float() }}) as ending_balance,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('customer_balance_transactions_ab1') }}
-- customer_balance_transactions
where 1 = 1

