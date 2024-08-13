{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('payouts_ab1') }}
select
    cast(id as {{ dbt_utils.type_string() }}) as id,
    cast(date as {{ dbt_utils.type_bigint() }}) as date,
    cast(type as {{ dbt_utils.type_string() }}) as type,
    cast(amount as {{ dbt_utils.type_bigint() }}) as amount,
    cast(method as {{ dbt_utils.type_string() }}) as method,
    cast(object as {{ dbt_utils.type_string() }}) as object,
    cast(status as {{ dbt_utils.type_string() }}) as status,
    cast(created as {{ dbt_utils.type_bigint() }}) as created,
    cast(currency as {{ dbt_utils.type_string() }}) as currency,
    {{ cast_to_boolean('livemode') }} as livemode,
    cast(metadata as {{ type_json() }}) as metadata,
    {{ cast_to_boolean('automatic') }} as automatic,
    cast(recipient as {{ dbt_utils.type_string() }}) as recipient,
    cast(description as {{ dbt_utils.type_string() }}) as description,
    cast(destination as {{ dbt_utils.type_string() }}) as destination,
    cast(source_type as {{ dbt_utils.type_string() }}) as source_type,
    cast(arrival_date as {{ dbt_utils.type_bigint() }}) as arrival_date,
    cast(bank_account as {{ type_json() }}) as bank_account,
    cast(failure_code as {{ dbt_utils.type_string() }}) as failure_code,
    cast(transfer_group as {{ dbt_utils.type_string() }}) as transfer_group,
    cast(amount_reversed as {{ dbt_utils.type_bigint() }}) as amount_reversed,
    cast(failure_message as {{ dbt_utils.type_string() }}) as failure_message,
    cast(source_transaction as {{ dbt_utils.type_string() }}) as source_transaction,
    cast(balance_transaction as {{ dbt_utils.type_string() }}) as balance_transaction,
    cast(statement_descriptor as {{ dbt_utils.type_string() }}) as statement_descriptor,
    cast(statement_description as {{ dbt_utils.type_string() }}) as statement_description,
    cast(failure_balance_transaction as {{ dbt_utils.type_string() }}) as failure_balance_transaction,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('payouts_ab1') }}
-- payouts
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

