{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_stripe_partner_a",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('balance_transactions_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(fee as {{ dbt_utils.type_bigint() }}) as fee,
    cast(net as {{ dbt_utils.type_bigint() }}) as net,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(source as {{ dbt_utils.type_string() }}) as source,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    fee_details,
    cast(available_on as {{ dbt_utils.type_bigint() }}) as available_on,
    cast(exchange_rate as {{ dbt_utils.type_float() }}) as exchange_rate,
    sourced_transfers,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('balance_transactions_ab1') }}
-- balance_transactions
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

